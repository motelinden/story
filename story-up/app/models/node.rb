class Node < ActiveRecord::Base
	belongs_to :story
	belongs_to :user
	has_one    :statistic

	has_many :subordinates, class_name: "Node",
							foreign_key: "parent_id"
	belongs_to :parent, class_name: "Node"
	has_many :user_actions, dependent: :destroy
end
