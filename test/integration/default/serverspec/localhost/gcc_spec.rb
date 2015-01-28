require 'spec_helper'

describe 'GCC' do
  describe command('gcc-4.9 --version') do
    its(:stdout) { should match /4.9.\d/ }
  end
  
  describe command('g++-4.9 --version') do
    its(:stdout) { should match /4.9.\d/ }
  end
end
