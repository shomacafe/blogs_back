class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false
      t.string :title, null: false, comment: 'ブログ記事のタイトル'
      t.text :body, null: false, comment: 'ブログ記事の本文'
      t.string :image, comment: 'サムネイル画像'

      t.timestamps
    end
  end
end
