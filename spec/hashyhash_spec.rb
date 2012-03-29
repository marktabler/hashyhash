  require 'spec_helper'
  require 'ostruct'

  describe HashyHash do
    before(:each) do
      a = OpenStruct.new({id: 1, name: "foo", suit: "hearts"})
      b = OpenStruct.new({id: 2, name: "bar", suit: "spades"})
      c = OpenStruct.new({id: 3, name: "baz", suit: "hearts"})
      @collection = [a, b, c]
    end

    it "believes in truth" do
      true.should be_true
    end

    it "does not interfere with Method Missing" do
      expect do
        hashy_hash = HashyHash.new(@collection) do |h|
          h.unique :id
        end
        hashy_hash.foo_bar
      end.should raise_exception
    end

    it "establishes unique indexes via a block" do
      expect do
        hashy_hash = HashyHash.new(@collection) do |h|
          h.unique :id
          h.unique :name
        end
      end.should_not raise_exception      
    end

    it "establishes foreign keys via a block" do
      expect do
        hashy_hash = HashyHash.new(@collection) do |h|
          h.foreign :suit
        end
      end.should_not raise_exception      
    end

    it "adds one index for each key in the block" do
      hashy_hash = HashyHash.new(@collection) do |h|
        h.unique :id
        h.unique :name
      end
      hashy_hash.indexes.size.should == 2
    end

    it "adds one element for each item in the collection" do
      hashy_hash = HashyHash.new(@collection) do |h|
        h.unique :id
        h.unique :name
      end
      hashy_hash[:id].size.should == 3
    end

    it "can find_by a unique key" do
      hashy_hash = HashyHash.new(@collection) do |h|
        h.unique :id
        h.unique :name
      end
      hashy_hash.find_by_id(1) == @collection[1]
    end

    it "can find_by a foreign key" do
      hashy_hash = HashyHash.new(@collection) do |h|
        h.foreign :suit
      end
      hashy_hash.find_by_suit("hearts").should == [@collection.first, @collection.last]
    end

    it "responds to each" do
      hashy_hash = HashyHash.new(@collection) do |h|
        h.foreign :suit
      end
      counter = 0

      hashy_hash.each do |item|
        @collection[counter].should == item
        counter += 1
      end
    end

    it "responds to all" do
      hashy_hash = HashyHash.new(@collection) do |h|
        h.foreign :suit
      end
      hashy_hash.all.sort_by(&:suit).should == @collection.sort_by(&:suit)
    end

    it "accepts <<(item)" do
      hashy_hash = HashyHash.new(@collection) do |h|
        h.foreign :suit
      end
      hashy_hash << OpenStruct.new(suit: "potatoes")
      hashy_hash.all.map(&:suit).include?("potatoes").should be_true
    end

    it "returns the string 'HashyHash' when asked for to_s" do
       hashy_hash = HashyHash.new(@collection) do |h|
        h.foreign :suit
      end.to_s.should == "HashyHash"
    end


    it "delegates method missing to @collection first" do
       hashy_hash = HashyHash.new(@collection) do |h|
        h.foreign :suit
      end
      hashy_hash.size.should == 3
    end

  end