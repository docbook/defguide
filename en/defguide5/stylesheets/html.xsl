<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

  <xsl:import href="http://docbook.sourceforge.net/release/xsl/current/html/chunk.xsl"/>

  <xsl:param name="l10n.gentext.language" select="'en'"/>
  <xsl:param name="draft.mode" select="no"/>

  <xsl:param name="use.extensions">1</xsl:param>
  <xsl:param name="callouts.extension">1</xsl:param>
  <xsl:param name="linenumbering.extension">1</xsl:param>
  <xsl:param name="tablecolumns.extension">1</xsl:param>
  <xsl:param name="textinsert.extension">1</xsl:param>

  <xsl:param name="admon.graphics" select="1" />
  <xsl:param name="admon.graphics.extension">.png</xsl:param>
  <xsl:param name="callout.graphics" select="1" />
  <xsl:param name="callout.graphics.extension">.png</xsl:param>

  <xsl:param name="section.autolabel" select="1" />
  <xsl:param name="section.label.includes.component.label">1</xsl:param>

  <xsl:output method="html" encoding="utf-8" indent="yes"/>     <!-- html only -->
  <xsl:param name="use.id.as.filename">1</xsl:param>            <!-- html only -->
  <xsl:param name="chunk.section.depth">0</xsl:param>           <!-- html only -->
  <xsl:param name="chunker.output.indent">yes</xsl:param>       <!-- html only -->
  <xsl:param name="html.stylesheet">debian.css</xsl:param>      <!-- html only -->
  <xsl:param name="toc.section.depth">3</xsl:param>             <!-- html only -->

  <xsl:template match="sect1" mode="toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes"
        select="sect2|refentry|bridgehead[$bridgehead.in.toc != 0]"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="sect2" mode="toc">
    <xsl:param name="toc-context" select="."/>

    <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes"
        select="sect3|refentry|bridgehead[$bridgehead.in.toc != 0]"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
