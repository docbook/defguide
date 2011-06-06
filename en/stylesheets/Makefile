include ../../../buildtools/Makefile.incl

html-titlepage.xsl: html-titlepage.xml
	$(XSLT) $< ../../../xsl/template/titlepage.xsl $@

r.fo : r.xml
	xsltproc $< tdgfo.xsl $@

r.pdf : r.fo
	xep $<
	rm -f $<
