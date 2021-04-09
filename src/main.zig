const std = @import("std");

const Chunk = @import("chunk.zig").Chunk;
const OpCode = @import("chunk.zig").OpCode;

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};

    var chunk = Chunk.init(&gpa.allocator);

    try chunk.write(OpCode.op_return);

    @import("debug.zig").disassembleChunk(&chunk, "test chunk");

    chunk.free();

    var constant = try chunk.addConstant(1.2);
    try chunk.write(OpCode.op_constant);
    try chunk.write(@intCast(u8, constant));

    @import("debug.zig").disassembleChunk(&chunk, "test chunk");
}
