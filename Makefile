default:
	nasm -felf64 *.asm
	ld -o clock *.o