<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

<!-- this stylesheet somewhat dangerously does its own profiling -->

<xsl:import href="/sourceforge/docbook/xsl/fo/docbook.xsl"/>

<xsl:param name="draft.watermark.image" select="''"/>
<xsl:param name="refentry.generate.title" select="1"/>
<xsl:param name="variablelist.as.blocks" select="1"/>
<xsl:param name="ulink.footnotes" select="1"/>
<xsl:param name="title.margin.left" select="'0pt'"/>

<xsl:param name="output.media" select="'print'"/>
<xsl:param name="output.type" select="'expanded'"/>
<xsl:param name="toc.section.depth" select="1"/>
<xsl:param name="callout.graphics.path" select="'figures/callouts/'"/>
<xsl:param name="refentry.generate.name" select="0"/>

<xsl:param name="generate.toc">
/appendix nop
/article  nop
book      toc,figure,table,example,equation
/chapter  nop
part      nop
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

<xsl:template match="processing-instruction('lb')">
  <fo:block>
    <xsl:text> </xsl:text>
  </fo:block>
</xsl:template>

<xsl:template name="revision.graphic">
  <xsl:param name="large" select="'0'"/>

  <xsl:if test="@revision">
    <xsl:choose>
      <xsl:when test="@revision='5.0'">
        <fo:external-graphic src="figures/100dpi/rev_5.0.png"/>
      </xsl:when>
      <xsl:when test="@revision='4.2'">
        <fo:external-graphic src="figures/100dpi/rev_4.2.png"/>
      </xsl:when>
      <xsl:when test="@revision='4.0'">
        <fo:external-graphic src="figures/100dpi/rev_4.0.png"/>
      </xsl:when>
      <xsl:when test="@revision='3.1'">
        <!-- nop; 3.1 isn't interesting anymore -->
      </xsl:when>
      <xsl:when test="@revision='EBNF'">
        <fo:external-graphic src="figures/100dpi/rev_ebnf.png"/>
      </xsl:when>
      <xsl:when test="@revision='SVG'">
        <fo:external-graphic src="figures/100dpi/rev_svg.png"/>
      </xsl:when>
      <xsl:when test="@revision='MathML'">
        <fo:external-graphic src="figures/100dpi/rev_mathml.png"/>
      </xsl:when>
      <xsl:when test="@revision='HTMLForms'">
        <fo:external-graphic src="figures/100dpi/rev_htmlforms.png"/>
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

<xsl:template match="para">
  <xsl:if test="not(@condition)
                or (@condition = $output.media)">
    <fo:block xsl:use-attribute-sets="normal.para.spacing">
      <xsl:if test="@id">
        <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
      </xsl:if>
      <xsl:call-template name="revision.graphic"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:if>
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
  <!-- FIXME: -->
</xsl:template>

<xsl:template match="anchor[@role='HACK-ex.out.end']">
  <!-- FIXME: -->
</xsl:template>

<xsl:template match="title" mode="book.titlepage.recto.mode">
  <fo:block font-size="24.8832pt" fo:font-family="{$title.font.family}">
    <xsl:apply-templates/>
    <xsl:apply-templates select="../subtitle[1]"
                         mode="book.titlepage.recto.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="subtitle" mode="book.titlepage.recto.mode">
  <xsl:text>: </xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<!-- ============================================================ -->

<!-- FIXME:
<xsl:template match="informaltable">
  <xsl:choose>
    <xsl:when test="@role='elemsynop'">
...
-->

<!-- ============================================================ -->

<!-- FIXME:
<xsl:template name="titlepage-block">
 ...
-->

<!-- ============================================================ -->

<!-- FIXME: make link -->
<xsl:template match="sgmltag">
  <xsl:variable name="class">
    <xsl:choose>
      <xsl:when test="@class">
        <xsl:value-of select="@class"/>
      </xsl:when>
      <xsl:otherwise>element</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$class = 'element'
                    and count(id(concat(.,'.element'))) &gt; 0">
      <xsl:variable name="targets" select="id(concat(.,'.element'))"/>
      <xsl:variable name="target" select="$targets[1]"/>

      <xsl:apply-imports/>

    </xsl:when>
    <xsl:when test="$class = 'paramentity'
                    and count(id(concat(.,'.parament'))) &gt; 0">
      <xsl:variable name="targets" select="id(concat(.,'.parament'))"/>
      <xsl:variable name="target" select="$targets[1]"/>

      <xsl:apply-imports/>

    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-imports/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ============================================================ -->
