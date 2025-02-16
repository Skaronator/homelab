{{- define "generic-service.name" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}


{{- define "extractLatest" -}}
{{- $split := splitList ":" . -}}
{{- $split := splitList "@" (index $split 0) -}}
{{- index $split 0 | trunc 63 | quote -}}
{{- end -}}


{{- define "generic-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "generic-service.name" . }}
app.kubernetes.io/instance: {{ printf "%s-%s" .Chart.Name .Release.Name }}
{{- end }}


{{- define "generic-service.labels" -}}
{{ include "generic-service.selectorLabels" . }}
app.kubernetes.io/version: {{ include "extractLatest" .Values.image.tag }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{- define "generic-service.podHealthCheck" -}}
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

{{- define "generic-service.envs" -}}
{{- if .Values.database.enabled -}}
- name: TEMPLATE_DB_HOST
  value: {{ include "database.name" . }}
- name: TEMPLATE_DB_PORT
  value: {{ include "database.port" . | quote }}
- name: TEMPLATE_DB_USERNAME
  value: {{ include "database.username" . }}
- name: TEMPLATE_DB_DATABASE
  value: {{ include "database.database" . }}
- name: TEMPLATE_DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "database.name" . }}
    {{- if eq .Values.database.type "mariadb" }}
      key: userPassword
    {{- else }}
      key: rootPassword
    {{- end }}
{{- end }}
- name: TZ
  value: Europe/Berlin
{{- range $k, $v := .Values.secretEnvs }}
{{- range $kk, $vv := $v }}
- name: {{ $kk | quote }}
  valueFrom:
    secretKeyRef:
      name: {{ include "generic-service.name" $ }}
      key: {{ $kk | quote }}
{{- end }}
{{- end }}
{{- range $k, $v := .Values.envs }}
{{- range $kk, $vv := $v }}
- name: {{ $kk | quote }}
  value: {{ $vv | quote }}
{{- end }}
{{- end }}
{{- end }}
