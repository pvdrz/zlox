pub const Value = f64;

const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

pub const ValueArray = struct {
    values: ArrayList(Value),

    pub fn init(allocator: *Allocator) ValueArray {
        return ValueArray{
            .values = ArrayList(Value).init(allocator),
        };
    }

    pub fn write(self: *ValueArray, value: Value) !void {
        try self.values.append(value);
    }

    pub fn free(self: *ValueArray) void {
        self.values.shrink(0);
    }

    pub fn get(self: *ValueArray, offset: usize) Value {
        return self.values.items[offset];
    }

    pub fn count(self: *ValueArray) usize {
        return self.values.items.len;
    }
};
