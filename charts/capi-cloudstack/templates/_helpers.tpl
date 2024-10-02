{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "capi-cloudstack.name" -}}
{{- $name:= default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Returns a machineDeploymentName from object because its always used inside a
range iteration
*/}}
{{- define "capi-cloudstack.machineDeploymentName" -}}
{{- $machineName:= required (
      printf "name is required for .Values.machineDeployments.%d" .Index)
      .MachineDeployment.name -}}
{{- printf "%s-%s" (include "capi-cloudstack.name" .Context) $machineName |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Returns a machineTemplateName from object because its always used inside a
range iteration
*/}}
{{- define "capi-cloudstack.machineTemplateName" -}}
{{- $templateName:= required (
      printf "name is required for .Values.machineTemplates.%d" .Index) 
      .MachineTemplate.name -}}
{{- printf "%s-%s" (include "capi-cloudstack.name" .Context) $templateName |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-cloudstack.machineTemplateNameFromMDObject" -}}
{{- $templateName:= required (
      printf "templateName is required for .Values.machineDeployments.%d" .Index)
      .MachineDeployment.templateName -}}
{{- printf "%s-%s" (include "capi-cloudstack.name" .Context) $templateName |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{/*
Cloud config secret
*/}}
{{- define "capi-cloudstack.cloudConfigSecret" -}}
name: {{ include "capi-cloudstack.cloudConfigSecretName" . }}
{{- if .Values.cloudConfigSecret.namespace -}}
namespace: {{ .Values.cloudConfigSecret.namespace }}
{{- end -}}
{{- end -}}

{{/*
Cloud config secret Name
*/}}
{{- define "capi-cloudstack.cloudConfigSecretName" -}}
{{- if .Values.cloudConfigSecret.name -}}
{{ .Values.cloudConfigSecret.name }}
{{- else -}}
{{- printf "%s-cloud-config" (include "capi-cloudstack.name" .) |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Array of dnsNameservers to be configured for internal network
*/}}
{{- define "capi-cloudstack.cloudstackDnsNameservers" -}}
{{- if .Values.cloudstack.dnsNameservers -}}
{{- toYaml  .Values.cloudstack.dnsNameservers -}}
{{- else -}}
{{- fail "No dnsNameservers set" }}
{{- end -}}
{{- end -}}

{{- define "capi-cloudstack.kubeadmControlPlaneName" -}}
{{- printf "%s-control-plane" (include "capi-cloudstack.name" .) |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-cloudstack.crsCloudConfigName" -}}
{{- printf "%s-crs-cloud-config" (include "capi-cloudstack.name" .) |
    trunc 63 | trimSuffix "-" -}}
{{- end -}}
