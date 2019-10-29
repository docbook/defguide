<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0"
                xmlns:c="http://www.w3.org/ns/xproc-step"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                xmlns:exf="http://exproc.org/standard/functions"
                exclude-inline-prefixes="cx exf"
                name="main">
<p:input port="source"/>
<p:output port="result"/>
<p:input port="parameters" kind="parameter"/>

<p:option name="rnd" select="'RNDMISSING'"/>
<p:option name="seealso" select="'SEEALSOMISSING'"/>
<p:option name="patterns" select="'PATTERNSMISSING'"/>

<p:declare-step type="cx:message">
  <p:input port="source" sequence="true"/>
  <p:output port="result" sequence="true"/>
  <p:option name="message" required="true"/>
</p:declare-step>

<p:xinclude/>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="../xsl/refentry.xsl"/>
  </p:input>
  <p:with-param name="rngfile"
                select="resolve-uri($rnd, exf:cwd())"/>
  <p:with-param name="seealsofile" select="$seealso"/>
  <p:with-param name="patternsfile" select="$patterns"/>
  <p:with-param name="gitfile"
                select="resolve-uri('../../build/gitlog.xml', exf:cwd())"/>
  <p:with-param name="schema" select="'docbook'"/>
  <!-- <p:log port="result" href="/tmp/refentry.xml"/> -->
</p:xslt>

<p:validate-with-relax-ng>
  <p:input port="schema">
    <p:document href="../schema/tdg.rng"/>
  </p:input>
</p:validate-with-relax-ng>

</p:declare-step>
