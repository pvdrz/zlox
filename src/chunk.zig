const std = @import("std");
const Allocator = std.mem.Allocator;

pub const Chunk = struct {
    code: []u8,
    count: usize,
    allocator: *Allocator,

    pub fn new(allocator: *Allocator) Chunk {
        return Chunk{
            .code = &[0]u8{},
            .count = 0,
            .allocator = allocator,
        };
    }

    pub fn write(self: *Chunk, byte: u8) !void {
        if (self.code.len < self.count + 1) {
            try self.grow();
        }

        self.code[self.count] = byte;
        self.count += 1;
    }

    fn grow(self: *Chunk) !void {
        var new_code = try self.allocator.alloc(u8, 2 * (self.code.len + 1));
        std.mem.copy(u8, new_code[0..self.code.len], self.code);
        self.allocator.free(self.code);
        self.code = new_code;
    }

    pub fn free(self: *Chunk) void {
        self.allocator.free(self.code);

        self.code = &[0]u8{};
        self.count = 0;
    }

    pub fn get(self: *Chunk, offset: usize) u8 {
        return self.code[offset];
    }
};
