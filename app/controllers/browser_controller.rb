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
class BrowserController < ApplicationController
  def index
    if params[:browser_page]
      session[:browser_page] = params[:browser_page]
    end

    if current_user && current_user.is_admin && params[:sortierung] && ['effektiv_zensiert', 'entzensiert', 'admin_zensiert'].include?(params[:sortierung])
      @petitionen = Petition.page(session[:browser_page])
      if params[:sortierung] == 'effektiv_zensiert'
        @petitionen = @petitionen.zensiert
      end
      if params[:sortierung] == 'entzensiert'
        @petitionen = @petitionen.entzensiert
      end
      if params[:sortierung] == 'admin_zensiert'
        @petitionen = @petitionen.von_admin_zensiert
      end

    else
      @petitionen = Petition.visible.page(session[:browser_page])
    end

    if params[:sortierung]
      @sortierung = params[:sortierung]
      session[:browser_sortierung] = @sortierung
    else
      @sortierung = session[:browser_sortierung]
    end

    if @sortierung == 'unterstuetzer'
      @petitionen = @petitionen.order('anzahl_unterstuetzer_cached asc')
    end
    if @sortierung == 'unterstuetzer_desc'
      @petitionen = @petitionen.order('anzahl_unterstuetzer_cached desc')
    end
    if @sortierung == 'dagegen'
      @petitionen = @petitionen.order('anzahl_dagegen_cached asc')
    end
    if @sortierung == 'dagegen_desc'
      @petitionen = @petitionen.order('anzahl_dagegen_cached desc')
    end
    if @sortierung == 'alphabetisch'
      @petitionen = @petitionen.order('titel asc')
    end
    if @sortierung == 'alphabetisch_desc'
      @petitionen = @petitionen.order('titel desc')
    end    
    if @sortierung == 'spam'
      @petitionen = @petitionen.order('anzahl_spam_cached asc')
    end
    if @sortierung == 'spam_desc'
      @petitionen = @petitionen.order('anzahl_spam_cached desc')
    end
    if @sortierung == 'veroeffentlichung'
      @petitionen = @petitionen.order('datum_veroeffentlicht')
    end
    if @sortierung == 'veroeffentlichung_desc'
      @petitionen = @petitionen.order('datum_veroeffentlicht desc')
    end
  end

  def show
    @petition = Petition.find(params[:petition_id])
    if @petition.ist_zensiert
      if current_user && current_user.is_admin
        redirect_to user_petition_path(@petition.user, @petition)
        return
      end
      raise NotFoundException.new
    end
    session[:last_petition_id] = @petition.id

    if current_user
      @meine_meinung = current_user.meinungen.for_petition(@petition).first
    end
  end
end
