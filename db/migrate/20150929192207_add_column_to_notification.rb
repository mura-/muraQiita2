class AddColumnToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :reference_url, :string
  end
end
