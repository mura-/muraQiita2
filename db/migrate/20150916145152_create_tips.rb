class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.references :user, null: false    
      t.string :title, null: false        
      t.text :content, null: false        
      t.datetime :created_at, null: false
      t.timestamps null: false
    end
  end
end
