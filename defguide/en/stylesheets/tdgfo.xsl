<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

<!-- this stylesheet somewhat dangerously does its own profiling -->

<xsl:import href="/sourceforge/docbook/xsl/fo/docbook.xsl"/>

<xsl:param name="output.media" select="'print'"/>
<xsl:param name="output.type" select="'expanded'"/>
<xsl:param name="toc.section.depth" select="1"/>
<xsl:param name="callout.graphics.path" select="'figures/callouts/'"/>
<xsl:param name="refentry.generate.name" select="0"/>
<xsl:param name="refentry.generate.title" select="0"/>

<xsl:template match="processing-instruction('lb')">
  <fo:inline linefeed-treatment="preserve">&#xA;</fo:inline>
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

</xsl:stylesheet>
