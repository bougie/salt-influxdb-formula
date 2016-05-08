{% from "influxdb/default.yml" import lookup, rawmap with context %}
{% set lookup = salt['grains.filter_by'](lookup, grain='os', merge=salt['pillar.get']('influxdb:lookup')) %}
{% set rawmap = salt['pillar.get']('influxdb', rawmap, merge=True) %}

{% if lookup.package is defined %}
influxdb_repo:
    pkgrepo.managed:
        - humanname: Filebeat Repository
        {% if salt['grains.get']('os') == 'CentOS' %}
        - baseurl: {{lookup.repo_url}}
        - gpgkey: {{lookup.gpg_url}}
        {% else %}
        - name: {{lookup.repo_url}}
        - dist: stable
        - key_url: {{lookup.gpg_url}}
        {% endif %}
        - file: {{lookup.repo_file}}
        - gpgcheck: 1
        - refresh_db: True

influxdb_package:
    pkg.installed:
        - name: {{lookup.package}}
        - require:
            - pkgrepo: influxdb_repo
{% endif %}
