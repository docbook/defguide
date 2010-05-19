include $(DOCBOOK_SVN)/buildtools/Makefile.incl

SSTITLEPG=stylesheets/html-titlepage.xsl
SSCHUNK=stylesheets/chunk.xsl
SSFO=stylesheets/tdgfo.xsl

SOURCE=book.xml
MEMORY=100000000
BASEDIR=../html/
ROOTID=
FORESULT=chunk.fo
STYLEOPT=
HTMLEXT=.html
TIDY=tidy

DIFFVER=

FMGO=-N

ifeq ($(ROOTID),)
  ROOTIDPARAM=
else
  ROOTIDPARAM=rootid=$(ROOTID)
endif

ifeq ($(XSLT),xsltproc)
  MEMORYOPT=
else
  MEMORYOPT=-opts hugemem
endif

.PHONY: refpages

all: chunks

test: book.xml
	jing ../../docbook/relaxng/docbook/docbook.rng $<

patterns.xml: stylesheets/patterns.xml stylesheets/patterns.xsl
	$(XSLT) $< stylesheets/patterns.xsl $@

tdg.xml: refpages book5.xml bookinfo.xml patterns.xml \
         refpages/references.xml refpages/list-elements.xml \
         refpages/intro-elements.xml \
         $(wildcard src/*.xml) \
         $(wildcard refpages/elements/build/*.xml)
	xmllint --nowarning --xinclude book5.xml > $@

profiled.xml: tdg.xml stylesheets/profile.xsl
	$(XSLT) $< stylesheets/profile.xsl $@ not-condition=compact

tdg-p.xml: profiled.xml stylesheets/purpose.xsl
	$(XSLT) $< stylesheets/purpose.xsl $@

# No more stripping!
book.xml: tdg-p.xml
	cp $< $@

refpages:
	make -C refpages

bookinfo.xml: VERSION.xml
	$(XSLT) $< $< $@

chunks: $(SOURCE) $(SSTITLEPG) book.xml
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) $(STYLEOPT)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) rootid=index $(STYLEOPT)
	cd $(BASEDIR) && $(TIDY) *.html

chunk: $(SOURCE) $(SSTITLEPG) book.xml
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) $(ROOTIDPARAM) $(STYLEOPT)

index: $(SSTITLEPG)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) rootid=index

stylesheets/html-titlepage.xsl: stylesheets/html-titlepage.xml
	$(XSLT) $< ../../xsl/template/titlepage.xsl $@

fochunks:
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSFO) partI.fo rootid=docbook-intro $(STYLEOPT)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSFO) partII.fo rootid=docbook-reference $(STYLEOPT)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSFO) partIII.fo rootid=docbook-apps $(STYLEOPT)

fochunk:
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSFO) $(FORESULT) $(ROOTIDPARAM) $(STYLEOPT)

%.pdf: %.fo
	xep $<

tdg.fo: tdg.xml
	$(XSLT) $(MEMORYOPT) $< $(SSFO) $@ $(ROOTIDPARAM) $(STYLEOPT)

tdg.pdf: tdg.fo
	xep $< $@

clean:
	rm -f tdg.{html,fo,pdf} tdg.xml tdgex.xml tdg-p.xml

freshmeat:
	$(XSLT) VERSION.xml VERSION.xml /tmp/fm-docbook-tdg freshmeat=1
	grep -v "<?xml" /tmp/fm-docbook-tdg | freshmeat-submit $(FMGO)

WhatsNew:
	$(CVS2LOG) -w
ifeq ($(DIFFVER),)
	$(MERGELOGS) > $@
else
	$(MERGELOGS) -v $(DIFFVER) > $@
endif
