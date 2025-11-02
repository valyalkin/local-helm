{{/*
Common secret template
Usage: {{ include "common.secret" (dict "context" . "data" .Values.secrets) }}
*/}}
{{- define "common.secret" -}}
{{- $context := .context }}
{{- $data := .data }}
{{- if $data }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "common.fullname" $context }}-secret
  labels:
    {{- include "common.labels" $context | nindent 4 }}
type: Opaque
data:
  {{- range $key, $value := $data }}
  {{ $key | kebabcase }}: {{ $value | b64enc | quote }}
  {{- end }}
{{- end }}
{{- end }}
