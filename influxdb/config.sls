{% from "influxdb/default.yml" import lookup, rawmap with context %}
{% set lookup = salt['grains.filter_by'](lookup, grain='os', merge=salt['pillar.get']('influxdb:lookup')) %}
{% set rawmap = salt['pillar.get']('influxdb', rawmap, merge=True) %}

{% if lookup.config_file is defined %}
influxdb_config:
    file.managed:
        - name: {{lookup.config_file}}
        - source: salt://influxdb/files/influxdb.conf.j2
        - template: jinja
        - makedirs: True
        - context:
            config: {{rawmap}}
{% endif %}
