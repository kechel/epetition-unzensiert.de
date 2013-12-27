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
  def newline2br(str)
    if !str
      return ''
    end
    return str.gsub("\n", "<br/>").html_safe
  end

  def datetime_format_long_wochentag(datum)
    if datum
      ret = I18n.localize(datum, :format => "%A") + ", " + datum.strftime("%1d. ") + I18n.localize(datum, :format => "%B") + datum.strftime(" %Y") + datum.strftime(" %H:%M")
    end
    ret
  end

  def date_format(datum)
    if datum
      datum.strftime("%d.%m.%Y")
    end
  end

  def datetime_format(datum)
    if datum
      datum.strftime("%d.%m.%Y %H:%M")
    end
  end

  def time_format(datum)
    if datum
      datum.strftime("%H:%M")
    end
  end

  def date_format_sql(datum)
    if datum
      datum.strftime("%Y-%m-%dT%H:%M:%S")
    end
  end
end
