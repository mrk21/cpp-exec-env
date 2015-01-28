require 'spec_helper'

describe 'Base' do
  packages = %w(
    python-software-properties
    vim
    wget
    tree
    git
    subversion
    make
    autoconf
    libssl-dev
  )
  packages.each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
end
