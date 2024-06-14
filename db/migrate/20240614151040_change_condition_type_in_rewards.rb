class ChangeConditionTypeInRewards < ActiveRecord::Migration[7.1]
  def change
    remove_column :rewards, :condition_type, :string
    add_column :rewards, :condition_type, :integer, null: false
  end
end
