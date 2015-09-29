class CreateHasTags < ActiveRecord::Migration
  def change
    create_table :has_tags do |t|
      t.references :article, index: true
      t.references :tag, index: true

      t.timestamps null: false
    end
    add_foreign_key :has_tags, :articles
    add_foreign_key :has_tags, :tags
  end
end
