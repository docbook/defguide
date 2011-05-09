<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://docbook.org/ns/docbook"
		xmlns:rng='http://relaxng.org/ns/structure/1.0'
                xmlns:exsl="http://exslt.org/common"
		exclude-result-prefixes="rng exsl"
		version="1.0">

<xsl:output method="xml" encoding="utf-8" indent="yes"
	    omit-xml-declaration="yes"/>

<xsl:variable name="rngfile"
	      select="'../tools/lib/defguide.rnd'"/>

<xsl:variable name="rng" select="document($rngfile)"/>

<xsl:template match="patterns">
  <variablelist>
    <xsl:apply-templates select="pattern"/>
  </variablelist>
</xsl:template>

<xsl:template match="pattern">
  <xsl:message>Processing <xsl:value-of select="."/></xsl:message>

  <varlistentry xml:id="ipatn.{@name}">
    <term><xsl:value-of select="."/></term>
    <listitem>
      <para>
	<xsl:text>A choice of one of the following: </xsl:text>

	<xsl:variable name="patn" select="@name"/>
	<xsl:variable name="def" select="$rng//rng:define[@name = $patn]"/>

        <xsl:variable name="ns.elem.names">
          <xsl:for-each select="$def//rng:ref">
            <xsl:variable name="patname" select="@name"/>
            <xsl:variable name="elname"
                          select="$rng//rng:define[@name = $patname]/rng:element/@name"/>
            <tag>
              <xsl:value-of select="$elname"/>
            </tag>
          </xsl:for-each>
        </xsl:variable>

        <xsl:variable name="elem.names"
                      select="exsl:node-set($ns.elem.names)/*"/>

        <xsl:variable name="ns.uniq.names">
          <xsl:for-each select="$elem.names">
            <xsl:variable name="name" select="string(.)"/>
            <xsl:if test="generate-id(.) = generate-id($elem.names[. = $name][1])">
              <xsl:copy-of select="."/>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>

        <xsl:variable name="uniq.names" select="exsl:node-set($ns.uniq.names)/*"/>

	<xsl:for-each select="$uniq.names">
	  <xsl:if test="position() &gt; 1 and last() != 2">, </xsl:if>
	  <xsl:if test="position() &gt; 1 and last() = 2">&#160;</xsl:if>
	  <xsl:if test="position() &gt; 1 and position() = last()">or </xsl:if>
          <xsl:copy-of select="."/>
          <xsl:if test="position() = last()">.</xsl:if>
        </xsl:for-each>
      </para>
    </listitem>
  </varlistentry>
</xsl:template>

</xsl:stylesheet>
