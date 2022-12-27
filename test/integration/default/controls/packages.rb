# frozen_string_literal: true

control 'nvim.install' do
  title 'Check the nvim command is available'
  describe.one do
    describe directory('/opt/nvim/current/bin/nvim') do
      its('mode') { should cmp '0755' }
    end

    describe package('neovim') do
      it { should be_installed }
    end
  end
end
