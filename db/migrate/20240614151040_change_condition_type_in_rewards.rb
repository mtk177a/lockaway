class ChangeConditionTypeInRewards < ActiveRecord::Migration[7.1]
  def up
    change_column :rewards, :condition_type, :integer, using: 'condition_type::integer'

    Reward.where(condition_type: 'continuous_days').update_all(condition_type: 0)
    Reward.where(condition_type: 'total_days').update_all(condition_type: 1)
  end

  def down
    change_column :rewards, :condition_type, :string

    Reward.where(condition_type: 0).update_all(condition_type: 'continuous_days')
    Reward.where(condition_type: 1).update_all(condition_type: 'total_days')
  end
end