<!-- Reference Entries -->

<xsl:template match="refnamediv">
  <fo:block>
    <xsl:choose>
      <xsl:when test="$refentry.generate.name != 0">
        <fo:block xsl:use-attribute-sets="refentry.title.properties">
          <xsl:call-template name="gentext">
            <xsl:with-param name="key" select="'RefName'"/>
          </xsl:call-template>
        </fo:block>
      </xsl:when>

      <xsl:when test="$refentry.generate.title != 0">
        <fo:block xsl:use-attribute-sets="refentry.title.properties">
          <xsl:choose>
            <xsl:when test="../refmeta/refentrytitle">
              <xsl:apply-templates select="../refmeta/refentrytitle"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="refname[1]"/>
            </xsl:otherwise>
          </xsl:choose>
        </fo:block>
      </xsl:when>
    </xsl:choose>

    <fo:block>
      <xsl:choose>
        <xsl:when test="../refmeta/refentrytitle">
          <xsl:apply-templates select="../refmeta/refentrytitle"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="refname[1]"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="refpurpose"/>
    </fo:block>
  </fo:block>
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

<xsl:attribute-set name="synop.table.title.properties">
  <xsl:attribute name="font-family">
    <xsl:value-of select="$title.font.family"/>
  </xsl:attribute>
  <xsl:attribute name="font-weight">normal</xsl:attribute>
  <xsl:attribute name="font-size">11pt</xsl:attribute>
  <xsl:attribute name="space-before">1em</xsl:attribute>
</xsl:attribute-set>

