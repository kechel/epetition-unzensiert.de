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
class Meinung < ActiveRecord::Base
  belongs_to :user
  belongs_to :petition

  validates_presence_of :user_id
  validates_presence_of :petition_id
  validates_presence_of :datum
  validates_inclusion_of :bin_unterstuetzer, :in => [true, false]
  validates_inclusion_of :bin_dagegen, :in => [true, false]
  validates_inclusion_of :ist_spam, :in => [true, false]

  validates_uniqueness_of :user_id, :scope => :petition_id

  scope :for_petition, -> (petition_id) { where('petition_id = ?', petition_id)}
  scope :for_unterstuetzer, -> { where('bin_unterstuetzer = true')}
  scope :for_dagegen, -> { where('bin_dagegen = true')}
  scope :for_spam, -> { where('ist_spam = true')}

  scope :correctorder, -> { order('datum desc') }
end
