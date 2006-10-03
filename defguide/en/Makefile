include ../../cvstools/Makefile.incl

SSTITLEPG=stylesheets/html-titlepage.xsl
SSCHUNK=stylesheets/chunk.xsl
SSFO=stylesheets/tdgfo.xsl

SOURCE=tdg.xml
BASEDIR=../html/
ROOTID=
FORESULT=chunk.fo

DIFFVER=

FMGO=-N

ifeq ($(SOURCE),tdgex.xml)
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

all: chunks

test:
	xjparse $(SOURCE)

tdg.xml: bookinfo.xml WhatsNew
	xsltproc --output $@ stylesheets/identity.xsl book.xml

tdgex.xml: bookinfo.xml WhatsNew
	xsltproc --output $@ stylesheets/identity.xsl unexbook.xml

bookinfo.xml: VERSION.xml
	$(XSLT) $< $< $@

chunks: $(SSTITLEPG)
	$(XSLT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) $(STYLEOPT)
	$(XSLT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) rootid=index $(STYLEOPT)

chunk: $(SSTITLEPG)
	$(XSLT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) $(ROOTIDPARAM) $(STYLEOPT)

index: $(SSTITLEPG)
	$(XSLT) $(SOURCE) $(SSCHUNK) /dev/null base.dir=$(BASEDIR) html.ext=$(HTMLEXT) rootid=index

stylesheets/html-titlepage.xsl: stylesheets/html-titlepage.xml
	$(XSLT) $< ../../xsl/template/titlepage.xsl $@

fochunks:
	$(XSLT) $(SOURCE) $(SSFO) partI.fo rootid=docbook-intro $(STYLEOPT)
	$(XSLT) $(SOURCE) $(SSFO) partII.fo rootid=docbook-reference $(STYLEOPT)
	$(XSLT) $(SOURCE) $(SSFO) partIII.fo rootid=docbook-apps $(STYLEOPT)

fochunk:
	$(XSLT) $(SOURCE) $(SSFO) $(FORESULT) $(ROOTIDPARAM) $(STYLEOPT)

%.pdf: %.fo
	xep $<

tdg.fo: tdg.xml
	$(XSLT) $< $(SSFO) $@ $(ROOTIDPARAM) $(STYLEOPT)

tdg.pdf: tdg.fo
	xep $< $@

clean:
	rm -f tdg.{html,fo,pdf} tdg.xml tdgex.xml

freshmeat:
	$(XSLT) VERSION.xml VERSION.xml /tmp/fm-docbook-tdg freshmeat=1
	grep -v "<?xml" /tmp/fm-docbook-tdg | freshmeat-submit $(FMGO)

WhatsNew:
	svn update
	/usr/local/svn2cl/svn2cl.sh --group-by-day --output=$@
