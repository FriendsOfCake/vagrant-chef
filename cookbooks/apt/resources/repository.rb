actions :add, :remove

def initialize(*args)
  super
  @action = :add
end

attribute :source, :kind_of => String, :name_attribute => true
attribute :key, :kind_of => String
attribute :url, :kind_of => String
