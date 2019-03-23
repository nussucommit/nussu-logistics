# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'redirects when unauthenticated' do
      get :index
      should redirect_to new_user_session_path
    end
    it 'renders when authenticated' do
      sign_in create(:user)
      get :index
      should respond_with :ok
    end
  end

  describe 'GET #edit' do
    it 'redirects when unauthenticated' do
      get :edit, params: { id: create(:user).id }
      should redirect_to(new_user_session_path)
    end
    it 'denies access when normal user access another users page' do
      user = create(:user)
      sign_in user
      expect do
        get :edit, params: { id: create(:user).id }
      end.to raise_error(CanCan::AccessDenied)
    end
    it 'provides access to admin' do
      user = create(:user)
      user.add_role(:admin)
      sign_in user
      should respond_with :ok
    end
  end

  describe 'PUT #update' do
    it 'redirects when unauthenticated' do
      put :update, params: { id: create(:user).id }
      should redirect_to(new_user_session_path)
    end
    context 'normal user' do
      it 'updates password' do
        user = create(:user, password: '123456')
        sign_in user
        expect do
          put :update, params: { id: user.id, user: { password: '1234567',
                                                      confirmation_password:
                                                      '1234567',
                                                      current_password:
                                                      '123456' } }
        end.to change {
          User.find(user.id).valid_password?('1234567')
        }.from(false).to(true)
        should redirect_to(users_path)
      end
      it 'password not updated if current password wrong' do
        user = create(:user, password: '123456')
        sign_in user
        expect do
          put :update, params: { id: user.id, user: { password: '1234567',
                                                      confirmation_password:
                                                      '1234567',
                                                      current_password:
                                                      '12345678' } }
        end.to_not change {
          User.find(user.id).valid_password?('123456')
        }.from(true)
        should redirect_to(users_path)
      end
      it 'denies access when access another users page' do
        user = create(:user)
        new_user = create(:user, password: '123456')
        sign_in user
        expect do
          get :update, params: { id: new_user.id, user: { password: '1234567',
                                                          confirmation_password:
                                                          '1234567',
                                                          current_password:
                                                          '123456' } }
        end.to raise_error(CanCan::AccessDenied)
      end
    end
    context 'admin' do
      it 'updates password' do
        admin = create(:user)
        admin.add_role(:admin)
        user = create(:user, password: '123456')
        sign_in admin
        expect do
          put :update, params: { id: user.id, user: { password: '1234567',
                                                      confirmation_password:
                                                      '1234567',
                                                      current_password:
                                                      '123456' } }
        end.to change {
          User.find(user.id).valid_password?('1234567')
        }.from(false).to(true)
        should redirect_to(users_path)
      end
    end
  end

  describe 'PUT #update_roles' do
    it 'redirects when unauthenticated' do
      put :update_roles, params: { id: create(:user).id }
      should redirect_to(new_user_session_path)
    end
    context 'admin' do
      before do
        user = create(:user)
        user.add_role(:admin)
        sign_in user
      end
      it 'adds role' do
        user = create(:user)
        expect do
          put :update_roles, params: { id: user.id,
                                       Role::ROLES.last => 1 }
        end.to change {
          User.find(user.id).has_role?(Role::ROLES.last)
        }.from(false).to(true)
        should redirect_to(users_path)
      end
      it 'removes role' do
        user = create(:user)
        user.add_role(:admin)
        expect do
          put :update_roles, params: { id: user.id,
                                       admin: 0 }
        end.to change {
          User.find(user.id).has_role?(:admin)
        }.from(true).to(false)
        should redirect_to(users_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects when unauthenticated' do
      delete :destroy, params: { id: create(:user).id }
      should redirect_to new_user_session_path
    end
    it 'works when authenticated' do
      user = create(:user)
      user.add_role(:admin)
      sign_in user
      user = create(:user)
      expect do
        delete :destroy, params: { id: user.id }
      end.to change { User.count }.by(-1)
      should redirect_to users_path
    end
  end
end
