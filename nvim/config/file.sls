# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as nvim with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
{% set config_target = nvim | traverse("config:target", False) %}
{% set vimplug_install = nvim | traverse("vimplug", False) %}

nvim-config-file-file-managed-init-vim:
  file.recurse:
    - name: {{ config_target }}
    - makedirs: True
    - source: {{ files_switch(
                    ['nvim_config_dir']
                 )
              }}
