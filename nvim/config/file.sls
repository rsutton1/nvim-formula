# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as nvim with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
{% set nvim_path = "/opt/nvim/current/bin/nvim" %}
{% set user = salt.environ.get("SUDO_USER") %}

include:
  - {{ sls_package_install }}

nvim-config-file-file-managed-init-vim:
  file.managed:
    - name: /home/{{ user }}/.config/nvim/init.vim
    - makedirs: True
    - source: {{ files_switch(['init.vim']
                 )
              }}
    - require:
      - sls: {{ sls_package_install }}

neovim_plugins_vimplug:
  cmd.run:
    - name: curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    - runas: {{ user }}
    - require:
      - sls: {{ sls_package_install }}
      - nvim-config-file-file-managed-init-vim

neovim_plugins_installed:
  cmd.run:
    - name: {{ nvim_path }} --headless +PlugInstall +qa
    - runas: {{ user }}
    - require:
      - sls: {{ sls_package_install }}
      - nvim-config-file-file-managed-init-vim
      - neovim_plugins_vimplug
