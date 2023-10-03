class ArticleSerializer
  include JSONAPI::Serializer
  attributes :title, :content, :slug


  attribute :image do |record|
    record.image.url || ""
  end
end
