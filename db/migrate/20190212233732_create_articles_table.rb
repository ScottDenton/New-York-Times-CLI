class CreateArticlesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :snippet
      t.text :search_query
    end
  end
end
