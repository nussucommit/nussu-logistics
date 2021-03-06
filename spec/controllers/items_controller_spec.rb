# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe 'GET #index' do
    it 'redirects when unauthenticated' do
      get :index
      should redirect_to new_user_session_path
    end
    it 'renders when authenticated' do
      user = create(:user)
      sign_in user
      get :index
      should respond_with :ok
    end
  end

  # Should be done once item edit view is implemented
  # describe 'GET #edit' do
  #   it 'redirects when unauthenticated' do
  #     get :edit, params: { id: create(:item).id }
  #     should redirect_to(new_user_session_path)
  #   end
  #   it 'denies access when normal user edit the item parameters' do
  #     user = create(:user)
  #     sign_in user
  #     expect do
  #       get :edit, params: { id: create(:item).id }
  #     end.to raise_error(CanCan::AccessDenied)
  #   end
  #   it 'provides access to admin' do
  #     admin = create(:user)
  #     user.add_role(:admin)
  #     sign_in user
  #     get :edit, params: { id: create(:item).id }
  #     should respond_with :ok
  #   end
  # end

  # Should be done once item new view is implemented
  # describe 'GET #new' do
  #   it 'redirects when unauthenticated' do
  #     get :new, params: { id: create(:item).id }
  #     should redirect_to(new_user_session_path)
  #   end
  #   it 'denies access when normal user create new item' do
  #     user = create(:user)
  #     sign_in user
  #     expect do
  #       get :new, params: { id: create(:item).id }
  #     end.to raise_error(CanCan::AccessDenied)
  #   end
  #   it 'provides access to admin' do
  #     admin = create(:admin)
  #     user.add_role(:admin)
  #     sign_in user
  #     get :new, params: { id: create(:item).id }
  #     should respond_with :ok
  #   end
  # end

  # Should be done once item create view is implemented
  # describe 'GET #create' do
  #   it 'redirects when unauthenticated' do
  #     get :create, params: { id: create(:item).id }
  #     should redirect_to(new_user_session_path)
  #   end
  #   it 'denies access when normal user create new items' do
  #     user = create(:user)
  #     sign_in user
  #     expect do
  #       get :create, params: { id: create(:item).id }
  #     end.to raise_error(CanCan::AccessDenied)
  #   end
  #   it 'provides access to admin' do
  #     admin = create(:user)
  #     user.add_role(:admin)
  #     sign_in user
  #     get :create, params: { id: create(:item).id }
  #     should respond_with :ok
  #   end
  # end

  describe 'GET #show' do
    it 'redirects when unauthenticated' do
        get :create, params: { id: create(:item).id }
        should redirect_to(new_user_session_path)
    end
  end
end
