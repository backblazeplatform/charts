{{- define "backblazeplatform.common.chartLabels" -}}
backblazeplatform.io/chart: {{ include "backblazeplatform.common.format.safe" .Chart.Name }}
backblazeplatform.io/version: {{ include "backblazeplatform.common.format.safe" .Chart.Version }}
{{- end -}}



