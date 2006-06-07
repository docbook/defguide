DEFGUIDERND=../../tools/lib/defguide.rnd
REFENTRYXSL=../../stylesheets/refentry.xsl

all: buildall
	rm -f build/*.xi

clean:
	rm -rf build

Makefile:
	../../tools/bin/makeelmake > $@

build/db._any.mml.xml: ANY/db._any.mml.xml ANY/example.mml.1.xml ANY/example.svg.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db._any.mml.xml.xi
	@saxon build/db._any.mml.xml.xi $(REFENTRYXSL) $@

build/db._any.svg.xml: ANY/db._any.svg.xml ANY/example.mml.1.xml ANY/example.svg.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db._any.svg.xml.xi
	@saxon build/db._any.svg.xml.xi $(REFENTRYXSL) $@

build/db._any.xml: ANY/db._any.xml ANY/example.mml.1.xml ANY/example.svg.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db._any.xml.xi
	@saxon build/db._any.xml.xi $(REFENTRYXSL) $@

build/db.abbrev.xml: abbrev/db.abbrev.xml abbrev/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.abbrev.xml.xi
	@saxon build/db.abbrev.xml.xi $(REFENTRYXSL) $@

build/db.abstract.xml: abstract/db.abstract.xml abstract/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.abstract.xml.xi
	@saxon build/db.abstract.xml.xi $(REFENTRYXSL) $@

build/db.accel.xml: accel/db.accel.xml accel/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.accel.xml.xi
	@saxon build/db.accel.xml.xi $(REFENTRYXSL) $@

build/db.ackno.xml: ackno/db.ackno.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.ackno.xml.xi
	@saxon build/db.ackno.xml.xi $(REFENTRYXSL) $@

build/db.acronym.xml: acronym/db.acronym.xml acronym/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.acronym.xml.xi
	@saxon build/db.acronym.xml.xi $(REFENTRYXSL) $@

build/db.address.xml: address/db.address.xml address/example.1.xml address/example.2.xml address/example.3.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.address.xml.xi
	@saxon build/db.address.xml.xi $(REFENTRYXSL) $@

build/db.affiliation.xml: affiliation/db.affiliation.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.affiliation.xml.xi
	@saxon build/db.affiliation.xml.xi $(REFENTRYXSL) $@

build/db.alt.xml: alt/db.alt.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.alt.xml.xi
	@saxon build/db.alt.xml.xi $(REFENTRYXSL) $@

build/db.anchor.xml: anchor/db.anchor.xml anchor/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.anchor.xml.xi
	@saxon build/db.anchor.xml.xi $(REFENTRYXSL) $@

build/db.annotation.xml: annotation/db.annotation.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.annotation.xml.xi
	@saxon build/db.annotation.xml.xi $(REFENTRYXSL) $@

build/db.answer.xml: answer/db.answer.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.answer.xml.xi
	@saxon build/db.answer.xml.xi $(REFENTRYXSL) $@

build/db.appendix.xml: appendix/db.appendix.xml appendix/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.appendix.xml.xi
	@saxon build/db.appendix.xml.xi $(REFENTRYXSL) $@

build/db.application.xml: application/db.application.xml application/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.application.xml.xi
	@saxon build/db.application.xml.xi $(REFENTRYXSL) $@

build/db.arc.xml: arc/db.arc.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.arc.xml.xi
	@saxon build/db.arc.xml.xi $(REFENTRYXSL) $@

build/db.area.inareaset.xml: area/db.area.inareaset.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.area.inareaset.xml.xi
	@saxon build/db.area.inareaset.xml.xi $(REFENTRYXSL) $@

build/db.area.xml: area/db.area.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.area.xml.xi
	@saxon build/db.area.xml.xi $(REFENTRYXSL) $@

build/db.areaset.xml: areaset/db.areaset.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.areaset.xml.xi
	@saxon build/db.areaset.xml.xi $(REFENTRYXSL) $@

build/db.areaspec.xml: areaspec/db.areaspec.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.areaspec.xml.xi
	@saxon build/db.areaspec.xml.xi $(REFENTRYXSL) $@

build/db.arg.xml: arg/db.arg.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.arg.xml.xi
	@saxon build/db.arg.xml.xi $(REFENTRYXSL) $@

build/db.article.xml: article/db.article.xml article/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.article.xml.xi
	@saxon build/db.article.xml.xi $(REFENTRYXSL) $@

build/db.artpagenums.xml: artpagenums/db.artpagenums.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.artpagenums.xml.xi
	@saxon build/db.artpagenums.xml.xi $(REFENTRYXSL) $@

build/db.attribution.xml: attribution/db.attribution.xml attribution/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.attribution.xml.xi
	@saxon build/db.attribution.xml.xi $(REFENTRYXSL) $@

build/db.audiodata.xml: audiodata/db.audiodata.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.audiodata.xml.xi
	@saxon build/db.audiodata.xml.xi $(REFENTRYXSL) $@

build/db.audioobject.xml: audioobject/db.audioobject.xml audioobject/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.audioobject.xml.xi
	@saxon build/db.audioobject.xml.xi $(REFENTRYXSL) $@

build/db.author.xml: author/db.author.xml author/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.author.xml.xi
	@saxon build/db.author.xml.xi $(REFENTRYXSL) $@

build/db.authorgroup.xml: authorgroup/db.authorgroup.xml authorgroup/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.authorgroup.xml.xi
	@saxon build/db.authorgroup.xml.xi $(REFENTRYXSL) $@

build/db.authorinitials.xml: authorinitials/db.authorinitials.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.authorinitials.xml.xi
	@saxon build/db.authorinitials.xml.xi $(REFENTRYXSL) $@

build/db.bibliocoverage.xml: bibliocoverage/db.bibliocoverage.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.bibliocoverage.xml.xi
	@saxon build/db.bibliocoverage.xml.xi $(REFENTRYXSL) $@

build/db.bibliodiv.xml: bibliodiv/db.bibliodiv.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.bibliodiv.xml.xi
	@saxon build/db.bibliodiv.xml.xi $(REFENTRYXSL) $@

build/db.biblioentry.xml: biblioentry/db.biblioentry.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.biblioentry.xml.xi
	@saxon build/db.biblioentry.xml.xi $(REFENTRYXSL) $@

build/db.bibliography.xml: bibliography/db.bibliography.xml bibliography/example.1.xml bibliography/example.2.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.bibliography.xml.xi
	@saxon build/db.bibliography.xml.xi $(REFENTRYXSL) $@

build/db.biblioid.xml: biblioid/db.biblioid.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.biblioid.xml.xi
	@saxon build/db.biblioid.xml.xi $(REFENTRYXSL) $@

build/db.bibliolist.xml: bibliolist/db.bibliolist.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.bibliolist.xml.xi
	@saxon build/db.bibliolist.xml.xi $(REFENTRYXSL) $@

build/db.bibliomisc.xml: bibliomisc/db.bibliomisc.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.bibliomisc.xml.xi
	@saxon build/db.bibliomisc.xml.xi $(REFENTRYXSL) $@

build/db.bibliomixed.xml: bibliomixed/db.bibliomixed.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.bibliomixed.xml.xi
	@saxon build/db.bibliomixed.xml.xi $(REFENTRYXSL) $@

build/db.bibliomset.xml: bibliomset/db.bibliomset.xml bibliomset/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.bibliomset.xml.xi
	@saxon build/db.bibliomset.xml.xi $(REFENTRYXSL) $@

build/db.biblioref.xml: biblioref/db.biblioref.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.biblioref.xml.xi
	@saxon build/db.biblioref.xml.xi $(REFENTRYXSL) $@

build/db.bibliorelation.xml: bibliorelation/db.bibliorelation.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.bibliorelation.xml.xi
	@saxon build/db.bibliorelation.xml.xi $(REFENTRYXSL) $@

build/db.biblioset.xml: biblioset/db.biblioset.xml biblioset/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.biblioset.xml.xi
	@saxon build/db.biblioset.xml.xi $(REFENTRYXSL) $@

build/db.bibliosource.xml: bibliosource/db.bibliosource.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.bibliosource.xml.xi
	@saxon build/db.bibliosource.xml.xi $(REFENTRYXSL) $@

build/db.blockquote.xml: blockquote/db.blockquote.xml blockquote/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.blockquote.xml.xi
	@saxon build/db.blockquote.xml.xi $(REFENTRYXSL) $@

build/db.book.xml: book/db.book.xml book/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.book.xml.xi
	@saxon build/db.book.xml.xi $(REFENTRYXSL) $@

build/db.bridgehead.xml: bridgehead/db.bridgehead.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.bridgehead.xml.xi
	@saxon build/db.bridgehead.xml.xi $(REFENTRYXSL) $@

build/db.callout.xml: callout/db.callout.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.callout.xml.xi
	@saxon build/db.callout.xml.xi $(REFENTRYXSL) $@

build/db.calloutlist.xml: calloutlist/db.calloutlist.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.calloutlist.xml.xi
	@saxon build/db.calloutlist.xml.xi $(REFENTRYXSL) $@

build/db.caption.xml: caption/db.caption.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.caption.xml.xi
	@saxon build/db.caption.xml.xi $(REFENTRYXSL) $@

build/db.html.caption.xml: caption/db.html.caption.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.caption.xml.xi
	@saxon build/db.html.caption.xml.xi $(REFENTRYXSL) $@

build/db.caution.xml: caution/db.caution.xml caution/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.caution.xml.xi
	@saxon build/db.caution.xml.xi $(REFENTRYXSL) $@

build/db.chapter.xml: chapter/db.chapter.xml chapter/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.chapter.xml.xi
	@saxon build/db.chapter.xml.xi $(REFENTRYXSL) $@

build/db.citation.xml: citation/db.citation.xml citation/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.citation.xml.xi
	@saxon build/db.citation.xml.xi $(REFENTRYXSL) $@

build/db.citebiblioid.xml: citebiblioid/db.citebiblioid.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.citebiblioid.xml.xi
	@saxon build/db.citebiblioid.xml.xi $(REFENTRYXSL) $@

build/db.citerefentry.xml: citerefentry/db.citerefentry.xml citerefentry/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.citerefentry.xml.xi
	@saxon build/db.citerefentry.xml.xi $(REFENTRYXSL) $@

build/db.citetitle.xml: citetitle/db.citetitle.xml citetitle/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.citetitle.xml.xi
	@saxon build/db.citetitle.xml.xi $(REFENTRYXSL) $@

build/db.city.xml: city/db.city.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.city.xml.xi
	@saxon build/db.city.xml.xi $(REFENTRYXSL) $@

build/db.classname.xml: classname/db.classname.xml classname/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.classname.xml.xi
	@saxon build/db.classname.xml.xi $(REFENTRYXSL) $@

build/db.classsynopsis.xml: classsynopsis/db.classsynopsis.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.classsynopsis.xml.xi
	@saxon build/db.classsynopsis.xml.xi $(REFENTRYXSL) $@

build/db.classsynopsisinfo.xml: classsynopsisinfo/db.classsynopsisinfo.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.classsynopsisinfo.xml.xi
	@saxon build/db.classsynopsisinfo.xml.xi $(REFENTRYXSL) $@

build/db.cmdsynopsis.xml: cmdsynopsis/db.cmdsynopsis.xml cmdsynopsis/example.1.xml cmdsynopsis/example.2.xml cmdsynopsis/example.3.xml cmdsynopsis/example.4.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.cmdsynopsis.xml.xi
	@saxon build/db.cmdsynopsis.xml.xi $(REFENTRYXSL) $@

build/db.co.xml: co/db.co.xml co/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.co.xml.xi
	@saxon build/db.co.xml.xi $(REFENTRYXSL) $@

build/db.code.xml: code/db.code.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.code.xml.xi
	@saxon build/db.code.xml.xi $(REFENTRYXSL) $@

build/db.html.col.xml: col/db.html.col.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.col.xml.xi
	@saxon build/db.html.col.xml.xi $(REFENTRYXSL) $@

build/db.html.colgroup.xml: colgroup/db.html.colgroup.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.colgroup.xml.xi
	@saxon build/db.html.colgroup.xml.xi $(REFENTRYXSL) $@

build/db.collab.xml: collab/db.collab.xml collab/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.collab.xml.xi
	@saxon build/db.collab.xml.xi $(REFENTRYXSL) $@

build/db.colophon.xml: colophon/db.colophon.xml colophon/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.colophon.xml.xi
	@saxon build/db.colophon.xml.xi $(REFENTRYXSL) $@

build/db.colspec.xml: colspec/db.colspec.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.colspec.xml.xi
	@saxon build/db.colspec.xml.xi $(REFENTRYXSL) $@

build/db.command.xml: command/db.command.xml command/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.command.xml.xi
	@saxon build/db.command.xml.xi $(REFENTRYXSL) $@

build/db.computeroutput.xml: computeroutput/db.computeroutput.xml computeroutput/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.computeroutput.xml.xi
	@saxon build/db.computeroutput.xml.xi $(REFENTRYXSL) $@

build/db.confdates.xml: confdates/db.confdates.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.confdates.xml.xi
	@saxon build/db.confdates.xml.xi $(REFENTRYXSL) $@

build/db.confgroup.xml: confgroup/db.confgroup.xml confgroup/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.confgroup.xml.xi
	@saxon build/db.confgroup.xml.xi $(REFENTRYXSL) $@

build/db.confnum.xml: confnum/db.confnum.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.confnum.xml.xi
	@saxon build/db.confnum.xml.xi $(REFENTRYXSL) $@

build/db.confsponsor.xml: confsponsor/db.confsponsor.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.confsponsor.xml.xi
	@saxon build/db.confsponsor.xml.xi $(REFENTRYXSL) $@

build/db.conftitle.xml: conftitle/db.conftitle.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.conftitle.xml.xi
	@saxon build/db.conftitle.xml.xi $(REFENTRYXSL) $@

build/db.constant.xml: constant/db.constant.xml constant/example.1.xml constant/example.2.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.constant.xml.xi
	@saxon build/db.constant.xml.xi $(REFENTRYXSL) $@

build/db.constraint.xml: constraint/db.constraint.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.constraint.xml.xi
	@saxon build/db.constraint.xml.xi $(REFENTRYXSL) $@

build/db.constraintdef.xml: constraintdef/db.constraintdef.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.constraintdef.xml.xi
	@saxon build/db.constraintdef.xml.xi $(REFENTRYXSL) $@

build/db.constructorsynopsis.xml: constructorsynopsis/db.constructorsynopsis.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.constructorsynopsis.xml.xi
	@saxon build/db.constructorsynopsis.xml.xi $(REFENTRYXSL) $@

build/db.contractnum.xml: contractnum/db.contractnum.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.contractnum.xml.xi
	@saxon build/db.contractnum.xml.xi $(REFENTRYXSL) $@

build/db.contractsponsor.xml: contractsponsor/db.contractsponsor.xml contractsponsor/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.contractsponsor.xml.xi
	@saxon build/db.contractsponsor.xml.xi $(REFENTRYXSL) $@

build/db.contrib.xml: contrib/db.contrib.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.contrib.xml.xi
	@saxon build/db.contrib.xml.xi $(REFENTRYXSL) $@

build/db.copyright.xml: copyright/db.copyright.xml copyright/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.copyright.xml.xi
	@saxon build/db.copyright.xml.xi $(REFENTRYXSL) $@

build/db.coref.xml: coref/db.coref.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.coref.xml.xi
	@saxon build/db.coref.xml.xi $(REFENTRYXSL) $@

build/db.country.xml: country/db.country.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.country.xml.xi
	@saxon build/db.country.xml.xi $(REFENTRYXSL) $@

build/db.cover.xml: cover/db.cover.xml cover/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.cover.xml.xi
	@saxon build/db.cover.xml.xi $(REFENTRYXSL) $@

build/db.database.xml: database/db.database.xml database/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.database.xml.xi
	@saxon build/db.database.xml.xi $(REFENTRYXSL) $@

build/db.date.xml: date/db.date.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.date.xml.xi
	@saxon build/db.date.xml.xi $(REFENTRYXSL) $@

build/db.dedication.xml: dedication/db.dedication.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.dedication.xml.xi
	@saxon build/db.dedication.xml.xi $(REFENTRYXSL) $@

build/db.destructorsynopsis.xml: destructorsynopsis/db.destructorsynopsis.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.destructorsynopsis.xml.xi
	@saxon build/db.destructorsynopsis.xml.xi $(REFENTRYXSL) $@

build/db.edition.xml: edition/db.edition.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.edition.xml.xi
	@saxon build/db.edition.xml.xi $(REFENTRYXSL) $@

build/db.editor.xml: editor/db.editor.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.editor.xml.xi
	@saxon build/db.editor.xml.xi $(REFENTRYXSL) $@

build/db.email.xml: email/db.email.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.email.xml.xi
	@saxon build/db.email.xml.xi $(REFENTRYXSL) $@

build/db._emphasis.xml: emphasis/db._emphasis.xml emphasis/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db._emphasis.xml.xi
	@saxon build/db._emphasis.xml.xi $(REFENTRYXSL) $@

build/db.emphasis.xml: emphasis/db.emphasis.xml emphasis/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.emphasis.xml.xi
	@saxon build/db.emphasis.xml.xi $(REFENTRYXSL) $@

build/db.entry.xml: entry/db.entry.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.entry.xml.xi
	@saxon build/db.entry.xml.xi $(REFENTRYXSL) $@

build/db.entrytbl.xml: entrytbl/db.entrytbl.xml entrytbl/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.entrytbl.xml.xi
	@saxon build/db.entrytbl.xml.xi $(REFENTRYXSL) $@

build/db.envar.xml: envar/db.envar.xml envar/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.envar.xml.xi
	@saxon build/db.envar.xml.xi $(REFENTRYXSL) $@

build/db.epigraph.xml: epigraph/db.epigraph.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.epigraph.xml.xi
	@saxon build/db.epigraph.xml.xi $(REFENTRYXSL) $@

build/db.equation.xml: equation/db.equation.xml equation/example.1.xml equation/example.2.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.equation.xml.xi
	@saxon build/db.equation.xml.xi $(REFENTRYXSL) $@

build/db.errorcode.xml: errorcode/db.errorcode.xml errorcode/example.1.xml errorcode/example.2.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.errorcode.xml.xi
	@saxon build/db.errorcode.xml.xi $(REFENTRYXSL) $@

build/db.errorname.xml: errorname/db.errorname.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.errorname.xml.xi
	@saxon build/db.errorname.xml.xi $(REFENTRYXSL) $@

build/db.errortext.xml: errortext/db.errortext.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.errortext.xml.xi
	@saxon build/db.errortext.xml.xi $(REFENTRYXSL) $@

build/db.errortype.xml: errortype/db.errortype.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.errortype.xml.xi
	@saxon build/db.errortype.xml.xi $(REFENTRYXSL) $@

build/db.example.xml: example/db.example.xml example/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.example.xml.xi
	@saxon build/db.example.xml.xi $(REFENTRYXSL) $@

build/db.exceptionname.xml: exceptionname/db.exceptionname.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.exceptionname.xml.xi
	@saxon build/db.exceptionname.xml.xi $(REFENTRYXSL) $@

build/db.extendedlink.xml: extendedlink/db.extendedlink.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.extendedlink.xml.xi
	@saxon build/db.extendedlink.xml.xi $(REFENTRYXSL) $@

build/db.fax.xml: fax/db.fax.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.fax.xml.xi
	@saxon build/db.fax.xml.xi $(REFENTRYXSL) $@

build/db.fieldsynopsis.xml: fieldsynopsis/db.fieldsynopsis.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.fieldsynopsis.xml.xi
	@saxon build/db.fieldsynopsis.xml.xi $(REFENTRYXSL) $@

build/db.figure.xml: figure/db.figure.xml figure/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.figure.xml.xi
	@saxon build/db.figure.xml.xi $(REFENTRYXSL) $@

build/db.filename.xml: filename/db.filename.xml filename/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.filename.xml.xi
	@saxon build/db.filename.xml.xi $(REFENTRYXSL) $@

build/db.firstname.xml: firstname/db.firstname.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.firstname.xml.xi
	@saxon build/db.firstname.xml.xi $(REFENTRYXSL) $@

build/db.firstterm.xml: firstterm/db.firstterm.xml firstterm/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.firstterm.xml.xi
	@saxon build/db.firstterm.xml.xi $(REFENTRYXSL) $@

build/db.footnote.xml: footnote/db.footnote.xml footnote/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.footnote.xml.xi
	@saxon build/db.footnote.xml.xi $(REFENTRYXSL) $@

build/db.footnoteref.xml: footnoteref/db.footnoteref.xml footnoteref/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.footnoteref.xml.xi
	@saxon build/db.footnoteref.xml.xi $(REFENTRYXSL) $@

build/db.foreignphrase.xml: foreignphrase/db.foreignphrase.xml foreignphrase/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.foreignphrase.xml.xi
	@saxon build/db.foreignphrase.xml.xi $(REFENTRYXSL) $@

build/db.formalpara.xml: formalpara/db.formalpara.xml formalpara/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.formalpara.xml.xi
	@saxon build/db.formalpara.xml.xi $(REFENTRYXSL) $@

build/db.funcdef.xml: funcdef/db.funcdef.xml funcdef/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.funcdef.xml.xi
	@saxon build/db.funcdef.xml.xi $(REFENTRYXSL) $@

build/db.funcparams.xml: funcparams/db.funcparams.xml funcparams/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.funcparams.xml.xi
	@saxon build/db.funcparams.xml.xi $(REFENTRYXSL) $@

build/db.funcprototype.xml: funcprototype/db.funcprototype.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.funcprototype.xml.xi
	@saxon build/db.funcprototype.xml.xi $(REFENTRYXSL) $@

build/db.funcsynopsis.xml: funcsynopsis/db.funcsynopsis.xml funcsynopsis/example.1.xml funcsynopsis/example.2.xml funcsynopsis/example.3.xml funcsynopsis/example.4.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.funcsynopsis.xml.xi
	@saxon build/db.funcsynopsis.xml.xi $(REFENTRYXSL) $@

build/db.funcsynopsisinfo.xml: funcsynopsisinfo/db.funcsynopsisinfo.xml funcsynopsisinfo/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.funcsynopsisinfo.xml.xi
	@saxon build/db.funcsynopsisinfo.xml.xi $(REFENTRYXSL) $@

build/db.function.xml: function/db.function.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.function.xml.xi
	@saxon build/db.function.xml.xi $(REFENTRYXSL) $@

build/db.glossary.xml: glossary/db.glossary.xml glossary/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.glossary.xml.xi
	@saxon build/db.glossary.xml.xi $(REFENTRYXSL) $@

build/db.glossdef.xml: glossdef/db.glossdef.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.glossdef.xml.xi
	@saxon build/db.glossdef.xml.xi $(REFENTRYXSL) $@

build/db.glossdiv.xml: glossdiv/db.glossdiv.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.glossdiv.xml.xi
	@saxon build/db.glossdiv.xml.xi $(REFENTRYXSL) $@

build/db.glossentry.xml: glossentry/db.glossentry.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.glossentry.xml.xi
	@saxon build/db.glossentry.xml.xi $(REFENTRYXSL) $@

build/db.glosslist.xml: glosslist/db.glosslist.xml glosslist/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.glosslist.xml.xi
	@saxon build/db.glosslist.xml.xi $(REFENTRYXSL) $@

build/db.glosssee.xml: glosssee/db.glosssee.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.glosssee.xml.xi
	@saxon build/db.glosssee.xml.xi $(REFENTRYXSL) $@

build/db.glossseealso.xml: glossseealso/db.glossseealso.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.glossseealso.xml.xi
	@saxon build/db.glossseealso.xml.xi $(REFENTRYXSL) $@

build/db.glossterm.xml: glossterm/db.glossterm.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.glossterm.xml.xi
	@saxon build/db.glossterm.xml.xi $(REFENTRYXSL) $@

build/db.group.xml: group/db.group.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.group.xml.xi
	@saxon build/db.group.xml.xi $(REFENTRYXSL) $@

build/db.guibutton.xml: guibutton/db.guibutton.xml guibutton/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.guibutton.xml.xi
	@saxon build/db.guibutton.xml.xi $(REFENTRYXSL) $@

build/db.guiicon.xml: guiicon/db.guiicon.xml guiicon/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.guiicon.xml.xi
	@saxon build/db.guiicon.xml.xi $(REFENTRYXSL) $@

build/db.guilabel.xml: guilabel/db.guilabel.xml guilabel/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.guilabel.xml.xi
	@saxon build/db.guilabel.xml.xi $(REFENTRYXSL) $@

build/db.guimenu.xml: guimenu/db.guimenu.xml guimenu/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.guimenu.xml.xi
	@saxon build/db.guimenu.xml.xi $(REFENTRYXSL) $@

build/db.guimenuitem.xml: guimenuitem/db.guimenuitem.xml guimenuitem/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.guimenuitem.xml.xi
	@saxon build/db.guimenuitem.xml.xi $(REFENTRYXSL) $@

build/db.guisubmenu.xml: guisubmenu/db.guisubmenu.xml guisubmenu/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.guisubmenu.xml.xi
	@saxon build/db.guisubmenu.xml.xi $(REFENTRYXSL) $@

build/db.hardware.xml: hardware/db.hardware.xml hardware/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.hardware.xml.xi
	@saxon build/db.hardware.xml.xi $(REFENTRYXSL) $@

build/db.holder.xml: holder/db.holder.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.holder.xml.xi
	@saxon build/db.holder.xml.xi $(REFENTRYXSL) $@

build/db.honorific.xml: honorific/db.honorific.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.honorific.xml.xi
	@saxon build/db.honorific.xml.xi $(REFENTRYXSL) $@

build/db.html.button.xml: html/db.html.button.xml html/example.form.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.button.xml.xi
	@saxon build/db.html.button.xml.xi $(REFENTRYXSL) $@

build/db.html.fieldset.xml: html/db.html.fieldset.xml html/example.form.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.fieldset.xml.xi
	@saxon build/db.html.fieldset.xml.xi $(REFENTRYXSL) $@

build/db.html.form.xml: html/db.html.form.xml html/example.form.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.form.xml.xi
	@saxon build/db.html.form.xml.xi $(REFENTRYXSL) $@

build/db.html.input.xml: html/db.html.input.xml html/example.form.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.input.xml.xi
	@saxon build/db.html.input.xml.xi $(REFENTRYXSL) $@

build/db.html.label.xml: html/db.html.label.xml html/example.form.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.label.xml.xi
	@saxon build/db.html.label.xml.xi $(REFENTRYXSL) $@

build/db.html.legend.xml: html/db.html.legend.xml html/example.form.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.legend.xml.xi
	@saxon build/db.html.legend.xml.xi $(REFENTRYXSL) $@

build/db.html.option.xml: html/db.html.option.xml html/example.form.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.option.xml.xi
	@saxon build/db.html.option.xml.xi $(REFENTRYXSL) $@

build/db.html.select.xml: html/db.html.select.xml html/example.form.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.select.xml.xi
	@saxon build/db.html.select.xml.xi $(REFENTRYXSL) $@

build/db.html.textarea.xml: html/db.html.textarea.xml html/example.form.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.textarea.xml.xi
	@saxon build/db.html.textarea.xml.xi $(REFENTRYXSL) $@

build/db.imagedata.mathml.xml: imagedata/db.imagedata.mathml.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.imagedata.mathml.xml.xi
	@saxon build/db.imagedata.mathml.xml.xi $(REFENTRYXSL) $@

build/db.imagedata.svg.xml: imagedata/db.imagedata.svg.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.imagedata.svg.xml.xi
	@saxon build/db.imagedata.svg.xml.xi $(REFENTRYXSL) $@

build/db.imagedata.xml: imagedata/db.imagedata.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.imagedata.xml.xi
	@saxon build/db.imagedata.xml.xi $(REFENTRYXSL) $@

build/db.imageobject.xml: imageobject/db.imageobject.xml imageobject/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.imageobject.xml.xi
	@saxon build/db.imageobject.xml.xi $(REFENTRYXSL) $@

build/db.imageobjectco.xml: imageobjectco/db.imageobjectco.xml imageobjectco/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.imageobjectco.xml.xi
	@saxon build/db.imageobjectco.xml.xi $(REFENTRYXSL) $@

build/db.important.xml: important/db.important.xml important/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.important.xml.xi
	@saxon build/db.important.xml.xi $(REFENTRYXSL) $@

build/db.index.xml: index/db.index.xml index/example.1.xml index/example.2.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.index.xml.xi
	@saxon build/db.index.xml.xi $(REFENTRYXSL) $@

build/db.indexdiv.xml: indexdiv/db.indexdiv.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.indexdiv.xml.xi
	@saxon build/db.indexdiv.xml.xi $(REFENTRYXSL) $@

build/db.indexentry.xml: indexentry/db.indexentry.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.indexentry.xml.xi
	@saxon build/db.indexentry.xml.xi $(REFENTRYXSL) $@

build/db.indexterm.endofrange.xml: indexterm/db.indexterm.endofrange.xml indexterm/example.1.xml indexterm/example.2.xml indexterm/example.3.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.indexterm.endofrange.xml.xi
	@saxon build/db.indexterm.endofrange.xml.xi $(REFENTRYXSL) $@

build/db.indexterm.singular.xml: indexterm/db.indexterm.singular.xml indexterm/example.1.xml indexterm/example.2.xml indexterm/example.3.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.indexterm.singular.xml.xi
	@saxon build/db.indexterm.singular.xml.xi $(REFENTRYXSL) $@

build/db.indexterm.startofrange.xml: indexterm/db.indexterm.startofrange.xml indexterm/example.1.xml indexterm/example.2.xml indexterm/example.3.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.indexterm.startofrange.xml.xi
	@saxon build/db.indexterm.startofrange.xml.xi $(REFENTRYXSL) $@

build/db.info.xml: info/db.info.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.info.xml.xi
	@saxon build/db.info.xml.xi $(REFENTRYXSL) $@

build/db.titleforbidden.info.xml: info/db.titleforbidden.info.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.titleforbidden.info.xml.xi
	@saxon build/db.titleforbidden.info.xml.xi $(REFENTRYXSL) $@

build/db.titleonly.info.xml: info/db.titleonly.info.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.titleonly.info.xml.xi
	@saxon build/db.titleonly.info.xml.xi $(REFENTRYXSL) $@

build/db.titleonlyreq.info.xml: info/db.titleonlyreq.info.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.titleonlyreq.info.xml.xi
	@saxon build/db.titleonlyreq.info.xml.xi $(REFENTRYXSL) $@

build/db.titlereq.info.xml: info/db.titlereq.info.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.titlereq.info.xml.xi
	@saxon build/db.titlereq.info.xml.xi $(REFENTRYXSL) $@

build/db.informalequation.xml: informalequation/db.informalequation.xml informalequation/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.informalequation.xml.xi
	@saxon build/db.informalequation.xml.xi $(REFENTRYXSL) $@

build/db.informalexample.xml: informalexample/db.informalexample.xml informalexample/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.informalexample.xml.xi
	@saxon build/db.informalexample.xml.xi $(REFENTRYXSL) $@

build/db.informalfigure.xml: informalfigure/db.informalfigure.xml informalfigure/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.informalfigure.xml.xi
	@saxon build/db.informalfigure.xml.xi $(REFENTRYXSL) $@

build/db.cals.informaltable.xml: informaltable/db.cals.informaltable.xml informaltable/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.cals.informaltable.xml.xi
	@saxon build/db.cals.informaltable.xml.xi $(REFENTRYXSL) $@

build/db.html.informaltable.xml: informaltable/db.html.informaltable.xml informaltable/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.informaltable.xml.xi
	@saxon build/db.html.informaltable.xml.xi $(REFENTRYXSL) $@

build/db.initializer.xml: initializer/db.initializer.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.initializer.xml.xi
	@saxon build/db.initializer.xml.xi $(REFENTRYXSL) $@

build/db.inlineequation.xml: inlineequation/db.inlineequation.xml inlineequation/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.inlineequation.xml.xi
	@saxon build/db.inlineequation.xml.xi $(REFENTRYXSL) $@

build/db.inlinemediaobject.xml: inlinemediaobject/db.inlinemediaobject.xml inlinemediaobject/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.inlinemediaobject.xml.xi
	@saxon build/db.inlinemediaobject.xml.xi $(REFENTRYXSL) $@

build/db.interfacename.xml: interfacename/db.interfacename.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.interfacename.xml.xi
	@saxon build/db.interfacename.xml.xi $(REFENTRYXSL) $@

build/db.issuenum.xml: issuenum/db.issuenum.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.issuenum.xml.xi
	@saxon build/db.issuenum.xml.xi $(REFENTRYXSL) $@

build/db.itemizedlist.xml: itemizedlist/db.itemizedlist.xml itemizedlist/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.itemizedlist.xml.xi
	@saxon build/db.itemizedlist.xml.xi $(REFENTRYXSL) $@

build/db.itermset.xml: itermset/db.itermset.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.itermset.xml.xi
	@saxon build/db.itermset.xml.xi $(REFENTRYXSL) $@

build/db.jobtitle.xml: jobtitle/db.jobtitle.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.jobtitle.xml.xi
	@saxon build/db.jobtitle.xml.xi $(REFENTRYXSL) $@

build/db.keycap.xml: keycap/db.keycap.xml keycap/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.keycap.xml.xi
	@saxon build/db.keycap.xml.xi $(REFENTRYXSL) $@

build/db.keycode.xml: keycode/db.keycode.xml keycode/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.keycode.xml.xi
	@saxon build/db.keycode.xml.xi $(REFENTRYXSL) $@

build/db.keycombo.xml: keycombo/db.keycombo.xml keycombo/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.keycombo.xml.xi
	@saxon build/db.keycombo.xml.xi $(REFENTRYXSL) $@

build/db.keysym.xml: keysym/db.keysym.xml keysym/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.keysym.xml.xi
	@saxon build/db.keysym.xml.xi $(REFENTRYXSL) $@

build/db.keyword.xml: keyword/db.keyword.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.keyword.xml.xi
	@saxon build/db.keyword.xml.xi $(REFENTRYXSL) $@

build/db.keywordset.xml: keywordset/db.keywordset.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.keywordset.xml.xi
	@saxon build/db.keywordset.xml.xi $(REFENTRYXSL) $@

build/db.label.xml: label/db.label.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.label.xml.xi
	@saxon build/db.label.xml.xi $(REFENTRYXSL) $@

build/db.legalnotice.xml: legalnotice/db.legalnotice.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.legalnotice.xml.xi
	@saxon build/db.legalnotice.xml.xi $(REFENTRYXSL) $@

build/db.lhs.xml: lhs/db.lhs.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.lhs.xml.xi
	@saxon build/db.lhs.xml.xi $(REFENTRYXSL) $@

build/db.lineage.xml: lineage/db.lineage.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.lineage.xml.xi
	@saxon build/db.lineage.xml.xi $(REFENTRYXSL) $@

build/db.lineannotation.xml: lineannotation/db.lineannotation.xml lineannotation/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.lineannotation.xml.xi
	@saxon build/db.lineannotation.xml.xi $(REFENTRYXSL) $@

build/db.link.xml: link/db.link.xml link/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.link.xml.xi
	@saxon build/db.link.xml.xi $(REFENTRYXSL) $@

build/db.listitem.xml: listitem/db.listitem.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.listitem.xml.xi
	@saxon build/db.listitem.xml.xi $(REFENTRYXSL) $@

build/db.literal.xml: literal/db.literal.xml literal/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.literal.xml.xi
	@saxon build/db.literal.xml.xi $(REFENTRYXSL) $@

build/db.literallayout.xml: literallayout/db.literallayout.xml literallayout/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.literallayout.xml.xi
	@saxon build/db.literallayout.xml.xi $(REFENTRYXSL) $@

build/db.locator.xml: locator/db.locator.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.locator.xml.xi
	@saxon build/db.locator.xml.xi $(REFENTRYXSL) $@

build/db.manvolnum.xml: manvolnum/db.manvolnum.xml manvolnum/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.manvolnum.xml.xi
	@saxon build/db.manvolnum.xml.xi $(REFENTRYXSL) $@

build/db.markup.xml: markup/db.markup.xml markup/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.markup.xml.xi
	@saxon build/db.markup.xml.xi $(REFENTRYXSL) $@

build/db.mathphrase.xml: mathphrase/db.mathphrase.xml mathphrase/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.mathphrase.xml.xi
	@saxon build/db.mathphrase.xml.xi $(REFENTRYXSL) $@

build/db.mediaobject.xml: mediaobject/db.mediaobject.xml mediaobject/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.mediaobject.xml.xi
	@saxon build/db.mediaobject.xml.xi $(REFENTRYXSL) $@

build/db.member.xml: member/db.member.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.member.xml.xi
	@saxon build/db.member.xml.xi $(REFENTRYXSL) $@

build/db.menuchoice.xml: menuchoice/db.menuchoice.xml menuchoice/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.menuchoice.xml.xi
	@saxon build/db.menuchoice.xml.xi $(REFENTRYXSL) $@

build/db.methodname.xml: methodname/db.methodname.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.methodname.xml.xi
	@saxon build/db.methodname.xml.xi $(REFENTRYXSL) $@

build/db.methodparam.xml: methodparam/db.methodparam.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.methodparam.xml.xi
	@saxon build/db.methodparam.xml.xi $(REFENTRYXSL) $@

build/db.methodsynopsis.xml: methodsynopsis/db.methodsynopsis.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.methodsynopsis.xml.xi
	@saxon build/db.methodsynopsis.xml.xi $(REFENTRYXSL) $@

build/db.modifier.xml: modifier/db.modifier.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.modifier.xml.xi
	@saxon build/db.modifier.xml.xi $(REFENTRYXSL) $@

build/db.mousebutton.xml: mousebutton/db.mousebutton.xml mousebutton/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.mousebutton.xml.xi
	@saxon build/db.mousebutton.xml.xi $(REFENTRYXSL) $@

build/db.msg.xml: msg/db.msg.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.msg.xml.xi
	@saxon build/db.msg.xml.xi $(REFENTRYXSL) $@

build/db.msgaud.xml: msgaud/db.msgaud.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.msgaud.xml.xi
	@saxon build/db.msgaud.xml.xi $(REFENTRYXSL) $@

build/db.msgentry.xml: msgentry/db.msgentry.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.msgentry.xml.xi
	@saxon build/db.msgentry.xml.xi $(REFENTRYXSL) $@

build/db.msgexplan.xml: msgexplan/db.msgexplan.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.msgexplan.xml.xi
	@saxon build/db.msgexplan.xml.xi $(REFENTRYXSL) $@

build/db.msginfo.xml: msginfo/db.msginfo.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.msginfo.xml.xi
	@saxon build/db.msginfo.xml.xi $(REFENTRYXSL) $@

build/db.msglevel.xml: msglevel/db.msglevel.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.msglevel.xml.xi
	@saxon build/db.msglevel.xml.xi $(REFENTRYXSL) $@

build/db.msgmain.xml: msgmain/db.msgmain.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.msgmain.xml.xi
	@saxon build/db.msgmain.xml.xi $(REFENTRYXSL) $@

build/db.msgorig.xml: msgorig/db.msgorig.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.msgorig.xml.xi
	@saxon build/db.msgorig.xml.xi $(REFENTRYXSL) $@

build/db.msgrel.xml: msgrel/db.msgrel.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.msgrel.xml.xi
	@saxon build/db.msgrel.xml.xi $(REFENTRYXSL) $@

build/db.msgset.xml: msgset/db.msgset.xml msgset/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.msgset.xml.xi
	@saxon build/db.msgset.xml.xi $(REFENTRYXSL) $@

build/db.msgsub.xml: msgsub/db.msgsub.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.msgsub.xml.xi
	@saxon build/db.msgsub.xml.xi $(REFENTRYXSL) $@

build/db.msgtext.xml: msgtext/db.msgtext.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.msgtext.xml.xi
	@saxon build/db.msgtext.xml.xi $(REFENTRYXSL) $@

build/db.nonterminal.xml: nonterminal/db.nonterminal.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.nonterminal.xml.xi
	@saxon build/db.nonterminal.xml.xi $(REFENTRYXSL) $@

build/db.note.xml: note/db.note.xml note/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.note.xml.xi
	@saxon build/db.note.xml.xi $(REFENTRYXSL) $@

build/db.olink.xml: olink/db.olink.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.olink.xml.xi
	@saxon build/db.olink.xml.xi $(REFENTRYXSL) $@

build/db.ooclass.xml: ooclass/db.ooclass.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.ooclass.xml.xi
	@saxon build/db.ooclass.xml.xi $(REFENTRYXSL) $@

build/db.ooexception.xml: ooexception/db.ooexception.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.ooexception.xml.xi
	@saxon build/db.ooexception.xml.xi $(REFENTRYXSL) $@

build/db.oointerface.xml: oointerface/db.oointerface.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.oointerface.xml.xi
	@saxon build/db.oointerface.xml.xi $(REFENTRYXSL) $@

build/db.option.xml: option/db.option.xml option/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.option.xml.xi
	@saxon build/db.option.xml.xi $(REFENTRYXSL) $@

build/db.optional.xml: optional/db.optional.xml optional/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.optional.xml.xi
	@saxon build/db.optional.xml.xi $(REFENTRYXSL) $@

build/db.orderedlist.xml: orderedlist/db.orderedlist.xml orderedlist/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.orderedlist.xml.xi
	@saxon build/db.orderedlist.xml.xi $(REFENTRYXSL) $@

build/db.org.xml: org/db.org.xml org/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.org.xml.xi
	@saxon build/db.org.xml.xi $(REFENTRYXSL) $@

build/db.orgdiv.xml: orgdiv/db.orgdiv.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.orgdiv.xml.xi
	@saxon build/db.orgdiv.xml.xi $(REFENTRYXSL) $@

build/db.orgname.xml: orgname/db.orgname.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.orgname.xml.xi
	@saxon build/db.orgname.xml.xi $(REFENTRYXSL) $@

build/db.otheraddr.xml: otheraddr/db.otheraddr.xml otheraddr/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.otheraddr.xml.xi
	@saxon build/db.otheraddr.xml.xi $(REFENTRYXSL) $@

build/db.othercredit.xml: othercredit/db.othercredit.xml othercredit/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.othercredit.xml.xi
	@saxon build/db.othercredit.xml.xi $(REFENTRYXSL) $@

build/db.othername.xml: othername/db.othername.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.othername.xml.xi
	@saxon build/db.othername.xml.xi $(REFENTRYXSL) $@

build/db.package.xml: package/db.package.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.package.xml.xi
	@saxon build/db.package.xml.xi $(REFENTRYXSL) $@

build/db.pagenums.xml: pagenums/db.pagenums.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.pagenums.xml.xi
	@saxon build/db.pagenums.xml.xi $(REFENTRYXSL) $@

build/db.para.xml: para/db.para.xml para/example.1.xml para/example.2.xml para/example.3.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.para.xml.xi
	@saxon build/db.para.xml.xi $(REFENTRYXSL) $@

build/db.paramdef.xml: paramdef/db.paramdef.xml paramdef/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.paramdef.xml.xi
	@saxon build/db.paramdef.xml.xi $(REFENTRYXSL) $@

build/db.parameter.xml: parameter/db.parameter.xml parameter/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.parameter.xml.xi
	@saxon build/db.parameter.xml.xi $(REFENTRYXSL) $@

build/db.part.xml: part/db.part.xml part/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.part.xml.xi
	@saxon build/db.part.xml.xi $(REFENTRYXSL) $@

build/db.partintro.xml: partintro/db.partintro.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.partintro.xml.xi
	@saxon build/db.partintro.xml.xi $(REFENTRYXSL) $@

build/db.person.xml: person/db.person.xml person/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.person.xml.xi
	@saxon build/db.person.xml.xi $(REFENTRYXSL) $@

build/db.personblurb.xml: personblurb/db.personblurb.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.personblurb.xml.xi
	@saxon build/db.personblurb.xml.xi $(REFENTRYXSL) $@

build/db.personname.xml: personname/db.personname.xml personname/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.personname.xml.xi
	@saxon build/db.personname.xml.xi $(REFENTRYXSL) $@

build/db.phone.xml: phone/db.phone.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.phone.xml.xi
	@saxon build/db.phone.xml.xi $(REFENTRYXSL) $@

build/db._phrase.xml: phrase/db._phrase.xml phrase/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db._phrase.xml.xi
	@saxon build/db._phrase.xml.xi $(REFENTRYXSL) $@

build/db.phrase.xml: phrase/db.phrase.xml phrase/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.phrase.xml.xi
	@saxon build/db.phrase.xml.xi $(REFENTRYXSL) $@

build/db.pob.xml: pob/db.pob.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.pob.xml.xi
	@saxon build/db.pob.xml.xi $(REFENTRYXSL) $@

build/db.postcode.xml: postcode/db.postcode.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.postcode.xml.xi
	@saxon build/db.postcode.xml.xi $(REFENTRYXSL) $@

build/db.preface.xml: preface/db.preface.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.preface.xml.xi
	@saxon build/db.preface.xml.xi $(REFENTRYXSL) $@

build/db.primary.xml: primary/db.primary.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.primary.xml.xi
	@saxon build/db.primary.xml.xi $(REFENTRYXSL) $@

build/db.primaryie.xml: primaryie/db.primaryie.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.primaryie.xml.xi
	@saxon build/db.primaryie.xml.xi $(REFENTRYXSL) $@

build/db.printhistory.xml: printhistory/db.printhistory.xml printhistory/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.printhistory.xml.xi
	@saxon build/db.printhistory.xml.xi $(REFENTRYXSL) $@

build/db.procedure.xml: procedure/db.procedure.xml procedure/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.procedure.xml.xi
	@saxon build/db.procedure.xml.xi $(REFENTRYXSL) $@

build/db.production.xml: production/db.production.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.production.xml.xi
	@saxon build/db.production.xml.xi $(REFENTRYXSL) $@

build/db.productionrecap.xml: productionrecap/db.productionrecap.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.productionrecap.xml.xi
	@saxon build/db.productionrecap.xml.xi $(REFENTRYXSL) $@

build/db.productionset.xml: productionset/db.productionset.xml productionset/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.productionset.xml.xi
	@saxon build/db.productionset.xml.xi $(REFENTRYXSL) $@

build/db.productname.xml: productname/db.productname.xml productname/example.1.xml productname/example.2.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.productname.xml.xi
	@saxon build/db.productname.xml.xi $(REFENTRYXSL) $@

build/db.productnumber.xml: productnumber/db.productnumber.xml productnumber/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.productnumber.xml.xi
	@saxon build/db.productnumber.xml.xi $(REFENTRYXSL) $@

build/db.programlisting.xml: programlisting/db.programlisting.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.programlisting.xml.xi
	@saxon build/db.programlisting.xml.xi $(REFENTRYXSL) $@

build/db.programlistingco.xml: programlistingco/db.programlistingco.xml programlistingco/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.programlistingco.xml.xi
	@saxon build/db.programlistingco.xml.xi $(REFENTRYXSL) $@

build/db.prompt.xml: prompt/db.prompt.xml prompt/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.prompt.xml.xi
	@saxon build/db.prompt.xml.xi $(REFENTRYXSL) $@

build/db.property.xml: property/db.property.xml property/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.property.xml.xi
	@saxon build/db.property.xml.xi $(REFENTRYXSL) $@

build/db.pubdate.xml: pubdate/db.pubdate.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.pubdate.xml.xi
	@saxon build/db.pubdate.xml.xi $(REFENTRYXSL) $@

build/db.publisher.xml: publisher/db.publisher.xml publisher/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.publisher.xml.xi
	@saxon build/db.publisher.xml.xi $(REFENTRYXSL) $@

build/db.publishername.xml: publishername/db.publishername.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.publishername.xml.xi
	@saxon build/db.publishername.xml.xi $(REFENTRYXSL) $@

build/db.qandadiv.xml: qandadiv/db.qandadiv.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.qandadiv.xml.xi
	@saxon build/db.qandadiv.xml.xi $(REFENTRYXSL) $@

build/db.qandaentry.xml: qandaentry/db.qandaentry.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.qandaentry.xml.xi
	@saxon build/db.qandaentry.xml.xi $(REFENTRYXSL) $@

build/db.qandaset.xml: qandaset/db.qandaset.xml qandaset/example.1.xml qandaset/example.2.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.qandaset.xml.xi
	@saxon build/db.qandaset.xml.xi $(REFENTRYXSL) $@

build/db.question.xml: question/db.question.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.question.xml.xi
	@saxon build/db.question.xml.xi $(REFENTRYXSL) $@

build/db.quote.xml: quote/db.quote.xml quote/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.quote.xml.xi
	@saxon build/db.quote.xml.xi $(REFENTRYXSL) $@

build/db.refclass.xml: refclass/db.refclass.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.refclass.xml.xi
	@saxon build/db.refclass.xml.xi $(REFENTRYXSL) $@

build/db.refdescriptor.xml: refdescriptor/db.refdescriptor.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.refdescriptor.xml.xi
	@saxon build/db.refdescriptor.xml.xi $(REFENTRYXSL) $@

build/db.refentry.xml: refentry/db.refentry.xml refentry/example.1.xml refentry/example.2.xml refentry/example.3.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.refentry.xml.xi
	@saxon build/db.refentry.xml.xi $(REFENTRYXSL) $@

build/db.refentrytitle.xml: refentrytitle/db.refentrytitle.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.refentrytitle.xml.xi
	@saxon build/db.refentrytitle.xml.xi $(REFENTRYXSL) $@

build/db.reference.xml: reference/db.reference.xml reference/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.reference.xml.xi
	@saxon build/db.reference.xml.xi $(REFENTRYXSL) $@

build/db.refmeta.xml: refmeta/db.refmeta.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.refmeta.xml.xi
	@saxon build/db.refmeta.xml.xi $(REFENTRYXSL) $@

build/db.refmiscinfo.xml: refmiscinfo/db.refmiscinfo.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.refmiscinfo.xml.xi
	@saxon build/db.refmiscinfo.xml.xi $(REFENTRYXSL) $@

build/db.refname.xml: refname/db.refname.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.refname.xml.xi
	@saxon build/db.refname.xml.xi $(REFENTRYXSL) $@

build/db.refnamediv.xml: refnamediv/db.refnamediv.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.refnamediv.xml.xi
	@saxon build/db.refnamediv.xml.xi $(REFENTRYXSL) $@

build/db.refpurpose.xml: refpurpose/db.refpurpose.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.refpurpose.xml.xi
	@saxon build/db.refpurpose.xml.xi $(REFENTRYXSL) $@

build/db.refsect1.xml: refsect1/db.refsect1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.refsect1.xml.xi
	@saxon build/db.refsect1.xml.xi $(REFENTRYXSL) $@

build/db.refsect2.xml: refsect2/db.refsect2.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.refsect2.xml.xi
	@saxon build/db.refsect2.xml.xi $(REFENTRYXSL) $@

build/db.refsect3.xml: refsect3/db.refsect3.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.refsect3.xml.xi
	@saxon build/db.refsect3.xml.xi $(REFENTRYXSL) $@

build/db.refsection.xml: refsection/db.refsection.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.refsection.xml.xi
	@saxon build/db.refsection.xml.xi $(REFENTRYXSL) $@

build/db.refsynopsisdiv.xml: refsynopsisdiv/db.refsynopsisdiv.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.refsynopsisdiv.xml.xi
	@saxon build/db.refsynopsisdiv.xml.xi $(REFENTRYXSL) $@

build/db.releaseinfo.xml: releaseinfo/db.releaseinfo.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.releaseinfo.xml.xi
	@saxon build/db.releaseinfo.xml.xi $(REFENTRYXSL) $@

build/db.remark.xml: remark/db.remark.xml remark/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.remark.xml.xi
	@saxon build/db.remark.xml.xi $(REFENTRYXSL) $@

build/db.replaceable.xml: replaceable/db.replaceable.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.replaceable.xml.xi
	@saxon build/db.replaceable.xml.xi $(REFENTRYXSL) $@

build/db.returnvalue.xml: returnvalue/db.returnvalue.xml returnvalue/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.returnvalue.xml.xi
	@saxon build/db.returnvalue.xml.xi $(REFENTRYXSL) $@

build/db.revdescription.xml: revdescription/db.revdescription.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.revdescription.xml.xi
	@saxon build/db.revdescription.xml.xi $(REFENTRYXSL) $@

build/db.revhistory.xml: revhistory/db.revhistory.xml revhistory/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.revhistory.xml.xi
	@saxon build/db.revhistory.xml.xi $(REFENTRYXSL) $@

build/db.revision.xml: revision/db.revision.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.revision.xml.xi
	@saxon build/db.revision.xml.xi $(REFENTRYXSL) $@

build/db.revnumber.xml: revnumber/db.revnumber.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.revnumber.xml.xi
	@saxon build/db.revnumber.xml.xi $(REFENTRYXSL) $@

build/db.revremark.xml: revremark/db.revremark.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.revremark.xml.xi
	@saxon build/db.revremark.xml.xi $(REFENTRYXSL) $@

build/db.rhs.xml: rhs/db.rhs.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.rhs.xml.xi
	@saxon build/db.rhs.xml.xi $(REFENTRYXSL) $@

build/db.entrytbl.row.xml: row/db.entrytbl.row.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.entrytbl.row.xml.xi
	@saxon build/db.entrytbl.row.xml.xi $(REFENTRYXSL) $@

build/db.row.xml: row/db.row.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.row.xml.xi
	@saxon build/db.row.xml.xi $(REFENTRYXSL) $@

build/db.sbr.xml: sbr/db.sbr.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.sbr.xml.xi
	@saxon build/db.sbr.xml.xi $(REFENTRYXSL) $@

build/db.screen.xml: screen/db.screen.xml screen/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.screen.xml.xi
	@saxon build/db.screen.xml.xi $(REFENTRYXSL) $@

build/db.screenco.xml: screenco/db.screenco.xml screenco/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.screenco.xml.xi
	@saxon build/db.screenco.xml.xi $(REFENTRYXSL) $@

build/db.screenshot.xml: screenshot/db.screenshot.xml screenshot/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.screenshot.xml.xi
	@saxon build/db.screenshot.xml.xi $(REFENTRYXSL) $@

build/db.secondary.xml: secondary/db.secondary.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.secondary.xml.xi
	@saxon build/db.secondary.xml.xi $(REFENTRYXSL) $@

build/db.secondaryie.xml: secondaryie/db.secondaryie.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.secondaryie.xml.xi
	@saxon build/db.secondaryie.xml.xi $(REFENTRYXSL) $@

build/db.sect1.xml: sect1/db.sect1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.sect1.xml.xi
	@saxon build/db.sect1.xml.xi $(REFENTRYXSL) $@

build/db.sect2.xml: sect2/db.sect2.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.sect2.xml.xi
	@saxon build/db.sect2.xml.xi $(REFENTRYXSL) $@

build/db.sect3.xml: sect3/db.sect3.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.sect3.xml.xi
	@saxon build/db.sect3.xml.xi $(REFENTRYXSL) $@

build/db.sect4.xml: sect4/db.sect4.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.sect4.xml.xi
	@saxon build/db.sect4.xml.xi $(REFENTRYXSL) $@

build/db.sect5.xml: sect5/db.sect5.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.sect5.xml.xi
	@saxon build/db.sect5.xml.xi $(REFENTRYXSL) $@

build/db.section.xml: section/db.section.xml section/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.section.xml.xi
	@saxon build/db.section.xml.xi $(REFENTRYXSL) $@

build/db.see.xml: see/db.see.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.see.xml.xi
	@saxon build/db.see.xml.xi $(REFENTRYXSL) $@

build/db.seealso.xml: seealso/db.seealso.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.seealso.xml.xi
	@saxon build/db.seealso.xml.xi $(REFENTRYXSL) $@

build/db.seealsoie.xml: seealsoie/db.seealsoie.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.seealsoie.xml.xi
	@saxon build/db.seealsoie.xml.xi $(REFENTRYXSL) $@

build/db.seeie.xml: seeie/db.seeie.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.seeie.xml.xi
	@saxon build/db.seeie.xml.xi $(REFENTRYXSL) $@

build/db.seg.xml: seg/db.seg.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.seg.xml.xi
	@saxon build/db.seg.xml.xi $(REFENTRYXSL) $@

build/db.seglistitem.xml: seglistitem/db.seglistitem.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.seglistitem.xml.xi
	@saxon build/db.seglistitem.xml.xi $(REFENTRYXSL) $@

build/db.segmentedlist.xml: segmentedlist/db.segmentedlist.xml segmentedlist/example.1.xml segmentedlist/example.2.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.segmentedlist.xml.xi
	@saxon build/db.segmentedlist.xml.xi $(REFENTRYXSL) $@

build/db.segtitle.xml: segtitle/db.segtitle.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.segtitle.xml.xi
	@saxon build/db.segtitle.xml.xi $(REFENTRYXSL) $@

build/db.seriesvolnums.xml: seriesvolnums/db.seriesvolnums.xml seriesvolnums/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.seriesvolnums.xml.xi
	@saxon build/db.seriesvolnums.xml.xi $(REFENTRYXSL) $@

build/db.set.xml: set/db.set.xml set/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.set.xml.xi
	@saxon build/db.set.xml.xi $(REFENTRYXSL) $@

build/db.setindex.xml: setindex/db.setindex.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.setindex.xml.xi
	@saxon build/db.setindex.xml.xi $(REFENTRYXSL) $@

build/db.shortaffil.xml: shortaffil/db.shortaffil.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.shortaffil.xml.xi
	@saxon build/db.shortaffil.xml.xi $(REFENTRYXSL) $@

build/db.shortcut.xml: shortcut/db.shortcut.xml shortcut/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.shortcut.xml.xi
	@saxon build/db.shortcut.xml.xi $(REFENTRYXSL) $@

build/db.sidebar.xml: sidebar/db.sidebar.xml sidebar/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.sidebar.xml.xi
	@saxon build/db.sidebar.xml.xi $(REFENTRYXSL) $@

build/db.simpara.xml: simpara/db.simpara.xml simpara/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.simpara.xml.xi
	@saxon build/db.simpara.xml.xi $(REFENTRYXSL) $@

build/db.simplelist.xml: simplelist/db.simplelist.xml simplelist/example.1.xml simplelist/example.2.xml simplelist/example.3.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.simplelist.xml.xi
	@saxon build/db.simplelist.xml.xi $(REFENTRYXSL) $@

build/db.simplemsgentry.xml: simplemsgentry/db.simplemsgentry.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.simplemsgentry.xml.xi
	@saxon build/db.simplemsgentry.xml.xi $(REFENTRYXSL) $@

build/db.simplesect.xml: simplesect/db.simplesect.xml simplesect/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.simplesect.xml.xi
	@saxon build/db.simplesect.xml.xi $(REFENTRYXSL) $@

build/db.spanspec.xml: spanspec/db.spanspec.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.spanspec.xml.xi
	@saxon build/db.spanspec.xml.xi $(REFENTRYXSL) $@

build/db.state.xml: state/db.state.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.state.xml.xi
	@saxon build/db.state.xml.xi $(REFENTRYXSL) $@

build/db.step.xml: step/db.step.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.step.xml.xi
	@saxon build/db.step.xml.xi $(REFENTRYXSL) $@

build/db.stepalternatives.xml: stepalternatives/db.stepalternatives.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.stepalternatives.xml.xi
	@saxon build/db.stepalternatives.xml.xi $(REFENTRYXSL) $@

build/db.street.xml: street/db.street.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.street.xml.xi
	@saxon build/db.street.xml.xi $(REFENTRYXSL) $@

build/db.subject.xml: subject/db.subject.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.subject.xml.xi
	@saxon build/db.subject.xml.xi $(REFENTRYXSL) $@

build/db.subjectset.xml: subjectset/db.subjectset.xml subjectset/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.subjectset.xml.xi
	@saxon build/db.subjectset.xml.xi $(REFENTRYXSL) $@

build/db.subjectterm.xml: subjectterm/db.subjectterm.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.subjectterm.xml.xi
	@saxon build/db.subjectterm.xml.xi $(REFENTRYXSL) $@

build/db.subscript.xml: subscript/db.subscript.xml subscript/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.subscript.xml.xi
	@saxon build/db.subscript.xml.xi $(REFENTRYXSL) $@

build/db.substeps.xml: substeps/db.substeps.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.substeps.xml.xi
	@saxon build/db.substeps.xml.xi $(REFENTRYXSL) $@

build/db.subtitle.xml: subtitle/db.subtitle.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.subtitle.xml.xi
	@saxon build/db.subtitle.xml.xi $(REFENTRYXSL) $@

build/db.superscript.xml: superscript/db.superscript.xml superscript/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.superscript.xml.xi
	@saxon build/db.superscript.xml.xi $(REFENTRYXSL) $@

build/db.surname.xml: surname/db.surname.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.surname.xml.xi
	@saxon build/db.surname.xml.xi $(REFENTRYXSL) $@

build/db.symbol.xml: symbol/db.symbol.xml symbol/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.symbol.xml.xi
	@saxon build/db.symbol.xml.xi $(REFENTRYXSL) $@

build/db.synopfragment.xml: synopfragment/db.synopfragment.xml synopfragment/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.synopfragment.xml.xi
	@saxon build/db.synopfragment.xml.xi $(REFENTRYXSL) $@

build/db.synopfragmentref.xml: synopfragmentref/db.synopfragmentref.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.synopfragmentref.xml.xi
	@saxon build/db.synopfragmentref.xml.xi $(REFENTRYXSL) $@

build/db.synopsis.xml: synopsis/db.synopsis.xml synopsis/example.1.xml synopsis/example.2.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.synopsis.xml.xi
	@saxon build/db.synopsis.xml.xi $(REFENTRYXSL) $@

build/db.systemitem.xml: systemitem/db.systemitem.xml systemitem/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.systemitem.xml.xi
	@saxon build/db.systemitem.xml.xi $(REFENTRYXSL) $@

build/db.cals.table.xml: table/db.cals.table.xml table/example.1.xml table/example.2.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.cals.table.xml.xi
	@saxon build/db.cals.table.xml.xi $(REFENTRYXSL) $@

build/db.html.table.xml: table/db.html.table.xml table/example.1.xml table/example.2.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.table.xml.xi
	@saxon build/db.html.table.xml.xi $(REFENTRYXSL) $@

build/db.tag.xml: tag/db.tag.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.tag.xml.xi
	@saxon build/db.tag.xml.xi $(REFENTRYXSL) $@

build/db.task.xml: task/db.task.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.task.xml.xi
	@saxon build/db.task.xml.xi $(REFENTRYXSL) $@

build/db.taskprerequisites.xml: taskprerequisites/db.taskprerequisites.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.taskprerequisites.xml.xi
	@saxon build/db.taskprerequisites.xml.xi $(REFENTRYXSL) $@

build/db.taskrelated.xml: taskrelated/db.taskrelated.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.taskrelated.xml.xi
	@saxon build/db.taskrelated.xml.xi $(REFENTRYXSL) $@

build/db.tasksummary.xml: tasksummary/db.tasksummary.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.tasksummary.xml.xi
	@saxon build/db.tasksummary.xml.xi $(REFENTRYXSL) $@

build/db.cals.entrytbl.tbody.xml: tbody/db.cals.entrytbl.tbody.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.cals.entrytbl.tbody.xml.xi
	@saxon build/db.cals.entrytbl.tbody.xml.xi $(REFENTRYXSL) $@

build/db.cals.tbody.xml: tbody/db.cals.tbody.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.cals.tbody.xml.xi
	@saxon build/db.cals.tbody.xml.xi $(REFENTRYXSL) $@

build/db.html.tbody.xml: tbody/db.html.tbody.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.tbody.xml.xi
	@saxon build/db.html.tbody.xml.xi $(REFENTRYXSL) $@

build/db.html.td.xml: td/db.html.td.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.td.xml.xi
	@saxon build/db.html.td.xml.xi $(REFENTRYXSL) $@

build/db.term.xml: term/db.term.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.term.xml.xi
	@saxon build/db.term.xml.xi $(REFENTRYXSL) $@

build/db.termdef.xml: termdef/db.termdef.xml termdef/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.termdef.xml.xi
	@saxon build/db.termdef.xml.xi $(REFENTRYXSL) $@

build/db.tertiary.xml: tertiary/db.tertiary.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.tertiary.xml.xi
	@saxon build/db.tertiary.xml.xi $(REFENTRYXSL) $@

build/db.tertiaryie.xml: tertiaryie/db.tertiaryie.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.tertiaryie.xml.xi
	@saxon build/db.tertiaryie.xml.xi $(REFENTRYXSL) $@

build/db.textdata.xml: textdata/db.textdata.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.textdata.xml.xi
	@saxon build/db.textdata.xml.xi $(REFENTRYXSL) $@

build/db.textobject.xml: textobject/db.textobject.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.textobject.xml.xi
	@saxon build/db.textobject.xml.xi $(REFENTRYXSL) $@

build/db.cals.tfoot.xml: tfoot/db.cals.tfoot.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.cals.tfoot.xml.xi
	@saxon build/db.cals.tfoot.xml.xi $(REFENTRYXSL) $@

build/db.html.tfoot.xml: tfoot/db.html.tfoot.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.tfoot.xml.xi
	@saxon build/db.html.tfoot.xml.xi $(REFENTRYXSL) $@

build/db.tgroup.xml: tgroup/db.tgroup.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.tgroup.xml.xi
	@saxon build/db.tgroup.xml.xi $(REFENTRYXSL) $@

build/db.html.th.xml: th/db.html.th.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.th.xml.xi
	@saxon build/db.html.th.xml.xi $(REFENTRYXSL) $@

build/db.cals.entrytbl.thead.xml: thead/db.cals.entrytbl.thead.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.cals.entrytbl.thead.xml.xi
	@saxon build/db.cals.entrytbl.thead.xml.xi $(REFENTRYXSL) $@

build/db.cals.thead.xml: thead/db.cals.thead.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.cals.thead.xml.xi
	@saxon build/db.cals.thead.xml.xi $(REFENTRYXSL) $@

build/db.html.thead.xml: thead/db.html.thead.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.thead.xml.xi
	@saxon build/db.html.thead.xml.xi $(REFENTRYXSL) $@

build/db.tip.xml: tip/db.tip.xml tip/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.tip.xml.xi
	@saxon build/db.tip.xml.xi $(REFENTRYXSL) $@

build/db.title.xml: title/db.title.xml title/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.title.xml.xi
	@saxon build/db.title.xml.xi $(REFENTRYXSL) $@

build/db.titleabbrev.xml: titleabbrev/db.titleabbrev.xml titleabbrev/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.titleabbrev.xml.xi
	@saxon build/db.titleabbrev.xml.xi $(REFENTRYXSL) $@

build/db.toc.xml: toc/db.toc.xml toc/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.toc.xml.xi
	@saxon build/db.toc.xml.xi $(REFENTRYXSL) $@

build/db.tocdiv.xml: tocdiv/db.tocdiv.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.tocdiv.xml.xi
	@saxon build/db.tocdiv.xml.xi $(REFENTRYXSL) $@

build/db.tocentry.xml: tocentry/db.tocentry.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.tocentry.xml.xi
	@saxon build/db.tocentry.xml.xi $(REFENTRYXSL) $@

build/db.token.xml: token/db.token.xml token/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.token.xml.xi
	@saxon build/db.token.xml.xi $(REFENTRYXSL) $@

build/db.html.tr.xml: tr/db.html.tr.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.html.tr.xml.xi
	@saxon build/db.html.tr.xml.xi $(REFENTRYXSL) $@

build/db.trademark.xml: trademark/db.trademark.xml trademark/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.trademark.xml.xi
	@saxon build/db.trademark.xml.xi $(REFENTRYXSL) $@

build/db.type.xml: type/db.type.xml type/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.type.xml.xi
	@saxon build/db.type.xml.xi $(REFENTRYXSL) $@

build/db.uri.xml: uri/db.uri.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.uri.xml.xi
	@saxon build/db.uri.xml.xi $(REFENTRYXSL) $@

build/db.userinput.xml: userinput/db.userinput.xml userinput/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.userinput.xml.xi
	@saxon build/db.userinput.xml.xi $(REFENTRYXSL) $@

build/db.varargs.xml: varargs/db.varargs.xml varargs/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.varargs.xml.xi
	@saxon build/db.varargs.xml.xi $(REFENTRYXSL) $@

build/db.variablelist.xml: variablelist/db.variablelist.xml variablelist/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.variablelist.xml.xi
	@saxon build/db.variablelist.xml.xi $(REFENTRYXSL) $@

build/db.varlistentry.xml: varlistentry/db.varlistentry.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.varlistentry.xml.xi
	@saxon build/db.varlistentry.xml.xi $(REFENTRYXSL) $@

build/db.varname.xml: varname/db.varname.xml varname/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.varname.xml.xi
	@saxon build/db.varname.xml.xi $(REFENTRYXSL) $@

build/db.videodata.xml: videodata/db.videodata.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.videodata.xml.xi
	@saxon build/db.videodata.xml.xi $(REFENTRYXSL) $@

build/db.videoobject.xml: videoobject/db.videoobject.xml videoobject/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.videoobject.xml.xi
	@saxon build/db.videoobject.xml.xi $(REFENTRYXSL) $@

build/db.void.xml: void/db.void.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.void.xml.xi
	@saxon build/db.void.xml.xi $(REFENTRYXSL) $@

build/db.volumenum.xml: volumenum/db.volumenum.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.volumenum.xml.xi
	@saxon build/db.volumenum.xml.xi $(REFENTRYXSL) $@

build/db.warning.xml: warning/db.warning.xml warning/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.warning.xml.xi
	@saxon build/db.warning.xml.xi $(REFENTRYXSL) $@

build/db.wordasword.xml: wordasword/db.wordasword.xml wordasword/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.wordasword.xml.xi
	@saxon build/db.wordasword.xml.xi $(REFENTRYXSL) $@

build/db.xref.xml: xref/db.xref.xml xref/example.1.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.xref.xml.xi
	@saxon build/db.xref.xml.xi $(REFENTRYXSL) $@

build/db.year.xml: year/db.year.xml build/.f $(DEFGUIDERND) $(REFENTRYXSL)
	@echo Making $@
	@xmllint --xinclude $< > build/db.year.xml.xi
	@saxon build/db.year.xml.xi $(REFENTRYXSL) $@

build/.f:
	mkdir build
	touch build/.f

buildall: build/db._any.mml.xml build/db._any.svg.xml build/db._any.xml build/db.abbrev.xml build/db.abstract.xml build/db.accel.xml build/db.ackno.xml build/db.acronym.xml build/db.address.xml build/db.affiliation.xml build/db.alt.xml build/db.anchor.xml build/db.annotation.xml build/db.answer.xml build/db.appendix.xml build/db.application.xml build/db.arc.xml build/db.area.inareaset.xml build/db.area.xml build/db.areaset.xml build/db.areaspec.xml build/db.arg.xml build/db.article.xml build/db.artpagenums.xml build/db.attribution.xml build/db.audiodata.xml build/db.audioobject.xml build/db.author.xml build/db.authorgroup.xml build/db.authorinitials.xml build/db.bibliocoverage.xml build/db.bibliodiv.xml build/db.biblioentry.xml build/db.bibliography.xml build/db.biblioid.xml build/db.bibliolist.xml build/db.bibliomisc.xml build/db.bibliomixed.xml build/db.bibliomset.xml build/db.biblioref.xml build/db.bibliorelation.xml build/db.biblioset.xml build/db.bibliosource.xml build/db.blockquote.xml build/db.book.xml build/db.bridgehead.xml build/db.callout.xml build/db.calloutlist.xml build/db.caption.xml build/db.html.caption.xml build/db.caution.xml build/db.chapter.xml build/db.citation.xml build/db.citebiblioid.xml build/db.citerefentry.xml build/db.citetitle.xml build/db.city.xml build/db.classname.xml build/db.classsynopsis.xml build/db.classsynopsisinfo.xml build/db.cmdsynopsis.xml build/db.co.xml build/db.code.xml build/db.html.col.xml build/db.html.colgroup.xml build/db.collab.xml build/db.colophon.xml build/db.colspec.xml build/db.command.xml build/db.computeroutput.xml build/db.confdates.xml build/db.confgroup.xml build/db.confnum.xml build/db.confsponsor.xml build/db.conftitle.xml build/db.constant.xml build/db.constraint.xml build/db.constraintdef.xml build/db.constructorsynopsis.xml build/db.contractnum.xml build/db.contractsponsor.xml build/db.contrib.xml build/db.copyright.xml build/db.coref.xml build/db.country.xml build/db.cover.xml build/db.database.xml build/db.date.xml build/db.dedication.xml build/db.destructorsynopsis.xml build/db.edition.xml build/db.editor.xml build/db.email.xml build/db._emphasis.xml build/db.emphasis.xml build/db.entry.xml build/db.entrytbl.xml build/db.envar.xml build/db.epigraph.xml build/db.equation.xml build/db.errorcode.xml build/db.errorname.xml build/db.errortext.xml build/db.errortype.xml build/db.example.xml build/db.exceptionname.xml build/db.extendedlink.xml build/db.fax.xml build/db.fieldsynopsis.xml build/db.figure.xml build/db.filename.xml build/db.firstname.xml build/db.firstterm.xml build/db.footnote.xml build/db.footnoteref.xml build/db.foreignphrase.xml build/db.formalpara.xml build/db.funcdef.xml build/db.funcparams.xml build/db.funcprototype.xml build/db.funcsynopsis.xml build/db.funcsynopsisinfo.xml build/db.function.xml build/db.glossary.xml build/db.glossdef.xml build/db.glossdiv.xml build/db.glossentry.xml build/db.glosslist.xml build/db.glosssee.xml build/db.glossseealso.xml build/db.glossterm.xml build/db.group.xml build/db.guibutton.xml build/db.guiicon.xml build/db.guilabel.xml build/db.guimenu.xml build/db.guimenuitem.xml build/db.guisubmenu.xml build/db.hardware.xml build/db.holder.xml build/db.honorific.xml build/db.html.button.xml build/db.html.fieldset.xml build/db.html.form.xml build/db.html.input.xml build/db.html.label.xml build/db.html.legend.xml build/db.html.option.xml build/db.html.select.xml build/db.html.textarea.xml build/db.imagedata.mathml.xml build/db.imagedata.svg.xml build/db.imagedata.xml build/db.imageobject.xml build/db.imageobjectco.xml build/db.important.xml build/db.index.xml build/db.indexdiv.xml build/db.indexentry.xml build/db.indexterm.endofrange.xml build/db.indexterm.singular.xml build/db.indexterm.startofrange.xml build/db.info.xml build/db.titleforbidden.info.xml build/db.titleonly.info.xml build/db.titleonlyreq.info.xml build/db.titlereq.info.xml build/db.informalequation.xml build/db.informalexample.xml build/db.informalfigure.xml build/db.cals.informaltable.xml build/db.html.informaltable.xml build/db.initializer.xml build/db.inlineequation.xml build/db.inlinemediaobject.xml build/db.interfacename.xml build/db.issuenum.xml build/db.itemizedlist.xml build/db.itermset.xml build/db.jobtitle.xml build/db.keycap.xml build/db.keycode.xml build/db.keycombo.xml build/db.keysym.xml build/db.keyword.xml build/db.keywordset.xml build/db.label.xml build/db.legalnotice.xml build/db.lhs.xml build/db.lineage.xml build/db.lineannotation.xml build/db.link.xml build/db.listitem.xml build/db.literal.xml build/db.literallayout.xml build/db.locator.xml build/db.manvolnum.xml build/db.markup.xml build/db.mathphrase.xml build/db.mediaobject.xml build/db.member.xml build/db.menuchoice.xml build/db.methodname.xml build/db.methodparam.xml build/db.methodsynopsis.xml build/db.modifier.xml build/db.mousebutton.xml build/db.msg.xml build/db.msgaud.xml build/db.msgentry.xml build/db.msgexplan.xml build/db.msginfo.xml build/db.msglevel.xml build/db.msgmain.xml build/db.msgorig.xml build/db.msgrel.xml build/db.msgset.xml build/db.msgsub.xml build/db.msgtext.xml build/db.nonterminal.xml build/db.note.xml build/db.olink.xml build/db.ooclass.xml build/db.ooexception.xml build/db.oointerface.xml build/db.option.xml build/db.optional.xml build/db.orderedlist.xml build/db.org.xml build/db.orgdiv.xml build/db.orgname.xml build/db.otheraddr.xml build/db.othercredit.xml build/db.othername.xml build/db.package.xml build/db.pagenums.xml build/db.para.xml build/db.paramdef.xml build/db.parameter.xml build/db.part.xml build/db.partintro.xml build/db.person.xml build/db.personblurb.xml build/db.personname.xml build/db.phone.xml build/db._phrase.xml build/db.phrase.xml build/db.pob.xml build/db.postcode.xml build/db.preface.xml build/db.primary.xml build/db.primaryie.xml build/db.printhistory.xml build/db.procedure.xml build/db.production.xml build/db.productionrecap.xml build/db.productionset.xml build/db.productname.xml build/db.productnumber.xml build/db.programlisting.xml build/db.programlistingco.xml build/db.prompt.xml build/db.property.xml build/db.pubdate.xml build/db.publisher.xml build/db.publishername.xml build/db.qandadiv.xml build/db.qandaentry.xml build/db.qandaset.xml build/db.question.xml build/db.quote.xml build/db.refclass.xml build/db.refdescriptor.xml build/db.refentry.xml build/db.refentrytitle.xml build/db.reference.xml build/db.refmeta.xml build/db.refmiscinfo.xml build/db.refname.xml build/db.refnamediv.xml build/db.refpurpose.xml build/db.refsect1.xml build/db.refsect2.xml build/db.refsect3.xml build/db.refsection.xml build/db.refsynopsisdiv.xml build/db.releaseinfo.xml build/db.remark.xml build/db.replaceable.xml build/db.returnvalue.xml build/db.revdescription.xml build/db.revhistory.xml build/db.revision.xml build/db.revnumber.xml build/db.revremark.xml build/db.rhs.xml build/db.entrytbl.row.xml build/db.row.xml build/db.sbr.xml build/db.screen.xml build/db.screenco.xml build/db.screenshot.xml build/db.secondary.xml build/db.secondaryie.xml build/db.sect1.xml build/db.sect2.xml build/db.sect3.xml build/db.sect4.xml build/db.sect5.xml build/db.section.xml build/db.see.xml build/db.seealso.xml build/db.seealsoie.xml build/db.seeie.xml build/db.seg.xml build/db.seglistitem.xml build/db.segmentedlist.xml build/db.segtitle.xml build/db.seriesvolnums.xml build/db.set.xml build/db.setindex.xml build/db.shortaffil.xml build/db.shortcut.xml build/db.sidebar.xml build/db.simpara.xml build/db.simplelist.xml build/db.simplemsgentry.xml build/db.simplesect.xml build/db.spanspec.xml build/db.state.xml build/db.step.xml build/db.stepalternatives.xml build/db.street.xml build/db.subject.xml build/db.subjectset.xml build/db.subjectterm.xml build/db.subscript.xml build/db.substeps.xml build/db.subtitle.xml build/db.superscript.xml build/db.surname.xml build/db.symbol.xml build/db.synopfragment.xml build/db.synopfragmentref.xml build/db.synopsis.xml build/db.systemitem.xml build/db.cals.table.xml build/db.html.table.xml build/db.tag.xml build/db.task.xml build/db.taskprerequisites.xml build/db.taskrelated.xml build/db.tasksummary.xml build/db.cals.entrytbl.tbody.xml build/db.cals.tbody.xml build/db.html.tbody.xml build/db.html.td.xml build/db.term.xml build/db.termdef.xml build/db.tertiary.xml build/db.tertiaryie.xml build/db.textdata.xml build/db.textobject.xml build/db.cals.tfoot.xml build/db.html.tfoot.xml build/db.tgroup.xml build/db.html.th.xml build/db.cals.entrytbl.thead.xml build/db.cals.thead.xml build/db.html.thead.xml build/db.tip.xml build/db.title.xml build/db.titleabbrev.xml build/db.toc.xml build/db.tocdiv.xml build/db.tocentry.xml build/db.token.xml build/db.html.tr.xml build/db.trademark.xml build/db.type.xml build/db.uri.xml build/db.userinput.xml build/db.varargs.xml build/db.variablelist.xml build/db.varlistentry.xml build/db.varname.xml build/db.videodata.xml build/db.videoobject.xml build/db.void.xml build/db.volumenum.xml build/db.warning.xml build/db.wordasword.xml build/db.xref.xml build/db.year.xml

