class ToDo < ApplicationRecord
	validates :task, presence: true, length: {minimum: 5}
end
