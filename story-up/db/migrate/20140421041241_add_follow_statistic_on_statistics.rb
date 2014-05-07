class AddFollowStatisticOnStatistics < ActiveRecord::Migration
  def change
  	add_column :statistics, :follows, :integer, null: false, default: 0
  end
end
