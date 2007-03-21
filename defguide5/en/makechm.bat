@ECHO OFF
SET HHC="c:\Program Files\HTML Help Workshop\hhc.exe"
REM Sorry for MS-DOS batch file, but you probably never will be able to produce CHMs on Unix box
REM Script expects that saxon command is able to run Saxon processor and that your copy 
REM of HTML Help Workshop is installed in common place

xcopy /s /y /i figures htmlhelp\figures
xcopy /i /y html\defguide.css htmlhelp\defguide.css

call saxon-big-stack tdg.xml stylesheets/htmlhelp.xsl
%HHC% htmlhelp.hhp



