include $(DOCBOOK_SVN)/buildtools/Makefile.incl

SSTITLEPG=style/html-titlepage.xsl
SSCHUNK=../stylesheets/chunk.xsl
SSFO=style/tdgfo.xsl

SOURCE=book.xml
MEMORY=100000000
BASEDIR=build
ROOTID=
FORESULT=chunk.fo
STYLEOPT=
HTMLEXT=.html
TIDY=tidy

DIFFVER=

FMGO=-N

XSLTOPT=base.dir=$(BASEDIR)/ html.ext=$(HTMLEXT) $(STYLEOPT)

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

.PHONY: refpages debug-chunks

all: chunks

test: book.xml
	jing ../../docbook/relaxng/docbook/docbook.rng $<

patterns.xml: lib/patterns.xml ../stylesheets/patterns.xsl lib/defguide.rnd
	$(XSLT) $< ../stylesheets/patterns.xsl $@ rngfile=/projects/docbook/defguide/en/defguide5/lib/defguide.rnd

tdg.xml: refpages book5.xml bookinfo.xml patterns.xml \
         refpages/references.xml refpages/list-elements.xml \
         refpages/intro-elements.xml \
         $(wildcard src/*.xml) \
         $(wildcard refpages/elements/*.fmt)
	calabash -isource=book5.xml -oresult=$@ ../stylesheets/xinclude.xpl

profiled.xml: tdg.xml ../stylesheets/profile.xsl
	$(XSLT) $< ../stylesheets/profile.xsl $@ not-condition="compact print"

book.xml: profiled.xml style/purpose.xsl ../stylesheets/purpose.xsl
	calabash -isource=$< -oresult=$@ ../stylesheets/make-book.xpl

refpages:
	make -C refpages

setup:
	mkdir -p $(BASEDIR) $(BASEDIR)/css $(BASEDIR)/js
	cp ../css/*.css $(BASEDIR)/css/
	cp ../script/*.js $(BASEDIR)/js/
	echo "DirectoryIndex docbook.html" > $(BASEDIR)/.htaccess

# Warning: this might only work on Unix
raw-chunks: $(SOURCE) book.xml setup
	mkdir -p figs && cd ../figs && tar cf - web | (cd ../defguide5/figs; tar xf -)
	$(XSLT) $(MEMORYOPT) $(SOURCE) ../stylesheets/chunk.xsl - $(XSLTOPT)
	rm -rf $(BASEDIR)/figs && mv figs $(BASEDIR)/

debug-chunks:
	mkdir -p figs && cd ../figs && tar cf - web | (cd ../defguide5/figs; tar xf -)
	$(XSLT) $(MEMORYOPT) $(SOURCE) ../stylesheets/chunk.xsl - $(XSLTOPT)
	rm -rf $(BASEDIR)/figs && mv figs $(BASEDIR)/

chunks: raw-chunks
	cd $(BASEDIR) && $(TIDY) *.html

chunk: $(SOURCE) $(SSTITLEPG) book.xml
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null $(XSLTOPT) $(ROOTIDPARAM)

index: $(SSTITLEPG)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) /dev/null $(XSLTOPT) rootid=index

style/html-titlepage.xsl: style/html-titlepage.xml
	$(XSLT) $< /sourceforge/docbook/xsl/template/titlepage.xsl $@

clean:
	rm -f tdg.{html,fo,pdf} tdg.xml tdgex.xml book.xml
	rm -rf build figs
	$(MAKE) -C refpages clean
