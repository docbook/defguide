<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:cvs="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.CVS"
		xmlns:html="http://www.w3.org/1999/xhtml"
		xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="cvs rng html db"
                version="1.0">

<!-- $Id$ -->

<!-- this stylesheet somewhat dangerously does its own profiling -->

<xsl:import href="/sourceforge/docbook/xsl/html/docbook.xsl"/>
<xsl:include href="html-titlepage.xsl"/>

<xsl:output method="html" encoding="utf-8" indent="no"/>

<xsl:param name="ng-release" select="'5.0b1'"/>

<xsl:param name="output.media" select="'online'"/>
<xsl:param name="html.stylesheet">defguide.css</xsl:param>
<xsl:param name="toc.section.depth" select="1"/>
<xsl:param name="callout.graphics.path" select="'figures/callouts/'"/>
<xsl:param name="refentry.generate.name" select="0"/>
<xsl:param name="refentry.generate.title" select="0"/>
<xsl:param name="refentry.separator" select="0"/>
<xsl:param name="table.borders.with.css" select="1"/>

<xsl:param name="generate.toc">
/appendix nop
/article  nop
book      toc,figure,table,example,equation
/chapter  nop
part      toc
/preface  nop
qandadiv  nop
qandaset  nop
reference nop
/section  nop
set       nop
</xsl:param>

<xsl:param name="local.l10n.xml" select="document('')"/>
<l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
  <l:l10n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0" language="en">
   <l:context name="title-numbered">
      <l:template name="appendix" text="%t"/>
      <l:template name="chapter" text="%t"/>
    </l:context>
  </l:l10n>
</l:i18n>

<xsl:variable name="rngfile"
	      select="'/sourceforge/docbook/defguide5/en/tools/lib/defguide.rnd'"/>

<xsl:variable name="rng" select="document($rngfile,.)"/>

<xsl:template match="processing-instruction('lb')">
  <br/>
</xsl:template>

<xsl:template match="processing-instruction('lb')" mode="no.anchor.mode">
  <xsl:text> </xsl:text>
</xsl:template>

<xsl:template name="user.header.content">
  <xsl:param name="node" select="."/>
</xsl:template>

<xsl:template name="user.footer.navigation">
  <xsl:param name="node" select="."/>
  <div class="copyrightfooter">
    <p>
      <a href="dbcpyright.html">Copyright</a>
      <xsl:text> &#xA9; 2004, 2005 Norman Walsh. </xsl:text>
      <xsl:text>Portions Copright © 1999-2003 </xsl:text>
      <a href="http://www.oreilly.com/">O'Reilly &amp; Associates, Inc.</a>
      <xsl:text> All rights reserved.</xsl:text>
    </p>
  </div>
</xsl:template>

<xsl:template name="revision.graphic">
  <xsl:param name="large" select="'0'"/>
  <xsl:param name="align" select="''"/>

  <xsl:if test="@revision">
    <xsl:choose>
      <xsl:when test="@revision='5.0'">
        <img src="figures/rev_5.0.png" alt="[5.0]">
          <xsl:if test="$align != ''">
            <xsl:attribute name="align">
              <xsl:value-of select="$align"/>
            </xsl:attribute>
          </xsl:if>
        </img>
      </xsl:when>
      <xsl:when test="@revision='4.3'">
        <img src="figures/rev_4.3.png" alt="[4.3]">
          <xsl:if test="$align != ''">
            <xsl:attribute name="align">
              <xsl:value-of select="$align"/>
            </xsl:attribute>
          </xsl:if>
        </img>
      </xsl:when>
      <xsl:when test="@revision='4.2'">
        <img src="figures/rev_4.2.png" alt="[4.2]">
          <xsl:if test="$align != ''">
            <xsl:attribute name="align">
              <xsl:value-of select="$align"/>
            </xsl:attribute>
          </xsl:if>
        </img>
      </xsl:when>
      <xsl:when test="@revision='4.0'">
        <img src="figures/rev_4.0.png" alt="[4.0]">
          <xsl:if test="$align != ''">
            <xsl:attribute name="align">
              <xsl:value-of select="$align"/>
            </xsl:attribute>
          </xsl:if>
        </img>
      </xsl:when>
      <xsl:when test="@revision='3.1'">
        <!-- nop; 3.1 isn't interesting anymore -->
      </xsl:when>
      <xsl:when test="@revision='EBNF'">
        <img src="figures/rev_ebnf.png" alt="[EBNF]">
          <xsl:if test="$align != ''">
            <xsl:attribute name="align">
              <xsl:value-of select="$align"/>
            </xsl:attribute>
          </xsl:if>
        </img>
      </xsl:when>
      <xsl:when test="@revision='SVG'">
        <img src="figures/rev_svg.png" alt="[SVG]">
          <xsl:if test="$align != ''">
            <xsl:attribute name="align">
              <xsl:value-of select="$align"/>
            </xsl:attribute>
          </xsl:if>
        </img>
      </xsl:when>
      <xsl:when test="@revision='MathML'">
        <img src="figures/rev_mathml.png" alt="[MathML]">
          <xsl:if test="$align != ''">
            <xsl:attribute name="align">
              <xsl:value-of select="$align"/>
            </xsl:attribute>
          </xsl:if>
        </img>
      </xsl:when>
      <xsl:when test="@revision='HTMLForms'">
        <img src="figures/rev_htmlforms.png" alt="[HTML Forms]">
          <xsl:if test="$align != ''">
            <xsl:attribute name="align">
              <xsl:value-of select="$align"/>
            </xsl:attribute>
          </xsl:if>
        </img>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>
          <xsl:text>Unexpected revision '</xsl:text>
          <xsl:value-of select="@revision"/>
          <xsl:text>' on </xsl:text>
          <xsl:value-of select="local-name(.)"/>
        </xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:if>
