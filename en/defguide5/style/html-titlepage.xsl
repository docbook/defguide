<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" version="1.0" exclude-result-prefixes="exsl">

<!-- This stylesheet was created by template/titlepage.xsl-->

<xsl:template name="book.titlepage.recto">
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/mediaobject"/>
  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/mediaobject"/>
  <xsl:choose>
    <xsl:when test="bookinfo/title">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/title[1]"/>
    </xsl:when>
    <xsl:when test="info/title">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/title[1]"/>
    </xsl:when>
    <xsl:when test="title">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="title[1]"/>
    </xsl:when>
  </xsl:choose>

  <div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:call-template name="titlepage-block">
</xsl:call-template></div>
</xsl:template>

<xsl:template name="book.titlepage.verso">
</xsl:template>

<xsl:template name="book.titlepage.separator"><hr/>
</xsl:template>

<xsl:template name="book.titlepage.before.recto">
</xsl:template>

<xsl:template name="book.titlepage.before.verso">
</xsl:template>

<xsl:template name="book.titlepage">
  <div>
    <xsl:variable name="recto.content">
      <xsl:call-template name="book.titlepage.before.recto"/>
      <xsl:call-template name="book.titlepage.recto"/>
    </xsl:variable>
    <xsl:variable name="recto.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($recto.content) != '') or ($recto.elements.count &gt; 0)">
      <div><xsl:copy-of select="$recto.content"/></div>
    </xsl:if>
    <xsl:variable name="verso.content">
      <xsl:call-template name="book.titlepage.before.verso"/>
      <xsl:call-template name="book.titlepage.verso"/>
    </xsl:variable>
    <xsl:variable name="verso.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($verso.content) != '') or ($verso.elements.count &gt; 0)">
      <div><xsl:copy-of select="$verso.content"/></div>
    </xsl:if>
    <xsl:call-template name="book.titlepage.separator"/>
  </div>
</xsl:template>

<xsl:template match="*" mode="book.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="book.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="mediaobject" mode="book.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="title" mode="book.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template name="chapter.titlepage.recto">
  <xsl:choose>
    <xsl:when test="chapterinfo/title">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/title"/>
    </xsl:when>
    <xsl:when test="docinfo/title">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/title"/>
    </xsl:when>
    <xsl:when test="info/title">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/title"/>
    </xsl:when>
    <xsl:when test="title">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="title"/>
    </xsl:when>
  </xsl:choose>

  <xsl:choose>
    <xsl:when test="chapterinfo/subtitle">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="docinfo/subtitle">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/subtitle"/>
    </xsl:when>
    <xsl:when test="info/subtitle">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/subtitle"/>
    </xsl:when>
    <xsl:when test="subtitle">
      <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="subtitle"/>
    </xsl:when>
  </xsl:choose>

  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/corpauthor"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/corpauthor"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/corpauthor"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/authorgroup"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/authorgroup"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/authorgroup"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/author"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/author"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/author"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/othercredit"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/othercredit"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/othercredit"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/releaseinfo"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/releaseinfo"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/releaseinfo"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/copyright"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/copyright"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/copyright"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/legalnotice"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/legalnotice"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/legalnotice"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/pubdate"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/pubdate"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/pubdate"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/revision"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/revision"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/revision"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/revhistory"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/revhistory"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/revhistory"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="chapterinfo/abstract"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="docinfo/abstract"/>
  <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="info/abstract"/>
</xsl:template>

<xsl:template name="chapter.titlepage.verso">
</xsl:template>

<xsl:template name="chapter.titlepage.separator"><hr class="component-separator"/>
</xsl:template>

<xsl:template name="chapter.titlepage.before.recto">
</xsl:template>

<xsl:template name="chapter.titlepage.before.verso">
</xsl:template>

<xsl:template name="chapter.titlepage">
  <div>
    <xsl:variable name="recto.content">
      <xsl:call-template name="chapter.titlepage.before.recto"/>
      <xsl:call-template name="chapter.titlepage.recto"/>
    </xsl:variable>
    <xsl:variable name="recto.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($recto.content) != '') or ($recto.elements.count &gt; 0)">
      <div><xsl:copy-of select="$recto.content"/></div>
    </xsl:if>
    <xsl:variable name="verso.content">
      <xsl:call-template name="chapter.titlepage.before.verso"/>
      <xsl:call-template name="chapter.titlepage.verso"/>
    </xsl:variable>
    <xsl:variable name="verso.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($verso.content) != '') or ($verso.elements.count &gt; 0)">
      <div><xsl:copy-of select="$verso.content"/></div>
    </xsl:if>
    <xsl:call-template name="chapter.titlepage.separator"/>
  </div>
</xsl:template>

