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

	FactoryGirl.define do
		factory :project do
	    name "kitchen"
	  end

	  factory :to_do do
	  	task "clean the coffee machine"
	  	project_id 1
	  end
	end
	describe "Adding a todo" do 

		new_todo = { 
			to_do: {
				"task": "Clean the kitchen", 
				"project_id": "1"
			}
		}

		it "adds one todo to the database and redirects" do
			total_todos = ToDo.all.length
			project = create(:project)
			post(:create, params: new_todo)
			expect(ToDo.all.length).to eq(total_todos+1)
			expect(response).to redirect_to(to_dos_path)
		end

		it "rejects if no task in text field" do 
			project = create(:project)
			total_todos = ToDo.all.length
			new_todo[:to_do][:task] = ""
			post(:create, params: new_todo)
			expect(ToDo.all.length).to eq(total_todos)
			expect(response).to render_template(:new)
			expect(assigns(:to_do).errors.count).to eq(2)
		end

	end

	describe "deleting a task" do
		it "deletes the task" do 
			project = create(:project)
			todo 		= create(:to_do)

			todos = ToDo.all.length
			delete :destroy, params: {id: 1}

			expect(ToDo.all.length).to eq(todos-1)
			expect(response).to redirect_to(to_dos_path)
			expect(flash[:success]).to eq('Nice Job')
			# p flash[:success]
		end
	end

end

