'  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'  ³       Programm: CREATE.BAS                                       ³
'  ³                                                                  ³
'  ³   Beschreibung: Beispielprogramm fr PowerISAM                   ³
'  ³                 zum Erstellen einer ISAM-Datei                   ³
'  ³                                                                  ³
'  ³        Sprache: PowerBASIC  Version 2.10  und 3.0                ³
'  ³                                                                  ³
'  ³          Autor: Thomas Reichardt                                 ³
'  ³                                                                  ³
'  ³          Stand: Februar 1993                                     ³
'  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
$LIB ALL OFF

$INCLUDE "ISAMPB.H"
$INCLUDE "ISAMPBC.H"

  cls
  print "Beispielprogramm zum Erstellen einer ISAM-Datei  "+_
	"(C) Thomas Reichardt 1993"
  print

'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º  Dimensionierungen                                                   º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

dim dynamic KeyLengths%(0:16)    'Keyl„ngen
dim dynamic KeyCounts&(1:16)     'Anzahl Keys
dim dynamic SortFlags$(1:16)     'Sortierflags

'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º            ******  Aufbau der šbergabeparameter  ******              º
'º                                                                      º
'º  Die Definition der ISAM-Datei CREATE.IDX und deren Datendatei       º
'º  entspricht in diesem Beispiel der Dateien KUNDEN.IDX und            º
'º  KUNDEN.IDD                                                          º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º  Globale Definitionen                                                º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

  rem gosub kunde
  rem gosub artikel
  rem gosub bestell
      gosub strasse
  end


KUNDEN:
   IsamFileName$  = "KUNDEN.IDX" 'ISAM-Dateiname
   DateFileName$  = "KUNDEN.DAT" 'Datendateiname
   CreateFlags$   = "00000000"   'Createflags
				 ' 0 0 0 0 0 0 0 0
				 ' ³ ³ ³ ³ ³ ³ ³ ÀÄ> nicht benutzt
				 ' ³ ³ ³ ³ ³ ³ ÀÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ³ ÀÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ÀÄÄÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄ> Datenbereich intern
				 ' ³ ³                                  Nein
				 ' ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄ> Datenbereich statisch
				 ' ³                                    Nein
				 ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ> Indexbereich statisch
				 '                                      Nein
   RecLength%     = 1024          'L„nge der Datens„tze
   RecCount&      = 50000        'Anzahl    Datens„tze
   KeyLengths%(0) =  4           'Anzahl Keybereiche

'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º  Definitionen fr Keybereich 1 : tel                                 º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
   KeyLengths%(1) =  24          'Keyl„nge     Keybereich 1 = 24
   KeyCounts&(1)  =  50000       'Anzahl Keys  Keybereich 1 = 5000
   SortFlags$(1)  = "01000000"   'Sortierflags Keybereich 1
				 ' 0 1 0 0 0 0 0 0
				 ' ³ ³ ³ ³ ³ ³ ³ ÀÄ> Reorg n”tig         Nein
				 ' ³ ³ ³ ³ ³ ³ ÀÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ³ ÀÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ÀÄÄÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄ> doppelte Keys       Nein
				 ' ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄ> sort absteigend     Nein
				 ' ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄ> Keys drehen         Ja
				 ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ> ndern Sortierfolge Nein

'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º  Definitionen fr Keybereich 2 :name                                 º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
   KeyLengths%(2) =  32          'Keyl„nge     Keybereich 2 = 32
   KeyCounts&(2)  =  50000       'Anzahl Keys  Keybereich 2 = 5000
   SortFlags$(2)  = "10010000"   'Sortierflags Keybereich 2
				 ' 1 0 0 1 0 0 0 0
				 ' ³ ³ ³ ³ ³ ³ ³ ÀÄ> Reorg n”tig         Nein
				 ' ³ ³ ³ ³ ³ ³ ÀÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ³ ÀÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ÀÄÄÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄ> doppelte Keys       Ja
				 ' ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄ> sort absteigend     Nein
				 ' ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄ> Keys drehen         Nein
				 ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ> ndern Sortierfolge Ja

