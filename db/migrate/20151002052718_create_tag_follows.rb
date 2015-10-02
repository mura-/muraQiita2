class CreateTagFollows < ActiveRecord::Migration
  def change
    create_table :tag_follows do |t|
      t.references :user, null: false
      t.references :tag, null: false
      t.timestamps null: false
    end
    add_foreign_key :tag_follows, :users
    add_foreign_key :tag_follows, :tags
  end
end
