{% from "influxdb/default.yml" import lookup, rawmap with context %}
{% set lookup = salt['grains.filter_by'](lookup, grain='os', merge=salt['pillar.get']('influxdb:lookup')) %}
{% set rawmap = salt['pillar.get']('influxdb', rawmap, merge=True) %}

{% if lookup.service is defined %}
influxdb_service:
    service.running:
        - name: {{lookup.service}}
        - enable: True
{% endif %}
