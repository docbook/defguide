<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:cvs="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.CVS"
		xmlns:html="http://www.w3.org/1999/xhtml"
		xmlns:db="http://docbook.org/ns/docbook"
		xmlns:dbx="http://sourceforge.net/projects/docbook/defguide/schema/extra-markup"
        xmlns:exsl="http://exslt.org/common"
        exclude-result-prefixes="cvs rng html db dbx exsl"
        version="2.0">

<xsl:key name="define" match="rng:define" use="@name"/>

<xsl:variable name="rngfile"
	      select="'../tools/lib/defguide.rnd'"/>

<xsl:variable name="rng" select="document($rngfile)"/>

<xsl:template match="processing-instruction('tdg-purp')">
  <xsl:variable name="elem" select="."/>
  <xsl:variable name="div" select="$rng//rng:div[db:refname = $elem]"/>

  <!--
  <xsl:if test="count($div) &gt; 1">
    <xsl:message>
      <xsl:text>Warning: more than once rng:div for </xsl:text>
      <xsl:value-of select="$elem"/>
      <xsl:text>?</xsl:text>
    </xsl:message>
  </xsl:if>
  -->

  <xsl:choose>
    <xsl:when test="$div">
      <xsl:copy-of select="$div[1]/db:refpurpose/node()"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>
	<xsl:text>Can't find purpose of </xsl:text>
	<xsl:value-of select="$elem"/>
      </xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="processing-instruction('common-general-attributes')">
  <!-- get "role" into the list -->
  <xsl:variable name="ns.all.common.attributes">
    <xsl:copy-of select="$rng//rng:define[@name='db.common.attributes']//rng:attribute"/>
    <rng:attribute name="role">
      <db:refpurpose>Provides additional, user-specified classification for an element</db:refpurpose>
      <dbx:description>
	<db:para>While <db:tag class='attribute'>role</db:tag>
	is a common attribute in the sense that it
	occurs on all DocBook elements, customizers will find that it is not part of
	any of the “common attribute” patterns. It is parameterized differently
	because it is useful to be able to subclass
	<db:tag class='attribute'>role</db:tag> independently
	on different elements.
	</db:para>
      </dbx:description>
    </rng:attribute>
  </xsl:variable>

  <xsl:variable name="effectivity.attributes"
                select="$rng//rng:define[@name='db.effectivity.attributes']//rng:attribute"/>

  <xsl:variable name="all.common.attributes"
                select="exsl:node-set($ns.all.common.attributes)/*"/>

  <xsl:variable name="ns.common.attributes">
    <xsl:for-each select="$all.common.attributes">
      <xsl:variable name="name" select="@name"/>
      <xsl:if test="not($effectivity.attributes[@name = $name])">
        <xsl:copy-of select="."/>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="common.attributes"
                select="exsl:node-set($ns.common.attributes)/*"/>

  <xsl:call-template name="process.common.attr">
    <xsl:with-param name="common.attributes"
		    select="$common.attributes"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="processing-instruction('common-effectivity-attributes')">
  <xsl:variable name="effectivity.attributes"
                select="$rng//rng:define[@name='db.effectivity.attributes']//rng:attribute"/>

  <xsl:call-template name="process.common.attr">
    <xsl:with-param name="common.attributes"
		    select="$effectivity.attributes"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="processing-instruction('common-linking-attributes')">
  <!-- get "role" into the list -->
  <xsl:variable name="common.linking.attributes"
		select="$rng//rng:define[@name='db.common.linking.attributes']//rng:attribute"/>

  <xsl:call-template name="process.common.attr">
    <xsl:with-param name="common.attributes"
		    select="$common.linking.attributes"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="processing-instruction('db-roots')">
  <xsl:variable name="roots" as="element()+">
    <xsl:for-each select="$rng/rng:grammar/rng:start//rng:ref">
      <xsl:variable name="def" select="key('define',@name,$rng)"/>
      <xsl:sequence select="$def/rng:element"/>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="rootnames" select="distinct-values($roots/@name)"/>

  <xsl:for-each select="$rootnames">
    <xsl:sort select="."/>
    <xsl:if test="position() &gt; 1">, </xsl:if>
    <xsl:if test="position() = last()">and </xsl:if>
    <db:tag>
      <xsl:value-of select="."/>
    </db:tag>
  </xsl:for-each>
</xsl:template>

<xsl:template match="@*|node()">
   <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
   </xsl:copy>
</xsl:template>

