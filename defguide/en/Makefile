include ../../cvstools/Makefile.incl

SSTITLEPG=stylesheets/html-titlepage.xsl
SSCHUNK=stylesheets/chunk.xsl

SOURCE=book.xml
MEMORY=100000000
BASEDIR=html/
ROOTID=

ifeq ($(SOURCE),unexbook.xml)
  STYLEOPT=output.type=unexpanded
else
  STYLEOPT=
endif

all: chunks index

test:
	xjparse $(SOURCE)

chunks: $(SSTITLEPG)
	$(XSLT) -m $(MEMORY) $(SOURCE) $(SSCHUNK) base.dir=$(BASEDIR) $(STYLEOPT)

chunk: $(SSTITLEPG)
	$(XSLT) -m $(MEMORY) $(SOURCE) $(SSCHUNK) - base.dir=$(BASEDIR) rootid=$(ROOTID) $(STYLEOPT)

index: $(SSTITLEPG)
	$(XSLT) -m $(MEMORY) $(SOURCE) $(SSCHUNK) - base.dir=$(BASEDIR) rootid=index

stylesheets/html-titlepage.xsl: stylesheets/html-titlepage.xml
	$(XSLT) $< ../../xsl/template/titlepage.xsl $@
