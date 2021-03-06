#!/usr/bin/ruby


Dir.glob(['app/views/*', 'app/views/*/*', 'app/views/*/*/*', 'app/views/*/*/*/*']).each do |file|

  if File.directory?(file)
    next
  end
  puts file

  f = File.new(file, "r")
  content = "<%
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
%>

"

  f.each_line do |line|
    content += line
  end
  f.close

  fout = File.new(file, "w")
  fout.write content
  fout.close
end
