#!/usr/bin/env rspec

require 'spec_helper'

describe 'systemd' do
  it { should contain_class 'systemd' }
end
