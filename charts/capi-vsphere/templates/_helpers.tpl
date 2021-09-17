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

{{/*
Expand the VSphereCluster workspace propertie
*/}}
{{- define "capi-vsphere.vsphereCluster.workspace" -}}
datacenter: {{ required ".Values.vsphere.cloudProviderConfiguration.workspace.datacenter is required" .Values.vsphere.cloudProviderConfiguration.workspace.datacenter }}
datastore: {{ required ".Values.vsphere.cloudProviderConfiguration.workspace.datastore is required" .Values.vsphere.cloudProviderConfiguration.workspace.datastore }}
folder: {{ .Values.vsphere.cloudProviderConfiguration.workspace.folder }}
resourcePool: {{ .Values.vsphere.cloudProviderConfiguration.workspace.resourcePool }}
server: {{ .Values.vsphere.server }}
{{- end -}}

{{- define "capi-vsphere.kubeadmControlPlaneName" -}}
{{- printf "%s-control-plane" (include "capi-vsphere.name" .) |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-vsphere.crsCSIName" -}}
{{- printf "%s-crs" (include "capi-vsphere.name" .) |
    trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-vsphere.crsCSIClusterRoleName" -}}
{{- printf "%s-clusterrole" (include "capi-vsphere.crsCSIName" .) |
    trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-vsphere.crsCSIClusterRoleBindingName" -}}
{{- printf "%s-clusterrolebinding" (include "capi-vsphere.crsCSIName" .) |
    trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-vsphere.crsCSIServiceAccountName" -}}
{{- printf "%s-serviceaccount" (include "capi-vsphere.crsCSIName" .) |
    trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-vsphere.crsCSIDriverName" -}}
{{- printf "%s-driver-name" (include "capi-vsphere.crsCSIName" .) |
    trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-vsphere.crsCSIControllerDeploymentName" -}}
{{- printf "%s-controller" (include "capi-vsphere.crsCSIName" .) |
    trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-vsphere.crsCSINodeName" -}}
{{- printf "%s-node" (include "capi-vsphere.crsCSIName" .) |
    trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-vsphere.crsCSIInternalFeatureStateName" -}}
{{- printf "%s-internal-feature-states" (include "capi-vsphere.crsCSIName" .) |
    trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-vsphere.crsCSIConfigName" -}}
{{- printf "%s-config" (include "capi-vsphere.crsCSIName" .) |
    trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-vsphere.crsCSIStorageClassName" -}}
{{- printf "%s-sc" (include "capi-vsphere.crsCSIName" .) |
    trunc 63 | trimSuffix "-" -}}
{{- end -}}