<xsl:template match="*" mode="chapter.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="chapter.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="title" mode="chapter.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="subtitle" mode="chapter.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="corpauthor" mode="chapter.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="authorgroup" mode="chapter.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="author" mode="chapter.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="othercredit" mode="chapter.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="releaseinfo" mode="chapter.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="copyright" mode="chapter.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="legalnotice" mode="chapter.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="pubdate" mode="chapter.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="revision" mode="chapter.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="revhistory" mode="chapter.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="abstract" mode="chapter.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="chapter.titlepage.recto.style">
<xsl:apply-templates select="." mode="chapter.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template name="refentry.titlepage.recto">
  <div xsl:use-attribute-sets="refentry.titlepage.recto.style">
<xsl:call-template name="refentry.title">
<xsl:with-param name="node" select="ancestor-or-self::refentry[1]"/>
</xsl:call-template></div>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="refentryinfo/corpauthor"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="docinfo/corpauthor"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="info/corpauthor"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="refentryinfo/authorgroup"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="docinfo/authorgroup"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="info/authorgroup"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="refentryinfo/author"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="docinfo/author"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="info/author"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="refentryinfo/othercredit"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="docinfo/othercredit"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="info/othercredit"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="refentryinfo/copyright"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="docinfo/copyright"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="info/copyright"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="refentryinfo/legalnotice"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="docinfo/legalnotice"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="info/legalnotice"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="refentryinfo/revision"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="docinfo/revision"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="info/revision"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="refentryinfo/revhistory"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="docinfo/revhistory"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="info/revhistory"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="refentryinfo/abstract"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="docinfo/abstract"/>
  <xsl:apply-templates mode="refentry.titlepage.recto.auto.mode" select="info/abstract"/>
</xsl:template>

<xsl:template name="refentry.titlepage.verso">
</xsl:template>

<xsl:template name="refentry.titlepage.separator">
</xsl:template>

<xsl:template name="refentry.titlepage.before.recto">
</xsl:template>

<xsl:template name="refentry.titlepage.before.verso">
</xsl:template>

<xsl:template name="refentry.titlepage">
  <div>
    <xsl:variable name="recto.content">
      <xsl:call-template name="refentry.titlepage.before.recto"/>
      <xsl:call-template name="refentry.titlepage.recto"/>
    </xsl:variable>
    <xsl:variable name="recto.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($recto.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($recto.content) != '') or ($recto.elements.count &gt; 0)">
      <div><xsl:copy-of select="$recto.content"/></div>
    </xsl:if>
    <xsl:variable name="verso.content">
      <xsl:call-template name="refentry.titlepage.before.verso"/>
      <xsl:call-template name="refentry.titlepage.verso"/>
    </xsl:variable>
    <xsl:variable name="verso.elements.count">
      <xsl:choose>
        <xsl:when test="function-available('exsl:node-set')"><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:when test="contains(system-property('xsl:vendor'), 'Apache Software Foundation')">
          <!--Xalan quirk--><xsl:value-of select="count(exsl:node-set($verso.content)/*)"/></xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="(normalize-space($verso.content) != '') or ($verso.elements.count &gt; 0)">
      <div><xsl:copy-of select="$verso.content"/></div>
    </xsl:if>
    <xsl:call-template name="refentry.titlepage.separator"/>
  </div>
</xsl:template>

<xsl:template match="*" mode="refentry.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="*" mode="refentry.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="corpauthor" mode="refentry.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="refentry.titlepage.recto.style">
<xsl:apply-templates select="." mode="refentry.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="authorgroup" mode="refentry.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="refentry.titlepage.recto.style">
<xsl:apply-templates select="." mode="refentry.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="author" mode="refentry.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="refentry.titlepage.recto.style">
<xsl:apply-templates select="." mode="refentry.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="othercredit" mode="refentry.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="refentry.titlepage.recto.style">
<xsl:apply-templates select="." mode="refentry.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="copyright" mode="refentry.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="refentry.titlepage.recto.style">
<xsl:apply-templates select="." mode="refentry.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="legalnotice" mode="refentry.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="refentry.titlepage.recto.style">
<xsl:apply-templates select="." mode="refentry.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="revision" mode="refentry.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="refentry.titlepage.recto.style">
<xsl:apply-templates select="." mode="refentry.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="revhistory" mode="refentry.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="refentry.titlepage.recto.style">
<xsl:apply-templates select="." mode="refentry.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template match="abstract" mode="refentry.titlepage.recto.auto.mode">
<div xsl:use-attribute-sets="refentry.titlepage.recto.style">
<xsl:apply-templates select="." mode="refentry.titlepage.recto.mode"/>
</div>
</xsl:template>

</xsl:stylesheet>
