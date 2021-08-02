{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "capi-openstack.name" -}}
{{- $name:= default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Returns a machineDeploymentName from object because its always used inside a
range iteration
*/}}
{{- define "capi-openstack.machineDeploymentName" -}}
{{- $machineName:= required (
      printf "name is required for .Values.machineDeployments.%d" .Index)
      .MachineDeployment.name -}}
{{- printf "%s-%s" (include "capi-openstack.name" .Context) $machineName |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Returns a machineTemplateName from object because its always used inside a
range iteration
*/}}
{{- define "capi-openstack.machineTemplateName" -}}
{{- $templateName:= required (
      printf "name is required for .Values.machineTemplates.%d" .Index) 
      .MachineTemplate.name -}}
{{- printf "%s-%s" (include "capi-openstack.name" .Context) $templateName |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-openstack.machineTemplateNameFromMDObject" -}}
{{- $templateName:= required (
      printf "templateName is required for .Values.machineDeployments.%d" .Index)
      .MachineDeployment.templateName -}}
{{- printf "%s-%s" (include "capi-openstack.name" .Context) $templateName |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{/*
Cloud config secret
*/}}
{{- define "capi-openstack.cloudConfigSecret" -}}
name: {{ include "capi-openstack.cloudConfigSecretName" . }}
{{- if .Values.cloudConfigSecret.namespace -}}
namespace: {{ .Values.cloudConfigSecret.namespace }}
{{- end -}}
{{- end -}}

{{/*
Cloud config secret Name
*/}}
{{- define "capi-openstack.cloudConfigSecretName" -}}
{{- if .Values.cloudConfigSecret.name -}}
{{ .Values.cloudConfigSecret.name }}
{{- else -}}
{{- printf "cloud-config-%s" (include "capi-openstack.name" .) |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Array of dnsNameservers to be configured for internal network
*/}}
{{- define "capi-openstack.openstackDnsNameservers" -}}
{{- if .Values.openstack.dnsNameservers -}}
{{- toYaml  .Values.openstack.dnsNameservers -}}
{{- else -}}
{{- fail "No dnsNameservers set" }}
{{- end -}}
{{- end -}}

{{- define "capi-openstack.kubeadmControlPlaneName" -}}
{{- printf "control-plane-%s" (include "capi-openstack.name" .) |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-openstack.crsCloudConfigName" -}}
{{- printf "%s-crs-cloud-config" (include "capi-openstack.name" .) |
    trunc 63 | trimSuffix "-" -}}
{{- end -}}
