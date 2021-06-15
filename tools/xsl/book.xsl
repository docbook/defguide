<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:db="http://docbook.org/ns/docbook"
                xmlns:f="http://docbook.org/ns/docbook/functions"
		xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns:m="http://docbook.org/ns/docbook/modes"
                xmlns:rng="http://relaxng.org/ns/structure/1.0"
                xmlns:t="http://docbook.org/ns/docbook/templates"
                xmlns:tp="http://docbook.org/ns/docbook/templates/private"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="db f h m rng t tp xs"
                version="3.0">

<xsl:import href="https://cdn.docbook.org/release/xsltng/current/xslt/docbook.xsl"/>

<!-- ============================================================ -->

<xsl:param name="docbookXsltVersion" required="yes"/>
<xsl:param name="bookVersion" required="yes"/>

<!-- ============================================================ -->

<xsl:param name="profile-separator" select="' '"/>
<xsl:param name="refentry-generate-name" select="false()"/>
<xsl:param name="refentry-generate-title" select="true()"/>
<xsl:param name="component-numbers-inherit" select="true()"/>

<xsl:param name="generate-toc" as="xs:string">
  (empty(parent::*) and self::db:article)
  or self::db:set or self::db:book
  or self::db:part
</xsl:param>

<xsl:param name="chunk-exclude"
           select="('self::db:partintro',
                    'self::*[ancestor::db:partintro]',
                    'self::db:section',
                    'self::db:toc')"/>

<xsl:param name="section-toc-depth" select="1"/>

<!-- ============================================================ -->

<xsl:param name="rngfile" required="yes"/>

<xsl:variable name="rng" select="document($rngfile)"/>

<!-- ============================================================ -->

<xsl:template match="*" mode="m:html-head-links">
  <link href="{/db:book/db:info/db:releaseinfo[@role='icon']}"
        rel="icon" type="image/png" />
  <link rel="stylesheet" href="css/defguide.css"/>
  <link rel="stylesheet" href="css/pygments.css"/>
  <script type="text/javascript"
          src="https://kit.fontawesome.com/c94d537c36.js" crossorigin="anonymous"/>
</xsl:template>

<xsl:template match="*" mode="m:html-body-script">
  <xsl:param name="rootbaseuri" as="xs:anyURI" required="yes"/>
  <xsl:param name="chunkbaseuri" as="xs:anyURI" required="yes"/>
  <script type="text/javascript" src="js/refentry.js"/>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="/">
  <xsl:call-template name="t:docbook"/>
</xsl:template>

<xsl:template match="db:book" mode="m:docbook">
  <xsl:next-match/>
  <div db-chunk="dbcpyright.html" db-navigable='false'>
    <div>
      <xsl:apply-templates select="db:info/db:legalnotice/*"
                           mode="m:docbook"/>
    </div>
  </div>
</xsl:template>

