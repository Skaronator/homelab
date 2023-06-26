{{- define "database.name" -}}
{{- printf "%s-%s" (include "generic-service.name" . | trunc 60) "db" -}}
{{- end }}


{{- define "database.selectorLabels" -}}
app.kubernetes.io/name: {{ include "database.name" . }}
app.kubernetes.io/instance: {{ printf "%s-%s-%s" .Chart.Name .Release.Name "db" }}
{{- end }}


{{- define "database.labels" -}}
{{ include "database.selectorLabels" . }}
app.kubernetes.io/version: {{ include "extractLatest" .Values.database.image.tag }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "database.username" -}}
{{ include "generic-service.name" . }}
{{- end }}

{{- define "database.database" -}}
{{ include "generic-service.name" . }}
{{- end }}
