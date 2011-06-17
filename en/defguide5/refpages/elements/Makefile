DEFGUIDERND=../../lib/defguide.rnd
REFENTRYXSL=../../../stylesheets/refentry.xsl
SAXON=$(DOCBOOK_SVN)/buildtools/saxon
SAXONPARAM=rngfile=$(DEFGUIDERND) seealsofile=../../lib/seealso.xml patternsfile=../../lib/patterns.xml gitfile=../../lib/gitlog.xml

VPATH=../../../refpages/elements

XINCLUDED=_any.mml.xi _any.svg.xi _any.xi _emphasis.xi _firstterm.xi \
          _foreignphrase.xi _glossterm.xi _phrase.xi _quote.xi abbrev.xi \
          abstract.xi accel.xi acknowledgements.xi acronym.xi address.xi \
          affiliation.xi alt.xi anchor.xi annotation.xi answer.xi appendix.xi \
          application.xi arc.xi area.inareaset.xi area.xi areaset.xi areaspec.xi \
          arg.xi article.xi artpagenums.xi assembly.xi association.xi \
          attribution.xi audiodata.xi audioobject.xi author.xi authorgroup.xi \
          authorinitials.xi bibliocoverage.xi bibliodiv.xi biblioentry.xi \
          bibliography.xi biblioid.xi bibliolist.xi bibliomisc.xi bibliomixed.xi \
          bibliomset.xi biblioref.xi bibliorelation.xi biblioset.xi \
          bibliosource.xi blockquote.xi book.xi bridgehead.xi callout.xi \
          calloutlist.xi caption.xi caution.xi chapter.xi citation.xi \
          citebiblioid.xi citerefentry.xi citetitle.xi city.xi classname.xi \
          classsynopsis.xi classsynopsisinfo.xi cmdsynopsis.xi co.xi code.xi \
          collab.xi colophon.xi colspec.xi command.xi computeroutput.xi \
          confdates.xi confgroup.xi confnum.xi confsponsor.xi conftitle.xi \
          constant.xi constraint.xi constraintdef.xi constructorsynopsis.xi \
          container.resource.xi contractnum.xi contractsponsor.xi contrib.xi \
          copyright.xi coref.xi country.xi cover.xi database.xi date.xi \
          dedication.xi destructorsynopsis.xi edition.xi editor.xi email.xi \
          emphasis.xi entry.xi entrytbl.row.xi entrytbl.tbody.xi \
          entrytbl.thead.xi entrytbl.xi envar.xi epigraph.xi equation.xi \
          errorcode.xi errorname.xi errortext.xi errortype.xi example.xi \
          exceptionname.xi extendedlink.xi fax.xi fieldsynopsis.xi figure.xi \
          file.resource.xi filename.xi filterin.xi filterout.xi firstname.xi \
          firstterm.xi footnote.xi footnoteref.xi foreignphrase.xi formalpara.xi \
          funcdef.xi funcparams.xi funcprototype.xi funcsynopsis.xi \
          funcsynopsisinfo.xi function.xi givenname.xi glossary.xi glossdef.xi \
          glossdiv.xi glossentry.xi glosslist.xi glosssee.xi glossseealso.xi \
          glossterm.xi group.methodparam.xi group.paramdef.xi group.xi \
          guibutton.xi guiicon.xi guilabel.xi guimenu.xi guimenuitem.xi \
          guisubmenu.xi hardware.xi holder.xi honorific.xi \
          html.caption.xi html.col.xi html.colgroup.xi \
          html.informaltable.xi \
          html.table.xi \
          html.tbody.xi html.td.xi html.tfoot.xi html.th.xi \
          html.thead.xi html.tr.xi imagedata.mathml.xi imagedata.svg.xi \
          imagedata.xi imageobject.xi imageobjectco.xi important.xi index.xi \
          indexdiv.xi indexentry.xi indexterm.endofrange.xi \
          indexterm.singular.xi indexterm.startofrange.xi info.xi \
          informalequation.xi informalexample.xi informalfigure.xi \
          informaltable.xi initializer.xi inlineequation.xi inlinemediaobject.xi \
          instance.xi interfacename.xi issuenum.xi itemizedlist.xi itermset.xi \
          jobtitle.xi keycap.xi keycode.xi keycombo.xi keysym.xi keyword.xi \
          keywordset.xi label.xi legalnotice.xi lhs.xi lineage.xi \
          lineannotation.xi link.xi listitem.xi literal.xi literallayout.xi \
          locator.xi manvolnum.xi markup.xi mathphrase.xi mediaobject.xi \
          member.xi menuchoice.xi methodname.xi methodparam.xi methodsynopsis.xi \
          modifier.xi module.container.xi module.resource.xi \
          mousebutton.xi msg.xi msgaud.xi msgentry.xi \
          msgexplan.xi msginfo.xi msglevel.xi msgmain.xi msgorig.xi msgrel.xi \
          msgset.xi msgsub.xi msgtext.xi nonterminal.xi note.xi olink.xi \
          ooclass.xi ooexception.xi oointerface.xi option.xi optional.xi \
          orderedlist.xi org.xi orgdiv.xi orgname.xi otheraddr.xi othercredit.xi \
          othername.xi output.xi override.xi package.xi pagenums.xi para.xi \
          paramdef.xi parameter.xi part.xi partintro.xi person.xi personblurb.xi \
          personname.xi phone.xi phrase.xi pob.xi postcode.xi preface.xi \
          primary.xi primaryie.xi printhistory.xi procedure.xi production.xi \
          productionrecap.xi productionset.xi productname.xi productnumber.xi \
          programlisting.xi programlistingco.xi prompt.xi property.xi pubdate.xi \
          publisher.xi publishername.xi qandadiv.xi qandaentry.xi qandaset.xi \
          question.xi quote.xi refclass.xi refdescriptor.xi refentry.xi \
          refentrytitle.xi reference.xi refmeta.xi refmiscinfo.xi refname.xi \
          refnamediv.xi refpurpose.xi refsect1.xi refsect2.xi refsect3.xi \
          refsection.xi refsynopsisdiv.xi relationship.xi relationships.xi \
          releaseinfo.xi remark.xi replaceable.xi resources.xi returnvalue.xi \
          revdescription.xi revhistory.xi revision.xi revnumber.xi revremark.xi \
          rhs.xi row.xi sbr.xi screen.xi screenco.xi screenshot.xi secondary.xi \
          secondaryie.xi sect1.xi sect2.xi sect3.xi sect4.xi sect5.xi section.xi \
          see.xi seealso.xi seealsoie.xi seeie.xi seg.xi seglistitem.xi \
          segmentedlist.xi segtitle.xi seriesvolnums.xi set.xi setindex.xi \
          shortaffil.xi shortcut.xi sidebar.xi simpara.xi simplelist.xi \
          simplemsgentry.xi simplesect.xi spanspec.xi state.xi step.xi \
          stepalternatives.xi street.xi structure.xi subject.xi subjectset.xi \
          subjectterm.xi subscript.xi substeps.xi subtitle.xi superscript.xi \
          surname.xi symbol.xi synopfragment.xi synopfragmentref.xi synopsis.xi \
          systemitem.xi table.xi tag.xi task.xi taskprerequisites.xi \
          taskrelated.xi tasksummary.xi tbody.xi term.xi termdef.xi tertiary.xi \
          tertiaryie.xi textdata.xi textobject.xi tfoot.xi tgroup.xi thead.xi \
          tip.xi title.xi titleabbrev.xi titleforbidden.info.xi \
          titleonly.info.xi titleonlyreq.info.xi titlereq.info.xi toc.xi \
          tocdiv.xi tocentry.xi token.xi topic.xi trademark.xi transform.xi \
          transforms.xi type.xi uri.xi userinput.xi varargs.xi variablelist.xi \
          varlistentry.xi varname.xi videodata.xi videoobject.xi void.xi \
          volumenum.xi warning.xi wordasword.xi xref.xi year.xi description.xi

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