<xsl:template match="row" mode="elemsynop">
  <xsl:variable name="entry" select="entry[1]"/>
  <xsl:variable name="entry2" select="entry[2]"/>

  <xsl:choose>
    <xsl:when test="@role = 'cmtitle'">
      <fo:block xsl:use-attribute-sets="synop.table.title.properties"
                space-before="5pt">
        <xsl:apply-templates select="$entry/*"/>
      </fo:block>
    </xsl:when>
    <xsl:when test="@role = 'cmsynop'">
      <xsl:apply-templates select="$entry/*"/>
    </xsl:when>
    <xsl:when test="@role = 'incltitle'">
      <fo:block xsl:use-attribute-sets="synop.table.title.properties">
        <xsl:apply-templates select="$entry/*"/>
      </fo:block>
    </xsl:when>
    <xsl:when test="@role = 'inclsynop'">
      <xsl:apply-templates select="$entry/*"/>
    </xsl:when>
    <xsl:when test="@role = 'excltitle'">
      <fo:block xsl:use-attribute-sets="synop.table.title.properties">
        <xsl:apply-templates select="$entry/*"/>
      </fo:block>
    </xsl:when>
    <xsl:when test="@role = 'exclsynop'">
      <xsl:apply-templates select="$entry/*"/>
    </xsl:when>
    <xsl:when test="@role = 'attrtitle'">
      <fo:block xsl:use-attribute-sets="synop.table.title.properties">
        <xsl:apply-templates select="$entry/*"/>
      </fo:block>
      <fo:block>
        <xsl:apply-templates select="$entry2/*"/>
      </fo:block>
    </xsl:when>
    <xsl:when test="@role = 'attrheader'">
      <xsl:variable name="attrrows" select="../row[@role='attr']"/>
      <fo:table space-before="5pt">
        <fo:table-body>
          <fo:table-row>
            <xsl:apply-templates select="entry[1]">
              <xsl:with-param name="spans">
                <xsl:call-template name="blank.spans">
                  <xsl:with-param name="cols" select="3"/>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:apply-templates>
          </fo:table-row>
          <xsl:for-each select="$attrrows">
            <fo:table-row>
              <xsl:apply-templates select="entry[1]">
                <xsl:with-param name="spans">
                  <xsl:call-template name="blank.spans">
                    <xsl:with-param name="cols" select="3"/>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:apply-templates>
            </fo:table-row>
          </xsl:for-each>
        </fo:table-body>
      </fo:table>
    </xsl:when>
    <xsl:when test="@role = 'attr'">
      <!-- nop -->
    </xsl:when>
    <xsl:when test="@role = 'tmtitle'">
      <fo:block xsl:use-attribute-sets="synop.table.title.properties">
        <xsl:apply-templates select="$entry/*"/>
      </fo:block>
    </xsl:when>
    <xsl:when test="@role = 'tmsynop'">
      <xsl:apply-templates select="$entry/*"/>
    </xsl:when>
    <xsl:when test="@role = 'petitle'">
      <xsl:if test="$output.type = 'unexpanded'">
        <xsl:variable name="attrrows" select="../row[@role='pe']"/>
        <fo:block xsl:use-attribute-sets="synop.table.title.properties">
          <xsl:apply-templates select="$entry/*"/>
        </fo:block>

        <fo:block>
          <xsl:text>The following parameter entities contain </xsl:text>
          <xsl:value-of select="ancestor::refentry/refnamediv/refname"/>
          <xsl:text>:</xsl:text>
        </fo:block>

        <fo:table>
          <fo:table-body>
            <fo:table-row>
              <xsl:apply-templates select="entry[1]">
                <xsl:with-param name="spans">
                  <xsl:call-template name="blank.spans">
                    <xsl:with-param name="cols" select="3"/>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:apply-templates>
            </fo:table-row>
            <xsl:for-each select="$attrrows">
              <fo:table-row>
                <xsl:apply-templates select="entry[1]">
                  <xsl:with-param name="spans">
                    <xsl:call-template name="blank.spans">
                      <xsl:with-param name="cols" select="3"/>
                    </xsl:call-template>
                  </xsl:with-param>
                </xsl:apply-templates>
              </fo:table-row>
            </xsl:for-each>
          </fo:table-body>
        </fo:table>
      </xsl:if>
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
      <fo:block xsl:use-attribute-sets="synop.table.title.properties">
        <xsl:apply-templates select="$entry/*"/>
      </fo:block>
      <fo:table>
        <fo:table-body>
          <fo:table-row>
            <xsl:apply-templates select="entry[1]">
              <xsl:with-param name="spans">
                <xsl:call-template name="blank.spans">
                  <xsl:with-param name="cols" select="3"/>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:apply-templates>
          </fo:table-row>
          <xsl:for-each select="$attrrows">
            <fo:table-row>
              <xsl:apply-templates select="entry[1]">
                <xsl:with-param name="spans">
                  <xsl:call-template name="blank.spans">
                    <xsl:with-param name="cols" select="3"/>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:apply-templates>
            </fo:table-row>
          </xsl:for-each>
        </fo:table-body>
      </fo:table>
    </xsl:when>
    <xsl:when test="@role = 'vle-eltitle'">
      <xsl:variable name="attrrows" select="../row[@role='vle-el']"/>
      <fo:block xsl:use-attribute-sets="synop.table.title.properties">
        <xsl:apply-templates select="$entry/*"/>
      </fo:block>
      <fo:table>
        <fo:table-body>
          <fo:table-row>
            <xsl:apply-templates select="entry[1]">
              <xsl:with-param name="spans">
                <xsl:call-template name="blank.spans">
                  <xsl:with-param name="cols" select="3"/>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:apply-templates>
          </fo:table-row>
          <xsl:for-each select="$attrrows">
            <fo:table-row>
              <xsl:apply-templates select="entry[1]">
                <xsl:with-param name="spans">
                  <xsl:call-template name="blank.spans">
                    <xsl:with-param name="cols" select="3"/>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:apply-templates>
            </fo:table-row>
          </xsl:for-each>
        </fo:table-body>
      </fo:table>
    </xsl:when>
    <xsl:when test="@role = 'vle-ieltitle'">
      <xsl:variable name="attrrows" select="../row[@role='vle-iel']"/>
      <fo:block xsl:use-attribute-sets="synop.table.title.properties">
        <xsl:apply-templates select="$entry/*"/>
      </fo:block>
      <fo:table>
        <fo:table-body>
          <fo:table-row>
            <xsl:apply-templates select="entry[1]">
              <xsl:with-param name="spans">
                <xsl:call-template name="blank.spans">
                  <xsl:with-param name="cols" select="3"/>
                </xsl:call-template>
              </xsl:with-param>
            </xsl:apply-templates>
          </fo:table-row>
          <xsl:for-each select="$attrrows">
            <fo:table-row>
              <xsl:apply-templates select="entry[1]">
                <xsl:with-param name="spans">
                  <xsl:call-template name="blank.spans">
                    <xsl:with-param name="cols" select="3"/>
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:apply-templates>
            </fo:table-row>
          </xsl:for-each>
        </fo:table-body>
      </fo:table>
    </xsl:when>
    <xsl:when test="@role = 'vle-cmtitle'">
      <fo:block xsl:use-attribute-sets="synop.table.title.properties">
        <xsl:text>Parameter entity content:</xsl:text>
      </fo:block>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<!-- ============================================================ -->

