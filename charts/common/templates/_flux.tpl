{{/*
  Many of backblazeplatform's charts wrap flux CRDs. These checks ensure they are installed.
*/}}

{{/* Error message */}}
{{ define "backblazeplatform.common.require.api.flux.message" }}
  {{- "Flux is required. Install Flux: https://fluxcd.io/flux/installation" -}}
{{ end }}

{{/*
  Checks generally if API version for flux is installed. Currently only checking require CRDs.
*/}}
{{ define "backblazeplatform.common.require.api.flux.helm-release" }}
  {{ list "helm.toolkit.fluxcd.io" "HelmRelease" . | include "backblazeplatform.common.require.api.flux.base" }}
{{ end }}

{{ define "backblazeplatform.common.require.api.flux.kustomize" }}
  {{ list "kustomize.toolkit.fluxcd.io" "Kustomization" $ | include "backblazeplatform.common.require.api.flux.base" }}
{{ end }}

{{ define "backblazeplatform.common.require.api.flux.git-repository" }}
  {{ list "source.toolkit.fluxcd.io" "GitRepository" . | include "backblazeplatform.common.require.api.flux.base" }}
{{ end }}

{{ define "backblazeplatform.common.require.api.flux.helm-repository" }}
  {{ list "source.toolkit.fluxcd.io" "HelmRepository" . | include "backblazeplatform.common.require.api.flux.base" }}
{{ end }}

{{ define "backblazeplatform.common.require.api.flux.source" }}
  {{ include "backblazeplatform.common.require.api.flux.git-repository" . }}
  {{ include "backblazeplatform.common.require.api.flux.helm-repository" . }}
{{ end }}

{{ define "backblazeplatform.common.require.api.flux.all" }}
  {{ include "backblazeplatform.common.require.api.flux.helm-release" . }}
  {{ include "backblazeplatform.common.require.api.flux.kustomize" . }}
  {{ include "backblazeplatform.common.require.api.flux.source" . }}
{{ end }}


{{/*
  Checks specifically for a flux api version and resource.

  Use like `{{ include "backblazeplatform.common.require.api.flux.base" ( list "helm.toolkit.fluxcd.io" "HelmRelease" $) }}`
*/}}
{{- define "backblazeplatform.common.require.api.flux.base" }}
  {{- include "backblazeplatform.common.require.api.flux.message" . | prepend . | include "backblazeplatform.common.require.api" -}}
{{- end -}}