'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º  Definitionen fr Keybereich 3  :vorname                             º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
   KeyLengths%(3) =  32          'Keyl„nge     Keybereich 3 = 15
   KeyCounts&(3)  =  50000       'Anzahl Keys  Keybereich 3 = 5000
   SortFlags$(3)  = "10010000"   'Sortierflags Keybereich 3
				 ' 1 0 0 1 0 0 0 0
				 ' ³ ³ ³ ³ ³ ³ ³ ÀÄ> Reorg n”tig         Nein
				 ' ³ ³ ³ ³ ³ ³ ÀÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ³ ÀÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ÀÄÄÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄ> doppelte Keys       Ja
				 ' ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄ> sort absteigend     Nein
				 ' ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄ> Keys drehen         Nein
				 ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ> ndern Sortierfolge Ja
'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º  Definitionen fr Keybereich 4  :kundenNR                            º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
   KeyLengths%(4) =  4           'Keyl„nge     Keybereich 4 = 15
   KeyCounts&(4) =  50000       'Anzahl Keys  Keybereich 4 = 5000
   SortFlags$(4) = "10010000"   'Sortierflags Keybereich 4
				 ' 1 0 0 1 0 0 0 0
				 ' ³ ³ ³ ³ ³ ³ ³ ÀÄ> Reorg n”tig         Nein
				 ' ³ ³ ³ ³ ³ ³ ÀÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ³ ÀÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ÀÄÄÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄ> doppelte Keys       Ja
				 ' ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄ> sort absteigend     Nein
				 ' ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄ> Keys drehen         Nein
				 ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ> ndern Sortierfolge Ja
    gosub createfile
   return
ARTIKEL:
   IsamFileName$  = "ARTIKEL.IDX" 'ISAM-Dateiname
   DateFileName$  = "ARTIKEL.DAT" 'Datendateiname
   CreateFlags$   = "00000000"   'Createflags
				 ' 0 0 0 0 0 0 0 0
				 ' ³ ³ ³ ³ ³ ³ ³ ÀÄ> nicht benutzt
				 ' ³ ³ ³ ³ ³ ³ ÀÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ³ ÀÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ÀÄÄÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄ> Datenbereich intern
				 ' ³ ³                                  Nein
				 ' ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄ> Datenbereich statisch
				 ' ³                                    Nein
				 ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ> Indexbereich statisch
				 '                                      Nein
   RecLength%     = 512          'L„nge der Datens„tze
   RecCount&      = 500          'Anzahl    Datens„tze
   KeyLengths%(0) =  2           'Anzahl Keybereiche

'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º  Definitionen fr Keybereich 1 :Nr                                   º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
   KeyLengths%(1) =  4           'Keyl„nge     Keybereich 1 = 3
   KeyCounts&(1)  =  500         'Anzahl Keys  Keybereich 1 = 5000
   SortFlags$(1)  = "01000000"   'Sortierflags Keybereich 1
				 ' 0 1 0 0 0 0 0 0
				 ' ³ ³ ³ ³ ³ ³ ³ ÀÄ> Reorg n”tig         Nein
				 ' ³ ³ ³ ³ ³ ³ ÀÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ³ ÀÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ÀÄÄÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄ> doppelte Keys       Nein
				 ' ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄ> sort absteigend     Nein
				 ' ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄ> Keys drehen         Ja
				 ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ> ndern Sortierfolge Nein

'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º  Definitionen fr Keybereich 2 :bez                                  º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
   KeyLengths%(2) =  32          'Keyl„nge     Keybereich 2 = 32
   KeyCounts&(2)  =  500         'Anzahl Keys  Keybereich 2 = 5000
   SortFlags$(2)  = "10010000"   'Sortierflags Keybereich 2
				 ' 1 0 0 1 0 0 0 0
				 ' ³ ³ ³ ³ ³ ³ ³ ÀÄ> Reorg n”tig         Nein
				 ' ³ ³ ³ ³ ³ ³ ÀÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ³ ÀÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ÀÄÄÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄ> doppelte Keys       Ja
				 ' ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄ> sort absteigend     Nein
				 ' ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄ> Keys drehen         Nein
				 ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ> ndern Sortierfolge Ja

  gosub createfile
  return
