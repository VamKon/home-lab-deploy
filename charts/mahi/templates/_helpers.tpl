{{- define "mahi.labels" -}}
app.kubernetes.io/managed-by: Helm
app.kubernetes.io/part-of: mahi
app.kubernetes.io/instance: {{ .Release.Name }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}

{{- define "mahi.selectorLabels" -}}
app: mahi
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
