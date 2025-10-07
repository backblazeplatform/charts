{{- define "backblazeplatform.common.template.flux.helm-repository" -}}
{{- $ := last . -}}
{{- $component := first . -}}

{{- $name :=  list $component.name $ | include (printf "%s.format.name" $.Chart.Name) -}}
{{- $solution := $.Values.components.flux -}}

{{- if and $component.enabled $solution.enabled }}
{{- include "backblazeplatform.common.require.api.flux.helm-repository" $ -}}
---
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: HelmRepository
metadata:
  name: {{ $name }}
  namespace: {{ $solution.namespace }}
  labels:
    {{- include (printf "%s.labels" $.Chart.Name) $ | nindent 4 }}
    {{- include "backblazeplatform.common.chartLabels" $ | nindent 4 }}
spec:
  interval: {{ default $solution.interval $component.interval }}
  url: {{ $component.url }}
{{- end }}

{{- end }}
