const std = @import("std");

const Chunk = @import("chunk.zig").Chunk;

const OpCode = enum {
    op_return,
};

pub fn main() anyerror!void {
    std.log.info("All your codebase are belong to us.", .{});
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};

    var chunk = Chunk.new(&gpa.allocator);

    try chunk.write(0);

    chunk.free();
}