<xsl:template match="db:book" mode="m:generate-titlepage">
  <xsl:variable name="isbn" select="db:info/db:biblioid[@class='isbn'][1]"/>
  <xsl:variable name="version" select="db:info/db:releaseinfo[1]"/>
  <xsl:variable name="date" select="db:info/db:pubdate[1]"/>
  <xsl:variable name="copyright" select="db:info/db:copyright"/>

  <header>
    <xsl:apply-templates select="db:info/db:mediaobject" mode="m:docbook"/>

    <h1><xsl:value-of select="db:info/db:title"/></h1>

    <div class="titlepage-block">
      <div class="authorgroup">
        <xsl:text>Author: </xsl:text>
        <xsl:apply-templates select="db:info/db:author" mode="m:docbook"/>
      </div>
      <div class="editor">
        <xsl:text>Editor: </xsl:text>
        <xsl:apply-templates select="db:info/db:editor" mode="m:docbook"/>
      </div>
      <xsl:if test="$isbn">
        <div class="isbn">
          <xsl:text>ISBN: </xsl:text>
          <a href="http://oreilly.com/catalog/{$isbn}/">
            <xsl:value-of select="$isbn"/>
          </a>
          <xsl:text>, published in conjunction with </xsl:text>
          <a href="http://xmlpress.net/">XML Press</a>.
        </div>
      </xsl:if>
      <div class="version">
        <xsl:if test="$rng/*/@buildhash">
          <xsl:variable name="hash" select="string($rng/*/@buildhash)"/>
          <xsl:attribute name="title">
            <xsl:text>Schema commit </xsl:text>
            <xsl:value-of select="substring($hash, 1, 6)"/>
            <xsl:text>…</xsl:text>
          </xsl:attribute>
        </xsl:if>
        <xsl:text>Version </xsl:text>
        <xsl:apply-templates select="$version/node()" mode="m:docbook"/>
      </div>
      <div class="date">
        <xsl:variable name="pubdate"
                      select="$date cast as xs:date" as="xs:date"/>
        <xsl:text>Updated: </xsl:text>
        <xsl:value-of select="format-date($pubdate, '[D1] [MNn], [Y0001]')"/>
      </div>
    </div>

    <p class="copyright">
      <a href="dbcpyright.html">Copyright</a>
      <xsl:text> &#xA9; </xsl:text>
      <xsl:value-of select="/db:book/db:info/db:copyright/db:year[1]"/>
      <xsl:text>–</xsl:text>
      <xsl:value-of select="/db:book/db:info/db:copyright/db:year[last()]"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="/db:book/db:info/db:copyright/db:holder"/>
      <xsl:text>.</xsl:text>
    </p>

    <br clear="all"/>

    <xsl:if test="/db:book/db:info/db:releaseinfo[@role='backcover']">
      <p id="backcover">
        <xsl:text>(</xsl:text>
        <a href="{/db:book/db:info/db:releaseinfo[@role='backcover']}">back cover</a>
        <xsl:text>)</xsl:text>
      </p>
    </xsl:if>

    <hr/>
  </header>
</xsl:template>

<xsl:template match="db:info/db:mediaobject" mode="m:docbook">
  <div class="covergraphic">
    <xsl:apply-imports/>
  </div>
</xsl:template>

<xsl:template match="db:refentrytitle" mode="m:docbook">
  <xsl:param name="purpose" select="''"/>
  <span>
    <xsl:apply-templates select="." mode="m:attributes"/>
    <xsl:if test="$purpose != 'lot'">
      <xsl:call-template name="t:revision.graphic">
        <xsl:with-param name="node" select="ancestor::db:refentry[1]"/>
        <xsl:with-param name="large" select="'1'"/>
        <xsl:with-param name="align" select="'right'"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates mode="m:docbook"/>
  </span>
</xsl:template>

<!-- Override this template in order to put revision graphics in the TOC -->
<xsl:template match="db:refpurpose" mode="m:docbook">
  <xsl:param name="purpose" select="''"/>

  <xsl:variable name="sincerev" as="node()*">
    <xsl:call-template name="t:revision.graphic">
      <xsl:with-param name="node" select="ancestor::db:refentry"/>
      <xsl:with-param name="large" select="'0'"/>
      <xsl:with-param name="align" select="''"/>
    </xsl:call-template>
  </xsl:variable>

  <span>
    <xsl:choose>
      <xsl:when test="$purpose = 'lot'">
        <xsl:attribute name="class" select="local-name(.)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="m:attributes"/>
      </xsl:otherwise>
    </xsl:choose>

    <span class="refpurpose-sep">
      <xsl:sequence
          select="f:gentext(., 'separator', 'refpurpose-sep')"/>
    </span>

    <xsl:choose>
      <xsl:when test="$purpose != 'lot'">
        <span class="refpurpose-text">
          <xsl:apply-templates mode="m:docbook"/>
        </span>
        <span class="refpurpose-punc">
          <xsl:text>.</xsl:text>
        </span>
      </xsl:when>
      <xsl:when test="empty($sincerev)">
        <span class="refpurpose-text">
          <xsl:apply-templates mode="m:docbook"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <!-- Tinker with purpose that we can wrap the last
             word and the sincerev in a span so that they
             don't get broken apart by word wrap. -->
        <xsl:variable name="words" as="node()*">
          <xsl:apply-templates mode="m:docbook"/>
        </xsl:variable>

        <!-- get rid of trailing whitespace, if there is any -->
        <xsl:variable name="lastword" select="$words[count($words)]"/>
        <xsl:variable name="words" as="node()*"
                      select="if ($lastword/self::text()
                                  and normalize-space($lastword) = '')
                              then subsequence($words, 1, count($words) - 1)
                              else $words"/>

        <span class="refpurpose-text">
          <xsl:sequence select="$words[position() lt count($words)]"/>

          <xsl:variable name="lastword"
                        select="if ($words[count($words)]/self::text())
                                then tokenize($words[count($words)], '\s+')
                                else $words[count($words)]"/>

          <xsl:if test="count($lastword) gt 1">
            <xsl:sequence
                select="string-join($lastword[position() lt count($lastword)], ' ')"/>
            <xsl:text> </xsl:text>
          </xsl:if>

          <span class="nobr">
            <xsl:sequence select="$lastword[position() eq count($lastword)]"/>
            <xsl:sequence select="$sincerev"/>
          </span>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </span>
