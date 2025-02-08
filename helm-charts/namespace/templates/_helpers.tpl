{{/*
Expand the name of the chart.
*/}}
{{- define "namespace.name" -}}
{{- .Release.Namespace }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "namespace.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "namespace.labels" -}}
helm.sh/chart: {{ include "namespace.chart" . }}
{{ include "namespace.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "namespace.selectorLabels" -}}
app.kubernetes.io/name: {{ include "namespace.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
