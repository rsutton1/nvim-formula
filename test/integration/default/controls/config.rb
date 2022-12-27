# frozen_string_literal: true

control 'nvim.config.file' do
  title 'Check the config file exists'

  describe file('/home/kitchen/.config/nvim/init.vim') do
    it { should exist }
  end
end
