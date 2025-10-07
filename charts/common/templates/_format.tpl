{{- define "backblazeplatform.common.format.name" -}}
  {{- compact . | join "-" | lower | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "backblazeplatform.common.format.component.namespace" -}}
  {{- $ := last . -}}
  {{- $component := first . -}}
  {{- default $component.name $component.namespace | list $.Values.prefix | include "backblazeplatform.common.format.name" -}}
{{- end -}}

{{- define "backblazeplatform.common.format.literal" -}}
{{ "{{ " }}{{ . }}{{ " }}" }}
{{- end -}}

{{- define "backblazeplatform.common.format.safe" -}}
  {{- regexReplaceAll "[^.a-zA-Z0-9-]+" . "-" | trimAll "-" | lower -}}
{{- end -}}
