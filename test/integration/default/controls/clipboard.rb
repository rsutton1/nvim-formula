# frozen_string_literal: true

control 'nvim.clipboard' do
  title 'Check clipboard is configured'
  only_if('on WSL') do
    file('/proc/version').content =~ /WSL/
  end
  describe file('/opt/nvim/current/bin/win32yank.exe') do
    it { should exist }
  end
end
