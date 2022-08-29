class AddImageIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :image_id, :string
  end
end
