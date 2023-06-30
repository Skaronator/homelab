{{- define "generic-cronjob.name" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}


{{- define "extractLatest" -}}
{{- $split := splitList ":" . -}}
{{- $split := splitList "@" (index $split 0) -}}
{{- index $split 0 | trunc 63 | quote -}}
{{- end -}}


{{- define "generic-cronjob.selectorLabels" -}}
app.kubernetes.io/name: {{ include "generic-cronjob.name" . }}
app.kubernetes.io/instance: {{ printf "%s-%s" .Chart.Name .Release.Name }}
{{- end }}


{{- define "generic-cronjob.labels" -}}
{{ include "generic-cronjob.selectorLabels" . }}
app.kubernetes.io/version: {{ include "extractLatest" .Values.image.tag }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{- define "generic-cronjob.podHealthCheck" -}}
{{- with .Values.health }}
{{- if or (eq .type "HTTP") (eq .type "HTTPS") }}
httpGet:
  path: {{ .path }}
  port: {{ .port }}
  scheme: {{ .type }}
{{- end }}
{{- if eq .type "TCP" }}
tcpSocket:
{{- /* Workaround since we cannot use the port name for tcpSockets health checks */}}
{{- $healthPortName := .port }}
{{- range $ports := $.Values.ports  }}
{{- if eq $ports.name $healthPortName }}
  port: {{ $ports.containerPort }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
