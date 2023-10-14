class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at_formatted, :updated_at_formatted

  belongs_to :user
  belongs_to :post

  def created_at_formatted
    object.created_at.strftime('%Y/%m/%d %H:%M')
  end

  def updated_at_formatted
    object.updated_at.strftime('%Y/%m/%d %H:%M')
  end
end
