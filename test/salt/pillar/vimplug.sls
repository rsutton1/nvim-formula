# -*- coding: utf-8 -*-
# vim: ft=yaml
---
nvim:
  lookup:
    master: template-master
    # Just for testing purposes
    winner: lookup
    added_in_lookup: lookup_value

  pkg:
    name: neovim
  config:
    target: /root/.config/nvim/
  vimplug:
    user: root

  # tofs:
    # The files_switch key serves as a selector for alternative
    # directories under the formula files directory. See TOFS pattern
    # doc for more info.
    # Note: Any value not evaluated by `config.get` will be used literally.
    # This can be used to set custom paths, as many levels deep as required.
    # files_switch:
    #   - default
    #   - id
    #   - roles
    #   - osfinger
    #   - os
    #   - os_family
    # All aspects of path/file resolution are customisable using the options below.
    # This is unnecessary in most cases; there are sensible defaults.
    # Default path: salt://< path_prefix >/< dirs.files >/< dirs.default >
    #         I.e.: salt://nvim/files/default
    # path_prefix: template_alt
    # dirs:
    #   files: files_alt
    #   default: default_alt
    # The entries under `source_files` are prepended to the default source files
    # given for the state
    # source_files:
    #   nvim-config-file-managed-init-vim:
    #     - 'init.vim'
    #     - 'example_alt.tmpl.jinja'

    # For testing purposes
    # source_files:
    #   nvim-config-file-file-managed:
    #     - 'example.tmpl.jinja'
    #   nvim-subcomponent-config-file-file-managed:
    #     - 'subcomponent-example.tmpl.jinja'

  # Just for testing purposes
  winner: pillar
  added_in_pillar: pillar_value