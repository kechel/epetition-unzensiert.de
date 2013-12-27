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
class StaticSitesController < ApplicationController
  before_filter :admin_only!, :except => [:show_static_site]

  def show_static_site
    if !params[:static_site_path] || params[:static_site_path] == ''
      @static_site = StaticSite.for_url('index').first
    else
      @static_site = StaticSite.for_url(params[:static_site_path]).first
    end

    if !@static_site
      raise NotFoundException.new
    end

    respond_to do |format|
      format.html
    end
  end


  # GET /static_sites
  # GET /static_sites.json
  def index
    @static_sites = StaticSite.correctorder

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @static_sites }
    end
  end

  # GET /static_sites/1
  # GET /static_sites/1.json
  def show
    @static_site = StaticSite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @static_site }
    end
  end

  # GET /static_sites/new
  # GET /static_sites/new.json
  def new
    @static_site = StaticSite.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @static_site }
    end
  end

  # GET /static_sites/1/edit
  def edit
    @static_site = StaticSite.find(params[:id])
  end

  # POST /static_sites
  # POST /static_sites.json
  def create
    @static_site = StaticSite.new(params.require(:static_site).permit(:url, :title, :description, :keywords, :html))

    respond_to do |format|
      if @static_site.save
        format.html { redirect_to @static_site, :notice => 'CMS-Seite wurde erstellt.' }
        format.json { render :json => @static_site, :status => :created, :location => @static_site }
      else
        format.html { render :action => "new" }
        format.json { render :json => @static_site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /static_sites/1
  # PUT /static_sites/1.json
  def update
    @static_site = StaticSite.find(params[:id])

    respond_to do |format|
      if @static_site.update_attributes(params.require(:static_site).permit(:url, :title, :description, :keywords, :html))
        format.html { redirect_to @static_site, :notice => 'CMS-Seite wurde gespeichert.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @static_site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /static_sites/1
  # DELETE /static_sites/1.json
  def destroy
    @static_site = StaticSite.find(params[:id])
    @static_site.destroy

    respond_to do |format|
      format.html { redirect_to static_sites_url }
      format.json { head :no_content }
    end
  end
end
