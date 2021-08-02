{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "capi-openstack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
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
Returns a machineDeploymentName from object because its always used inside a
range iteration
*/}}
{{- define "capi-openstack.machineTemplateName" -}}
{{- $templateName:= required (
      printf "name is required for .Values.machineTemplates.%d" .Index) 
      .MachineTemplate.name -}}
{{- printf "%s-%s" (include "capi-openstack.name" .Context) $templateName |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Cloud config secret
*/}}
{{- define "capi-openstack.cloudConfigSecret" -}}
{{- if .Values.cloudConfigSecret.name -}}
name: {{ .Values.cloudConfigSecret.name }}
{{- else -}}
name: {{ printf "%s-cloud-config" .Values.name }}
{{- end -}}
{{- if .Values.cloudConfigSecret.namespace -}}
namespace: {{ .Values.cloudConfigSecret.namespace }}
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
{{- printf "%s-control-plane" .Values.name -}}
{{- end -}}
