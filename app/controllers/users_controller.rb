class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
	before_filter :correct_user,   only: [:edit, :update]
	before_filter :admin_user,     only: :destroy
	before_filter :self_delete,    only: :destroy

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:success] = "Welcome to the sample app"
			sign_in @user
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
	end

	def destroy
		@user.destroy
		flash[:success] = "User destroyed."
		redirect_to users_url
	end

	def index
		@users = User.paginate(page: params[:page])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	private
		def signed_in_user
			store_location
			redirect_to signin_url, notice: "Please sign in." unless signed_in?			
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to root_path unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end

		def self_delete
			@user = User.find(params[:id])
			redirect_to(root_path) if current_user == @user
		end
end
