# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as nvim with context %}

nvim-config-clean-file-absent:
  file.absent:
    - name: /home/{{ user }}/.config/nvim/init.vim
