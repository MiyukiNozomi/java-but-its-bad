module dev.miyuki.laythe.vm.vm;

import std.stdio : printf;

import dev.miyuki.laythe.vm.bytecode;
import dev.miyuki.laythe.vm.dissasembler;

public class LaytheVM {
    
    public ByteChunk current;
    public uint8_t* ip;

    public Value[512] stack;
    public Value* stackTop;

    public this() {
        Reset();
    }

    public void Reset() {
        this.stackTop = stack.ptr;
        this.ip = null;
    }

    auto ReadInstruction(){return *this.ip++;}
    auto Peek(int offset) {
        return this.stackTop[-1 - offset];
    }
    auto Pop() {
        this.stackTop--;
        return *this.stackTop;
    }
    auto Push(Value v) {
        *this.stackTop = v;
        return this.stackTop++;    
    }

    public int Execute(ByteChunk c) {
        template Binary(char op) {
            const char[] Binary = "
                Value b = Pop();
                Value a = Pop();

                Push(b " ~ op ~ " a);
            ";
        }
        this.current = c;

        this.ip = this.current.instructions.ptr;

        uint8_t instruction;
        for (;;) {
            debug {
                printf("STACK > ");
                for (Value* s = this.stack.ptr; s < this.stackTop; s++) {
                    printf("[%g]", *s);
                }
                printf("\n");
                DissasembleInstruction(this.current, cast(int) (this.ip - this.current.instructions.ptr));           
            }
            switch((instruction = ReadInstruction())) {
                case OpSet.Value: {
                    Push(current.values[ReadInstruction()]);
                    break;
                }
                case OpSet.Add:
                    mixin(Binary!('+'));
                    break;
                case OpSet.Subtract:
                    mixin(Binary!('-'));
                    break;
                case OpSet.Divide:
                    mixin(Binary!('/'));
                    break;
                case OpSet.Multiply:
                    mixin(Binary!('*'));
                    break;
                case OpSet.Percentage:
                    mixin(Binary!('%'));
                    break;
                case OpSet.Return: {
                    printf("%g", Pop());
                    return 0;
                }
                default: break;
            }
        }
    }
}