<xsl:template name="process.common.attr">
  <xsl:param name="common.attributes"/>

  <db:informaltable width="100%" border="0" style="border-collapse: collapse;border-top: 0.5pt solid ; border-bottom: 0.5pt solid ; border-left: 0.5pt solid ; border-right: 0.5pt solid ; ">
    <db:col align="left" width="25%"/>
    <db:thead>
      <db:tr>
	<db:th style="border-right: 0.5pt solid ; border-bottom: 0.5pt solid ; ">Name</db:th>
	<db:th style="border-right: 0.5pt solid ; border-bottom: 0.5pt solid ; ">Type</db:th>
      </db:tr>
    </db:thead>
    <db:tbody>
      <xsl:for-each select="$common.attributes">
	<xsl:sort select="@name" order="ascending" data-type="text"/>

	<db:tr>
	  <db:td style="border-right: 0.5pt solid ; border-bottom: 0.5pt solid ; "
	      valign="top">
	    <xsl:choose>
	      <xsl:when test="@name = 'linkend'">
		<db:code>
		    <xsl:value-of select="@name"/>
		</db:code>
		<xsl:text>/</xsl:text>
		<db:code>
		  linkends
		</db:code>
	      </xsl:when>
	      <xsl:otherwise>
		<db:code>
		    <xsl:value-of select="@name"/>
		</db:code>
	      </xsl:otherwise>
	    </xsl:choose>
	  </db:td>
	  <db:td style="border-right: 0.5pt solid ; border-bottom: 0.5pt solid ; "
	      valign="top">
	    <xsl:choose>
	      <xsl:when test="@name = 'linkend'">
		<xsl:text>IDREF/IDREFS</xsl:text>
	      </xsl:when>
	      <xsl:when test="rng:data">
		<xsl:value-of select="rng:data/@type"/>
	      </xsl:when>
	      <xsl:when test="rng:choice">
		<db:informaltable class="simplelist" border="0" summary="Simple list">
		  <db:tr>
		    <db:td><db:emphasis>Enumeration:</db:emphasis></db:td>
		  </db:tr>
		  <xsl:for-each select="rng:choice/rng:value">
		    <db:tr>
		      <db:td>
			<xsl:value-of select="."/>
		      </db:td>
		    </db:tr>
		  </xsl:for-each>
		</db:informaltable>
	      </xsl:when>
	      <xsl:otherwise>
		<db:emphasis>text</db:emphasis>
	      </xsl:otherwise>
	    </xsl:choose>
	  </db:td>
	</db:tr>
      </xsl:for-each>
    </db:tbody>
  </db:informaltable>

  <db:variablelist>
    <xsl:for-each select="$common.attributes">
      <xsl:sort select="@name" order="ascending" data-type="text"/>
      <db:varlistentry><db:term>
        <xsl:choose>
          <xsl:when test="@name = 'linkend'">
            <db:code>
              <xsl:value-of select="@name"/>
            </db:code>
            <xsl:text>/</xsl:text>
            <db:code>
              linkends
            </db:code>
          </xsl:when>
          <xsl:otherwise>
            <db:code>
              <xsl:value-of select="@name"/>
            </db:code>
          </xsl:otherwise>
        </xsl:choose>
      </db:term>
      <db:listitem>
        <db:para>
          <xsl:value-of select="db:refpurpose"/>
          <xsl:text>.</xsl:text>

          <xsl:if test="dbx:description">
            <xsl:variable name="desc">
              <xsl:apply-templates select="dbx:description/*" mode="stripNS"/>
            </xsl:variable>
            <xsl:apply-templates select="exsl:node-set($desc)/*"/>
          </xsl:if>

          <xsl:if test="rng:choice">
            <db:variablelist>
              <xsl:for-each select="rng:choice/rng:value">
                <db:varlistentry>
                  <db:term>
                    <db:code>
                      <xsl:value-of select="."/>
                    </db:code>
                  </db:term>
                  <db:listitem>
                    <db:para>
                      <xsl:value-of select="following-sibling::a:documentation[1]"
                                    xmlns:a="http://relaxng.org/ns/compatibility/annotations/1.0"/>
                    </db:para>
                  </db:listitem>
                </db:varlistentry>
              </xsl:for-each>
            </db:variablelist>
          </xsl:if>
        </db:para>
      </db:listitem>
      </db:varlistentry>
    </xsl:for-each>
  </db:variablelist>
</xsl:template>

</xsl:stylesheet>
