{{/*
  Many of backblazeplatform's charts wrap istio CRDs. These checks ensure they are installed.
*/}}

{{/* Error message */}}
{{ define "backblazeplatform.common.require.api.istio.message" }}
  {{- "Istio is installed as a part of the Platform System chart: https://github.com/backblazeplatform/charts/tree/main/charts/platform-system" -}}
  {{- "\n" -}}
  {{- "Or to install Istio: https://istio.io/latest/docs/setup/install" -}}
{{ end }}

{{/*
  Checks generally if API version for flux is installed. Currently only checking require CRDs.
*/}}

{{ define "backblazeplatform.common.require.api.istio.gateway" }}
  {{ list "networking.istio.io" "Gateway" $ | include "backblazeplatform.common.require.api.istio.base" }}
{{ end }}

{{ define "backblazeplatform.common.require.api.istio.sidecar" }}
  {{ list "networking.istio.io" "Sidecar" $ | include "backblazeplatform.common.require.api.istio.base" }}
{{ end }}

{{ define "backblazeplatform.common.require.api.istio.vs" }}
  {{ list "networking.istio.io" "VirtualService" $ | include "backblazeplatform.common.require.api.istio.base" }}
{{ end }}

{{ define "backblazeplatform.common.require.api.istio.all" }}
  {{ include "backblazeplatform.common.require.api.istio.networking" . }}
{{ end }}

{{ define "backblazeplatform.common.require.api.istio.networking" }}
  {{ include "backblazeplatform.common.require.api.istio.vs" . }}
  {{ include "backblazeplatform.common.require.api.istio.sidecar" . }}
  {{ include "backblazeplatform.common.require.api.istio.gateway" . }}
{{ end }}

{{ define "backblazeplatform.common.require.api.istio.peer-authentication" }}
  {{ list "security.istio.io" "PeerAuthentication" $ | include "backblazeplatform.common.require.api.istio.base" }}
{{ end }}

{{ define "backblazeplatform.common.require.api.istio.authorization-policy" }}
  {{ list "security.istio.io" "AuthorizationPolicy" $ | include "backblazeplatform.common.require.api.istio.base" }}
{{ end }}

{{ define "backblazeplatform.common.require.api.istio.request-authentication" }}
  {{ list "security.istio.io" "RequestAuthentication" $ | include "backblazeplatform.common.require.api.istio.base" }}
{{ end }}

{{ define "backblazeplatform.common.require.api.istio.security" }}
  {{ include "backblazeplatform.common.require.api.istio.peer-authentication" . }}
  {{ include "backblazeplatform.common.require.api.istio.authorization-policy" . }}
  {{ include "backblazeplatform.common.require.api.istio.request-authentication" . }}
{{ end }}

{{/*
  Checks specifically for an istio api version and resource.

  Use like `{{ list "networking.istio.io" "VirtualService" $ | include "backblazeplatform.common.require.api.istio.base" }}`
*/}}
{{- define "backblazeplatform.common.require.api.istio.base" }}
  {{- include "backblazeplatform.common.require.api.istio.message" . | prepend . | include "backblazeplatform.common.require.api" -}}
{{- end -}}

