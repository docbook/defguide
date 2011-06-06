include $(DOCBOOK_SVN)/buildtools/Makefile.incl

SSTITLEPG=style/html-titlepage.xsl
SSCHUNK=style/chunk.xsl
SSFO=style/tdgfo.xsl

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

patterns.xml: lib/patterns.xml ../stylesheets/patterns.xsl
	$(XSLT) $< ../stylesheets/patterns.xsl $@

tdg.xml: refpages book5.xml bookinfo.xml patterns.xml \
         refpages/references.xml refpages/list-elements.xml \
         refpages/intro-elements.xml \
         $(wildcard src/*.xml) \
         $(wildcard refpages/elements/*.fmt)
	xmllint --nowarning --xinclude book5.xml > $@

profiled.xml: tdg.xml ../stylesheets/profile.xsl
	$(XSLT) $< ../stylesheets/profile.xsl $@ not-condition=compact

tdg-p.xml: profiled.xml style/purpose.xsl ../stylesheets/purpose.xsl
	$(XSLT) $< style/purpose.xsl $@

# No more stripping!
book.xml: tdg-p.xml
	cp $< $@

refpages:
	make -C refpages

chunks: $(SOURCE) $(SSTITLEPG) book.xml
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) $(STYLEOPT)
	cd $(BASEDIR) && $(TIDY) *.html
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) rootid=index $(STYLEOPT)

chunk: $(SOURCE) $(SSTITLEPG) book.xml
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) $(ROOTIDPARAM) $(STYLEOPT)

index: $(SSTITLEPG)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) rootid=index

style/html-titlepage.xsl: style/html-titlepage.xml
	$(XSLT) $< /sourceforge/docbook/xsl/template/titlepage.xsl $@

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

WhatsNew:
	$(CVS2LOG) -w
ifeq ($(DIFFVER),)
	$(MERGELOGS) > $@
else
	$(MERGELOGS) -v $(DIFFVER) > $@
endif
