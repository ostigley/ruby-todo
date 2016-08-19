class Project < ApplicationRecord
	validates :name, presence: true
	has_many :to_do
end
