require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
    render_views

    describe "GET #index" do
        context "when user is not authenticated", authenticated: false do
            before do
                get :index
            end
            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when user is authenticated", authenticated: true do
            before do
                get :index
            end

            it { expect(response).to have_http_status(:ok) }
            it { expect(response).to render_template(:index) }
            it { expect(assigns(:categories)).to_not be_nil }
        end
    end

    describe "GET #show" do
        let(:category) { create(:category) }

        context "when user is not authenticated", authenticated: false do
            before do
                get :show, params: { id: category.id }
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when user is authenticated", authenticated: true do
            before do
                get :show, params: { id: category.id }
            end

            it { expect(response).to have_http_status(:ok) }
            it { expect(response).to render_template(:show) }
        end
    end

    describe "GET #new" do
        context "when the user is not authenticated", authenticated: false do
            before do
                get :new
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when the user is authenticated", authenticated: true do
            before do
                get :new
            end

            it { expect(response).to have_http_status(:ok) }
            it { expect(response).to render_template(:new) }
            it { expect(assigns(:category)).to be_instance_of(Category) }
        end
    end

    describe "GET #edit" do
        let(:category) { create(:category) }
        context "when the user is not authenticated", authenticated: false do
            before do
                get :edit, params: {  id: category.id }
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when the user is authenticated", authenticated: true do
            before do
                get :edit, params: { id: category.id }
            end

            it { expect(response).to have_http_status(:ok) }
            it { expect(response).to render_template(:edit) }
            it { expect(assigns(:category)).to be_instance_of(Category) }
        end
    end

    describe "POST #create" do
        context "when the user is not authenticated", authenticated: false do
            let(:params) { {category: {title: ''}} }
            before do
                post :create, params: params
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when the user is authenticated", authenticated: true do
            context "with invalid params" do
                let(:params) { {} }
                it "raises an exception" do
                    expect{ post( :create, params: params ) }.to raise_error ActionController::ParameterMissing
                end
            end
            context "with unaccepted params" do
                let(:params) { {category: {title: ''}} }
                before do
                    post :create, params: params
                end

                it { expect(response).to have_http_status(:ok) }
                it { expect(response).to render_template :new }
            end
            context "with valid params" do
                let(:params) { {category: {title: 'meats', description: 'Foods contained within the meat food group.'}} }
                before do
                    post :create, params: params
                end

                it { expect(response).to have_http_status(:redirect) }
                it { expect(response).to redirect_to category_path(assigns(:category)) }
                it { expect(controller).to set_flash[:notice] }
                it { expect(flash[:notice]).to match(/Category was successfully created./) }
            end
        end
    end

    describe "PATCH/PUT #update" do
        context "when the user is not authenticated", authenticated: false do
            let(:category) { create(:category) }
            let(:params) { {id: category.id, category: {title: ''}} }
            before do
                put :update, params: params
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when the user is authenticated", authenticated: true do
            context "with invalid params" do
                let(:category) { create(:category) }
                let(:params) { {id: category.id} }
                it "raises an exception" do
                    expect{ put( :update, params: params ) }.to raise_error ActionController::ParameterMissing
                end
            end
            context "with unaccepted params" do
                let(:category) { create(:category) }
                let(:params) { {id: category.id, category: {title: '', description: ''}} }
                before do
                    put :update, params: params
                end

                it { expect(response).to have_http_status(:ok) }
                it { expect(response).to render_template :edit}
            end
            context "with valid params" do
                let(:category) { create(:category) }
                let(:params) { {id: category.id, category: {title: 'meats', description: 'Foods contained within the meat food group.'}} }
                before do
                    put :update, params: params
                end

                it { expect(response).to have_http_status(:redirect) }
                it { expect(response).to redirect_to category_path(assigns(:category)) }
            end
        end

    end

    describe "DELETE #destroy" do
        context "when the user is not authenticated", authenticated: false do
            let(:category) { create(:category) }
            before do
                delete :destroy, params: { id: category.id }
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when the user is authenticated", authenticated: true do
            let(:category) { create(:category) }
            before do
                delete :destroy, params: { id: category.id }
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to categories_path }
        end
    end
end
