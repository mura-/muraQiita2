class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, null: false    
      t.text :content, null: false
      t.boolean :is_checked, default: false
      t.timestamps null: false
    end
    add_index :notifications, [ :user_id ]
    add_foreign_key :notifications, :users
  end
end
