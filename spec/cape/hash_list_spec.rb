require 'spec_helper'
require 'cape/hash_list'

describe Cape::HashList do
  describe 'that is empty' do
    it { should be_empty }

    its(:inspect) { should == '{}' }

    its(:to_a) { should == [] }

    its(:to_hash) { should == {} }

    describe 'when values are added out of order' do
      before :each do
        subject['foo'] = 'bar'
        subject['baz'] = 'qux'
      end

      it { should == {'foo' => 'bar', 'baz' => 'qux'} }

      its(:inspect) { should == '{"foo"=>"bar", "baz"=>"qux"}' }

      its(:to_a) { should == [%w(foo bar), %w(baz qux)] }

      its(:to_hash) { should == {'foo' => 'bar', 'baz' => 'qux'} }
    end
  end

  describe 'that has values out of order' do
    subject { described_class.new 'foo' => 'bar', 'baz' => 'qux' }

    it { should == {'foo' => 'bar', 'baz' => 'qux'} }

    it 'should index the values as expected' do
      subject['foo'].should == 'bar'
      subject['baz'].should == 'qux'
    end

    describe 'when sent #clear' do
      before :each do
        subject.clear
      end

      it { should be_empty }
    end
  end
end