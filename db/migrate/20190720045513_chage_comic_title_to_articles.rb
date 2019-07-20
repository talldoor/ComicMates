class ChageComicTitleToArticles < ActiveRecord::Migration[5.2]
  def up
    change_column_null :articles, :comic_title, false
  end

  def down
    change_column_null :articles, :comic_title, true
  end
end
