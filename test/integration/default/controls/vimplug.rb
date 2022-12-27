# frozen_string_literal: true

control 'nvim.vimplug.sensible' do
  title 'The neovim sensible plugin should be installed'

  describe directory('/home/kitchen/.local/share/nvim/plugged/vim-sensible') do
    its('mode') { should cmp '0755' }
  end
end
