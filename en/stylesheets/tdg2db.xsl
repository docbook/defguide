<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns="http://docbook.org/ns/docbook"
		exclude-result-prefixes="db xs"
                version="2.0">

<xsl:output method="xml" encoding="utf-8" indent="no"
	    omit-xml-declaration="yes"/>

<xsl:template match="db:att">
  <tag class="attribute">
    <xsl:apply-templates select="@*,node()"/>
  </tag>
</xsl:template>

<xsl:template match="db:element-summary-list">
  <variablelist>
    <xsl:for-each select="db:tag">
      <varlistentry>
        <term><xsl:copy-of select="."/></term>
        <listitem>
          <para>
            <xsl:processing-instruction name="tdg-purp">
              <xsl:value-of select="."/>
            </xsl:processing-instruction>
            <xsl:text>.</xsl:text>
          </para>
        </listitem>
      </varlistentry>
    </xsl:for-each>
  </variablelist>
</xsl:template>

<xsl:template match="element()">
  <xsl:copy>
    <xsl:apply-templates select="@*,node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="attribute()|text()|comment()|processing-instruction()">
  <xsl:copy/>
</xsl:template>

</xsl:stylesheet>
