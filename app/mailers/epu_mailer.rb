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
class EpuMailer < Devise::Mailer  
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  
  def reset_password_instructions(record, token, opts={})
    data = File.read(Rails.root.join('public/bilder/epetition-unzensiert.png'))
    attachments.inline["epetition-unzensiert.png"] = data
    super
  end
  def confirmation_instructions(record, token, opts={})
    data = File.read(Rails.root.join('public/bilder/epetition-unzensiert.png'))
    attachments.inline["epetition-unzensiert.png"] = data
    super
  end
  def unlock_instructions(record, token, opts={})
    data = File.read(Rails.root.join('public/bilder/epetition-unzensiert.png'))
    attachments.inline["epetition-unzensiert.png"] = data
    super
  end
end