</xsl:template>

<xsl:template name="refentry.title">
  <xsl:param name="node" select="."/>
  <xsl:variable name="refmeta" select="$node//refmeta"/>
  <xsl:variable name="refentrytitle" select="$refmeta//refentrytitle"/>
  <xsl:variable name="refnamediv" select="$node//refnamediv"/>
  <xsl:variable name="refname" select="$refnamediv//refname"/>
  <xsl:variable name="title">
    <xsl:choose>
      <xsl:when test="$refentrytitle">
        <xsl:apply-templates select="$refentrytitle[1]" mode="title"/>
      </xsl:when>
      <xsl:when test="$refname">
        <xsl:apply-templates select="$refname[1]" mode="title"/>
      </xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <h1 class="title">
    <xsl:call-template name="revision.graphic">
      <xsl:with-param name="large" select="'1'"/>
      <xsl:with-param name="align" select="'right'"/>
    </xsl:call-template>
    <xsl:copy-of select="$title"/>
  </h1>
</xsl:template>

<xsl:template match="para">
  <xsl:if test="not(@condition)
                or (@condition = $output.media)">
    <p>
      <xsl:if test="@id">
        <a name="{@id}"/>
      </xsl:if>
      <xsl:call-template name="revision.graphic"/>
      <xsl:apply-templates/>
    </p>
  </xsl:if>
</xsl:template>

<xsl:template match="para[ancestor::itemizedlist[@role='element-synopsis']]"
	      priority="100">
  <!-- force this kind of list to be "compact" -->
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="footnote/para[1]">
  <xsl:apply-imports/>
</xsl:template>

<xsl:template match="phrase">
  <xsl:if test="not(@condition)
                or (@condition = $output.media)">
    <xsl:apply-imports/>
  </xsl:if>
</xsl:template>

<xsl:template match="ulink">
  <xsl:choose>
    <xsl:when test="not(@condition)
                    or (@condition = $output.media)">
      <xsl:apply-imports/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="anchor[@role='HACK-ex.out.start']">
  <xsl:text disable-output-escaping="yes">&lt;</xsl:text>
  <xsl:text>div class="example-output"</xsl:text>
  <xsl:text disable-output-escaping="yes">&gt;</xsl:text>
</xsl:template>

<xsl:template match="anchor[@role='HACK-ex.out.end']">
  <xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
</xsl:template>

<xsl:template match="title" mode="book.titlepage.recto.mode">
  <h1>
    <xsl:apply-templates/>
    <xsl:apply-templates select="../subtitle[1]"
                         mode="book.titlepage.recto.mode"/>
  </h1>
</xsl:template>

