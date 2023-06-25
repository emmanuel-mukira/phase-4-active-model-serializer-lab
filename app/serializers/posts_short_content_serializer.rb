class PostsShortContentSerializer < ActiveModel::Serializer
  attributes :id, :short_content

  def short_content
    object.content[0..39] + '...'
  end
end
