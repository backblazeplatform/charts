{{/*
  Validate the existence of a Kubernetes API/CRD object and version.
*/}}
{{- define "backblazeplatform.common.require.api.check" -}}
  {{- $ :=  last . -}}
  {{- $api := first . -}}
  {{- $kind := rest . | first -}}
  {{- $valid := "false" -}}

  {{- range $installed := $.Capabilities.APIVersions -}}
    {{- $matchApi := hasPrefix ( printf "%s/" $api ) $installed -}}
    {{- $matchKind := hasSuffix ( printf "/%s" $kind ) $installed -}}
    {{- if and $matchApi $matchKind -}}
      {{- $valid = "true" -}}
    {{- end -}}
  {{- end -}}
  {{- $valid -}}
{{- end -}}

{{/*
  Validate the existence of a Kubernetes API/CRD object and version.

  Usage: `{{ list "Flux not installed" "helm.toolkit.fluxcd.io" "HelmRelease" $ | include "backblazeplatform.common.require.api" }}`
*/}}
{{- define "backblazeplatform.common.require.api" }}
  {{- $ :=  last . -}}
  {{- $apiMessage := first . -}}
  {{- $api := rest . | first -}}
  {{- $kind := initial . | last -}}
  {{- $helpMessage := "To disable these checks see: https://github.com/backblazeplatform/charts/tree/main/charts/common/README.md#api-validation" -}}

  {{- $valid := list $api $kind $ | include "backblazeplatform.common.require.api.check" -}}
  {{- $valid := eq $valid "true" -}}

  {{- $enabled := ((($.Values.global).backblazeplatform).validate).api -}}

  {{- if ne $enabled false -}}
    {{- if eq $valid false -}}
      {{- $message := printf "\n\nMissing API: `%s` from `%s`\n\n%s\n\n%s" $kind $api $apiMessage $helpMessage -}}
      {{- fail $message -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
