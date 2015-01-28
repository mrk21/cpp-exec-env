require 'spec_helper'

describe 'Boost' do
  describe file('/usr/include/boost/version.hpp') do
    it { should be_file }
    its(:content) { should match /#define BOOST_VERSION 105700/ }
  end
  
  libs = %w(
    libboost_filesystem
    libboost_regex
    libboost_system
    libboost_thread
  )
  libs.each do |lib|
    describe file("/usr/lib/#{lib}.so") do
      it { should be_file }
    end
    
    describe file("/usr/lib/#{lib}.a") do
      it { should be_file }
    end
  end
end
