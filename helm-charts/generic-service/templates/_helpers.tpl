{{- define "generic-service.name" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "generic-service.clusterRbacName" -}}
{{- $identity := printf "%s/%s" .Release.Namespace .Release.Name -}}
{{- $prefix := printf "%s-%s" .Release.Namespace (include "generic-service.name" .) | trunc 54 | trimSuffix "-" -}}
{{- printf "%s-%s" $prefix ($identity | sha256sum | trunc 8) -}}
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

{{- define "generic-service.httpRoutePort" -}}
{{- $gatewayPortName := $.Values.gateway.port -}}
{{- range $ports := $.Values.ports  }}
{{- if eq $ports.name $gatewayPortName }}
{{- $ports.containerPort -}}
{{- end }}
{{- end }}
{{- end }}

{{- /* Copy the original routing rules, adding a header-presence match to each.
     Keep custom public rules (including rules without backends) and their order. */ -}}
{{- define "generic-service.apiKeyRules" -}}
{{- $root := .root -}}
{{- $rules := deepCopy (.rules | default list) -}}
{{- $backend := dict "name" (include "generic-service.name" $root) "port" (include "generic-service.httpRoutePort" $root | int) -}}
{{- $rules = append $rules (dict "backendRefs" (list $backend)) -}}
{{- range $rule := $rules -}}
  {{- $matches := $rule.matches | default (list (dict)) -}}
  {{- range $match := $matches -}}
    {{- $headers := $match.headers | default list -}}
    {{- range $header := $headers -}}
      {{- if eq (lower $header.name) "x-api-key" -}}
        {{- fail "gateway.publicRules must not match X-API-Key when oidc.apiKey is configured" -}}
      {{- end -}}
    {{- end -}}
    {{- $_ := set $match "headers" (append $headers (dict "name" "X-API-Key" "type" "RegularExpression" "value" ".*")) -}}
  {{- end -}}
  {{- $_ := set $rule "matches" $matches -}}
{{- end -}}
{{- toYaml $rules -}}
{{- end -}}

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
  {{- if kindIs "map" $vv }}
  valueFrom:
    {{- required "envs object values must contain valueFrom" $vv.valueFrom | toYaml | nindent 4 }}
  {{- else }}
  value: {{ $vv | quote }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}
