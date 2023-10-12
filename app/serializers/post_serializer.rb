class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :image, :created_at_formatted

  belongs_to :user

  def created_at_formatted
    object.created_at.strftime('%Y/%m/%d %H:%M')
  end
end
