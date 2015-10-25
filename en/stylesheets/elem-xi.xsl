<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:rng='http://relaxng.org/ns/structure/1.0'
                xmlns:xi='http://www.w3.org/2001/XInclude'
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="db rng xs"
		version="2.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"
	    omit-xml-declaration="yes"/>

<xsl:param name="manual" select="''"/>

<xsl:template match="/">
  <xsl:variable name="items" as="element(item)*">
    <xsl:apply-templates select="//rng:define[rng:element]"/>
  </xsl:variable>

  <xsl:variable name="includes" as="element(xi:include)*">
    <xsl:for-each select="$items">
      <xsl:sort select="."/>
      <xsl:choose>
        <xsl:when test=". = 'dcterms.any'">
          <xi:include href="elements/dcterms.xml"/>
        </xsl:when>
        <xsl:when test="starts-with(.,'dcterms.')">
          <!-- suppress -->
        </xsl:when>
        <xsl:otherwise>
          <xi:include href="elements/{.}.xml"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$manual = ''">
      <reference xml:id='ref-element'
                 xmlns='http://docbook.org/ns/docbook'>
        <title>DocBook Element Reference</title>
        <xsl:processing-instruction name="dbhtml">
          <xsl:text> filename='ref-elements.html'</xsl:text>
        </xsl:processing-instruction>
        <xi:include href='intro-elements.xml'/>
        <xsl:sequence select="$includes"/>
      </reference>
    </xsl:when>
    <xsl:when test="$manual = 'assembly'">
      <reference xml:id='ref-assembly'
                 xmlns='http://docbook.org/ns/docbook'>
        <title>DocBook Assembly Element Reference</title>
        <xsl:processing-instruction name="dbhtml">
          <xsl:text> filename='ref-assembly.html'</xsl:text>
        </xsl:processing-instruction>
        <xi:include href='intro-assembly.xml'/>
        <xsl:sequence select="$includes"/>
      </reference>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message terminate="yes">
        <xsl:text>Unexpected manual: </xsl:text>
        <xsl:value-of select="$manual"/>
      </xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="rng:define">
  <xsl:variable name="rmi" select="../db:refmiscinfo[@class='manual']"/>
  <xsl:if test="($rmi eq $manual) or (empty($rmi) and ($manual eq ''))">
    <item>
      <!-- Work around the irregular naming conventions of the XML files -->
      <xsl:choose>
        <xsl:when test="starts-with(@name,'db.cals.')">
          <xsl:value-of select="substring-after(@name, 'db.cals.')"/>
        </xsl:when>
        <xsl:when test="starts-with(@name,'db.')">
          <xsl:value-of select="substring-after(@name, 'db.')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@name"/>
        </xsl:otherwise>
      </xsl:choose>
    </item>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
