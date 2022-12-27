# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as nvim with context %}

{% set nvim_basedir = nvim.install.github.install_dir %}
{% set nvim_dir = nvim_basedir ~ "/v" ~ nvim.install.github.version %}
{% set nvim_hash = nvim.install.github.source_hash %}
{% set nvim_current = nvim_basedir + "/current" %}
{% set nvim_file = nvim.install.github.file %}
{% set nvim_version = nvim.install.github.version %}
{% set bashrc_path  = nvim.install.github.bashrc_path %}

neovim_downloaded:
  archive.extracted:
    - name: {{ nvim_dir }}
    - trim_output: 0
    - source: https://github.com/neovim/neovim/releases/download/v{{ nvim_version }}/nvim-{{ nvim.install.github.suffix }}.tar.gz
    - source_hash: {{ nvim.install.github.source_hash }}
    - hide_output: True
neovim_current:
  file.symlink:
    - name: {{ nvim_current }}
    - target: "{{ nvim_dir }}/nvim-{{ nvim.install.github.suffix }}"
    - force: True
    - onchanges:
      - neovim_downloaded
neovim_installed:
  file.copy:
    - name: /usr/local/
    - recurse: True
    - source: {{ nvim_current }}
    - require:
      - neovim_current
{% if bashrc_path is defined %}
neovim_path:
  file.blockreplace:
    - name: {{ bashrc_path }}
    - content: 'export PATH="{{ nvim_current }}/bin:$PATH"'
    - marker_start: "## salt managed -- nvim start"
    - marker_end: "## salt managed -- nvim end"
    - append_if_not_found: True
    - require:
      - neovim_current
{% endif %}
