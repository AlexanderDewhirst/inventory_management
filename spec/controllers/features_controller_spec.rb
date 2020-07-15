require 'rails_helper'

RSpec.describe FeaturesController, type: :controller do
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
            it { expect(assigns(:features)).to_not be_nil }
        end
    end

    describe "GET #show" do
        let(:feature) { create(:feature) }

        context "when user is not authenticated", authenticated: false do
            before do
                get :show, params: { id: feature.id }
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when user is authenticated", authenticated: true do
            before do
                get :show, params: { id: feature.id }
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
            it { expect(assigns(:feature)).to be_instance_of(Feature) }
        end
    end

    describe "GET #edit" do
        let(:feature) { create(:feature) }
        context "when the user is not authenticated", authenticated: false do
            before do
                get :edit, params: { id: feature.id }
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when the user is authenticated", authenticated: true do
            before do
                get :edit, params: { id: feature.id }
            end

            it { expect(response).to have_http_status(:ok) }
            it { expect(response).to render_template(:edit) }
            it { expect(assigns(:feature)).to be_instance_of(Feature) }
        end
    end

    describe "POST #create" do
        context "when the user is not authenticated", authenticated: false do
            let(:params) { {feature: {title: '', value: ''}} }
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
                let(:params) { {feature: {title: ''}} }
                before do
                    post :create, params: params
                end

                it { expect(response).to have_http_status(:ok) }
                it { expect(response).to render_template :new }
            end
            context "with valid params" do
                let(:params) { {feature: {title: 'color', value: 'red'}} }
                before do
                    post :create, params: params
                end

                it { expect(response).to have_http_status(:redirect) }
                it { expect(response).to redirect_to feature_path(assigns(:feature)) }
                it { expect(controller).to set_flash[:notice] }
                it { expect(flash[:notice]).to match(/Feature was successfully created./) }
            end
        end
    end

    describe "PATCH/PUT #update" do
        context "when the user is not authenticated", authenticated: false do
            let(:feature) { create(:feature) }
            let(:params) { {id: feature.id, feature: {title: '', value: ''}} }
            before do
                put :update, params: params
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when the user is authenticated", authenticated: true do
            context "with invalid params" do
                let(:feature) { create(:feature) }
                let(:params) { {id: feature.id} }
                it "raises an exception" do
                    expect{ put( :update, params: params ) }.to raise_error ActionController::ParameterMissing
                end
            end
            context "with unaccepted params" do
                let(:feature) { create(:feature) }
                let(:params) { {id: feature.id, feature: {title: '', value: "integer"}} }
                before do
                    put :update, params: params
                end

                it { expect(response).to have_http_status(:ok) }
                it { expect(response).to render_template :edit }
            end
            context "with valid params" do
                let(:feature) { create(:feature) }
                let(:params) { {id: feature.id, feature: {title: 'color', value: 'red'}} }
                before do
                    put :update, params: params
                end

                it { expect(response).to have_http_status(:redirect) }
                it { expect(response).to redirect_to feature_path(assigns(:feature)) }
            end
        end
    end

    describe "DELETE #destroy" do
        context "when the user is not authenticated", authenticated: false do
            let(:feature) { create(:feature) }
            before do
                delete :destroy, params: { id: feature.id }
            end

            it { expect(response).to have_http_status(:redirect) }
            it { expect(response).to redirect_to new_user_session_path }
        end
        context "when the user is authenticated", authenticated: true do
            context "the feature belongs to an item" do
                let(:item) { create(:item) }
                let(:feature) { create(:feature, items: [item] ) }
                before do
                    delete :destroy, params: { id: feature.id }
                end

                it { expect(response).to have_http_status(:redirect) }
                it { expect(response).to redirect_to features_path }
                it { expect(controller).to set_flash[:alert] }
                it { expect(flash[:alert]).to match(/There are items with this feature and cannot be destroyed./) }
            end
            context "the feature does not belong to any items" do
                let(:feature) { create(:feature) }
                before do
                    delete :destroy, params: { id: feature.id }
                end

                it { expect(response).to have_http_status(:redirect) }
                it { expect(response).to redirect_to features_path }
                it { expect(controller).to set_flash[:notice] }
                it { expect(flash[:notice]).to match(/Feature was successfully destroyed./) }
            end
        end
    end
end
