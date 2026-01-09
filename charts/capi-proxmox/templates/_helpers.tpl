{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "capi-proxmox.name" -}}
{{- $name:= default .Release.Name .Values.nameOverride -}}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "capi-proxmox.controlPlaneUsers" -}}
{{- $users:= default .Values.users .Values.kubeadmControlPlane.users -}}
{{- if and (kindIs "slice" $users) (eq (len $users) 0) }}
{{- fail "At least some user must be defined at .Values.users or .Values.kubeadmControlPlaneName.users" -}}
{{- end -}}
{{- toYaml (dict "users" $users) -}}
{{- end -}}

{{- define "capi-proxmox.kubeadmConfigUsers" -}}
{{- $users:= default .Context.Values.users .KubeadmConfigTemplate.users -}}
{{- if and (kindIs "slice" $users) (eq (len $users) 0) }}
{{- fail (printf "At least some user must be defined at .Values.users or .Values.kubeadmConfigTemplates[%d].users"
      .Index ) -}}
{{- end -}}
{{- toYaml (dict "users" $users) -}}
{{- end -}}

{{/*
Returns a machineDeploymentName from object because its always used inside a
range iteration
*/}}
{{- define "capi-proxmox.machineDeploymentName" -}}
{{- $machineName:= required (
      printf "name is required for .Values.machineDeployments.%d" .Index)
      .MachineDeployment.name -}}
{{- printf "%s-%s" (include "capi-proxmox.name" .Context) $machineName |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "capi-proxmox.findTemplate" -}}
{{- $name := .name -}}
{{- $found := false -}}
{{- range $item := .Context.Values.machineTemplates }}
  {{- if and (kindIs "map" $item) (eq $item.name $name) }}
    {{- $found = true -}}
  {{- end }}
{{- end }}
{{- if not $found  }}
  {{- fail (printf "An object named %s must exist in .Values.machineTemplates"
        .name) -}}
{{- end -}}
{{- $proxmoxMachineTemplate := dict "name" .name -}} 
{{- $object := dict "ProxmoxMachineTemplate" $proxmoxMachineTemplate
      "Context" .Context -}}
{{- include "capi-proxmox.machineTemplateName" $object -}}
{{- end -}}

{{- define "capi-proxmox.findKubeadmConfigTemplate" -}}
{{- $name := .name -}}
{{- $found := false -}}
{{- range $item := .Context.Values.kubeadmConfigTemplates }}
  {{- if and (kindIs "map" $item) (eq $item.name $name) }}
    {{- $found = true -}}
  {{- end }}
{{- end }}
{{- if not $found  }}
  {{- fail (printf "An object named %s must exist in .Values.kubeadmConfigTemplates"
        .name) -}}
{{- end -}}
{{- $proxmoxMachineTemplate := dict "name" .name -}} 
{{- $object := dict "ProxmoxMachineTemplate" $proxmoxMachineTemplate
      "Context" .Context -}}
{{- include "capi-proxmox.machineTemplateName" $object -}}
{{- end -}}

{{/*
Returns a machineTemplateName from object because its always used inside a
range iteration
*/}}
{{- define "capi-proxmox.machineTemplateName" -}}
{{- $templateName:= required (
      printf "name is required for .Values.machineDeployments[%d]" .Index)
      .ProxmoxMachineTemplate.name -}}
{{- printf "%s-%s" (include "capi-proxmox.name" .Context) $templateName |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-proxmox.kubeadmControlPlaneName" -}}
{{- printf "%s-control-plane" (include "capi-proxmox.name" .) | trunc 63 |
      trimSuffix "-" -}}
{{- end -}}

{{- define "capi-proxmox.kubeadmConfigTemplateName" -}}
{{- $templateName:= required (
      printf "name is required for .Values.kubeadmConfigTemplates[%d]" .Index)
      .KubeadmConfigTemplate.name -}}
{{- printf "%s-%s" (include "capi-proxmox.name" .Context) $templateName |
      trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "capi-proxmox.kubeadmConfigTemplate" -}}
{{- merge .Context.Values.kubeadmConfigTemplateDefaults .KubeadmConfigTemplate | toYaml }}
{{- end -}}

{{- define "capi-proxmox.kubeadmControlPlaneKind" -}}
{{- if .Values.kamaji.enabled }}
{{- printf "KamajiControlPlane" }}
{{- else -}}
{{- printf "KubeadmControlPlane" }}
{{- end -}}
{{- end -}}