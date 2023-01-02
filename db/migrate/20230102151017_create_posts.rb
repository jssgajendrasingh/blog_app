class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :subject
      t.date :publish_date
      t.integer :author_id

      t.timestamps
    end
  end
end
