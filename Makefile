############################ -*- Mode: Makefile -*- ###########################
## Makefile --- 
## Author          : 
## Created On      : Mon Oct 17 11:41:20 1994
## Last Modified By: Francisco J. Ballesteros Camara
## Last Modified On: Mon Oct 17 11:42:02 1994
## Update Count    : 1
## Status          : Unknown, Use with caution!
###############################################################################

#*******Symbols*************

CC=gcc
CFLAGS=-O2

#*******Targets*************

all: ada2latex 

test: all xample

clean:
	-rm -f *.o lex.yy.c ada2latex xample.ape *.dvi *.ps *.aux *.log

xample:
	ada2latex <xample.adb >xample.ape
	@echo '(this will be included by xample.tex)'
	latex xample.tex

ada2latex: lex.yy.o libyywrap.o
	$(CC) $(CFLAGS) -o ada2latex lex.yy.o libyywrap.o 

lex.yy.c: ape.flex
	flex ape.flex

