{{/*
Vault annotations
*/}}
{{- define "gnocchi.vaultAnnotations" -}}
vault.hashicorp.com/role: "{{ .Values.vault.role }}"
vault.hashicorp.com/agent-inject: "true"
vault.hashicorp.com/agent-pre-populate-only: "true"
vault.hashicorp.com/agent-inject-status: "update"
vault.hashicorp.com/secret-volume-path-secrets.conf: /etc/gnocchi/gnocchi.conf.d
vault.hashicorp.com/agent-inject-secret-secrets.conf: "{{ .Values.vault.settings_secret }}"
vault.hashicorp.com/agent-inject-template-secrets.conf: |
   {{ print "{{- with secret \"" .Values.vault.settings_secret "\" -}}" }}
   {{ print "[indexer]" }}
   {{ print "url={{ .Data.data.url }}" }}
   {{ print "[keystone_authtoken]" }}
   {{ print "password={{ .Data.data.keystone_password }}" }}
   {{ print "[storage]" }}
   {{ print "influxdb_password={{ .Data.data.influxdb_password }}" }}
   {{ print "{{- end -}}" }}
{{- end }}