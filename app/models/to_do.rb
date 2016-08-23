class ToDo < ApplicationRecord
	validates :task, presence: true, length: {minimum: 5}
	validates :user_id, presence: true
	belongs_to :project
	belongs_to :user
end
