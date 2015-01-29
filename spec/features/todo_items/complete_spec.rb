require 'spec_helper'

describe "Editing todo items" do
	let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries")}
	let!(:todo_item) {todo_list.todo_items.create(content: "Milk")}

	it "is successful when a single item is marked as complete" do
		expect(todo_item.completed_at).to be_nil
		visit_todo_list(todo_list)
		within dom_id_for(todo_item) do
			click_link "Mark completed"
		end

		todo_item.reload
		expect(todo_item.completed_at).to_not be_nil

	end

	
end