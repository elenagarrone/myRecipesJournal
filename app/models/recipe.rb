class Recipe

  include DataMapper::Resource

  property :id,     Serial
  property :title,  String
  property :ingredients, Text
  property :description, Text

end
