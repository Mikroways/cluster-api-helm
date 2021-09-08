{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "capi-vsphere.name" -}}
{{- $name:= default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Returns a machineDeploymentName from object because its always used inside a
range iteration
*/}}
{{- define "capi-vsphere.machineDeploymentName" -}}
{{- $machineName:= required (
      printf "name is required for .Values.machineDeployments.%d" .Index)
      .MachineDeployment.name -}}
{{- printf "%s-%s" (include "capi-vsphere.name" .Context) $machineName |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Returns a machineTemplateName from object because its always used inside a
range iteration
*/}}
{{- define "capi-vsphere.machineTemplateName" -}}
{{- $templateName:= required (
      printf "name is required for .Values.machineTemplates.%d" .Index)
      .MachineTemplate.name -}}
{{- printf "%s-%s" (include "capi-vsphere.name" .Context) $templateName |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-vsphere.machineTemplateNameFromMDObject" -}}
{{- $templateName:= required (
      printf "templateName is required for .Values.machineDeployments.%d" .Index)
      .MachineDeployment.templateName -}}
{{- printf "%s-%s" (include "capi-vsphere.name" .Context) $templateName |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{/*
Cloud config secret
*/}}
{{- define "capi-vsphere.cloudConfigSecret" -}}
name: {{ include "capi-vsphere.cloudConfigSecretName" . }}
{{- if .Values.cloudConfigSecret.namespace -}}
namespace: {{ .Values.cloudConfigSecret.namespace }}
{{- end -}}
{{- end -}}

{{/*
Cloud config secret Name
*/}}
{{- define "capi-vsphere.cloudConfigSecretName" -}}
{{- if .Values.cloudConfigSecret.name -}}
{{ .Values.cloudConfigSecret.name }}
{{- else -}}
{{- printf "%s-cloud-config" (include "capi-vsphere.name" .) |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Array of dnsNameservers to be configured for internal network
*/}}
{{- define "capi-vsphere.vsphereDnsNameservers" -}}
{{- if .Values.vsphere.dnsNameservers -}}
{{- toYaml  .Values.vsphere.dnsNameservers -}}
{{- else -}}
{{- fail "No dnsNameservers set" }}
{{- end -}}
{{- end -}}

{{- define "capi-vsphere.kubeadmControlPlaneName" -}}
{{- printf "%s-control-plane" (include "capi-vsphere.name" .) |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-vsphere.crsCloudConfigName" -}}
{{- printf "%s-crs-cloud-config" (include "capi-vsphere.name" .) |
    trunc 63 | trimSuffix "-" -}}
{{- end -}}
