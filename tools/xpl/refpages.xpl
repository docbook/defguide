<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>

<p:option name="rnd" required="true"/>
<p:option name="src" required="true"/>
<p:option name="dst" required="true"/>

<p:declare-step type="cx:message">
  <p:input port="source" sequence="true"/>
  <p:output port="result" sequence="true"/>
  <p:option name="message" required="true"/>
</p:declare-step>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="../xsl/elem-list.xsl"/>
  </p:input>
</p:xslt>

<p:for-each name="loop">
  <p:iteration-source select="/list/item"/>

  <!--
  <cx:message>
    <p:with-option name="message" select="concat('Processing ', /*)"/>
  </cx:message>
  -->

  <p:load>
    <p:with-option name="href"
                   select="resolve-uri(
                             concat('src/refpages/elements/',/*,'.xml'),
                             exf:cwd())"/>
  </p:load>

  <p:xslt>
    <p:input port="stylesheet">
      <p:document href="../xsl/refentry.xsl"/>
    </p:input>
    <p:with-param name="rngfile"
                  select="resolve-uri($rnd, exf:cwd())"/>
    <p:with-param name="seealsofile"
                  select="resolve-uri('seealso.xml', $src)"/>
    <p:with-param name="patternsfile"
                  select="resolve-uri('patterns.xml', $src)"/>
    <p:with-param name="gitfile"
                  select="resolve-uri('../../gitlog.xml', $dst)"/>
    <p:with-param name="schema"
                  select="'docbook'"/>
    <!-- <p:log port="result" href="/tmp/refentry.xml"/> -->
  </p:xslt>

  <p:validate-with-relax-ng>
    <p:input port="schema">
      <p:document href="../schema/tdg.rng"/>
    </p:input>
    <!-- <p:log port="result" href="/tmp/val.xml"/> -->
  </p:validate-with-relax-ng>

  <p:store method="xml" indent="false">
    <p:with-option name="href"
                   select="concat($dst, /*, '.xml')">
      <p:pipe step="loop" port="current"/>
    </p:with-option>
  </p:store>
</p:for-each>

</p:declare-step>
