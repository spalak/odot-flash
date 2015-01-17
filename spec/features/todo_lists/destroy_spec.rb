require 'spec_helper'

describe "Deleting todo lists" do

	let!(:todo_list) {TodoList.create(title: "Groceries", description: "My grocery list")}

	it "is successful when clicking destroy link" do
		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Destroy"
		end


		expect(page).to have_content("Todo list was successfully destroyed")
	
	end

	
end
