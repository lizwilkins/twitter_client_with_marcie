require 'spec_helper'

describe Friend do
  context '#initialize' do
    it 'creates an instance of Friend' do
      Friend.new(:screen_name => 'michael').should be_an_instance_of Friend
    end
  end

  context 'readers' do
    it 'returns the value of string_name' do
      Friend.new(:screen_name => 'michael').screen_name.should eq 'michael'
    end
  end

  context '==' do
    it 'compares two instances of a Friend and returns true if they are the same' do
      friend1 = Friend.new(:screen_name => 'testname')
      friend2 = Friend.new(:screen_name => 'testname')
      friend1.should eq friend2
    end
  end

end