# require 'spec_helper'
require 'rails_helper'

FactoryGirl.define do
  factory :user do
    email "oliver@email.com"
    password "password123"
  end
  factory :project do
    name "kitchen"
	end

  factory :to_do do
  	task "clean the coffee machine"
  	project_id 1
  	user_id 1
  end
end



describe ToDosController do 

	before do
		@user = create(:user)
	end
	describe "GET new" do

		it 'renders the template' do
			sign_in @user
			get :new
			expect(response).to render_template('new')
		end

		it 'assigns instance variables' do 
			sign_in @user
			todo = ToDo.new
			projects = Project.all
			users = User.all

			get :new
			expect(assigns(:projects)).to eq(projects)
			expect(assigns(:to_do).id).to eq(todo.id)
			expect(assigns(:users)).to eq(users)
		end
	end

	describe "GET index" do
		it 'renders the template' do
			sign_in @user
			get :index
			expect(response).to render_template('index')
		end

		it 'assigns instance variables' do
			sign_in @user
			project = create(:project)
			# arrange
			todos = ToDo.all
			projects = Project.all
			users = User.all
			# act
			get :index
			expect(assigns(:to_dos)).to eq(todos)
			expect(assigns(:projects)).to eq(projects)
			expect(assigns(:users)).to eq(users)
		end

		it "assigns @projects" do 

		end
	end

	describe "Adding a todo" do 

		new_todo = { 
			to_do: {
				"task": "Clean the kitchen", 
				"project_id": "1",
				"user_id": "1"
			}
		}

		it "adds one todo to the database and redirects" do
			sign_in @user
			total_todos = ToDo.all.length
			project = create(:project)
			post(:create, params: new_todo)
			expect(ToDo.all.length).to eq(total_todos+1)
			expect(response).to redirect_to(to_dos_path)
		end
		
		it "rejects if no user is assigned the tast" do 
			sign_in @user
			total_todos = ToDo.all.length
			project = create(:project)
			post(:create, params: {"to_do": {"task": "wash", "project_id": "1"}})
			expect(ToDo.all.length).to eq(total_todos)
			expect(response).to render_template(:new)
			expect(assigns(:to_do).errors.count).to eq(2)
		end

		it "rejects if no task in text field" do 
			sign_in @user
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
			sign_in @user
			project = create(:project)
			todo 		= create(:to_do)

			todos = ToDo.all.length
			delete :destroy, params: {id: 1}

			expect(ToDo.all.length).to eq(todos-1)
			expect(response).to redirect_to(to_dos_path)
			expect(flash[:success]).to eq('Nice job')
			# p flash[:success]
		end
	end

end

