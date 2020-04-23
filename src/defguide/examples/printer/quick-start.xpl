<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:db="http://docbook.org/ns/docbook"
                name="getting.started"
                version="1.0">
   <p:output port="result"/>
   <p:option name="validate" select="'true'"/>
   <p:import href="/projects/docbook/assembly/asmutils.xpl"/>
   <p:group name="getting.started.3">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-getting.started.3">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/unpacking.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:section"/>
   </p:group>
   <p:group name="getting.started.4">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-getting.started.4">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/drivers.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:section"/>
   </p:group>
   <p:group name="getting.started.5">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-getting.started.5">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/cartridges.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:section"/>
   </p:group>
   <p:group name="getting.started.6">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-getting.started.6">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/paper.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:section"/>
   </p:group>
   <p:group name="getting.started.7">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-getting.started.7">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/cables.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:section"/>
   </p:group>
   <p:group name="getting.started.8">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-getting.started.8">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/printing.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:section"/>
   </p:group>
   <p:wrap-sequence wrapper="db:article">
      <p:input port="source">
         <p:pipe step="getting.started.3" port="result"/>
         <p:pipe step="getting.started.4" port="result"/>
         <p:pipe step="getting.started.5" port="result"/>
         <p:pipe step="getting.started.6" port="result"/>
         <p:pipe step="getting.started.7" port="result"/>
         <p:pipe step="getting.started.8" port="result"/>
      </p:input>
   </p:wrap-sequence>
   <p:insert match="/*" position="first-child">
      <p:input port="insertion">
         <p:inline>
            <info xmlns="http://docbook.org/ns/docbook">
               <title>Quick Start Guide</title>
            </info>
         </p:inline>
      </p:input>
   </p:insert>
   <p:choose>
      <p:when test="$validate = 'true'">
         <p:validate-with-relax-ng>
            <p:input port="schema">
               <p:document href="/sourceforge/docbook/docbook/relaxng/docbook/docbook.rng"/>
            </p:input>
         </p:validate-with-relax-ng>
      </p:when>
      <p:otherwise>
         <p:identity/>
      </p:otherwise>
   </p:choose>
</p:declare-step>