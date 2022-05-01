module dev.miyuki.laythe.vm.bytecode;

alias uint8_t = ubyte;
alias uint16_t = ushort;

public enum OpSet : uint8_t {
    Value,
    Add,
    Subtract,
    Multiply,
    Divide,
    Percentage,
    
    Return,
}

public struct ByteChunk {
    public int[] lines;
    public uint8_t[] instructions;
    public Value[] values;

    public void WriteInstruction(uint8_t instruction, int line) {
        instructions ~= instruction;
        lines ~= line;
    }

    public uint8_t WriteValue(Value v) {
        this.values ~= v;
        return cast(uint8_t) (this.values.length - 1);
    }
}

alias Value = double;