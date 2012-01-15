DEFGUIDERND=../../lib/defguide.rnd
REFENTRYXSL=../../../stylesheets/refentry.xsl
SAXON=$(DOCBOOK_SVN)/buildtools/saxon
SAXONPARAM=rngfile=$(DEFGUIDERND) seealsofile=../../lib/seealso.xml patternsfile=../../lib/patterns.xml gitfile=../../lib/gitlog.xml

VPATH=../../../refpages/elements

XINCLUDED=_any.xi _any.mml.xi _any.svg.xi _emphasis.xi _firstterm.xi _foreignphrase.xi \
          _glossterm.xi _phrase.xi _quote.xi abbrev.xi abstract.xi \
          acknowledgements.xi acronym.xi address.xi affiliation.xi alt.xi \
          anchor.xi answer.xi appendix.xi area.xi area.inareaset.xi areaset.xi \
          areaspec.xi article.xi artpagenums.xi attribution.xi audiodata.xi \
          audioobject.xi author.xi authorgroup.xi authorinitials.xi \
          bibliocoverage.xi bibliodiv.xi biblioentry.xi bibliography.xi \
          biblioid.xi bibliolist.xi bibliomisc.xi bibliomixed.xi bibliomset.xi \
          biblioref.xi bibliorelation.xi biblioset.xi bibliosource.xi \
          blockquote.xi book.xi bridgehead.xi callout.xi calloutlist.xi \
          entrytbl.tbody.xi entrytbl.thead.xi table.xi \
          tbody.xi tfoot.xi thead.xi caption.xi chapter.xi \
          citation.xi citebiblioid.xi citetitle.xi city.xi co.xi collab.xi \
          colophon.xi colspec.xi confdates.xi confgroup.xi confnum.xi \
          confsponsor.xi conftitle.xi contractnum.xi contractsponsor.xi \
          contrib.xi copyright.xi coref.xi country.xi cover.xi date.xi \
          dedication.xi dialogue.xi drama.xi edition.xi editor.xi email.xi \
          emphasis.xi entry.xi entrytbl.xi entrytbl.row.xi epigraph.xi \
          equation.xi example.xi fax.xi figure.xi firstname.xi firstterm.xi \
          footnote.xi footnoteref.xi foreignphrase.xi formalpara.xi givenname.xi \
          glossary.xi glossdef.xi glossdiv.xi glossentry.xi glosslist.xi \
          glosssee.xi glossseealso.xi glossterm.xi \
          holder.xi honorific.xi \
          imagedata.xi imagedata.mathml.xi \
          imagedata.svg.xi imageobject.xi imageobjectco.xi index.xi \
          indexterm.endofrange.xi indexterm.singular.xi \
          indexterm.startofrange.xi info.xi informalequation.xi \
          informaltable.xi \
          informalexample.xi informalfigure.xi inlineequation.xi \
          inlinemediaobject.xi issuenum.xi itemizedlist.xi itermset.xi \
          jobtitle.xi keyword.xi keywordset.xi label.xi legalnotice.xi line.xi \
          lineage.xi linegroup.xi link.xi listitem.xi literal.xi \
          literallayout.xi mathphrase.xi mediaobject.xi member.xi note.xi \
          olink.xi optional.xi orderedlist.xi org.xi orgdiv.xi orgname.xi \
          otheraddr.xi othercredit.xi othername.xi pagenums.xi para.xi part.xi \
          partintro.xi person.xi personblurb.xi personname.xi phone.xi phrase.xi \
          pob.xi poetry.xi postcode.xi preface.xi primary.xi printhistory.xi \
          procedure.xi productname.xi productnumber.xi pubdate.xi publisher.xi \
          publishername.xi qandadiv.xi qandaentry.xi qandaset.xi question.xi \
          quote.xi releaseinfo.xi remark.xi revdescription.xi revhistory.xi \
          revision.xi revnumber.xi revremark.xi row.xi secondary.xi section.xi \
          see.xi seealso.xi seriesvolnums.xi set.xi setindex.xi shortaffil.xi \
          sidebar.xi simpara.xi simplelist.xi simplesect.xi spanspec.xi \
          speaker.xi state.xi step.xi stepalternatives.xi street.xi subject.xi \
          subjectset.xi subjectterm.xi subscript.xi substeps.xi subtitle.xi \
          superscript.xi surname.xi task.xi taskprerequisites.xi taskrelated.xi \
          tasksummary.xi term.xi termdef.xi tertiary.xi textdata.xi \
          textobject.xi tgroup.xi title.xi titleabbrev.xi titleforbidden.info.xi \
          titleonly.info.xi titleonlyreq.info.xi titlereq.info.xi toc.xi \
          trademark.xi uri.xi variablelist.xi varlistentry.xi \
          videodata.xi videoobject.xi volumenum.xi wordasword.xi xref.xi year.xi \
          dcterms.xi

all: .formatted

.xincluded:
	@../../../tools/bin/listxml $(XINCLUDED) > $@

clean:
	rm -f *.xi *.fmt .xincluded .formatted

.formatted: .xincluded
	echo "<irrelevant/>" > $@
	calabash -isource=.xincluded -oresult=/dev/null ../../../stylesheets/xinclude-list.xpl
	git-log-summary > ../../lib/gitlog.xml
	@echo saxon $(REFENTRYXSL) $(SAXONPARAM) SOURCES="..."
	@$(SAXON) $@ $(REFENTRYXSL) $(SAXONPARAM) SOURCES="$(XINCLUDED)" schema=publishers
