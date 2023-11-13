WIP disassembly of the OS for the Acorn Electron. The following
Acorn versions are covered:

* OS 1.00 - ROM supplied with Electron

The following non-Acorn versions are covered:

* OS 3.00 - ROM supplied with Slogger's Master RAM Board

**This project is a work in progress.** You'll find many holes, many
missing comments, and some rather unhelpful label names. The initial
goal is simply to separate code and data and ensure everything in the
ROM that needs a label has one.

Starting point was JGH's disassembly of the Electron MOS 1.00 here:
https://mdfs.net/Info/Comp/Acorn/Source/MOS.htm - this has supplied
nearly all the current comments.

# build

This repo has submodules. Clone it with `--recursive`:

    git clone --recursive https://github.com/tom-seddon/mos320
	
Alternatively, if you already cloned it non-recursively, you can do
the following from inside the working copy:

    git submodule init
	git submodule update

## prerequisites ##

Mandatory:

* Python 3.x

On Unix:

* [`64tass`](http://tass64.sourceforge.net/) (I use r3120)
* GNU Make

(Prebuilt Windows EXEs for 64tass and make are included in the repo.)

## build steps ##

Type `make` from the root of the working copy.

The build process is supposed to be silent when there are no errors
and when the output matches the original ROMs. Some versions of make
might print a load of stuff about entering and leaving the directory.

## build output

The build output is assembler listing files that you can use for
reference. Acorn versions:

- `build/elk100.lst` - OS 1.00

Non-Acorn versions:

- `build/os300.lst` - OS 3.00

