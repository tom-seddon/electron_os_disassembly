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
	$(_V)$(TASS) elk100.s65 "-L$(BUILD)/elk100.lst" -o "$(BUILD)/elk100.rom"
	$(_V)$(PYTHON) bin/romdiffs.py $(_ROM_DIFF_MUST_MATCH) -a orig -b "$(BUILD)" elk100.rom

##########################################################################
##########################################################################

.PHONY:diff
diff:
	$(_V)vbindiff "$(BUILD)/elk100.rom" orig/elk100.rom

##########################################################################
##########################################################################

.PHONY:tom_laptop
tom_laptop:
	$(_V)$(MAKE)
