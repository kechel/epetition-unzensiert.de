# encoding: utf-8
# Copyright (c) 2010-2013 Jan Kechel - jan@kechel.de
# Alle Rechte vorbehalten.
#
# Dieser Source-Code  beinhaltet Komponenten aus der 
# persoenlichen  Source-Bibliothek   von  Jan Kechel.
# Sofern nicht anders schriftlich vereinbart, werden 
# Kunden  ausschliesslich  Nutzungs-Rechte  gewaehrt.
# Jegliche  Verwendung  ausser  der Ausfuehrung  des 
# Source-Codes  fuer  die  eigene Web-Anwendung  ist 
# nicht gestattet.
# Insbesondere  nicht gestattet  sind die Weitergabe
# und der Weiterverkauf des Source-Codes oder Teilen
# davon.class BuchungException < Exception

  attr_accessor :buchung, :statuscode, :ret

  def initialize(buchung, ret)
    self.buchung = buchung
    self.statuscode = ret[:statuscode]
    self.ret = ret
    puts "success: #{ret[:success]}, msg: #{ret[:msg]}, status: #{ret[:statuscode]}"
  end
end
