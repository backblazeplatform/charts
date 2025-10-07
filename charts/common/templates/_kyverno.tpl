{{/*
  Many of backblazeplatform's charts wrap kyverno CRDs. These checks ensure they are installed.
*/}}

{{/* Error message */}}
{{ define "backblazeplatform.common.require.api.kyverno.message" }}
  {{- "Kyverno is installed as a part of the Platform System chart: https://github.com/backblazeplatform/charts/tree/main/charts/platform-system" -}}
  {{- "\n" -}}
  {{- "Or to install Kyverno: https://kyverno.io/docs/installation" -}}
{{ end }}

{{/*
  Checks generally if API version for kyverno is installed. Currently only checking require CRDs.
*/}}
{{ define "backblazeplatform.common.require.api.kyverno.cluster-policy" }}
  {{ include "backblazeplatform.common.require.api.kyverno.base" ( list "kyverno.io" "ClusterPolicy" $ ) }}
{{end}}

{{ define "backblazeplatform.common.require.api.kyverno.policy" }}
  {{ include "backblazeplatform.common.require.api.kyverno.base" ( list "kyverno.io" "Policy" $ ) }}
{{end}}


{{ define "backblazeplatform.common.require.api.kyverno.all" }}
  {{ include "backblazeplatform.common.require.api.kyverno.cluster-policy" . }}
  {{ include "backblazeplatform.common.require.api.kyverno.policy" . }}
{{ end }}


{{/*
  Checks specifically for a kyverno api version and resource.

  Use like `{{ include "backblazeplatform.common.require.api.kyverno.base" ( list "kyverno.io" "ClusterPolicy" $) }}`
*/}}
{{- define "backblazeplatform.common.require.api.kyverno.base" }}
  {{- include "backblazeplatform.common.require.api.kyverno.message" . | prepend . | include "backblazeplatform.common.require.api" -}}
{{- end -}}
