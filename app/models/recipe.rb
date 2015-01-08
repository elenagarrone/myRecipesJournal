class Recipe

  include DataMapper::Resource

  property :id,     Serial
  property :title,  String
  property :description, Text

end