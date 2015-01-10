require 'spec_helper'

describe "Creating todo lists" do

	def create_todo_list (options={})
		options[:title] ||= "My do list"
		options[:description] ||= "This is what is what I'm doing today"

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end

	it "redirects to the todo list index page on success" do
		create_todo_list

		expect(page).to have_content("My do list")

	end

	it "returns an error if the list has no title" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today")
	end

	it "returns an error when a title is less than three characters" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: "Hi"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today")

	end

	it "returns an error when a description is less than three characters" do
		expect(TodoList.count).to eq(0)

		create_todo_list description: "hi"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("hi")
	end

end