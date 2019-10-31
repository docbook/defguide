<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                xmlns:exsl="http://exslt.org/common"
                xmlns:set="http://exslt.org/sets"
                xmlns:fm="http://freshmeat.net/projects/freshmeat-submit/"
                version="1.0"
                exclude-result-prefixes="doc exsl set fm">


<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/htmlhelp/htmlhelp.xsl"/>
<xsl:include href="manifest.xsl"/>

<xsl:param name="use.extensions">1</xsl:param>
<xsl:param name="tablecolumns.extension">0</xsl:param>
<xsl:param name="callouts.extension">0</xsl:param>

<xsl:param name="base.dir" select="'htmlhelp/'"/>
<xsl:param name="htmlhelp.encoding" select="'UTF-8'"/>
<xsl:param name="chunker.output.encoding" select="'UTF-8'"/>
<xsl:param name="saxon.character.representation" select="'native'"/>
<xsl:param name="suppress.navigation" select="0"/>
<xsl:param name="suppress.footer.navigation" select="1"/>
<xsl:param name="htmlhelp.hhc.show.root" select="0"/>
<xsl:param name="htmlhelp.button.locate" select="1"/>
<xsl:param name="htmlhelp.show.advanced.search" select="1"/>
<xsl:param name="htmlhelp.show.favorities" select="1"/>

<xsl:param name="htmlhelp.title">
  <xsl:text>DocBook: The Definitive Guide</xsl:text>
</xsl:param>

<xsl:param name="VERSION" select="string(document('../VERSION.xml')//fm:Version[1])"/>
<xsl:param name="htmlhelp.chm" select="'defguide5.chm'"/>

<xsl:param name="htmlhelp.generate.index" select="1"/>

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

</xsl:template>

<!-- CHM should be selfcontained, we must use local copies of glyphs images -->
<xsl:template name="mediaobject.filename">
  <xsl:param name="object"></xsl:param>

  <xsl:variable name="data" select="$object/videodata
                                    |$object/imagedata
                                    |$object/audiodata
                                    |$object"/>

  <xsl:variable name="filename2">
    <xsl:choose>
      <xsl:when test="$data[@fileref]">
        <xsl:value-of select="$data/@fileref"/>
      </xsl:when>
      <xsl:when test="$data[@entityref]">
        <xsl:value-of select="unparsed-entity-uri($data/@entityref)"/>
      </xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="filename">
    <xsl:choose>
      <xsl:when test="starts-with($filename2, 'http://www.oasis-open.org/docbook/xmlcharent/')">
        <xsl:value-of select="substring-after($filename2, 'http://www.oasis-open.org/docbook/xmlcharent/')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$filename2"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="real.ext">
    <xsl:call-template name="filename-extension">
      <xsl:with-param name="filename" select="$filename"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="ext">
    <xsl:choose>
      <xsl:when test="$real.ext != ''">
        <xsl:value-of select="$real.ext"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$graphic.default.extension"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="graphic.ext">
    <xsl:call-template name="is.graphic.extension">
      <xsl:with-param name="ext" select="$ext"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$real.ext = ''">
      <xsl:choose>
        <xsl:when test="$ext != ''">
          <xsl:value-of select="$filename"/>
          <xsl:text>.</xsl:text>
          <xsl:value-of select="$ext"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$filename"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="not($graphic.ext)">
      <xsl:choose>
        <xsl:when test="$graphic.default.extension != ''">
          <xsl:value-of select="$filename"/>
          <xsl:text>.</xsl:text>
          <xsl:value-of select="$graphic.default.extension"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$filename"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$filename"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
