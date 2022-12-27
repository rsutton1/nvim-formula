# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as nvim with context %}

neovim_plugins_vimplug:
  cmd.run:
    - name: curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    - runas: {{ nvim.vimplug.user }}

neovim_plugins_installed:
  cmd.run:
    - name: nvim --headless +PlugInstall +qa
    - runas: {{ nvim.vimplug.user }}
    - prepend_path: "/opt/nvim/current/bin"
    - require:
      - neovim_plugins_vimplug
