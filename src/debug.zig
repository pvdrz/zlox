const std = @import("std");
const Chunk = @import("chunk.zig").Chunk;
const print = std.debug.print;

const OpCode = enum(u8) {
    op_return,
};

pub fn disassembleChunk(chunk: *Chunk, name: []const u8) void {
    print("== {s} ==\n", .{name});

    var offset: usize = 0;

    while (offset < chunk.count()) {
        offset = disassembleInstruction(chunk, offset);
    }
}

fn disassembleInstruction(chunk: *Chunk, offset: usize) usize {
    print("{}: ", .{offset});

    var byte = chunk.get(offset);

    switch (byte) {
        @enumToInt(OpCode.op_return) => return simpleInstruction("OP_RETURN", offset),
        else => {
            print("Unknown opcode {}\n", .{byte});
            return offset + 1;
        },
    }
}

fn simpleInstruction(name: []const u8, offset: usize) usize {
    print("{s}\n", .{name});
    return offset + 1;
}
