{{- define "database.name" -}}
{{- printf "%s-%s" (include "generic-service.name" . | trunc 60) "db" -}}
{{- end }}

{{- define "database.selectorLabels" -}}
app.kubernetes.io/name: {{ include "database.name" . }}
app.kubernetes.io/instance: {{ printf "%s-%s-%s" .Chart.Name .Release.Name "db" }}
app.kubernetes.io/type: {{ .Values.database.type }}
{{- end }}

{{- define "database.labels" -}}
{{ include "database.selectorLabels" . }}
{{- if eq .Values.database.type "mariadb" }}
app.kubernetes.io/version: {{ include "extractLatest" .Values.database.mariadb.image.tag }}
{{- else }}
app.kubernetes.io/version: {{ include "extractLatest" .Values.database.postgresql.image.tag }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "database.username" -}}
{{ include "generic-service.name" . }}
{{- end }}

{{- define "database.database" -}}
{{ include "generic-service.name" . }}
{{- end }}

{{- define "database.port" -}}
{{- if eq .Values.database.type "mariadb" -}}
  3306
{{- else if eq .Values.database.type "postgresql" -}}
  5432
{{- else -}}
  {{- fail "Unsupported database type" -}}
{{- end }}
{{- end }}
