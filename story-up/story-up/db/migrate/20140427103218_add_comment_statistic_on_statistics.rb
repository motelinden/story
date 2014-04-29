class AddCommentStatisticOnStatistics < ActiveRecord::Migration
  def change
  	add_column :statistics, :comments, :integer, null: false, default: 0
  end
end
