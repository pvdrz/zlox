const std = @import("std");

const Chunk = @import("chunk.zig").Chunk;

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};

    var chunk = Chunk.init(&gpa.allocator);

    try chunk.write(0);

    @import("debug.zig").disassembleChunk(&chunk, "test chunk");

    chunk.free();
    try chunk.write(0);
}
