module ControllerAuthHelpers
    extend ActiveSupport::Concern
    included do
      let(:current_user) { FactoryBot.create(:user) }
      before do |ex|
        sign_out :user # resets any residual state
        if ex.metadata[:authenticated]
          sign_in current_user
        end
      end
    end 
  end