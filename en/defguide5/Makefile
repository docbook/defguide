include $(DOCBOOK_SVN)/buildtools/Makefile.incl

SSCHUNK=../stylesheets/chunk.xsl

SOURCE=book.xml
MEMORY=100000000
BASEDIR=build
ROOTID=
FORESULT=chunk.fo
STYLEOPT=
HTMLEXT=.html
TIDY=tidy

RNDFILE=/Volumes/Data/docbook/defguide/en/defguide5/lib/defguide.rnd
XSLTOPT=base.dir=$(BASEDIR)/ html.ext=$(HTMLEXT) rngfile=$(RNDFILE) resource.root="" $(STYLEOPT)

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

patterns.xml: lib/patterns.xml ../stylesheets/patterns.xsl $(RNDFILE)
	$(XSLT) $< ../stylesheets/patterns.xsl $@ rngfile=$(RNDFILE)

tdg.xml: book5.xml bookinfo.xml patterns.xml \
         refpages/references.xml refpages/list-elements.xml \
         refpages/intro-elements.xml \
         $(wildcard src/*.xml) \
         $(wildcard refpages/elements/*.fmt)
	calabash -isource=book5.xml -oresult=$@ ../stylesheets/xinclude.xpl

book.xml: tdg.xml ../stylesheets/profile.xsl style/purpose.xsl ../stylesheets/purpose.xsl
	calabash -isource=$< -oresult=$@ ../stylesheets/make-book.xpl arch=assembly revision="5.0 5.1"

refpages:
	make -C refpages

setup:
	mkdir -p $(BASEDIR) $(BASEDIR)/css $(BASEDIR)/js
	cp ../css/*.css $(BASEDIR)/css/
	cp ../script/*.js $(BASEDIR)/js/
	echo "DirectoryIndex docbook.html" > $(BASEDIR)/.htaccess

# Warning: this might only work on Unix
raw-chunks: $(SOURCE) setup
	mkdir -p figs && cd ../figs && tar cf - web | (cd ../defguide5/figs; tar xf -)
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) - $(XSLTOPT)
	rm -rf $(BASEDIR)/figs && mv figs $(BASEDIR)/

chunks: raw-chunks
# No more tidy, we're outputing things like <article> that it simply doesn't understand
#	cd $(BASEDIR) && $(TIDY) *.html

chunk: $(SOURCE) book.xml setup
	$(XSLT) $(MEMORYOPT) $(SOURCE) $(SSCHUNK) - $(XSLTOPT) $(ROOTIDPARAM)

clean:
	rm -f tdg.{html,fo,pdf} tdg.xml tdgex.xml book.xml
	rm -rf $(BASEDIR) figs
	$(MAKE) -C refpages clean
