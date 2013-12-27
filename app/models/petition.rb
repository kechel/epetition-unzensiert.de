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
class Petition < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :datum_erstellt
  validates_presence_of :datum_zuletzt_bearbeitet
  validates_inclusion_of :ist_zensiert, :in => [true, false]
  validates_presence_of :titel
  validates_presence_of :inhalt
  validates_uniqueness_of :titel

  validates_length_of :titel, :maximum => 200
  validates_length_of :inhalt, :maximum => 50000

  belongs_to :user
  has_many :meinungen

  scope :correctorder, -> { order('datum_veroeffentlicht desc, datum_erstellt desc, id')}
  scope :veroeffentlicht, -> { where('datum_veroeffentlicht is not null')}
  scope :zensiert, -> { where('ist_zensiert = true') }
  scope :von_admin_zensiert, -> { where('ist_zensiert_von_admin = true') }
  scope :entzensiert, -> { where('datum_entzensiert is not null') }
  scope :nicht_zensiert, -> { where('ist_zensiert = false') }
  scope :visible, -> { veroeffentlicht.nicht_zensiert }

  def self.update_cached_columns!
    Petition.all.each do |p|
      p.anzahl_unterstuetzer_cached = p.meinungen.for_unterstuetzer.count
      p.anzahl_dagegen_cached = p.meinungen.for_dagegen.count
      p.anzahl_spam_cached = p.meinungen.for_spam.count
      p.ist_zensiert = false

      if p.anzahl_spam_cached >= 2 && !p.datum_entzensiert 
        p.ist_zensiert = true
      end
      if p.user.is_spammer
        p.ist_zensiert = true
      end
      if p.ist_zensiert_von_admin
        p.ist_zensiert = true
      end
      if p.ist_zensiert && !p.datum_zensiert
        p.datum_zensiert = DateTime.now
      end
      p.save
    end
  end

  def is_visible?
    return self.veroeffentlicht && !self.ist_zensiert
  end
  def get_anzahl_unterstuetzer
    return self.anzahl_unterstuetzer_cached || self.meinungen.for_unterstuetzer.count
  end
  def get_anzahl_dagegen
    return self.anzahl_dagegen_cached || self.meinungen.for_dagegen.count
  end
  def get_anzahl_spam
    return self.anzahl_spam_cached || self.meinungen.for_spam.count
  end

end
