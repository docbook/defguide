<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="xs"
                version="2.0">

<xsl:param name="condition" select="''"/>
<xsl:param name="not-condition" select="''"/>

<xsl:variable name="condition-tokens" as="xs:string*" select="tokenize($condition,' ')"/>
<xsl:variable name="not-condition-tokens" as="xs:string*" select="tokenize($not-condition,' ')"/>

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

<xsl:template match="*[@condition]">
  <xsl:choose>
    <xsl:when test="exists($condition-tokens) and @condition
                    and $condition-tokens != tokenize(@condition,' ')">
<!--
      <xsl:variable name="cond" as="xs:string*" select="tokenize(@condition, ' ')"/>
      <xsl:variable name="match" as="xs:string*">
        <xsl:for-each select="$condition-tokens">
          <xsl:if test=". != $cond">
            <xsl:value-of select="."/>
          </xsl:if>
        </xsl:for-each>
      </xsl:variable>

      <xsl:message>
	<xsl:text>Suppress: </xsl:text>
	<xsl:value-of select="local-name(.)"/>
        <xsl:if test="@xml:id">
          <xsl:text> (</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text> )</xsl:text>
        </xsl:if>
        <xsl:text>: </xsl:text>
	<xsl:value-of select="string-join($match, ', ')"/>
      </xsl:message>
-->
    </xsl:when>
    <xsl:when test="exists($not-condition-tokens) and @condition
                    and $not-condition-tokens = tokenize(@condition, ' ')">
<!--
      <xsl:variable name="cond" as="xs:string*" select="tokenize(@condition, ' ')"/>
      <xsl:variable name="match" as="xs:string*">
        <xsl:for-each select="$not-condition-tokens">
          <xsl:if test=". = $cond">
            <xsl:value-of select="."/>
          </xsl:if>
        </xsl:for-each>
      </xsl:variable>

      <xsl:message>
	<xsl:text>Suppress: </xsl:text>
	<xsl:value-of select="local-name(.)"/>
        <xsl:if test="@xml:id">
          <xsl:text> (</xsl:text>
          <xsl:value-of select="@xml:id"/>
          <xsl:text> )</xsl:text>
        </xsl:if>
        <xsl:text>: not </xsl:text>
	<xsl:value-of select="string-join($match, ', ')"/>
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
