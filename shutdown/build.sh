#! /usr/bin/bash
nasm -f elf64 -o func.o func.asm
nasm -f elf64 -o main.o main.asm
ld -o epico func.o main.o