</xsl:template>

<xsl:template match="db:para[ancestor::db:itemizedlist[@role='element-synopsis']]"
	      priority="100"
              mode="m:docbook">
  <!-- force this kind of list to be "compact" -->
  <xsl:apply-templates mode="m:docbook"/>
</xsl:template>

<xsl:template match="db:para[db:phrase[@role='cceq']]" mode="m:docbook">
  <div class="cmparents"/>
  <xsl:next-match/>
</xsl:template>

<xsl:template match="db:emphasis[@role='patnlink']" mode="m:docbook">
  <xsl:variable name="id" select="ancestor::db:listitem[1]/@xml:id"/>
  <xsl:variable name="list"
		select="following::db:itemizedlist[contains(@role,'patnlist')][1]"/>

  <xsl:variable name="title">
    <xsl:for-each select="$list//db:tag">
      <xsl:if test="position() &gt; 1 and last() &gt; 2">, </xsl:if>
      <xsl:if test="position() = last() and last() &gt; 1"> and </xsl:if>
      <xsl:value-of select="."/>
    </xsl:for-each>
  </xsl:variable>

  <em title="{$title}" class='patnlink'>
    <xsl:apply-templates mode="m:docbook"/>
  </em>

  <xsl:if test="$id != ''">
    <span db-ref="{$id}" class="cmjs cmshow" id="pls.{$id}"/>
    <span db-ref="{$id}" class="cmjs cmhide" id="plh.{$id}"/>
  </xsl:if>
</xsl:template>

<xsl:template match="db:itemizedlist[contains(@role,'patnlist')]" mode="m:docbook">
  <!-- don't apply imports because we don't want the anchor name -->
  <div class="patnlist" id="{@xml:id}">
    <div>
      <!-- Preserve order of PIs and comments -->
      <xsl:apply-templates
	  select="*[not(self::db:listitem
		    or self::db:title
		    or self::db:titleabbrev)]
		    |comment()[not(preceding-sibling::db:listitem)]
		    |processing-instruction()[not(preceding-sibling::db:listitem)]"
          mode="m:docbook"/>

      <ul>
        <xsl:apply-templates select="." mode="m:attributes"/>
        <xsl:apply-templates
            select="db:listitem
                    |comment()[preceding-sibling::db:listitem]
                    |processing-instruction()[preceding-sibling::db:listitem]"
            mode="m:docbook"/>
      </ul>
    </div>
  </div>
</xsl:template>

<xsl:template match="db:phrase[@role='cceq']" mode="m:docbook">
  <xsl:apply-imports/>

  <xsl:if test="ancestor::db:refsynopsisdiv//db:itemizedlist[contains(@role,'patnlist')]">
    <span class="cmjs cmdelete"/>
    <span class="cmjs cmshowall"/>
    <span class="cmjs cmhideall"/>
  </xsl:if>
</xsl:template>

