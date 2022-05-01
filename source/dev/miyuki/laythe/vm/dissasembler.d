module dev.miyuki.laythe.vm.dissasembler;

import std.stdio : printf;
import std.string : toStringz;

import dev.miyuki.laythe.vm.bytecode : ByteChunk, OpSet, Value;

public int DissasembleInstruction(ByteChunk chunk, int offset) {
    if (offset >= chunk.lines.length)
        return offset + 1;

    printf("%04d %04d ", offset, chunk.lines[offset]);

    switch(chunk.instructions[offset]) {
        case OpSet.Value: {
            printf("%-24s '%g'\n", "VALUE".toStringz(),
                    chunk.values[chunk.instructions[offset + 1]]);
            return offset + 2;
        }
        case OpSet.Add:        return Instruction("ADD", offset);
        case OpSet.Subtract:   return Instruction("SUBTRACT", offset);
        case OpSet.Multiply:   return Instruction("MULTIPLY", offset);
        case OpSet.Divide:     return Instruction("DIVIDE", offset);
        case OpSet.Percentage: return Instruction("PERCENTAGE", offset);
        case OpSet.Return:     return Instruction("RETURN", offset);
        default:
            printf("unrecognized: %d", chunk.instructions[offset]);
            return offset + 1;
    }
}

public int Instruction(string name, int offset) {
    printf("%-24s\n", name.toStringz());
    return offset + 1;
}