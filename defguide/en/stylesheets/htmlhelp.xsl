<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                xmlns:exsl="http://exslt.org/common"
                xmlns:set="http://exslt.org/sets"
		version="1.0"
                exclude-result-prefixes="doc exsl set">

<!-- ********************************************************************
     $Id$
     ******************************************************************** -->

<xsl:import href="chunk.xsl"/>
<xsl:import href="../../../xsl/htmlhelp/htmlhelp-common.xsl"/>
<xsl:include href="../../../xsl/html/manifest.xsl"/>

<xsl:param name="use.extensions" select="1"/>
<xsl:param name="base.dir" select="'htmlhelp/'"/>
<xsl:variable name="x">
  <xsl:choose>
    <xsl:when test="$output.type='unexpanded'">-x</xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:variable>
<xsl:param name="html.ext" select="concat($x,'.html')"/>
<xsl:param name="htmlhelp.encoding" select="'iso-8859-1'"/>
<xsl:param name="chunker.output.encoding" select="'iso-8859-1'"/>
<xsl:param name="saxon.character.representation" select="'native'"/>
<xsl:param name="suppress.navigation" select="0"/>
<xsl:param name="suppress.footer.navigation" select="1"/>
<xsl:param name="htmlhelp.hhc.show.root" select="0"/>
<xsl:param name="htmlhelp.button.locate" select="1"/>
<xsl:param name="htmlhelp.show.advanced.search" select="1"/>
<xsl:param name="htmlhelp.show.favorities" select="1"/>

<xsl:param name="htmlhelp.button.home" select="1"/>
<xsl:param name="htmlhelp.button.home.url">http://www.docbook.org</xsl:param>

<xsl:param name="htmlhelp.button.jump1" select="1"/>
<xsl:param name="htmlhelp.button.jump1.url">http://sourceforge.net/docman/display_doc.php?docid=10513&amp;group_id=21935</xsl:param>
<xsl:param name="htmlhelp.button.jump1.title">Archives</xsl:param>

<xsl:param name="htmlhelp.button.jump2" select="1"/>
<xsl:param name="htmlhelp.button.jump2.url">http://sourceforge.net/project/showfiles.php?group_id=21935</xsl:param>
<xsl:param name="htmlhelp.button.jump2.title">Stylesheets</xsl:param>

<xsl:param name="htmlhelp.title">
  <xsl:text>DocBook: The Definitive Guide</xsl:text>
  <xsl:if test="$output.type='unexpanded'"><xsl:text> (unexpanded)</xsl:text></xsl:if>
</xsl:param>
<xsl:param name="htmlhelp.chm" select="concat('tdg-en-',substring-after(/book/bookinfo/releaseinfo,' '),$x,'.chm')"/>

<!-- Group element reference by first letter -->
<xsl:template match="reference"
              mode="hhc">
  <xsl:variable name="title">
    <xsl:if test="$htmlhelp.autolabel=1">
      <xsl:variable name="label.markup">
        <xsl:apply-templates select="." mode="label.markup"/>
      </xsl:variable>
      <xsl:if test="normalize-space($label.markup)">
        <xsl:value-of select="concat($label.markup,$autotoc.label.separator)"/>
      </xsl:if>
    </xsl:if>
    <xsl:apply-templates select="." mode="title.markup"/>
  </xsl:variable>

  <xsl:if test="$htmlhelp.hhc.show.root != 0 or parent::*">
    <xsl:text disable-output-escaping="yes">&lt;LI&gt; &lt;OBJECT type="text/sitemap"&gt;
      &lt;param name="Name" value="</xsl:text>
          <xsl:value-of select="normalize-space($title)"/>
      <xsl:text disable-output-escaping="yes">"&gt;
      &lt;param name="Local" value="</xsl:text>
          <xsl:call-template name="href.target.with.base.dir"/>
      <xsl:text disable-output-escaping="yes">"&gt;
    &lt;/OBJECT&gt;</xsl:text>
  </xsl:if>
  <xsl:choose>
    <xsl:when test="refentry/refmeta[refmiscinfo = 'Element']">
      <xsl:text disable-output-escaping="yes">&lt;UL&gt;</xsl:text>
      <xsl:for-each select="refentry">
        <xsl:variable name="letter" select="substring(refnamediv/refname,1,1)"/>     
        <xsl:if test="position()=1 or
                      substring(preceding-sibling::refentry[1]/refnamediv/refname,1,1)!=$letter">
          <xsl:text disable-output-escaping="yes">&lt;LI&gt; &lt;OBJECT type="text/sitemap"&gt;
          &lt;param name="Name" value="</xsl:text>
          <xsl:value-of select="translate($letter,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
          <xsl:text disable-output-escaping="yes">"&gt;
          <!--
               &lt;param name="Local" value="</xsl:text>
               <xsl:call-template name="href.target.with.base.dir"/>
               <xsl:text disable-output-escaping="yes">"&gt; 
               -->
          &lt;/OBJECT&gt;</xsl:text>
          <xsl:text disable-output-escaping="yes">&lt;UL&gt;</xsl:text>
          <xsl:apply-templates select="../refentry[substring(refnamediv/refname,1,1)=$letter]" mode="hhc"/>
          <xsl:text disable-output-escaping="yes">&lt;/UL&gt;</xsl:text>
        </xsl:if>
      </xsl:for-each>
      <xsl:text disable-output-escaping="yes">&lt;/UL&gt;</xsl:text>
    </xsl:when>
    <xsl:when test="refentry">
      <xsl:text disable-output-escaping="yes">&lt;UL&gt;</xsl:text>
      <xsl:apply-templates
        select="refentry"
        mode="hhc"/>
      <xsl:text disable-output-escaping="yes">&lt;/UL&gt;</xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<!-- All elements from reference go automatically to index -->
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

  <xsl:call-template name="write.indexterm">
    <xsl:with-param name="text" select="concat($refname,' element reference')"/>
  </xsl:call-template>

  <h1 class="title">
    <xsl:call-template name="revision.graphic">
      <xsl:with-param name="large" select="'1'"/>
      <xsl:with-param name="align" select="'right'"/>
    </xsl:call-template>
    <xsl:copy-of select="$title"/>
  </h1>
</xsl:template>

</xsl:stylesheet>
