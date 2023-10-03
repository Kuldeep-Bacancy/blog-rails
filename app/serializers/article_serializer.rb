class ArticleSerializer
  include JSONAPI::Serializer
  attributes :title, :content, :slug, :user_id

  attribute :image do |record|
    record.image.url || ''
  end
end
