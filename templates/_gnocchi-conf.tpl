{{- define "gnocchi-conf" }}
[DEFAULT]
debug = {{ .Values.conf.debug }}

[api]
max_limit = {{ .Values.conf.api.max_limit }}
auth_mode = keystone

[cors]
allowed_origin = {{ .Values.conf.cors.allowed_origin }}

[keystone_authtoken]
auth_protocol = http
auth_type = password
auth_url = {{ .Values.conf.keystone_authtoken.auth_url }}

{{- if .Values.conf.keystone_authtoken.memcached_servers }}
memcached_servers={{ join "," .Values.conf.keystone_authtoken.memcached_servers }}
{{- end }}

project_domain_name = Default
project_name = {{ .Values.conf.keystone_authtoken.project_name }}
user_domain_name = Default
username = {{ .Values.conf.keystone_authtoken.username }}
www_authenticate_uri = {{ .Values.conf.keystone_authtoken.auth_url }}

[oslo_policy]
policy_file = /etc/gnocchi/policy.json

[storage]
driver = influxdb
influxdb_host = {{ .Values.conf.storage.influxdb_host }}
influxdb_port = {{ .Values.conf.storage.influxdb_port }}
influxdb_username = {{ .Values.conf.storage.influxdb_username }}
influxdb_database = {{ .Values.conf.storage.influxdb_database }}
influxdb_batch_size = {{ .Values.conf.storage.influxdb_batch_size }}
influxdb_block_until_data_ingested = {{ .Values.conf.storage.influxdb_block_until_data_ingested }}

[oslo_middleware]
enable_proxy_headers_parsing = True

{{- end }}