<xsl:template match="db:example-wrapper" mode="m:docbook">
  <div class="example-output">
    <xsl:apply-templates mode="m:docbook"/>
  </div>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="db:phrase" mode="m:docbook">
  <xsl:choose>
    <xsl:when test="@conformance = 'inschema'">
      <xsl:variable name="conforms">
        <xsl:for-each select="db:tag">
          <xsl:variable name="class">
            <xsl:choose>
              <xsl:when test="@class">
                <xsl:value-of select="@class"/>
              </xsl:when>
              <xsl:otherwise>element</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="id">
            <xsl:apply-templates select="." mode="idvalue"/>
          </xsl:variable>

          <xsl:choose>
            <xsl:when test="$id = 'NOTEXPECTED'">
              <xsl:value-of select="concat(.,':2 ')"/>
            </xsl:when>
            <xsl:when test="$class = 'element' and count(key('id', $id)) &gt; 0">
              <xsl:value-of select="concat(.,':1 ')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat(.,':0 ')"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="contains($conforms, '0')">
          <!--
          <xsl:message>
            <xsl:text>Suppressing inschema (</xsl:text>
            <xsl:value-of select="local-name(.)"/>
            <xsl:text>): </xsl:text>
            <xsl:value-of select="$conforms"/>
          </xsl:message>
          -->
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-imports/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-imports/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="db:para" mode="m:docbook">
  <xsl:choose>
    <xsl:when test="@conformance = 'inschema'">
      <xsl:variable name="conforms">
        <xsl:for-each select="db:tag">
          <xsl:variable name="class">
            <xsl:choose>
              <xsl:when test="@class">
                <xsl:value-of select="@class"/>
              </xsl:when>
              <xsl:otherwise>element</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="id">
            <xsl:apply-templates select="." mode="idvalue"/>
          </xsl:variable>

          <xsl:choose>
            <xsl:when test="$id = 'NOTEXPECTED'">
              <xsl:value-of select="concat(.,':2 ')"/>
            </xsl:when>
            <xsl:when test="$class = 'element' and count(key('id', $id)) &gt; 0">
              <xsl:value-of select="concat(.,':1 ')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat(.,':0 ')"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="contains($conforms, '0')">
          <!--
          <xsl:message>
            <xsl:text>Suppressing inschema (</xsl:text>
            <xsl:value-of select="local-name(.)"/>
            <xsl:text>): </xsl:text>
            <xsl:value-of select="$conforms"/>
          </xsl:message>
          -->
        </xsl:when>
        <xsl:otherwise>
          <p>
            <xsl:if test="@xml:id">
              <xsl:attribute name="id" select="@xml:id"/>
            </xsl:if>
            <xsl:call-template name="t:revision.graphic"/>
            <xsl:apply-templates mode="m:docbook"/>
          </p>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <p>
        <xsl:if test="@xml:id">
          <xsl:attribute name="id" select="@xml:id"/>
        </xsl:if>
        <xsl:call-template name="t:revision.graphic"/>
        <xsl:apply-templates mode="m:docbook"/>
      </p>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="db:templatename" mode="m:docbook">
  <xsl:call-template name="t:inline">
    <xsl:with-param name="namemap" select="'code'"/>
  </xsl:call-template>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="db:tag" mode="idvalue">
  <xsl:variable name="class">
    <xsl:choose>
      <xsl:when test="@class">
        <xsl:value-of select="@class"/>
      </xsl:when>
      <xsl:otherwise>element</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="lcname"
		select="translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ:',
			            'abcdefghijklmnopqrstuvwxyz.')"/>

  <xsl:variable name="elemidval">
    <xsl:choose>
      <xsl:when test="(@namespace
	               and @namespace != 'http://docbook.org/ns/docbook')
		      or @role = 'nonexistant'">
	<xsl:value-of select="'NOTEXPECTED'"/>
      </xsl:when>
      <xsl:when test="$lcname = 'indexterm'">
	<xsl:value-of select="'element.db.indexterm.singular'"/>
      </xsl:when>
      <xsl:when test="$lcname = 'mml.*'">
	<xsl:value-of select="'element.db._any.mml'"/>
      </xsl:when>
      <xsl:when test="$lcname = 'svg.*'">
	<xsl:value-of select="'element.db._any.svg'"/>
      </xsl:when>
      <xsl:when test="$lcname = '*.*'">
	<xsl:value-of select="'element.db._any'"/>
      </xsl:when>
      <xsl:when test="starts-with($lcname, 'dcterms.')">
	<xsl:value-of select="$lcname"/>
      </xsl:when>
      <xsl:when test="count(key('id', concat('element.db.', $lcname))) &gt; 0">
	<xsl:value-of select="concat('element.db.', $lcname)"/>
      </xsl:when>
      <xsl:when test="count(key('id', concat('element.sl.', $lcname))) &gt; 0">
	<xsl:value-of select="concat('element.sl.', $lcname)"/>
      </xsl:when>
      <xsl:when test="count(key('id', concat('element.ws.', $lcname))) &gt; 0">
	<xsl:value-of select="concat('element.ws.', $lcname)"/>
      </xsl:when>
      <xsl:when test="count(key('id', concat('element.ws.rddl.', $lcname))) &gt; 0">
	<xsl:value-of select="concat('element.ws.', $lcname)"/>
      </xsl:when>
      <xsl:when test="count(key('id', concat('element.db.html.', $lcname))) &gt; 0">
	<xsl:value-of select="concat('element.db.html.', $lcname)"/>
      </xsl:when>
      <xsl:when test="count(key('id', concat('element.db.cals.', $lcname))) &gt; 0">
	<xsl:value-of select="concat('element.db.cals.', $lcname)"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="concat('element.db.', $lcname)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$class = 'element'
		    and following-sibling::*[1]/self::db:phrase[not(@conformance)]
		    and contains(following-sibling::db:phrase[1], '(')">
      <!-- handle <tag>phrase</tag> (<phrase>db._phrase</phrase>) -->
      <xsl:variable name="pattern"
		    select="substring-before(
			      substring-after(
			        following-sibling::db:phrase[1],'('),')')"/>

      <xsl:value-of select="concat('element.',$pattern)"/>
    </xsl:when>

    <xsl:otherwise>
      <xsl:value-of select="$elemidval"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="db:tag" mode="m:docbook">
  <xsl:variable name="class">
    <xsl:choose>
      <xsl:when test="@class">
        <xsl:value-of select="@class"/>
      </xsl:when>
      <xsl:otherwise>element</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="elemidval">
    <xsl:apply-templates select="." mode="idvalue"/>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$elemidval = 'NOTEXPECTED'">
      <xsl:apply-templates mode="m:docbook"/>
    </xsl:when>

    <xsl:when test="$class = 'element' and count(key('id', $elemidval)) &gt; 0">
      <xsl:variable name="target" select="key('id', $elemidval)[1]"/>
      <!-- Testing if $target = ancestor::* to avoid the link
           when the tag is being formatted in its reference page
           has devastating performance consequences. :-( -->
      <a href="{f:href(/,$target)}">
        <xsl:apply-imports/>
      </a>
    </xsl:when>

    <xsl:when test="$class = 'element'">
<!--
      <xsl:message>
	<xsl:text>Failed to find “</xsl:text>
	<xsl:value-of select="$elemidval"/>
	<xsl:text>” for "</xsl:text>
	<xsl:value-of select="."/>
	<xsl:text>" (2)</xsl:text>
      </xsl:message>
-->
      <xsl:apply-imports/>
    </xsl:when>

    <xsl:otherwise>
      <xsl:apply-imports/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ============================================================ -->

<xsl:template name="t:top-nav">
  <xsl:param name="docbook" as="node()" tunnel="yes"/>
  <xsl:param name="node" as="element()"/>
  <xsl:param name="prev" as="element()?"/>
  <xsl:param name="next" as="element()?"/>
  <xsl:param name="up" as="element()?"/>
  <xsl:param name="top" as="element()?"/>

  <span class="nav">
    <a title="{$docbook/db:book/db:info/db:title}" href="{$top/@db-chunk/string()}">
      <i class="fas fa-home"></i>
    </a>
    <xsl:text>&#160;</xsl:text>

    <xsl:choose>
      <xsl:when test="exists($prev)">
        <a href="{$prev/@db-chunk/string()}" title="{f:title-content($prev)}">
          <i class="fas fa-arrow-left"></i>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <span class="inactive">
          <i class="fas fa-arrow-left"></i>
        </span>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#160;</xsl:text>

    <xsl:choose>
      <xsl:when test="exists($up)">
        <a title="{f:title-content($up)}" href="{$up/@db-chunk/string()}">
          <i class="fas fa-arrow-up"></i>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <span class="inactive">
          <i class="fas fa-arrow-up"></i>
        </span>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#160;</xsl:text>

    <xsl:choose>
      <xsl:when test="exists($next)">
        <a title="{f:title-content($next)}" href="{$next/@db-chunk/string()}">
          <i class="fas fa-arrow-right"></i>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <span class="inactive">
          <i class="fas fa-arrow-right"></i>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </span>
  
  <span class="text">
    <xsl:variable name="ver" select="(/h:html/h:div)[1]//h:div[@class='version']"/>

    <i class="title"><xsl:value-of select="/h:html/h:head/h:title"/></i>
    <span class="version">
      <xsl:copy-of select="$ver/@title"/>
      <xsl:text>  (Version </xsl:text>
      <a href="ch00-online.html">
        <xsl:sequence select="substring-after(string($ver), 'Version ')"/>
      </a>
      <xsl:text>)  </xsl:text>
    </span>
  </span>
</xsl:template>

<xsl:template name="t:bottom-nav">
  <xsl:param name="docbook" as="node()" tunnel="yes"/>
  <xsl:param name="node" as="element()"/>
  <xsl:param name="prev" as="element()?"/>
  <xsl:param name="next" as="element()?"/>
  <xsl:param name="up" as="element()?"/>
  <xsl:param name="top" as="element()?"/>

  <div class="navrow">
    <div class="navleft">
      <xsl:if test="count($prev)>0">
        <a title="{f:title-content($prev)}" href="{$prev/@db-chunk/string()}">
          <i class="fas fa-arrow-left"></i>
        </a>
      </xsl:if>
    </div>
    <div class="navmiddle">
      <xsl:if test="exists($top)">
        <a title="{f:title-content($top)}" href="{$top/@db-chunk/string()}">
          <i class="fas fa-home"></i>
        </a>
      </xsl:if>
    </div>
    <div class="navright">
      <xsl:if test="count($next)>0">
        <a title="{f:title-content($next)}" href="{$next/@db-chunk/string()}">
          <i class="fas fa-arrow-right"></i>
        </a>
      </xsl:if>
    </div>
  </div>

  <div class="navrow">
    <div class="navleft navtitle">
      <xsl:value-of select="f:title-content($prev)"/>
    </div>
    <div class="navmiddle">
      <xsl:if test="count($up) gt 0">
        <a title="{f:title-content($up)}" href="{$up/@db-chunk/string()}">
          <i class="fas fa-arrow-up"></i>
        </a>
      </xsl:if>
    </div>
    <div class="navright navtitle">
      <xsl:value-of select="f:title-content($next)"/>
    </div>
  </div>

  <xsl:variable name="db-node"
                select="key('genid', $node/@db-id, $docbook)"/>

  <div class="infofooter">
    <span class="copyrightfooter">
      <a href="dbcpyright.html">Copyright</a>
      <xsl:text> &#xA9; </xsl:text>
      <xsl:value-of select="root($db-node)/db:book/db:info/db:copyright/db:year[1]"/>
      <xsl:text>–</xsl:text>
      <xsl:value-of select="root($db-node)/db:book/db:info/db:copyright/db:year[last()]"/>
      <xsl:text> Norman Walsh.</xsl:text>
    </span>

    <xsl:if test="$db-node/db:info/db:releaseinfo[@role='hash']">
      <xsl:variable name="hash"
                    select="$db-node/db:info/db:releaseinfo[@role='hash']"/>

      <span class="revision">
        <xsl:attribute name="title"
                       select="'git hash: '
                               || substring($hash, 1, 6)
                               || '…'"/>
        <xsl:text>Last revised by </xsl:text>
        <xsl:value-of
            select="substring-before($db-node/db:info/db:releaseinfo[@role='author'],
                                     ' &lt;')"/>
        <xsl:text> on </xsl:text>
        <xsl:for-each select="$db-node/db:info/db:pubdate">
          <!-- hack: there should be only one -->
          <xsl:if test=". castable as xs:dateTime">
            <xsl:value-of select="format-dateTime(. cast as xs:dateTime,
                                                  '[D1] [MNn,*-3] [Y0001]')"/>
          </xsl:if>
        </xsl:for-each>
      </span>
    </xsl:if>
  </div>
