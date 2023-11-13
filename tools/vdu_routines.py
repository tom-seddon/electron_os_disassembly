#!/usr/bin/python3

def main():
    with open('orig/elk100.rom','rb') as f: data=f.read()
    assert len(data)==16384

    def rb(a): return data[a&0x3fff]
    
    ltable=0xc32b
    htable=0xc34c

    for i in range(33):
        l=rb(ltable+i)
        h=rb(htable+i)

        if (h&0x80)!=0:
            length=0
            routine=h*256+l
        else:
            length=16-(h&0xf)
            routine=0xc300+(h>>4)*256+l

        print('[($%04x,%d)] ; VDU %d'%(routine,length,i))

if __name__=='__main__': main()
