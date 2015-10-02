class CreateUserFollows < ActiveRecord::Migration
  def change
    create_table :user_follows do |t|
      t.references :user, null: false    
      t.integer :follow_user, null: false

      t.timestamps null: false
    end
    add_foreign_key :user_follows, :users, column: "follow_user"
  end
end
