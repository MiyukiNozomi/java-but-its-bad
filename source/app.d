import std.string:toStringz;
import std.stdio:printf;

import dev.miyuki.laythe.vm;

void main() {
	LaytheVM vm = new LaytheVM();

	ByteChunk chunk = ByteChunk();

	chunk.WriteInstruction(OpSet.Value, 0);
	chunk.WriteInstruction(chunk.WriteValue(2), 0);

	chunk.WriteInstruction(OpSet.Value, 0);
	chunk.WriteInstruction(chunk.WriteValue(2), 0);
	chunk.WriteInstruction(OpSet.Value, 0);
	chunk.WriteInstruction(chunk.WriteValue(4), 0);
	chunk.WriteInstruction(OpSet.Percentage, 0);
	chunk.WriteInstruction(OpSet.Add, 0);
	chunk.WriteInstruction(OpSet.Return, 1);

	printf("that chunk -----\n");
	for (int offset = 0; offset < chunk.lines.length;) 
		offset = DissasembleInstruction(chunk, offset);
	printf("end of chunk ---\n");
	printf("Executing...\n");

	vm.Execute(chunk);
}