require 'spec_helper'

describe 'CMake' do
  describe command('cmake --version') do
    its(:stdout) { should match /3.1.\d/ }
  end
end
