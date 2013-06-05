require 'spec_helper'

include ExactTargetSDK

describe Attributes do

  context 'a bare Attribute' do

    it { should_not be_valid }

  end

  context 'an Attribute with Name set' do

    subject { Attributes.new 'Name' => 'foo' }

    it { should be_valid }

  end

end
