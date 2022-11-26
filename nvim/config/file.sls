# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as nvim with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

nvim-config-file-file-managed:
  file.managed:
    - name: {{ nvim.config }}
    - source: {{ files_switch(['example.tmpl'],
                              lookup='nvim-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ nvim.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        nvim: {{ nvim | json }}
