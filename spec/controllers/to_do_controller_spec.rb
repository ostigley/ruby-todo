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

		it "assignes @to_dos" do
			# arrange
			todo = ToDo.all
			# act
			get :index
			expect(assigns(:to_dos)).to eq(todo)
		end
	end
end

