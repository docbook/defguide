include ../../cvstools/Makefile.incl

SSTITLEPG=stylesheets/html-titlepage.xsl
SSCHUNK=stylesheets/chunk.xsl
SSFO=stylesheets/tdgfo.xsl

SOURCE=book.xml
MEMORY=100000000
BASEDIR=html/
ROOTID=

ifeq ($(SOURCE),unexbook.xml)
  STYLEOPT=output.type=unexpanded
  HTMLEXT=-x.html
else
  STYLEOPT=
  HTMLEXT=.html
endif

ifeq ($(ROOTID),)
  ROOTIDPARAM=
else
  ROOTIDPARAM=rootid=$(ROOTID)
endif

ifeq ($(XSLT),xsltproc)
  MEMORYOPT=
else
  MEMORYOPT=-m $(MEMORY)
endif

all: chunks index

test:
	xjparse $(SOURCE)

chunks: $(SSTITLEPG)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) base.dir=$(BASEDIR) html.ext=$(HTMLEXT) $(STYLEOPT)

chunk: $(SSTITLEPG)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) - base.dir=$(BASEDIR) html.ext=$(HTMLEXT) $(ROOTIDPARAM) $(STYLEOPT)

index: $(SSTITLEPG)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) - base.dir=$(BASEDIR) html.ext=$(HTMLEXT) rootid=index

stylesheets/html-titlepage.xsl: stylesheets/html-titlepage.xml
	$(XSLT) $< ../../xsl/template/titlepage.xsl $@

fochunk:
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSFO) chunk.fo $(ROOTIDPARAM) $(STYLEOPT)

c.fo: c.xml
	$(XSLT) $< $(SSFO) $@ $(STYLEOPT)

c.pdf: c.fo
	xep $<
	rm -f $<

book.fo: book.xml
	$(XSLT) $(MEMORYOPT) $< $(SSFO) $@ $(ROOTIDPARAM) $(STYLEOPT)

book.pdf: book.fo
	xep $< $@

clean:
	rm -f book.{html,fo,pdf}
