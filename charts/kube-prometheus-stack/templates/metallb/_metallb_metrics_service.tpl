{{- define "metallb.metricsService" -}}

{{- $root := .root }}
{{- $name := .name }}
{{- $component := .component }}

{{- $svc := lookup "v1" "Service" "metallb-system" $name }}

{{- if not $svc }}

{{- $selectorKey := include "metallb.selectorKey" $root | trim }}

apiVersion: v1
kind: Service
metadata:
  name: {{ $name }}
  namespace: metallb-system
  labels:
    app: metallb
    component: {{ $component }}
spec:
  ports:
    - name: monitoring
      port: 7472
      targetPort: monitoring
  selector:
	{{- dict $selectorKey $component | toYaml | nindent 4 }}

{{- end }}

{{- end }}