BUCHUNG:
   IsamFileName$  = "BUCHUNG.IDX" 'ISAM-Dateiname
   DateFileName$  = "BUCHUNG.DAT" 'Datendateiname
   CreateFlags$   = "00000000"   'Createflags
				 ' 0 0 0 0 0 0 0 0
				 ' ³ ³ ³ ³ ³ ³ ³ ÀÄ> nicht benutzt
				 ' ³ ³ ³ ³ ³ ³ ÀÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ³ ÀÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ÀÄÄÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄ> Datenbereich intern
				 ' ³ ³                                  Nein
				 ' ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄ> Datenbereich statisch
				 ' ³                                    Nein
				 ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ> Indexbereich statisch
				 '                                      Nein
   RecLength%     = 255          'L„nge der Datens„tze
   RecCount&      = 500          'Anzahl    Datens„tze
   KeyLengths%(0) =  1           'Anzahl Keybereiche

'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º  Definitionen fr Keybereich 1  :bestelNR                            º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
   KeyLengths%(1) =  4           'Keyl„nge     Keybereich 1 = 3
   KeyCounts&(1)  =  500       'Anzahl Keys  Keybereich 1 = 5000
   SortFlags$(1)  = "01000000"   'Sortierflags Keybereich 1
				 ' 0 1 0 0 0 0 0 0
				 ' ³ ³ ³ ³ ³ ³ ³ ÀÄ> Reorg n”tig         Nein
				 ' ³ ³ ³ ³ ³ ³ ÀÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ³ ÀÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ³ ÀÄÄÄÄÄÄÄ> nicht benutzt
				 ' ³ ³ ³ ÀÄÄÄÄÄÄÄÄÄ> doppelte Keys       Nein
				 ' ³ ³ ÀÄÄÄÄÄÄÄÄÄÄÄ> sort absteigend     Nein
				 ' ³ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄ> Keys drehen         Ja
				 ' ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ> ndern Sortierfolge Nein

   gosub createfile
   return
CREATEFILE:
'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º  Generieren UmsetzTabelle 1                                          º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
   ChangeTab1$=string$(256,chr$(0))
   for char=1 to 255
     mid$(ChangeTab1$,char+1,1)=chr$(char)
   next char
   ChangeTab1$ = ucase$(ChangeTab1$)

'  Flexiblere M”glichkeiten hat man mit dem REPLACE-Befehl von PowerBASIC,
'  da man auch Zeichen erfassen kann, die von der UCASE-Funktion nicht
'  untersttzt werden.
'
'  replace ANY "abcdefghijklmnopqrstuvwxyz„”‘† •" with _
'	       "ABCDEFGHIJKLMNOPQRSTUVWXYZš™’AO" in ChangeTab1$


'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º  Generieren UmsetzTabelle 2                                          º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
   ChangeTab2$=string$(120,chr$(0))
   mid$(ChangeTab2$,1) = ""        '  '' soll wie 'AE' sortiert werden
   mid$(ChangeTab2$,2) = "AE"
   mid$(ChangeTab2$,5) = "™"        '  '™' soll wie 'OE' sortiert werden
   mid$(ChangeTab2$,6) = "OE"
   mid$(ChangeTab2$,9) = "š"        '  'š' soll wie 'UE' sortiert werden
   mid$(ChangeTab2$,10)= "UE"
   mid$(ChangeTab2$,13)= "á"        '  'á' soll wie 'SS' sortiert werden
   mid$(ChangeTab2$,14)= "SS"
   mid$(ChangeTab2$,41)= ""        '  '' soll wie 'AA' sortiert werden
   mid$(ChangeTab2$,42)= "AA"

'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º  Prozedur IsamCreateFile   ausfhren                                 º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
   call IsamCreateFile(IsamFileName$,  _
		       DateFileName$,  _
		       CreateFlags$,   _
		       RecLength%,     _
		       RecCount&,      _
		       KeyLengths%(),  _
		       KeyCounts&(),   _
		       SortFlags$(),   _
		       ChangeTab1$,    _
		       ChangeTab2$,    _
		       rc%)
   if rc% then Fehler

   print "Fertig"
return

Fehler:
   beep
   print

'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
'º  Fehlerausgabe mit IsamInfoErrorCreate                               º
'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
   call IsamInfoErrorCreate(rc%,f$,dummy%)
   print
   print "Fehler ";rc%;" ---> ";f$
   end