<xsl:template match="subtitle" mode="book.titlepage.recto.mode">
  <xsl:text>: </xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="informaltable">
  <xsl:choose>
    <xsl:when test="@role='elemsynop'">
      <xsl:apply-templates select=".//row" mode="elemsynop"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-imports/>
    </xsl:otherwise>
  </xsl:choose>
 
</xsl:template>

<xsl:template match="row" mode="elemsynop">
  <xsl:variable name="entry" select="entry[1]"/>
  <xsl:variable name="entry2" select="entry[2]"/>

  <xsl:choose>
    <xsl:when test="@role = 'cmtitle'">
      <h3>
        <xsl:apply-templates select="$entry/*"/>
      </h3>
    </xsl:when>
    <xsl:when test="@role = 'cmsynop'">
      <xsl:apply-templates select="$entry/*"/>
    </xsl:when>
    <xsl:when test="@role = 'incltitle'">
      <h3>
        <xsl:apply-templates select="$entry/*"/>
      </h3>
    </xsl:when>
    <xsl:when test="@role = 'inclsynop'">
      <xsl:apply-templates select="$entry/*"/>
    </xsl:when>
    <xsl:when test="@role = 'excltitle'">
      <h3>
        <xsl:apply-templates select="$entry/*"/>
      </h3>
    </xsl:when>
    <xsl:when test="@role = 'exclsynop'">
      <xsl:apply-templates select="$entry/*"/>
    </xsl:when>
    <xsl:when test="@role = 'attrtitle'">
      <h3>
        <xsl:apply-templates select="$entry/*"/>
      </h3>
      <p>
        <xsl:apply-templates select="$entry2/*"/>
      </p>
    </xsl:when>
    <xsl:when test="@role = 'attrheader'">
      <xsl:variable name="attrrows" select="../row[@role='attr']"/>
      <table border="0" width="100%" cellpadding="2"
             style="border-collapse: collapse; border-left: 0.5pt solid black; border-right: 0.5pt solid black; border-bottom: 0.5pt solid black;"
             summary="Attributes">
        <thead>
          <tr>
            <xsl:apply-templates select="entry[1]">
              <xsl:with-param name="spans">
                <xsl:call-template name="blank.spans">
                  <xsl:with-param name="cols" select="3"/>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:apply-templates>
          </tr>
        </thead>
        <tbody>
          <xsl:for-each select="$attrrows">
            <tr>
              <xsl:apply-templates select="entry[1]">
                <xsl:with-param name="spans">
                  <xsl:call-template name="blank.spans">
                    <xsl:with-param name="cols" select="3"/>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:apply-templates>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:when>
    <xsl:when test="@role = 'attr'">
      <!-- nop -->
    </xsl:when>
    <xsl:when test="@role = 'tmtitle'">
      <h3>
        <xsl:apply-templates select="$entry/*"/>
      </h3>
    </xsl:when>
    <xsl:when test="@role = 'tmsynop'">
      <xsl:apply-templates select="$entry/*"/>
    </xsl:when>
    <xsl:when test="@role = 'petitle'">
    </xsl:when>
    <xsl:when test="@role = 'pe'">
      <!-- nop -->
    </xsl:when>
    <xsl:when test="@role = 'vle-pe'">
      <!-- nop -->
    </xsl:when>
    <xsl:when test="@role = 'vle-el'">
      <!-- nop -->
    </xsl:when>
    <xsl:when test="@role = 'vle-iel'">
      <!-- nop -->
    </xsl:when>
    <xsl:when test="@role = 'vle-petitle'">
      <xsl:variable name="attrrows" select="../row[@role='vle-pe']"/>
      <p>
        <b><xsl:apply-templates select="$entry/*"/></b>
      </p>
      <table border="0" width="100%" summary="Attributes">
        <tr>
          <xsl:apply-templates select="entry[1]">
            <xsl:with-param name="spans">
              <xsl:call-template name="blank.spans">
                <xsl:with-param name="cols" select="3"/>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:apply-templates>
        </tr>
        <xsl:for-each select="$attrrows">
          <tr>
            <xsl:apply-templates select="entry[1]">
              <xsl:with-param name="spans">
                <xsl:call-template name="blank.spans">
                  <xsl:with-param name="cols" select="3"/>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:apply-templates>
          </tr>
        </xsl:for-each>
      </table>
    </xsl:when>
    <xsl:when test="@role = 'vle-eltitle'">
      <xsl:variable name="attrrows" select="../row[@role='vle-el']"/>
      <p>
        <b><xsl:apply-templates select="$entry/*"/></b>
      </p>
      <table border="0" width="100%" summary="Attributes">
        <tr>
          <xsl:apply-templates select="entry[1]">
            <xsl:with-param name="spans">
              <xsl:call-template name="blank.spans">
                <xsl:with-param name="cols" select="3"/>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:apply-templates>
        </tr>
        <xsl:for-each select="$attrrows">
          <tr>
            <xsl:apply-templates select="entry[1]">
              <xsl:with-param name="spans">
                <xsl:call-template name="blank.spans">
                  <xsl:with-param name="cols" select="3"/>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:apply-templates>
          </tr>
        </xsl:for-each>
      </table>
    </xsl:when>
    <xsl:when test="@role = 'vle-ieltitle'">
      <xsl:variable name="attrrows" select="../row[@role='vle-iel']"/>
      <p>
        <b><xsl:apply-templates select="$entry/*"/></b>
      </p>
      <table border="0" width="100%" summary="Attributes">
        <tr>
          <xsl:apply-templates select="entry[1]">
            <xsl:with-param name="spans">
              <xsl:call-template name="blank.spans">
                <xsl:with-param name="cols" select="3"/>
              </xsl:call-template>
            </xsl:with-param>
          </xsl:apply-templates>
        </tr>
        <xsl:for-each select="$attrrows">
          <tr>
            <xsl:apply-templates select="entry[1]">
              <xsl:with-param name="spans">
                <xsl:call-template name="blank.spans">
                  <xsl:with-param name="cols" select="3"/>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:apply-templates>
          </tr>
        </xsl:for-each>
      </table>
    </xsl:when>
    <xsl:when test="@role = 'vle-cmtitle'">
      <p>
        <b>Parameter entity content:</b>
      </p>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="entry/simplelist[@role='enum' or @role='notationenum']">
  <!-- with no type specified, the default is 'vert' -->
  <xsl:call-template name="anchor"/>
  <table class="simplelist" border="0" summary="Simple list">
    <tr>
      <td>
        <i>
          <xsl:choose>
            <xsl:when test="@role = 'enum'">
              <xsl:text>Enumeration:</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>Enumerated notation:</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </i>
      </td>
    </tr>
    <xsl:call-template name="simplelist.vert">
      <xsl:with-param name="cols">
	<xsl:choose>
	  <xsl:when test="@columns">
	    <xsl:value-of select="@columns"/>
	  </xsl:when>
	  <xsl:otherwise>1</xsl:otherwise>
	</xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </table>
