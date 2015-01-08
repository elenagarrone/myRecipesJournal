class Recipe

  include DataMapper::Resource

  has n, :tags, :through => Resource
  
  property :id,     Serial
  property :title,  String
  property :ingredients, Text
  property :description, Text

end
