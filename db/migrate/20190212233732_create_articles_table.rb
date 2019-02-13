class CreateArticlesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :headline
      t.text :snippet
      t.text :source
      t.text :credit
      t.text :url
      t.string :users_title
    end
  end
end
