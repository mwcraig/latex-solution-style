#
#  Makefile by MWC 6/4/2004
#

#
# Copy this makefile to directory where files to be latexed are, and 
# call the file Makefile
#

#
# Add the name of each tex file to the sources = line below.
# Type make DVI of foo.tex type 'make foo.dvi', 
#  to make PS type 'make foo.ps' and so on...
# 

default:
	@echo "There is no default rule for this file."

include Makefile.teximplicits
#
# the file Makefile.teximplicits defines the pattern rules for automagically 
# proccessing .tex files to compiled formats. It should be in 
# /usr/local/include or in the current directory.
# To find the output formats that are supported, type 'make formats'
#

SOURCES = ps01-sols.tex ps02-sols.tex ps03-sols.tex ps04-sols.tex ps05-sols.tex ps06-sols.tex ps07-sols.tex ps08-sols.tex ps09-sols.tex ps10-sols.tex ps11-sols.tex #ps12-sols.tex

include $(SOURCES:.tex=.d)


clean:
	-rm -f *.log *.dvi *.toc *.aux *.bak

veryclean: clean
	-rm -f *.ps *.pdf *.d
