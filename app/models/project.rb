class Project < ApplicationRecord
	validates :name, presence: true
	has_many :to_dos
	has_many :users, :through => :to_dos
end
