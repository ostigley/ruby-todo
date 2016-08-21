# require 'spec_helper'
require 'rails_helper'

describe ToDosController do 
	describe "GET new" do
		it 'renders the template' do
			get :new
			expect(response).to render_template('new')
		end

		it 'assigns instance variables' do 
			todo = ToDo.new
			projects = Project.all

			get :new
			expect(assigns(:projects)).to eq(projects)
			expect(assigns(:to_do).id).to eq(todo.id)
		end
	end

	describe "GET index" do
		it 'renders the template' do
			get :index
			expect(response).to render_template('index')
		end

		it "assigns @to_dos and @ projects" do
			project = create(:project)
			# arrange
			todos = ToDo.all
			projects = Project.all
			# act
			get :index
			expect(assigns(:to_dos)).to eq(todos)
			expect(assigns(:projects)).to eq(projects)
		end

		it "assigns @projects" do 

		end
	end

	describe "Adding a todo" do 
		FactoryGirl.define do
			factory :project do
		    name "kitchen"
		  end
		end


		total_todos = ToDo.all.length
		new_todo = { 
			to_do: {
				"task": "Clean the kitchen", 
				"project_id": "1"
			}
		}

		it "adds one todo to the database and redirects" do
			project = create(:project)
			post(:create, params: new_todo)
			expect(ToDo.all.length).to eq(total_todos+1)
		end

		it "redirects to to_dos path" do 
		end

	end

end

