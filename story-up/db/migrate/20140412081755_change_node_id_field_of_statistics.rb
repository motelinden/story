class ChangeNodeIdFieldOfStatistics < ActiveRecord::Migration
  def change
  	change_column :statistics, :node_id, :integer,  null: false, default: 0
  end
end
