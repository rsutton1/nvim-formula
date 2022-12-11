# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as nvim with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
{% set nvim_path = "/opt/nvim/current/bin/nvim" %}
{% set config_target = nvim | traverse("config:target", False) %}
{% set vimplug_install = nvim | traverse("vimplug", False) %}

include:
  - {{ sls_package_install }}

{% if config_target %}
nvim-config-file-file-managed-init-vim:
  file.recurse:
    - name: {{ config_target }}
    - makedirs: True
    - source: {{ files_switch(
                    ['nvim_config_dir']
                 )
              }}
    - require:
      - sls: {{ sls_package_install }}
{% endif %}

{% if vimplug_install != False %}
neovim_plugins_vimplug:
  cmd.run:
    - name: curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    - runas: {{ nvim.vimplug.user }}
    - require:
      - sls: {{ sls_package_install }}
      {% if config_target %}
      - nvim-config-file-file-managed-init-vim
      {% endif %}

neovim_plugins_installed:
  cmd.run:
    - name: {{ nvim_path }} --headless +PlugInstall +qa
    - runas: {{ nvim.vimplug.user }}
    - require:
      - sls: {{ sls_package_install }}
      - neovim_plugins_vimplug
      {% if config_target %}
      - nvim-config-file-file-managed-init-vim
      {% endif %}
{% endif %}
