class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :comic_title
      t.string :comic_author
      t.text :overview
      t.text :detail
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
