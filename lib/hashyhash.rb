  class HashyHash
    attr_accessor :index_table
    attr_accessor :unique_keys, :foreign_keys, :collection

    def initialize(collection, &block)
      @unique_keys = []
      @foreign_keys = []
      @collection = collection
      set_keys(&block)
      set_indices(collection)
      true
    end

    def[](value)
      @index_table[value]
    end

    def each(&block)
      @collection.each(&block)
    end

    def all
      @collection
    end

    def set_keys(&block)
      @index_table = Hash.new
      yield self
    end

    def set_indices(collection)
      collection.each do |item|
        index_new(item)
      end 
    end

    def index_new(item)
      unique_keys.each do |key|
        @index_table[key][item.send(key)] = item
      end
      foreign_keys.each do |key|
        @index_table[key][item.send(key)] ||= []
        @index_table[key][item.send(key)] << item
      end
    end

    def <<(item)
      @collection << item
      index_new(item)
    end

    def indexes
      unique_keys + foreign_keys
    end

    def method_missing(method, *args, &block)
      command = method.to_s.split('_')
      if command[0..1] == ["find", "by"]
        field = command[2..-1].join('_')
        return @index_table[field.to_sym][args[0]]
      elsif @collection.respond_to?(method)
        @collection.send(method, *args, &block)
      else
        super(method, *args, &block)
      end
    end


    # index_table[:id][1] = record
    def unique(key)
      @index_table[key] = Hash.new()
      @unique_keys << key
    end

    def foreign(key)
      @index_table[key] = Hash.new()
      @foreign_keys << key
    end

    def to_s
      "HashyHash"
    end

  end
