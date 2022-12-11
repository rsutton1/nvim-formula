# frozen_string_literal: true

control 'nvim.vimplug.sensible' do
  title 'The required package should be installed'

  describe directory('/root/.local/share/nvim/plugged/vim-sensible') do
    its('mode') { should cmp '0755' }
  end
end
