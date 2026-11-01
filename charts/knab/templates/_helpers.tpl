{{- define "knab.labels" -}}
app.kubernetes.io/managed-by: Helm
app.kubernetes.io/part-of: knab
app.kubernetes.io/instance: {{ .Release.Name }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}

{{- define "knab.selectorLabels" -}}
app: knab
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
