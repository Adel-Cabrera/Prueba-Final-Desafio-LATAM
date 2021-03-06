class UsersController < ApplicationController
  # before_action :set_user, only: [:profile]

  load_and_authorize_resource

  def all
    @users = User.page(params[:page]).order(created_at: :desc).per(9)
  end

  def profile
    # @user = User.find_by(name: params[:name])
    @user = User.find_by(name: params[:name])
    @projects = @user.projects
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :name)
  end



end
