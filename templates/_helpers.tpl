{{- define "common-helm-chart.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "common-helm-chart.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
