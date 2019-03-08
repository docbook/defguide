<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main">
<p:input port="source"/>
<p:input port="parameters" kind="parameter"/>

<p:option name="rnd" select="'lib/defguide.rnd'"/>

<p:declare-step type="cx:message">
  <p:input port="source" sequence="true"/>
  <p:output port="result" sequence="true"/>
  <p:option name="message" required="true"/>
</p:declare-step>

<p:xinclude/>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="../stylesheets/refentry.xsl"/>
  </p:input>
  <p:with-param name="rngfile"
                select="resolve-uri($rnd, exf:cwd())"/>
  <p:with-param name="seealsofile"
                select="resolve-uri('lib/seealso.xml', exf:cwd())"/>
  <p:with-param name="patternsfile"
                select="resolve-uri('lib/patterns.xml', exf:cwd())"/>
  <p:with-param name="gitfile"
                select="resolve-uri('lib/gitlog.xml', exf:cwd())"/>
  <p:with-param name="schema"
                select="'docbook'"/>
  <!-- <p:log port="result" href="/tmp/refentry.xml"/> -->
</p:xslt>

<p:validate-with-relax-ng>
  <p:input port="schema">
    <p:document href="../schema/tdg.rng"/>
  </p:input>
</p:validate-with-relax-ng>

<p:store method="xml" indent="false">
  <p:with-option name="href"
                 select="resolve-uri(substring-after(base-uri(.), '/elements/'),
                                     resolve-uri('build/elements/',
                                                 exf:cwd()))">
    <p:pipe step="main" port="source"/>
  </p:with-option>
</p:store>

</p:declare-step>
