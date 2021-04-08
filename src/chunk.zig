const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;
const ValueArray = @import("common.zig").ValueArray;

pub const Chunk = struct {
    code: ArrayList(u8),
    constants: ValueArray,

    pub fn init(allocator: *Allocator) Chunk {
        return Chunk{
            .code = ArrayList(u8).init(allocator),
            .constants = ValueArray.init(allocator),
        };
    }

    pub fn write(self: *Chunk, byte: u8) !void {
        try self.code.append(byte);
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
};
