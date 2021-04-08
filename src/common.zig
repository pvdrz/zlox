pub const Value = f64;

const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

pub const ValueArray = struct {
    values: ArrayList(u8),

    pub fn init(allocator: *Allocator) ValueArray {
        return ValueArray{
            .values = ArrayList(u8).init(allocator),
        };
    }

    pub fn write(self: *Chunk, byte: u8) !void {
        try self.values.append(byte);
    }

    pub fn free(self: *Chunk) void {
        self.values.shrink(0);
    }

    pub fn get(self: *Chunk, offset: usize) u8 {
        return self.values.items[offset];
    }

    pub fn count(self: *Chunk) usize {
        return self.values.items.len;
    }
};
