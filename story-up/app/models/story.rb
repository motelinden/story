class Story < ActiveRecord::Base
	has_many :nodes, dependent: :destroy
	has_many :user_actions, dependent: :destroy
	has_many :statistics
	belongs_to :user
end
