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
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ForbiddenException, :with => :forbidden403
  rescue_from NotFoundException, :with => :notfound404
  rescue_from ActiveRecord::RecordNotFound, :with => :notfound404

  def admin_only!
    if !current_user || !current_user.is_admin
      raise ForbiddenException.new
    end
  end

  def loggedin_only!
    if !current_user
      raise ForbiddenException.new
    end
  end

    # please don't call this function directly
    # gets called from global rescue_from NotFoundException in ApplicationController
    def forbidden403
      Rails.logger.info "********************************************************************"
      Rails.logger.info "*                         403 Forbidden                            *"
      Rails.logger.info "********************************************************************"
      # force html ignoring requested type -> no respond_to and not format.html
      render :file => File.join(Rails.public_path, '403.partial'), :formats => [:html], :status => 404, :layout => 'application', :content_type => 'text/html'
    end

    # please don't call this function directly
    # gets called from global rescue_from NotFoundException in ApplicationController
    def notfound404
      Rails.logger.info "********************************************************************"
      Rails.logger.info "*                         404 Not Found                            *"
      Rails.logger.info "********************************************************************"
      # force html ignoring requested type -> no respond_to and not format.html
      render :file => File.join(Rails.public_path, '404.partial'), :formats => [:html], :status => 404, :layout => 'application', :content_type => 'text/html'
    end
end
