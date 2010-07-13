all: quick-start.html user-guide.html

.SUFFIXES: .html .xml

COMPILER=/projects/docbook/assembly/compile-assembly.xsl
ASMUTILS=/projects/docbook/assembly/asmutils.xpl
HTMLXSL=/projects/docbook/xslt20/stylesheets/base/html/docbook.xsl
VALIDATE=true

.xml.html:
	saxon $< $(HTMLXSL) $@

quick-start.xpl: assembly.xml $(COMPILER)
	saxon $< $(COMPILER) $@ structure=getting.started

quick-start.xml: quick-start.xpl $(wildcard src/*.xml) $(ASMUTILS)
	calabash -oresult=$@ $< validate=$(VALIDATE)

user-guide.xpl: assembly.xml $(COMPILER)
	saxon $< $(COMPILER) $@ structure=user.guide

user-guide.xml: user-guide.xpl $(wildcard src/*.xml) $(ASMUTILS)
	calabash -oresult=$@ $< validate=$(VALIDATE)
