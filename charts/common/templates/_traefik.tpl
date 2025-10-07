{{/*
  Many of backblazeplatform's charts wrap traefik CRDs. These checks ensure they are installed.
*/}}

{{/* Error message */}}
{{ define "backblazeplatform.common.require.api.traefik.message" }}
  {{- "Traefik is installed as a part of the Platform Auth chart: https://github.com/backblazeplatform/charts/tree/main/charts/platform-auth" -}}
  {{- "\n" -}}
  {{- "Or to install Traefik: https://doc.traefik.io/traefik/getting-started/install-traefik/#use-the-helm-chart" -}}
{{ end }}

{{/*
  Checks generally if API version for traefik is installed. Currently only checking require CRDs.
*/}}
{{ define "backblazeplatform.common.require.api.traefik.ingress-route" }}
  {{ include "backblazeplatform.common.require.api.traefik.base" ( list "traefik.containo.us" "IngressRoute" $ ) }}
{{ end }}

{{ define "backblazeplatform.common.require.api.traefik.all" }}
  {{ include "backblazeplatform.common.require.api.traefik.ingress-route" . }}
{{ end }}

{{/*
  Checks specifically for a traefik api version and resource.

  Use like `{{ include "backblazeplatform.common.require.api.traefik.base" ( list "traefik.containo.us" "IngressRoute" $ ) }}`
*/}}
{{- define "backblazeplatform.common.require.api.traefik.base" }}
  {{- include "backblazeplatform.common.require.api.traefik.message" . | prepend . | include "backblazeplatform.common.require.api" -}}
{{- end -}}
