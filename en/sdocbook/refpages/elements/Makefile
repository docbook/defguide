DEFGUIDERND=../../lib/defguide.rnd
REFENTRYXSL=../../../stylesheets/refentry.xsl
SAXON=$(DOCBOOK_SVN)/buildtools/saxon
SAXONPARAM=rngfile=$(DEFGUIDERND) seealsofile=../../lib/seealso.xml patternsfile=../../lib/patterns.xml gitfile=../../lib/gitlog.xml

VPATH=../../../refpages/elements

XINCLUDED=_phrase.xi abbrev.xi abstract.xi acronym.xi affiliation.xi alt.xi \
          appendix.xi article.xi attribution.xi audiodata.xi audioobject.xi \
          author.xi authorgroup.xi authorinitials.xi bibliodiv.xi \
          bibliography.xi bibliomisc.xi bibliomixed.xi bibliomset.xi \
          blockquote.xi entrytbl.tbody.xi entrytbl.thead.xi \
          informaltable.xi table.xi tbody.xi tfoot.xi \
          thead.xi caption.xi citetitle.xi colspec.xi command.xi \
          computeroutput.xi copyright.xi date.xi edition.xi editor.xi email.xi \
          emphasis.xi entry.xi entrytbl.xi entrytbl.row.xi epigraph.xi \
          example.xi figure.xi filename.xi firstname.xi footnote.xi \
          footnoteref.xi givenname.xi holder.xi honorific.xi html.caption.xi \
          html.col.xi html.colgroup.xi html.informaltable.xi html.table.xi \
          html.tbody.xi html.td.xi html.tfoot.xi html.th.xi html.thead.xi \
          html.tr.xi imagedata.xi imageobject.xi info.xi inlinemediaobject.xi \
          issuenum.xi itemizedlist.xi jobtitle.xi keyword.xi keywordset.xi \
          legalnotice.xi lineage.xi lineannotation.xi link.xi listitem.xi \
          literal.xi literallayout.xi mediaobject.xi note.xi option.xi \
          orderedlist.xi org.xi orgdiv.xi orgname.xi othercredit.xi othername.xi \
          para.xi personblurb.xi personname.xi phrase.xi programlisting.xi \
          pubdate.xi publishername.xi quote.xi releaseinfo.xi replaceable.xi \
          revdescription.xi revhistory.xi revision.xi revnumber.xi revremark.xi \
          row.xi section.xi sidebar.xi spanspec.xi subject.xi subjectset.xi \
          subjectterm.xi subscript.xi subtitle.xi superscript.xi surname.xi \
          systemitem.xi term.xi textdata.xi textobject.xi tgroup.xi title.xi \
          titleabbrev.xi titleforbidden.info.xi titleonly.info.xi \
          titleonlyreq.info.xi titlereq.info.xi trademark.xi userinput.xi \
          variablelist.xi varlistentry.xi videodata.xi videoobject.xi \
          volumenum.xi xref.xi year.xi

all: .formatted

.xincluded:
	@../../../tools/bin/listxml $(XINCLUDED) > $@

clean:
	rm -f *.xi *.fmt .xincluded .formatted

.formatted: .xincluded
	echo "<irrelevant/>" > $@
	calabash -isource=.xincluded -oresult=/dev/null ../../../stylesheets/xinclude-list.xpl
	git-log-summary > ../../lib/gitlog.xml
	@$(SAXON) $@ $(REFENTRYXSL) $(SAXONPARAM) SOURCES="$(XINCLUDED)"

