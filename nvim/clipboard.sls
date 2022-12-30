# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as nvim with context %}
{% set vimplug_install = nvim | traverse("vimplug", False) %}
{% set clipboard = nvim | traverse("clipboard", {}) %}
{% set win32yank_version = "0.0.4" %}
{% set win32yank_suffix = "x64" %}
{% set win32yank_sourcehash = "33a747a92da60fb65e668edbf7661d3d902411a2d545fe9dc08623cecd142a20" %}

{% if clipboard.win32yank is defined %}
win32yank_downloaded:
  archive.extracted:
    - name: {{ nvim.clipboard.win32yank.path }}
    - enforce_toplevel: False
    - trim_output: 0
    - source: https://github.com/equalsraf/win32yank/releases/download/v{{ win32yank_version }}/win32yank-{{ win32yank_suffix }}.zip
    - source_hash: {{ win32yank_sourcehash }}
{% endif %}
