require 'spec_helper'

describe "Adding todo items" do
	let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries")}
	
	

  	it "is successful with valid content" do
  		visit_todo_list(todo_list)
  		click_link "New Todo Item"

  		fill_in "Content", with: "Todo Numero 1"

  		click_button "Save"

  		expect(page).to have_content("Added todo list item.")
  		within("ul.todo_items") do
  			expect(page).to have_content("Todo Numero 1")
  		end
  	end

  	it "returns an error with less than two characters" do
  		visit_todo_list(todo_list)
  		click_link "New Todo Item"

  		fill_in "Content", with: "1"

  		click_button "Save"
  		within("div.flash") do
  			expect(page).to have_content("There was a problem adding that todo list item")
  		end
  		expect(page).to have_content("Content is too short (minimum is 2 characters)")
  	end


end