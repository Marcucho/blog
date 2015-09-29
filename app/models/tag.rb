class Tag < ActiveRecord::Base
	validates :name, presence: true
	has_many :has_tag
	has_many :articles , through: :has_tag
end
