# frozen_string_literal: true

control 'nvim.vimplug.sensible' do
  title 'The neovim sensible plugin should be installed'

  describe directory('/home/kitchen/.local/share/nvim/plugged/vim-sensible') do
    it { should exist }
  end
end
