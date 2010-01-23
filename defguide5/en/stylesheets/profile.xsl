<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="xs"
                version="2.0">

<xsl:param name="condition" select="''"/>
<xsl:param name="not-condition" select="''"/>

<xsl:output method="xml" encoding="utf-8" indent="no"
	    omit-xml-declaration="yes"/>

<xsl:preserve-space elements="*"/>

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="db:pubdate[not(@condition)]|db:releaseinfo[not(@condition)]">
  <xsl:if test="not(starts-with(.,'$'))">
    <xsl:sequence select="."/>
  </xsl:if>
</xsl:template>

<xsl:template match="db:info">
  <xsl:variable name="content" as="element()*">
    <xsl:apply-templates select="*"/>
  </xsl:variable>
  <xsl:if test="not(empty($content))">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:sequence select="$content"/>
    </xsl:copy>
  </xsl:if>
</xsl:template>

<xsl:template match="*[@condition]">
  <xsl:choose>
    <xsl:when test="$condition != '' and @condition
                    and not(contains(@condition, $condition))">
<!--
      <xsl:message>
	<xsl:text>Suppress condition: </xsl:text>
	<xsl:value-of select="$condition"/>
	<xsl:text> on </xsl:text>
	<xsl:value-of select="local-name(.)"/>
	<xsl:text> (</xsl:text>
	<xsl:value-of select="@xml:id"/>
	<xsl:text> )</xsl:text>
      </xsl:message>
-->
    </xsl:when>
    <xsl:when test="$not-condition != '' and @condition
                    and contains(@condition, $not-condition)">
<!--
      <xsl:message>
	<xsl:text>Suppress not condition: </xsl:text>
	<xsl:value-of select="$not-condition"/>
	<xsl:text> on </xsl:text>
	<xsl:value-of select="local-name(.)"/>
	<xsl:text> (</xsl:text>
	<xsl:value-of select="@xml:id"/>
	<xsl:text> )</xsl:text>
      </xsl:message>
-->
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy>
	<xsl:copy-of select="@*"/>
	<xsl:apply-templates/>
      </xsl:copy>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="*">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="comment()|processing-instruction()|text()">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>
