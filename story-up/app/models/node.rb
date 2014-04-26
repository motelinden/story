class Node < ActiveRecord::Base
	belongs_to :story
	belongs_to :user
	has_one    :statistic
	has_many   :user_actions

	has_many :subordinates, class_name: "Node",
							foreign_key: "parent_id"
	belongs_to :parent, class_name: "Node"

	# rating  0
	# reading 2
	# follows 3
end
