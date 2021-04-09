const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

const common = @import("common.zig");
const ValueArray = common.ValueArray;
const Value = common.Value;

pub const OpCode = enum(u8) {
    op_constant,
    op_return,
};

pub const Chunk = struct {
    code: ArrayList(u8),
    constants: ValueArray,

    pub fn init(allocator: *Allocator) Chunk {
        return Chunk{
            .code = ArrayList(u8).init(allocator),
            .constants = ValueArray.init(allocator),
        };
    }

    pub fn write(self: *Chunk, bytes: anytype) !void {
        const ty = @TypeOf(bytes);

        switch (ty) {
            u8 => try self.code.append(bytes),
            OpCode => try self.code.append(@enumToInt(bytes)),
            else => {
                @compileError("Cannot write value of type '" ++ @typeName(ty) ++ "' in chunk.");
            },
        }
    }

    pub fn free(self: *Chunk) void {
        self.code.shrink(0);
    }

    pub fn get(self: *Chunk, offset: usize) u8 {
        return self.code.items[offset];
    }

    pub fn count(self: *Chunk) usize {
        return self.code.items.len;
    }

    pub fn addConstant(self: *Chunk, value: Value) !usize {
        try self.constants.write(value);
        return self.constants.count() - 1;
    }
};
