all: clean compile link

compile:
	@nasm -f elf -o main.o main.asm

link:
	@gcc -m32 -nostartfiles -o main main.o

clean:
	@rm -f main main.o	
