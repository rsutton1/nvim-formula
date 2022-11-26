# frozen_string_literal: true

control 'nvim.package.install' do
  title 'The required package should be installed'

  describe directory('/opt/nvim/current/bin/nvim') do
    its('mode') { should cmp '0755' }
  end
end
