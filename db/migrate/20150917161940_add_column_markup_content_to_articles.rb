class AddColumnMarkupContentToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :markup_content, :text
  end
end
