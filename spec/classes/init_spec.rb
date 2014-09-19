require 'spec_helper'
describe 'puppetdashboard' do

  context 'with defaults for all parameters' do
    it { should contain_class('puppetdashboard') }
  end
end
