<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>

<p:option name="src" select="'../refpages/elements/'"/>

<p:declare-step type="cx:message">
  <p:input port="source" sequence="true"/>
  <p:output port="result" sequence="true"/>
  <p:option name="message" required="true"/>
</p:declare-step>

<p:for-each name="loop">
  <p:iteration-source select="/list/item"/>

  <cx:message>
    <p:with-option name="message" select="concat('Processing ', /*)"/>
  </cx:message>

  <p:load>
    <p:with-option name="href"
                   select="resolve-uri(concat($src,/*,'.xml'), exf:cwd())"/>
  </p:load>

  <p:xinclude/>

  <p:xslt>
    <p:input port="stylesheet">
      <p:document href="../stylesheets/refentry.xsl"/>
    </p:input>
    <p:with-param name="rngfile"
                  select="resolve-uri('lib/defguide.rnd', exf:cwd())"/>
    <p:with-param name="seealsofile"
                  select="resolve-uri('lib/seealso.xml', exf:cwd())"/>
    <p:with-param name="patternsfile"
                  select="resolve-uri('lib/patterns.xml', exf:cwd())"/>
    <p:with-param name="gitfile"
                  select="resolve-uri('build/gitlog.xml', exf:cwd())"/>
    <p:with-param name="schema"
                  select="'docbook'"/>
  </p:xslt>

  <p:validate-with-relax-ng>
    <p:input port="schema">
      <p:document href="../schema/tdg.rng"/>
    </p:input>
  </p:validate-with-relax-ng>

  <p:store method="xml" indent="false">
    <p:with-option name="href"
                   select="resolve-uri(concat(/*, '.xml'),
                                       resolve-uri('build/elements/',
                                                   exf:cwd()))">
      <p:pipe step="loop" port="current"/>
    </p:with-option>
  </p:store>
</p:for-each>

</p:declare-step>
