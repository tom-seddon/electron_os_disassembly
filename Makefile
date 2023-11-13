# -*- mode:makefile-gmake; -*-

ifeq ($(OS),Windows_NT)
PYTHON:=py -3
TASSCMD:=bin\64tass.exe
else
PYTHON:=/usr/bin/python3
TASSCMD:=64tass
endif

##########################################################################
##########################################################################

ifeq ($(VERBOSE),1)
_V:=
_TASSQ:=
else
_V:=@
_TASSQ:=-q
endif

ifeq ($(MUST_MATCH),1)
_ROM_DIFF_MUST_MATCH:=--must-match
else
_ROM_DIFF_MUST_MATCH:=
endif

##########################################################################
##########################################################################

SHELLCMD:=$(PYTHON) submodules/shellcmd.py/shellcmd.py
MKDIR:=$(SHELLCMD) mkdir
TASS:=$(TASSCMD) --m6502 --nostart -Wall $(_TASSQ) --case-sensitive --line-numbers --verbose-list
BUILD:=build
DIST:=dist

##########################################################################
##########################################################################

.PHONY:all
all:
	$(_V)$(SHELLCMD) mkdir "$(BUILD)"
	$(_V)$(TASS) elk100.s65 -L$(BUILD)/elk100.lst -o $(BUILD)/elk100.rom

##########################################################################
##########################################################################

.PHONY:fixup
fixup:
	$(_V)$(PYTHON) tools/fixup.py --64tass -o elk100.s65 elk100.src 

##########################################################################
##########################################################################

.PHONY:tom_laptop
tom_laptop:
	$(_V)$(MAKE)