<xsl:template name="component.title">
  <xsl:param name="node" select="."/>
  <xsl:param name="pagewide" select="0"/>
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="$node"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="title">
    <xsl:apply-templates select="$node" mode="object.title.markup">
      <xsl:with-param name="allow-anchors" select="1"/>
    </xsl:apply-templates>
  </xsl:variable>

  <xsl:if test="$passivetex.extensions != 0">
    <fotex:bookmark xmlns:fotex="http://www.tug.org/fotex"
                    fotex-bookmark-level="2"
                    fotex-bookmark-label="{$id}">
      <xsl:value-of select="$title"/>
    </fotex:bookmark>
  </xsl:if>

  <fo:block text-align="right" font-size="100pt">
    <xsl:apply-templates select="$node" mode="label.markup">
      <xsl:with-param name="allow-anchors" select="1"/>
    </xsl:apply-templates>
  </fo:block>

  <fo:block keep-with-next.within-column="always"
            hyphenate="false"
            text-align="right">
    <xsl:if test="$pagewide != 0">
      <xsl:attribute name="span">all</xsl:attribute>
    </xsl:if>
    <xsl:copy-of select="$title"/>
  </fo:block>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="*" mode="running.foot.mode">
  <xsl:param name="master-reference" select="'unknown'"/>

  <xsl:variable name="foot">
    <fo:page-number/>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$master-reference='titlepage1'">
      <fo:static-content flow-name="xsl-region-after-first">
        <fo:block text-align="center" font-size="{$body.font.size}">
          <xsl:text>This is an </xsl:text>
          <fo:inline font-style="italic">alpha</fo:inline>
          <xsl:text> version of this book.</xsl:text>
        </fo:block>
      </fo:static-content>
    </xsl:when>
    <xsl:when test="$master-reference='oneside1'">
      <fo:static-content flow-name="xsl-region-after-first">
        <fo:block text-align="center" font-size="{$body.font.size}">
          <xsl:text>This is an </xsl:text>
          <fo:inline font-style="italic">alpha</fo:inline>
          <xsl:text> version of this book.</xsl:text>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-after">
        <fo:block text-align-last="justify" font-size="{$body.font.size}">
          <fo:inline keep-with-next.within-line="always">
            <xsl:text>This is an </xsl:text>
            <fo:inline font-style="italic">alpha</fo:inline>
            <xsl:text> version of this book.</xsl:text>
          </fo:inline>
          <fo:inline keep-together.within-line="always">
            <xsl:text> </xsl:text>
            <fo:leader leader-pattern="space"
                       keep-with-next.within-line="always"/>
            <xsl:text> </xsl:text>
            <xsl:copy-of select="$foot"/>
          </fo:inline>
        </fo:block>
      </fo:static-content>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>
        <xsl:text>Unexpected master-reference (</xsl:text>
        <xsl:value-of select="$master-reference"/>
        <xsl:text>) in running.foot.mode for </xsl:text>
        <xsl:value-of select="name(.)"/>
        <xsl:text>. No footer generated.</xsl:text>
      </xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ============================================================ -->

</xsl:stylesheet>
