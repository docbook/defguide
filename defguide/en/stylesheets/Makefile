include ../../../cvstools/Makefile.incl

html-titlepage.xsl: html-titlepage.xml
	$(XSLT) $< /sourceforge/docbook/xsl/template/titlepage.xsl $@

r.fo : r.xml
	xsltproc $< tdgfo.xsl $@

r.pdf : r.fo
	xep $<
	rm -f $<
