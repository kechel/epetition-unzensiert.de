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
class PetitionenController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  before_action :authenticate_user!

  before_filter :except => [] do
    if current_user.is_admin && params[:user_id]
      @foruser = User.find(params[:user_id])
    else
      if params[:user_id] && params[:user_id].to_i != current_user.id
        raise ForbiddenException.new
      end
      @foruser = current_user
    end
  end

  before_action :set_petition, only: [:show, :edit, :update, :destroy]
  before_action :set_petition_id, only: [:jetzt_veroeffentlichen, :entzensieren, :admin_zensieren, :nicht_admin_zensieren]

  before_filter :only => [:edit, :update, :destroy] do
    if @petition.datum_veroeffentlicht
      if !current_user || !current_user.is_admin
        redirect_to browser_show_path(@petition)
        return
      end
    end
  end

  before_filter :only => [:create, :update] do
    params[:petition][:inhalt] = sanitize(params[:petition][:inhalt], :tags=>[])
    params[:petition][:titel] = sanitize(params[:petition][:titel], :tags=>[])
  end

  # GET /petitionen
  def index
    @petitionen = @foruser.petitionen.page(params[:page])
  end

  # GET /petitionen/1
  def show
  end

  # GET /petitionen/new
  def new
    @petition = @foruser.petitionen.new
  end

  # GET /petitionen/1/edit
  def edit
  end

  # POST /petitionen
  def create
    @petition = @foruser.petitionen.new(params.require(:petition).permit(:titel, :inhalt))
    @petition.datum_erstellt = DateTime.now
    @petition.datum_zuletzt_bearbeitet = DateTime.now

    if @petition.save
      redirect_to [@foruser, @petition], notice: 'Petition wurde erstellt.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /petitionen/1
  def update
    if @petition.update(params.require(:petition).permit(:titel, :inhalt))
      @petition.datum_zuletzt_bearbeitet = DateTime.now
      @petition.save
      redirect_to [@foruser, @petition], notice: 'Petition wurde gespeichert.'
    else
      render action: 'edit'
    end
  end

  def jetzt_veroeffentlichen
    if !@petition.datum_veroeffentlicht
      @petition.datum_veroeffentlicht = DateTime.now
      @petition.save!
    end

    redirect_to browser_show_path(@petition), notice: 'Petition wurde veröffentlicht und wird jetzt allen Besuchern angezeigt.'
  end

  def entzensieren
    @petition.datum_entzensiert = DateTime.now
    @petition.save
    redirect_to [@foruser, @petition]
  end
  def admin_zensieren
    @petition.ist_zensiert_von_admin = true
    @petition.save
    redirect_to [@foruser, @petition]
  end
  def nicht_admin_zensieren
    @petition.ist_zensiert_von_admin = false
    @petition.save
    redirect_to [@foruser, @petition]
  end

  # DELETE /petitionen/1
  def destroy
    @petition.destroy
    redirect_to petitionen_url, notice: 'Petition wurde gelöscht.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_petition
      @petition = @foruser.petitionen.find(params[:id])
    end
    def set_petition_id
      @petition = @foruser.petitionen.find(params[:petition_id])
    end
end
