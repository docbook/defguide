<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:db="http://docbook.org/ns/docbook"
                version="2.0">

<!-- ============================================================ -->

<xsl:template match="db:itemizedlist" mode="inlinesynop">
  <xsl:apply-templates select="db:listitem" mode="inlinesynop"/>
</xsl:template>

<xsl:template match="db:listitem[db:para/db:emphasis[@role='patnlink']]"
	      mode="inlinesynop" priority="100">
  <xsl:copy-of select="db:para/db:emphasis[@role='patnlink']"/>
</xsl:template>

<xsl:template match="db:listitem[db:itemizedlist]" mode="inlinesynop"
	      priority="75">
  <xsl:variable name="type" select="normalize-space(db:para)"/>

  <xsl:choose>
    <xsl:when test="$type = 'Sequence of:'">
      <xsl:apply-templates select="." mode="inlinesynop-seq"/>
    </xsl:when>
    <xsl:when test="$type = 'One of:'">
      <xsl:apply-templates select="." mode="inlinesynop-one"/>
    </xsl:when>
    <xsl:when test="$type = 'Interleave of:'">
      <xsl:apply-templates select="." mode="inlinesynop-interleave"/>
    </xsl:when>
    <xsl:when test="$type = 'Zero or more of:'">
      <xsl:apply-templates select="." mode="inlinesynop-zero-or-more"/>
    </xsl:when>
    <xsl:when test="$type = 'One or more of:'">
      <xsl:apply-templates select="." mode="inlinesynop-one-or-more"/>
    </xsl:when>
    <xsl:when test="$type = 'Optionally one of:'">
      <xsl:apply-templates select="." mode="inlinesynop-opt-one"/>
    </xsl:when>
    <xsl:when test="$type = 'Optional one or more of:'">
      <xsl:apply-templates select="." mode="inlinesynop-opt-one-or-more"/>
    </xsl:when>
    <xsl:when test="$type = 'Any element from any namespace except:'">
      <xsl:apply-templates select="." mode="inlinesynop-ns-except"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>
	<xsl:text>Unrecognized: "</xsl:text>
	<xsl:value-of select="$type"/>
	<xsl:text>"</xsl:text>
      </xsl:message>
      <xsl:copy-of select="."/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>  

<xsl:template match="db:listitem" mode="inlinesynop">
  <xsl:apply-templates select="db:para" mode="inlinesynop-inline"/>
</xsl:template>

<xsl:template name="group">
  <xsl:param name="sep" required="yes"/>
  <xsl:param name="suffix" required="yes"/>

  <xsl:choose>
    <xsl:when test="count(db:itemizedlist/db:listitem) &gt; 1">
      <xsl:text>(</xsl:text>
      <xsl:for-each select="db:itemizedlist/db:listitem">
	<xsl:if test="position() &gt; 1">
	  <xsl:value-of select="$sep"/>
	</xsl:if>
	<xsl:apply-templates select="." mode="inlinesynop"/>
      </xsl:for-each>
      <xsl:text>)</xsl:text>
      <xsl:value-of select="$suffix"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="db:itemizedlist/db:listitem" mode="inlinesynop"/>
      <xsl:value-of select="$suffix"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="db:listitem" mode="inlinesynop-seq">
  <xsl:call-template name="group">
    <xsl:with-param name="sep" select="', '"/>
    <xsl:with-param name="suffix" select="''"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="db:listitem" mode="inlinesynop-one">
  <xsl:call-template name="group">
    <xsl:with-param name="sep" select="' | '"/>
    <xsl:with-param name="suffix" select="''"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="db:listitem" mode="inlinesynop-interleave">
  <xsl:call-template name="group">
    <xsl:with-param name="sep" select="' &amp; '"/>
    <xsl:with-param name="suffix" select="''"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="db:listitem" mode="inlinesynop-zero-or-more">
  <xsl:call-template name="group">
    <xsl:with-param name="sep" select="' | '"/>
    <xsl:with-param name="suffix" select="'*'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="db:listitem" mode="inlinesynop-one-or-more">
  <xsl:call-template name="group">
    <xsl:with-param name="sep" select="' | '"/>
    <xsl:with-param name="suffix" select="'+'"/>
  </xsl:call-template>
</xsl:template>

<!-- this is the same as zero or more, right? -->
<xsl:template match="db:listitem" mode="inlinesynop-opt-one-or-more">
  <xsl:call-template name="group">
    <xsl:with-param name="sep" select="' | '"/>
    <xsl:with-param name="suffix" select="'*'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="db:listitem" mode="inlinesynop-opt-one">
  <xsl:call-template name="group">
    <xsl:with-param name="sep" select="' | '"/>
    <xsl:with-param name="suffix" select="'?'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="db:listitem" mode="inlinesynop-ns-except">
  <xsl:text>(FIXME: *-NS:*)</xsl:text>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="db:para" mode="inlinesynop-inline">
  <xsl:apply-templates mode="inlinesynop-inline"/>
</xsl:template>

<xsl:template match="db:phrase[@role='pattern']" mode="inlinesynop-inline">
  <superscript xmlns="http://docbook.org/ns/docbook"
	       role='pattern'>
    <xsl:value-of select="substring-before(substring-after(., '('), ')')"/>
  </superscript>
</xsl:template>

</xsl:stylesheet>
