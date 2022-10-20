default:
	nasm -felf64 *.asm
	ld -o clock *.o
	rm *.o

clean:
	rm clock

install:
	make
	mv clock /home/cieran/bin

uninstall:
	rm /home/cieran/bin/clock