</xsl:template>

<xsl:template name="t:revision.graphic">
  <xsl:param name="node" select="."/>
  <xsl:param name="large" select="'0'"/>
  <xsl:param name="align" select="''"/>

  <xsl:variable name="arch" as="xs:string?" select="$node/@arch"/>
  <xsl:variable name="tag" as="xs:string?" select="local-name(.)"/>

  <xsl:for-each select="tokenize($node/@revision, '\s+')">
    <xsl:variable name="revision" select="."/>
    <xsl:choose>
      <xsl:when test="($arch = 'defguide' or $arch = 'publishers'
                      or $arch = 'sdocbook')
                      and empty($revision)">
        <!-- nop, expected -->
      </xsl:when>

      <xsl:when test="empty($revision)">
        <xsl:message>
          <xsl:text>Element with arch=</xsl:text>
          <xsl:value-of select="$arch"/>
          <xsl:text> but no revision!?</xsl:text>
        </xsl:message>
      </xsl:when>

      <xsl:when test="empty($arch)">
        <!-- 3.1 isn't interesting anymore -->
        <xsl:if test="$revision != '3.1'">
          <span class="sincerev">
            <xsl:text>V</xsl:text>
            <xsl:value-of select="$revision"/>
          </span>
        </xsl:if>
      </xsl:when>

      <xsl:when test="$arch = 'assembly'">
        <span class="sincerev">
          <xsl:text>V</xsl:text>
          <xsl:value-of select="$revision"/>
          <xsl:text> Assembly</xsl:text>
        </span>
      </xsl:when>

      <xsl:when test="$arch = 'publishers'">
        <span class="sincerev">
          <xsl:text>V</xsl:text>
          <xsl:value-of select="$revision"/>
          <xsl:text> Publishers</xsl:text>
        </span>
      </xsl:when>

      <xsl:when test="$arch = 'slides'">
        <span class="sincerev">
          <xsl:text>V</xsl:text>
          <xsl:value-of select="$revision"/>
          <xsl:text> Slides</xsl:text>
        </span>
      </xsl:when>

      <xsl:when test="$arch = 'website'">
        <span class="sincerev">
          <xsl:text>V</xsl:text>
          <xsl:value-of select="$revision"/>
          <xsl:text> Website</xsl:text>
        </span>
      </xsl:when>

      <xsl:otherwise>
        <xsl:message>
          <xsl:text>Unexpected revision/arch '</xsl:text>
          <xsl:value-of select="$revision"/>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="$arch"/>
          <xsl:text>' on </xsl:text>
          <xsl:value-of select="$tag"/>
        </xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
