<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:db="http://docbook.org/ns/docbook"
                name="user.guide"
                version="1.0">
   <p:output port="result"/>
   <p:option name="validate" select="'true'"/>
   <p:import href="/projects/docbook/assembly/asmutils.xpl"/>
   <p:group name="user.guide.3">
      <p:output port="result" sequence="true"/>
      <p:identity name="rsrc-user.guide.3">
         <p:input port="source">
            <p:inline>
               <toc xmlns="http://docbook.org/ns/docbook"/>
            </p:inline>
         </p:input>
      </p:identity>
   </p:group>
   <p:group name="user.guide.4">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-user.guide.4">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/unpacking.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:chapter"/>
   </p:group>
   <p:group name="user.guide.5">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-user.guide.5">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/drivers.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:chapter"/>
   </p:group>
   <p:group name="user.guide.6">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-user.guide.6">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/cartridges.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:chapter"/>
   </p:group>
   <p:group name="user.guide.7">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-user.guide.7">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/paper.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:chapter"/>
   </p:group>
   <p:group name="user.guide.8">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-user.guide.8">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/cables.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:chapter"/>
   </p:group>
   <p:group name="user.guide.9">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-user.guide.9">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/alignment.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:chapter"/>
   </p:group>
   <p:group name="user.guide.10">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-user.guide.10">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/paperjam.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:chapter"/>
   </p:group>
   <p:group name="user.guide.11">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-user.guide.11">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/copybw.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:chapter"/>
   </p:group>
   <p:group name="user.guide.12">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-user.guide.12">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/copycolor.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:chapter"/>
   </p:group>
   <p:group name="user.guide.13">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-user.guide.13">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/scanning.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:chapter"/>
   </p:group>
   <p:group name="user.guide.14">
      <p:output port="result" sequence="true"/>
      <u:normalize xmlns:u="http://docbook.org/xproc/utils" name="rsrc-user.guide.14">
         <p:input port="source">
            <p:document href="file:/sourceforge/docbook/defguide5/en/examples/printer/src/printing.xml"/>
         </p:input>
      </u:normalize>
      <p:rename match="/*" new-name="db:chapter"/>
   </p:group>
   <p:wrap-sequence wrapper="db:book">
      <p:input port="source">
         <p:pipe step="user.guide.3" port="result"/>
         <p:pipe step="user.guide.4" port="result"/>
         <p:pipe step="user.guide.5" port="result"/>
         <p:pipe step="user.guide.6" port="result"/>
         <p:pipe step="user.guide.7" port="result"/>
         <p:pipe step="user.guide.8" port="result"/>
         <p:pipe step="user.guide.9" port="result"/>
         <p:pipe step="user.guide.10" port="result"/>
         <p:pipe step="user.guide.11" port="result"/>
         <p:pipe step="user.guide.12" port="result"/>
         <p:pipe step="user.guide.13" port="result"/>
         <p:pipe step="user.guide.14" port="result"/>
      </p:input>
   </p:wrap-sequence>
   <p:insert match="/*" position="first-child">
      <p:input port="insertion">
         <p:inline>
            <info xmlns="http://docbook.org/ns/docbook">
               <title>User Guide</title>
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