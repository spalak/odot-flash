class TodoList < ActiveRecord::Base
	validates :title, presence: true
	validates :title, length: { minimum: 3 }
	validates :description, length: { minimum: 3 }
	has_many :todo_items

	def has_completed_items?
		todo_items.complete.size > 0
	end

	def has_incompleted_items?
		todo_items.incomplete.size > 0
	end
end
