{{- define "restic-backup.name" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}


{{- define "extractLatest" -}}
{{- $split := splitList ":" . -}}
{{- $split := splitList "@" (index $split 0) -}}
{{- index $split 0 | trunc 63 | quote -}}
{{- end -}}


{{- define "restic-backup.selectorLabels" -}}
app.kubernetes.io/name: {{ include "restic-backup.name" . }}
app.kubernetes.io/instance: {{ printf "%s-%s" .Chart.Name .Release.Name }}
{{- end }}


{{- define "restic-backup.labels" -}}
{{ include "restic-backup.selectorLabels" . }}
app.kubernetes.io/version: {{ include "extractLatest" .Values.image.tag }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "restic-backup.envs" -}}
- name: TZ
  value: Europe/Berlin
{{- range $k, $v := .Values.secretEnvs }}
{{- range $kk, $vv := $v }}
- name: {{ $kk | quote }}
  valueFrom:
    secretKeyRef:
      name: {{ include "restic-backup.name" $ }}
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
