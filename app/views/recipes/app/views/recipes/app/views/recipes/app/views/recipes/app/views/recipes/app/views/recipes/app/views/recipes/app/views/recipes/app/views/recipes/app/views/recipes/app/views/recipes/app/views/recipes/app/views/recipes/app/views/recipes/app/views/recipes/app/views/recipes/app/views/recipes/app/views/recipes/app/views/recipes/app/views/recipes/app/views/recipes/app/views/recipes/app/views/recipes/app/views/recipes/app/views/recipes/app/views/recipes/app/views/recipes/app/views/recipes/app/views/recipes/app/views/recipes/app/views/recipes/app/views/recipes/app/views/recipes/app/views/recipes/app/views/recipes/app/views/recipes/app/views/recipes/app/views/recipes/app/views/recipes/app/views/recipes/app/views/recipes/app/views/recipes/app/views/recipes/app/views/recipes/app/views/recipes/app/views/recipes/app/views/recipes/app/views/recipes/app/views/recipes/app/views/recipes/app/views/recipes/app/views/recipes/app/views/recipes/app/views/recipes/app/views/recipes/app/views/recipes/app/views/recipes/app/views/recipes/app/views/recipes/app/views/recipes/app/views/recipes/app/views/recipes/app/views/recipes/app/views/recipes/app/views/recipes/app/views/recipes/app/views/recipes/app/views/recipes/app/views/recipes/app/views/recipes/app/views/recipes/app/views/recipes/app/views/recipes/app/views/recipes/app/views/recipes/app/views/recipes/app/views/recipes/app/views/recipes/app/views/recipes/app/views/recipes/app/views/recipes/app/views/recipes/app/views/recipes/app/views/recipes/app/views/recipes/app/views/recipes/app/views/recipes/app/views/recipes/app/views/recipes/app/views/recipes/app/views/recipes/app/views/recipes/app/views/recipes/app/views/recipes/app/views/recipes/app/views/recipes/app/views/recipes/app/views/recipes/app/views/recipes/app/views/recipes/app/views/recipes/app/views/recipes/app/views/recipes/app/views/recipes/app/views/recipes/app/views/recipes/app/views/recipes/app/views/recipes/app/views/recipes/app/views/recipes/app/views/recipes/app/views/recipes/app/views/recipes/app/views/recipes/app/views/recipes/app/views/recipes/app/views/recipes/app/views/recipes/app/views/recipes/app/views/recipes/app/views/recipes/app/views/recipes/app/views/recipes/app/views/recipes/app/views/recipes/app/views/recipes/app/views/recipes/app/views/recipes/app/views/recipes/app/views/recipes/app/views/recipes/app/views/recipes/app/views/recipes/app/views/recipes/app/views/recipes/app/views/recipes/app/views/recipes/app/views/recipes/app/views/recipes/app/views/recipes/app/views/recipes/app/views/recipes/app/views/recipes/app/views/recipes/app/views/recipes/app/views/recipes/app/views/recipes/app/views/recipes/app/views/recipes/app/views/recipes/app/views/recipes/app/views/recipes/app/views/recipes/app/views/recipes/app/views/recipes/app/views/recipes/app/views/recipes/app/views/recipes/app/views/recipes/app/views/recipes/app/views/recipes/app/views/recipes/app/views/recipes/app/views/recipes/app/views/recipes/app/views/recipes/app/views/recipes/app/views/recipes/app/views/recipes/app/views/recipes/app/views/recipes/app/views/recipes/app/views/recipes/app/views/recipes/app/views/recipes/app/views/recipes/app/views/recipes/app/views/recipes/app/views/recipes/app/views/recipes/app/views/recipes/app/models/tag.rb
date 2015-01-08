class Tag

  include DataMapper::Resource

  has n, :recipes, :through => Resource

  property :id, Serial
  property :text, String

end
