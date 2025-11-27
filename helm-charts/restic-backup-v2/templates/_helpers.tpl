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
{{ if hasPrefix "/srv/nvme/" (.Values.restic.path | required "Path to backup is required!") }}
- name: RESTIC_READ_CONCURRENCY
  value: "50"
{{ end }}
- name: RESTIC_PROGRESS_FPS
  value: "0.01666"
- name: RESTIC_REPOSITORY
  value: "rclone:pcloud:restic/{{ .Release.Name }}"
- name: RESTIC_CACHE_DIR
  value: /mnt/cache
  # disable warning about empty config
- name: RCLONE_CONFIG
  value: ""
- name: RCLONE_CONFIG_PCLOUD_TYPE
  value: pcloud
- name: RCLONE_CONFIG_PCLOUD_HOSTNAME
  value: eapi.pcloud.com
- name: RCLONE_BWLIMIT
  value: {{ .Values.restic.uploadSpeed }}k:off
- name: RESTIC_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "restic-backup.name" $ }}
      key: RESTIC_PASSWORD
{{- end }}
