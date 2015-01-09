class Ingredient

  belongs_to :recipes

  property :id, Serial
  property :text, String

end
