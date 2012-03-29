  require 'spec_helper'
  require 'ostruct'

  describe Hashy::Index do
    before(:each) do
      a = OpenStruct.new({id: 1, name: "foo", suit: "hearts"})
      b = OpenStruct.new({id: 2, name: "bar", suit: "spades"})
      c = OpenStruct.new({id: 3, name: "baz", suit: "hearts"})
      @collection = [a, b, c]
    end

    it "believes in truth" do
      true.should be_true
    end

    it "establishes unique indexes via a block" do
      expect do
        hashy_hash = Hashy::Index.new(@collection) do |h|
          h.unique :id
          h.unique :name
        end
      end.should_not raise_exception      
    end

    it "establishes foreign keys via a block" do
      expect do
        hashy_hash = Hashy::Index.new(@collection) do |h|
          h.foreign :suit
        end
      end.should_not raise_exception      
    end
  end