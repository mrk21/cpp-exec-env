require 'spec_helper'

describe 'LLVM' do
  describe command('clang --version') do
    its(:stdout) { should match /3.7.\d/ }
  end
  
  describe command('clang++ --version') do
    its(:stdout) { should match /3.7.\d/ }
  end
  
  describe 'libc++' do
    describe file('/usr/include/c++/v1/tuple') do
      it { should be_file }
    end
    
    describe file('/usr/lib/libc++.so') do
      it { should be_file }
    end
  end
end