</xsl:template>

<!-- ============================================================ -->

<xsl:template name="titlepage-block">
  <xsl:variable name="authorgroup" select="bookinfo/authorgroup[1]"/>
  <xsl:variable name="isbn" select="bookinfo/isbn[1]"/>
  <xsl:variable name="version" select="bookinfo/releaseinfo[1]"/>
  <xsl:variable name="date" select="bookinfo/pubdate[1]"/>
  <xsl:variable name="legalnotice" select="bookinfo/legalnotice[1]"/>
  <xsl:variable name="copyright" select="bookinfo/copyright"/>

  <p class="titlepage-block">
    <span class="authorgroup">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key">by</xsl:with-param>
      </xsl:call-template>
      <xsl:text>&#160;</xsl:text>
      <xsl:apply-templates select="$authorgroup/author" mode="titleblock"/>
    </span>
    <br/>
    <span class="contributors">
      <xsl:text>With contributions from</xsl:text>
      <xsl:text>&#160;</xsl:text>
      <xsl:apply-templates select="$authorgroup/othercredit" mode="titleblock"/>
    </span>
    <br/>
    <xsl:if test="$isbn">
      <span class="isbn">
	<xsl:text>ISBN: </xsl:text>
	<a href="http://www.oreilly.com/catalog/docbook">
	  <xsl:apply-templates select="$isbn/node()"/>
	</a>
      </span>
      <br/>
    </xsl:if>
    <span class="version">
      <xsl:text>Version </xsl:text>
      <xsl:apply-templates select="$version/node()"/>
    </span>
    <br/>
    <span class="date">
      <!-- rcsdate = "$Date$" -->
      <!-- timeString = "dow mon dd hh:mm:ss TZN yyyy" -->
      <xsl:variable name="timeString" select="cvs:localTime($date/text())"/>
      <xsl:text>Updated: </xsl:text>
      <xsl:value-of select="substring($timeString, 1, 3)"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="substring($timeString, 9, 2)"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="substring($timeString, 5, 3)"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="substring($timeString, 25, 4)"/>
    </span>
  </p>

  <p class="copyright">
    <xsl:apply-templates select="$copyright" mode="titlepage.mode"/>
  </p>
  <br clear="all"/>
