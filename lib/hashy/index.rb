module Hashy
  class Index
    attr_accessor :index_table
    attr_accessor :unique_keys, :foreign_keys

    def initialize(collection, &block)
      @unique_keys = []
      @foreign_keys = []
      set_keys(&block)
      set_indices(collection)
    end

    def set_keys(&block)
      @index_table = Hash.new
      yield self
    end

    def set_indices(collection)
      collection.each do |item|
        unique_keys.each do |key|
          @index_table[key][item.send(key)] = item
        end
        foreign_keys.each do |key|
          @index_table[key][item.send(key)] << item
        end
      end 
    end

    # index_table[:id][1] = record
    def unique(key)
      @index_table[key] = Hash.new(Hash.new)
      @unique_keys << key
    end

    def foreign(key)
      @index_table[key] = Hash.new([])
      @foreign_keys << key
    end

  end
end
