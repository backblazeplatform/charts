{{/*
Expand the name of the chart.
*/}}
{{- define "platform-system.name" -}}
  {{- default .Chart.Name .Values.nameOverride }}
{{- end }}

{{- define "platform-system.format.name" -}}
  {{- $ := last . -}}
  {{- prepend . $.Values.prefix | initial | include "backblazeplatform.common.format.name" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "platform-system.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "platform-system.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "platform-system.labels" -}}
helm.sh/chart: {{ include "platform-system.chart" . }}
{{ include "platform-system.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "platform-system.selectorLabels" -}}
app.kubernetes.io/name: {{ include "platform-system.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "platform-system.serviceAccountName" -}}
  {{- if .Values.serviceAccount.create }}
  {{- default (include "platform-system.fullname" .) .Values.serviceAccount.name }}
  {{- else }}
  {{- default "default" .Values.serviceAccount.name }}
  {{- end }}
{{- end }}

{{- define "platform-system.require.dependencies" -}}
  {{- $ := . -}}
  {{- $kyverno := $.Values.components.kyverno -}}
  {{- $kyvernoPolicies := $kyverno.components.policies -}}
  {{- $backblazeplatformPolicies := $kyverno.components.backblazeplatformPolicies -}}
{{- if and $kyverno.enabled $kyvernoPolicies.enabled -}}
- name: {{ list $kyverno.name $kyvernoPolicies.name $ | include "platform-system.format.name" }}
{{- end }}
{{- if and $kyverno.enabled $backblazeplatformPolicies.enabled }}
- name: {{ list $kyverno.name $backblazeplatformPolicies.name $ | include "platform-system.format.name" }}
{{- end }}
{{- end }}
