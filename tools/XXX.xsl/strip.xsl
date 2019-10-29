<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:db="http://docbook.org/ns/docbook"
                xmlns:exsl="http://exslt.org/common"
                exclude-result-prefixes="db exsl"
                version="1.0">

<!-- $Id$ -->

<xsl:import href="/sourceforge/docbook/xsl/common/stripns.xsl"/>

<xsl:output method="xml" encoding="utf-8" indent="no"
	    doctype-public="-//OASIS//DTD DocBook V4.5//EN//XML"
	    doctype-system="/home/ndw/docbook.org/xml/4.5/docbookx.dtd"/>

<xsl:preserve-space elements="*"/>

<xsl:template match="/">
  <xsl:choose>
    <xsl:when test="function-available('exsl:node-set')
		    and (*/self::db:*)">
      <!-- Hack! If someone hands us a DocBook V5.x or DocBook NG document,
	   toss the namespace and continue. Someday we'll reverse this logic
	   and add the namespace to documents that don't have one.
	   But not before the whole stylesheet has been converted to use
	   namespaces. i.e., don't hold your breath -->
      <xsl:message>Stripping NS from DocBook 5/NG document.</xsl:message>
      <xsl:variable name="db4">
	<xsl:apply-templates mode="stripNS"/>
      </xsl:variable>
      <xsl:message>Stripping xml:base from DocBook document.</xsl:message>
      <xsl:apply-templates select="exsl:node-set($db4)" mode="stripbase"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message terminate="yes">
	<xsl:text>Cannot strip without exsl:node-set.</xsl:text>
      </xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="db:info[parent::db:partintro]" mode="stripNS">
  <xsl:message>Discarding info on partintro</xsl:message>
</xsl:template>

<xsl:template match="db:info[parent::db:colophon]" mode="stripNS">
  <xsl:message>Discarding info on colophon</xsl:message>
</xsl:template>

<xsl:template match="db:info[parent::db:part]" mode="stripNS">
  <xsl:message>Discarding info on part</xsl:message>
  <xsl:apply-templates select="db:title" mode="stripNS"/>
</xsl:template>

<xsl:template match="db:refsection[parent::db:refsynopsisdiv]" mode="stripNS">
  <refsect2>
    <xsl:apply-templates mode="stripNS"/>
  </refsect2>
</xsl:template>

<xsl:template match="*" mode="stripbase">
  <xsl:copy>
    <xsl:copy-of select="@*[name(.) != 'xml:base']"/>
    <xsl:apply-templates mode="stripbase"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="comment()|processing-instruction()|text()"
	      mode="stripbase">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>
