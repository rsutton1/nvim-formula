# -*- coding: utf-8 -*-
# vim: ft=sls

{% set extend_require = [] -%}
include:
  - .install
  {%- do extend_require.append("neovim_installed") %}
  {%- do extend_require.append("neovim_plugins_vimplug") %}
  {%- if salt.config.get("nvim:config") %}
  - .config
  {%- do extend_require.append("nvim-config-file-file-managed-init-vim") %}
  {%- endif %}
  {%- if salt.config.get("nvim:vimplug") %}
  - .vimplug

extend:
  neovim_plugins_installed:
    cmd:
      - require: {{ extend_require | json }}
  {%- endif %}
