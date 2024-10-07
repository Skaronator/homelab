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

{{- define "generic-cronjob.envs" -}}
- name: TZ
  value: Europe/Berlin
{{- range $k, $v := .Values.secretEnvs }}
{{- range $kk, $vv := $v }}
- name: {{ $kk | quote }}
  valueFrom:
    secretKeyRef:
      name: {{ include "generic-cronjob.name" $ }}
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
