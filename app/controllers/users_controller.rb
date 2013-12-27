# encoding: utf-8
#
# https://www.epetition-unzensiert.de - Web-Application to publish censored petitions.
# Copyright (C) 2013 Jan Kechel
#  
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
class UsersController < ApplicationController
  before_action :authenticate_user!

  before_filter do
    admin_only!
  end

  def ist_spammer
    @user = User.find(params[:user_id])
    @user.is_spammer = true
    @user.save
    redirect_to user_path(@user)
  end
  def ist_kein_spammer
    @user = User.find(params[:user_id])
    @user.is_spammer = false
    @user.save
    redirect_to user_path(@user)
  end

  def index
    @users = User.correctorder.page(params[:page])
    @filter = params[:filter]

    if params[:filter] == 'admin'
      @users = @users.where('is_admin = true')
    end
    if params[:filter] == 'spammer'
      @users = @users.where('is_spammer = true')
    end
    if params[:filter] == 'unconfirmed'
      @users = @users.where('confirmed_at is null')
    end
    if params[:filter] == 'locked'
      @users = @users.where('locked_at is not null')
    end
  end

  def show
    @user = User.find(params[:id])
    @petitionen = @user.petitionen.page(params[:petitionen_page])
    @meinungen = @user.meinungen.page(params[:meinungen_page])
  end
end
