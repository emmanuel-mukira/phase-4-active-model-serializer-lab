class Post < ApplicationRecord
  belongs_to :author
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  def short_content
    content.truncate(40, omission: "...")
  end
end