</xsl:template>

<xsl:function name="f:title-content" as="node()*">
  <xsl:param name="node" as="element()?"/>

  <xsl:variable name="header" select="($node/h:header, $node/h:article/h:header)[1]"/>

  <xsl:variable name="title" as="element()?"
                select="($header/h:h1,
                         $header/h:h2,
                         $header/h:h3,
                         $header/h:h4,
                         $header/h:h5)"/>

  <xsl:variable name="title" as="element()?"
                select="if (exists($title))
                        then $title
                        else $node/h:div[@class='refnamediv']
                                /h:p/h:span[@class='refname']"/>
 
  <xsl:sequence select="$title/node()"/>
</xsl:function>

<xsl:template match="processing-instruction('lb')" mode="m:docbook">
  <br/>
</xsl:template>

<xsl:template match="processing-instruction('docbookVersion')" mode="m:docbook">
  <xsl:value-of select="$bookVersion"/>
</xsl:template>

<xsl:template match="processing-instruction('docbookXsltVersion')" mode="m:docbook">
  <xsl:sequence select="$docbookXsltVersion"/>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="*" as="xs:boolean" mode="m:syntax-highlight">
  <xsl:variable name="language"
                select="if (@language)
                        then @language/string()
                        else if (matches(string(.), '^\s*&lt;'))
                             then 'xml'
                             else ''"/>
  <xsl:sequence select="'*' = $verbatim-syntax-highlight-languages
                        or $language = $verbatim-syntax-highlight-languages"/>
</xsl:template>

<xsl:template match="*" as="map(xs:string, xs:string)" mode="m:highlight-options">
  <xsl:variable name="language"
                select="if (@language)
                        then @language/string()
                        else if (matches(string(.), '^\s*&lt;'))
                             then 'xml'
                             else ''"/>
  <xsl:map>
    <xsl:if test="$language != ''">
      <xsl:map-entry key="'language'" select="$language"/>
    </xsl:if>
  </xsl:map>
</xsl:template>

</xsl:stylesheet>
