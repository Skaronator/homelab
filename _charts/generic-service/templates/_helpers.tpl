{{- define "generic-service.name" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}


{{- define "generic-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{- define "generic-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "generic-service.name" . }}
app.kubernetes.io/instance: {{ printf "%s-%s" .Chart.Name .Release.Name }}
{{- end }}


{{- define "generic-service.labels" -}}
{{ include "generic-service.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "generic-service.podHealthCheck" -}}
{{- with .Values.health }}
{{- if has .type (list "HTTP" "HTTPS") }}
httpGet:
  path: {{ .path }}
  port: {{ .port }}
  scheme: {{ .scheme }}
{{- end }}
{{- if has .type (list "TCP") }}
tcpSocket:
{{- /* Workaround since we cannot use the port name for tcpSockets health checks */}}
{{- range $ports := $.Values.ports  }}
{{- if eq $ports.name $.Values.health.port }}
  port: {{ $ports.containerPort }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}


