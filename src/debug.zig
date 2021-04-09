const std = @import("std");
const print = std.debug.print;

const Chunk = @import("chunk.zig").Chunk;
const OpCode = @import("chunk.zig").OpCode;

const Value = @import("common.zig").Value;

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
        @enumToInt(OpCode.op_constant) => return constantInstruction("OP_CONSTANT", chunk, offset),
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

fn constantInstruction(name: []const u8, chunk: *Chunk, offset: usize) usize {
    var constant: u8 = chunk.get(offset + 1);
    print("{s} {} ", .{ name, constant });
    printValue(chunk.constants.get(@intCast(usize, constant)));
    print("\n", .{});
    return offset + 2;
}

fn printValue(value: Value) void {
    print("{d}", .{value});
}