</xsl:template>

<xsl:template match="authorgroup/author" mode="titleblock">
  <xsl:if test="position() &gt; 1 and last() &gt; 2">,</xsl:if>
  <xsl:if test="position() &gt; 1 and position() = last()"> and</xsl:if>
  <xsl:if test="position() &gt; 1">&#160;</xsl:if>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="authorgroup/othercredit" mode="titleblock">
  <xsl:if test="position() &gt; 1 and last() &gt; 2">,</xsl:if>
  <xsl:if test="position() &gt; 1 and position() = last()"> and</xsl:if>
  <xsl:if test="position() &gt; 1"> </xsl:if>
  <xsl:apply-templates select="."/>
  <xsl:if test="contrib">
    <xsl:text> (</xsl:text>
    <xsl:apply-templates select="contrib" mode="titleblock"/>
    <xsl:text>)</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="othercredit/contrib" mode="titleblock">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="copyright" mode="titlepage.mode">
  <br clear="all"/>
  <xsl:apply-templates select="../legalnotice" mode="titlepage.mode"/>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="refentry" mode="toc">
  <xsl:variable name="refmeta" select=".//refmeta"/>
  <xsl:variable name="refentrytitle" select="$refmeta//refentrytitle"/>
  <xsl:variable name="refnamediv" select=".//refnamediv"/>
  <xsl:variable name="refname" select="$refnamediv//refname"/>
  <xsl:variable name="title">
    <xsl:choose>
      <xsl:when test="$refentrytitle">
        <xsl:apply-templates select="$refentrytitle[1]" mode="title"/>
      </xsl:when>
      <xsl:when test="$refname">
        <xsl:apply-templates select="$refname[1]" mode="title"/>
      </xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$toc.listitem.type}">
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target"/>
      </xsl:attribute>
      <xsl:copy-of select="$title"/>
    </a>
    <xsl:call-template name="revision.graphic">
      <xsl:with-param name="large" select="'1'"/>
    </xsl:call-template>
    <xsl:if test="$annotate.toc != 0">
      <xsl:text> - </xsl:text>
      <xsl:value-of select="refnamediv/refpurpose"/>
    </xsl:if>
  </xsl:element>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="sgmltag">
  <xsl:variable name="class">
    <xsl:choose>
      <xsl:when test="@class">
        <xsl:value-of select="@class"/>
      </xsl:when>
      <xsl:otherwise>element</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="lcname"
		select="translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ:',
			            'abcdefghijklmnopqrstuvwxyz.')"/>

  <xsl:variable name="elemidval">
    <xsl:choose>
      <xsl:when test="(@namespace
	               and @namespace != 'http://docbook.org/ns/docbook')
		      or @role = 'nonexistant'">
	<xsl:value-of select="'NOTEXPECTED'"/>
      </xsl:when>
      <xsl:when test="$lcname = 'indexterm'">
	<xsl:value-of select="'element.db.indexterm.singular'"/>
      </xsl:when>
      <xsl:when test="$lcname = 'mml.*'">
	<xsl:value-of select="'element.db._any.mml'"/>
      </xsl:when>
      <xsl:when test="$lcname = 'svg.*'">
	<xsl:value-of select="'element.db._any.svg'"/>
      </xsl:when>
      <xsl:when test="$lcname = '*.*'">
	<xsl:value-of select="'element.db._any'"/>
      </xsl:when>
      <xsl:when test="count(key('id', concat('element.db.', $lcname))) &gt; 0">
	<xsl:value-of select="concat('element.db.', $lcname)"/>
      </xsl:when>
      <xsl:when test="count(key('id', concat('element.db.html.', $lcname))) &gt; 0">
	<xsl:value-of select="concat('element.db.html.', $lcname)"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="concat('element.db.', $lcname)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!--
  <xsl:message>
    <xsl:text>elemidval: </xsl:text>
    <xsl:value-of select="$elemidval"/>
  </xsl:message>

  <xsl:message>
    <xsl:text>check: </xsl:text>
    <xsl:value-of select="."/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$class"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="following-sibling::text()"/>
    <xsl:text> </xsl:text>
    <xsl:if test="starts-with(following-sibling::text(), '&#160;(')">
      <xsl:text>1</xsl:text>
    </xsl:if>
  </xsl:message>
  -->

  <xsl:choose>
    <xsl:when test="$elemidval = 'NOTEXPECTED'">
      <xsl:apply-templates/>
    </xsl:when>

    <xsl:when test="$class = 'element'
		    and following-sibling::text()
		    and contains(following-sibling::text(), '&#160;(')">
      <!-- handle <tag>phrase</tag> (db._phrase) -->
      <xsl:variable name="ftext" select="following-sibling::text()[1]"/>
      <xsl:variable name="pattern"
		    select="substring-before(substring-after($ftext,'('),')')"/>
      <xsl:variable name="target"
		    select="key('id', concat('element.',$pattern))[1]"/>

      <!--
      <xsl:message>pattern: <xsl:value-of select="$pattern"/></xsl:message>
      -->

      <xsl:choose>
	<xsl:when test="$target">
	  <a>
	    <xsl:attribute name="href">
	      <xsl:call-template name="href.target">
		<xsl:with-param name="object" select="$target"/>
	      </xsl:call-template>
	    </xsl:attribute>
	    <xsl:apply-imports/>
	  </a>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:message>
	    <xsl:text>Failed to find </xsl:text>
	    <xsl:value-of select="$pattern"/>
	    <xsl:text> for "</xsl:text>
	    <xsl:value-of select="."/>
	    <xsl:text> </xsl:text>
	    <xsl:value-of select="$ftext"/>
	    <xsl:text>"</xsl:text>
	  </xsl:message>
	  <xsl:apply-imports/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <xsl:when test="$class = 'element' and count(key('id', $elemidval)) &gt; 0">
      <xsl:variable name="target" select="key('id', $elemidval)[1]"/>
      <a>
        <xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="$target"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:apply-imports/>
      </a>
    </xsl:when>

    <xsl:when test="$class = 'element'">
      <xsl:message>
	<xsl:text>Failed to find </xsl:text>
	<xsl:value-of select="$elemidval"/>
	<xsl:text> for "</xsl:text>
	<xsl:value-of select="."/>
	<xsl:text>"</xsl:text>
      </xsl:message>
      <xsl:apply-imports/>
    </xsl:when>

    <xsl:otherwise>
      <xsl:apply-imports/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ============================================================ -->

