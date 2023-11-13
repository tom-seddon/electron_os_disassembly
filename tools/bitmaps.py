#!/usr/bin/python3
import sys,argparse

def main():
    with open('orig/elk100.rom','rb') as f: data=f.read()
    assert len(data)==16384
    for ch in range(32,128):
        print('    ; CHR$%d - %c'%(ch,chr(ch)))
        for y in range(8):
            x=data[0+(ch-32)*8+y]
            bits=('0000000'+bin(x)[2:])[-8:]
            print('    .byte %%%s'%bits)
        print()

if __name__=='__main__': main()
