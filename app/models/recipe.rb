class Recipe

  include DataMapper::Resource

  has n, :tags, :through => Resource

  property :id,     Serial
  property :title,  String
  property :ingredients, Text
  property :description, Text

  def self.create_from_params(params)
    tags = params[:tags].split(" ").map do |tag|
      Tag.first_or_create(:text => tag)
    end

    create(:title => params[:title],
    :ingredients => params[:ingredients].gsub(', ', '   •'),
    :description => params[:description],
    :tags => tags)
  end

end
