default:
	nasm -felf64 *.asm
	ld -o clock *.o
	rm *.o

clean:
	rm clock

install:
	make
	mv clock ~/bin

uninstall:
	rm ~/bin/clock