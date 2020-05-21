class AddCreatorIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :creator_id, :integer
  end
end