<xsl:template name="component.title">
  <xsl:param name="node" select="."/>

  <xsl:call-template name="anchor">
    <xsl:with-param name="node" select="$node"/>
    <xsl:with-param name="conditional" select="0"/>
  </xsl:call-template>

  <div class="component-title">
    <h1 class="label">
      <xsl:apply-templates select="$node" mode="label.markup">
        <xsl:with-param name="allow-anchors" select="1"/>
      </xsl:apply-templates>
    </h1>
    <h1 class="title">
      <xsl:apply-templates select="$node" mode="object.title.markup">
        <xsl:with-param name="allow-anchors" select="1"/>
      </xsl:apply-templates>
    </h1>
  </div>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="html:*">
  <xsl:element name="{local-name(.)}" namespace="http://www.w3.org/1999/xhtml">
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="processing-instruction('tdg-purp')">
  <xsl:variable name="elem" select="."/>
  <xsl:variable name="div" select="$rng//rng:div[db:refname = $elem]"/>
  
  <!--
  <xsl:if test="count($div) &gt; 1">
    <xsl:message>
      <xsl:text>Warning: more than once rng:div for </xsl:text>
      <xsl:value-of select="$elem"/>
      <xsl:text>?</xsl:text>
    </xsl:message>
  </xsl:if>
  -->

  <xsl:choose>
    <xsl:when test="$div">
      <xsl:value-of select="$div[1]/db:refpurpose"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>
	<xsl:text>Can't find purpose of </xsl:text>
	<xsl:value-of select="$elem"/>
      </xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>

