# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as nvim with context %}
{% set config_target = nvim | traverse("config:target", False) %}

{% if config_target %}
nvim-config-clean-file-directory:
  file.directory:
    - name: {{ config_target }}
    - clean: True
{% endif %}
