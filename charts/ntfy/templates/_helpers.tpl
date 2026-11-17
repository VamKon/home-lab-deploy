{{- define "ntfy.labels" -}}
app.kubernetes.io/managed-by: Helm
app.kubernetes.io/part-of: ntfy
app.kubernetes.io/instance: {{ .Release.Name }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}

{{- define "ntfy.selectorLabels" -}}
app: ntfy
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
