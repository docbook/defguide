<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="xs"
                version="2.0">

<xsl:param name="condition" select="''"/>
<xsl:param name="not-condition" select="''"/>
<xsl:param name="arch" select="''"/>
<xsl:param name="not-arch" select="''"/>
<xsl:param name="revision" select="''"/>

<xsl:variable name="condition-tokens" as="xs:string*" select="tokenize($condition,' ')"/>
<xsl:variable name="not-condition-tokens" as="xs:string*" select="tokenize($not-condition,' ')"/>
<xsl:variable name="arch-tokens" as="xs:string*" select="tokenize($arch,' ')"/>
<xsl:variable name="not-arch-tokens" as="xs:string*" select="tokenize($not-arch,' ')"/>
<xsl:variable name="revision-tokens" as="xs:string*" select="tokenize($revision,' ')"/>

<xsl:output method="xml" encoding="utf-8" indent="no"
	    omit-xml-declaration="yes"/>

<xsl:preserve-space elements="*"/>

<xsl:template match="/">
  <xsl:apply-templates/>
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

<xsl:template match="*[@condition or @arch or @revision]">
  <xsl:choose>
    <xsl:when test="(exists($condition-tokens) and @condition
                     and $condition-tokens != tokenize(@condition,' '))
                    or (exists($arch-tokens) and @arch
                        and $arch-tokens != tokenize(@arch,' '))
                    or (exists($revision-tokens) and @revision
                        and $revision-tokens != tokenize(@revision,' '))">
<!--
      <xsl:message>
	<xsl:text>Suppress: </xsl:text>
	<xsl:value-of select="local-name(.)"/>
        <xsl:if test="@xml:id">
          <xsl:text> (</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text> )</xsl:text>
        </xsl:if>
        <xsl:text>: </xsl:text>
        <xsl:if test="@arch">
          <xsl:text>arch=</xsl:text>
          <xsl:value-of select="@arch"/>
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:if test="@condition">
          <xsl:text>condition=</xsl:text>
          <xsl:value-of select="@condition"/>
          <xsl:text> </xsl:text>
        </xsl:if>
      </xsl:message>
-->
    </xsl:when>
    <xsl:when test="(exists($not-condition-tokens) and @condition
                     and $not-condition-tokens = tokenize(@condition, ' '))
                    or (exists($not-arch-tokens) and @arch
                        and $not-arch-tokens = tokenize(@arch, ' '))">
<!--
      <xsl:message>
	<xsl:text>Suppress: </xsl:text>
	<xsl:value-of select="local-name(.)"/>
        <xsl:if test="@xml:id">
          <xsl:text> (</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text> )</xsl:text>
        </xsl:if>
        <xsl:text>: </xsl:text>
        <xsl:if test="@arch">
          <xsl:text>arch!=</xsl:text>
          <xsl:value-of select="@arch"/>
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:if test="@condition">
          <xsl:text>condition!=</xsl:text>
          <xsl:value-of select="@condition"/>
          <xsl:text> </xsl:text>
        </xsl:if>
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
