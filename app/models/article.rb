class Article < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true

  has_many_attached :images
  belongs_to :user

  before_save :create_slug_for_article

  def create_slug_for_article
    self.slug = title.gsub(' ', '-')
  end
end
