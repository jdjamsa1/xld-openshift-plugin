<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
<#assign container=deployed.container />
<#include "/openshift/oc-login-container.ftl">

${deployed.container.ocHome}/oc project ${deployed.project} || goto :error

<#-- determine if this app already exists, if not deploy a new one -->
echo "create new app automatically"
${deployed.container.ocHome}/oc new-app <#if deployed.dockerUrl?has_content>${deployed.dockerUrl}/</#if><#if deployed.dockerOrganization?has_content>${deployed.dockerOrganization}/</#if>${deployed.dockerName}<#if deployed.dockerTag?has_content>:${deployed.dockerTag}</#if> --name=${deployed.appName} || goto :error
${deployed.container.ocHome}/oc expose service ${deployed.appName} || goto :error
${deployed.container.ocHome}/oc status || goto :error
${deployed.container.ocHome}/oc logout || goto :error
goto :EOF

<#include "/openshift/error.bat.ftl">
