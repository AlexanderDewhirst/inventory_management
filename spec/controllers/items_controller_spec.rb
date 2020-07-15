require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
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
            it { expect(assigns(:items)).to_not be_nil }
        end
    end

    describe "GET #show" do
        let(:item) { create(:item) }

        context "when user is not authenticated", authenticated: false do
            before do
                get :show, params: { id: item.id }
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when user is authenticated", authenticated: true do
            before do
                get :show, params: { id: item.id }
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
            it { expect(assigns(:item)).to be_instance_of(Item) }
        end
    end

    describe "GET #edit" do
        let(:item) { create(:item) }
        context "when the user is not authenticated", authenticated: false do
            before do
                get :edit, params: {  id: item.id }
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when the user is authenticated", authenticated: true do
            before do
                get :edit, params: { id: item.id }
            end

            it { expect(response).to have_http_status(:ok) }
            it { expect(response).to render_template(:edit) }
            it { expect(assigns(:item)).to be_instance_of(Item) }
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
                let(:params) { {item: {foo: ''}} }
                before do
                    post :create, params: params
                end

                it { expect(response).to have_http_status(:ok) }
                it { expect(response).to render_template :new }
            end
            context "with valid params" do
                let(:category) { create(:category) }
                let(:params) { {item: {name: 'cucumber', price: 125, amount: 1, category_id: category.id}} }
                before do
                    post :create, params: params
                end

                it { expect(response).to have_http_status(:redirect) }
                it { expect(response).to redirect_to item_path(assigns(:item)) }
                it { expect(controller).to set_flash[:notice] }
                it { expect(flash[:notice]).to match(/Item was successfully created./) }
            end
        end
    end

    describe "PATCH/PUT #update" do
        context "when the user is not authenticated", authenticated: false do
            let(:item) { create(:item) }
            let(:params) { { id: item.id, item: {name: ''}} }
            before do
                put :update, params: params
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when the user is authenticated", authenticated: true do
            context "with invalid params" do
                let(:category) { create(:category) }
                let(:item) { create(:item, category: category) }
                let(:params) { {id: item.id} }
                it "raises an exception" do
                    expect{ put( :update, params: params ) }.to raise_error ActionController::ParameterMissing
                end
            end
            context "with unaccepted params" do
                let(:category) { create(:category) }
                let(:item) { create(:item, category: category) }
                let(:params) { {id: item.id, item: {name: 'Banana', amount: -1, price: 99}} }
                before do
                    put :update, params: params
                end

                it { expect(response).to have_http_status(:ok) }
                it { expect(response).to render_template :edit }
            end
            context "with valid params" do
                let(:category) { create(:category) }
                let(:item) { create(:item, category: category) }
                let(:params) { {id: item.id, item: {name: 'Banana', amount: 1, price: 99}} }
                before do
                    put :update, params: params
                end
                
                it { expect(response).to have_http_status(:redirect) }
                it { expect(response).to redirect_to item_path(assigns(:item)) }
                it { expect(controller).to set_flash[:notice] }
                it { expect(flash[:notice]).to match(/Item was successfully updated./) }
            end
        end
    end

    describe "DELETE #destroy" do
        context "when the user is not authenticated", authenticated: false do
            let(:item) { create(:item) }
            before do
                delete :destroy, params: { id: item.id }
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when the user is authenticated", authenticated: true do
            let(:item) { create(:item) }
            before do
                delete :destroy, params: { id: item.id }
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to items_path }
        end
    end

    describe "POST #duplicate" do
        context "when the user is not authenticated", authenticated: false do
            let(:item) { create(:item) }
            before do
                post :duplicate, params: { id: item.id }
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when the user is authenticated", authenticated: true do
            let(:item) { create(:item) }
            before do
                post :duplicate, params: { id: item.id }
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to items_path }
        end
    end
end
