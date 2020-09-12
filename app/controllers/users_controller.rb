class UsersController < ApplicationController
  include SessionsHelper

   def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
          sign_in @user
          redirect_to @user
        else
         render 'new'
        end
    end

    def show
        @events = current_user.made_events
        @going = current_user.attended_events
        @event = current_user.made_events.build
        @upcoming = @going.upcoming
        @previous = @going.previous
    end

    private

    def user_params
        params.require(:user).permit(:username)
    end
end
