<!--

This is here because there's a bug in the interaction between
gradle 6.x+ and the DocBook plugin that the pipeline has to
be a file. :-(

This is just a copy of the base pipeline wrapped around a call to the base pipeline.

-->
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:dbp="http://docbook.github.com/ns/pipeline"
                xmlns:pxp="http://exproc.org/proposed/steps"
                xmlns:cx="http://xmlcalabash.com/ns/extensions"
                name="main" version="1.0"
                exclude-inline-prefixes="cx dbp pxp">
<p:input port="source" sequence="true" primary="true"/>
<p:input port="parameters" kind="parameter"/>
<p:output port="result" sequence="true" primary="true">
  <p:pipe step="process" port="result"/>
</p:output>
<p:output port="secondary" sequence="true" primary="false">
  <p:pipe step="process" port="secondary"/>
</p:output>
<p:serialization port="result" method="html" encoding="utf-8" indent="false"
                 version="5"/>

<p:option name="schema" select="''"/>
<p:option name="format" select="'html'"/>
<p:option name="style" select="'docbook'"/>
<p:option name="preprocess" select="''"/>
<p:option name="postprocess" select="''"/>
<p:option name="return-secondary" select="'false'"/>
<p:option name="pdf" select="'/tmp/docbook.pdf'"/>
<p:option name="css" select="''"/>

<p:import href="https://cdn.docbook.org/release/xsl20/current/xslt/base/pipelines/docbook.xpl"/>

<dbp:docbook name="process">
  <p:input port="source">
    <p:pipe step="main" port="source"/>
  </p:input>
  <p:with-option name="schema" select="$schema"/>
  <p:with-option name="format" select="$format"/>
  <p:with-option name="style" select="$style"/>
  <p:with-option name="preprocess" select="$preprocess"/>
  <p:with-option name="postprocess" select="$postprocess"/>
  <p:with-option name="return-secondary" select="$return-secondary"/>
  <p:with-option name="pdf" select="$pdf"/>
  <p:with-option name="css" select="$css"/>
</dbp:docbook>

</p:declare-step>
