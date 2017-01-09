<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
<#assign container=previousDeployed.container />
<#include "/openshift/oc-login-container.ftl">

<#-- determine if this app already exists, if not deploy a new one -->
echo "destroy resource"
${previousDeployed.container.ocHome}/oc project ${previousDeployed.project} || goto :error
${previousDeployed.container.ocHome}/oc delete -f ${previousDeployed.file.path} || goto :error
${previousDeployed.container.ocHome}/oc status || goto :error
${previousDeployed.container.ocHome}/oc logout || goto :error
goto :EOF

<#include "/openshift/error.bat.ftl">
