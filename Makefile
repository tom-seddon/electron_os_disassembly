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
	$(_V)$(MAKE) _assemble FILE=elk100
	$(_V)$(MAKE) _assemble FILE=os300
	$(_V)$(MAKE) _assemble FILE=213-OS-3.00-alt1
	$(_V)$(MAKE) _assemble FILE=524-OS-3.00-alt4

##########################################################################
##########################################################################

.PHONY:_assemble
_assemble:
	$(_V)$(TASS) "$(FILE).s65" "-L$(BUILD)/$(FILE).lst" -o "$(BUILD)/$(FILE).rom"
	$(_V)$(PYTHON) bin/romdiffs.py $(_ROM_DIFF_MUST_MATCH) -a orig -b "$(BUILD)" "$(FILE).rom"

##########################################################################
##########################################################################

.PHONY:diff100
diff100:
	$(MAKE) _diff FILE=elk100
	$(_V)vbindiff "$(BUILD)/elk100.rom" orig/elk100.rom

.PHONY:diff300
diff300:
	$(MAKE) _diff FILE=os300

.PHONY:diff300_213
diff300_213:
	$(MAKE) _diff FILE=213-OS-3.00-alt1

.PHONY:diff300_524
diff300_524:
	$(MAKE) _diff FILE=524-OS-3.00-alt4

.PHONY:_diff
_diff:
	$(_V)vbindiff "$(BUILD)/$(FILE).rom" "orig/$(FILE).rom"

##########################################################################
##########################################################################

.PHONY:tom_laptop
tom_laptop:
	$(_V)$(MAKE)
