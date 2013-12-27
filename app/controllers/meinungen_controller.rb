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
class MeinungenController < ApplicationController
  before_action :authenticate_user!

  before_filter :except => [:index] do
    @petition = Petition.visible.find(params[:petition_id])
  end

  before_filter :only => [:index] do
    if current_user.is_admin && params[:user_id]
      @foruser = User.find(params[:user_id])
    else
      if params[:user_id] && params[:user_id].to_i != current_user.id
        raise ForbiddenException.new
      end
      @foruser = current_user
    end
  end

  def index
    @meinungen = @foruser.meinungen.correctorder.page(params[:page])
    @filter = params[:filter]

    if params[:filter] == 'unterstuetzer'
      @meinungen = @meinungen.for_unterstuetzer
    end
    if params[:filter] == 'dagegen'
      @meinungen = @meinungen.for_dagegen
    end
    if params[:filter] == 'spam'
      @meinungen = @meinungen.for_spam
    end
  end

  def bin_unterstuetzer
    meine_meinung = current_user.meinungen.for_petition(@petition).first
    if !meine_meinung
      meine_meinung = current_user.meinungen.new
      meine_meinung.petition = @petition
    end
    meine_meinung.datum = DateTime.now
    meine_meinung.bin_unterstuetzer = true
    meine_meinung.bin_dagegen = false
    meine_meinung.save!

    redirect_to browser_show_path(@petition), :notice => "Diese Petition wird jetzt von Ihnen unterstützt."
  end

  def bin_dagegen
    meine_meinung = current_user.meinungen.for_petition(@petition).first
    if !meine_meinung
      meine_meinung = current_user.meinungen.new
      meine_meinung.petition = @petition
    end
    meine_meinung.datum = DateTime.now
    meine_meinung.bin_unterstuetzer = false
    meine_meinung.bin_dagegen = true
    meine_meinung.save!

    redirect_to browser_show_path(@petition), :notice => "Diese Petition wird von Ihnen nicht unterstützt."
  end

  def habe_keine_meinung
    meine_meinung = current_user.meinungen.for_petition(@petition).first
    if meine_meinung && (meine_meinung.bin_unterstuetzer || meine_meinung.bin_dagegen)
      meine_meinung.destroy
    end

    redirect_to browser_show_path(@petition), :notice => "Ihre Meinung zu dieser Petition wurde gelöscht."
  end

  def ist_spam
    meine_meinung = current_user.meinungen.for_petition(@petition).first
    if !meine_meinung
      meine_meinung = current_user.meinungen.new
      meine_meinung.petition = @petition
    end
    meine_meinung.datum = DateTime.now
    meine_meinung.ist_spam = true
    meine_meinung.save!    

    redirect_to browser_show_path(@petition), :notice => "Petition wurde als SPAM markiert."
  end

  def ist_kein_spam
    meine_meinung = current_user.meinungen.for_petition(@petition).first
    if !meine_meinung
      redirect_to browser_show_path(@petition), :notice => "Petition wurde als 'kein SPAM' markiert."
      return
    end
    if meine_meinung && !meine_meinung.bin_unterstuetzer && !meine_meinung.bin_dagegen
      meine_meinung.destroy
      redirect_to browser_show_path(@petition), :notice => "Petition wurde als 'kein SPAM' markiert."
      return
    end

    meine_meinung.datum = DateTime.now
    meine_meinung.ist_spam = false
    meine_meinung.save!    

    redirect_to browser_show_path(@petition), :notice => "Petition wurde als 'kein SPAM' markiert."
  end

end

