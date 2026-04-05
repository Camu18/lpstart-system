' MHDR.BAS
' --------------------------------------------------------------------------
' Common Variables
' ----------------
  common cm$(1),fc$(1),cp%(1),cx%(1),cl&(1),lps%,lp$(1),wd%(1),wdl%
' -----------------
' Programm-Variable
' -----------------
  chp%=01  :' ---chainnl fr parameter
  chw%=02  :' ---chainnl fr window
  chi%=03  :' ---chainnl fr index
  chl%=05  :' ---chainnl fr lager
  chu%=06  :' ---chainnl fr user
  chk%=07  :' ---chainnl fr kunden
  cha%=08  :' ---chainnl fr ARTIKEL
  cht%=09  :' ---chainnl fr brief
  chr%=10  :' ---chainnl fr Rechnung
  chm%=11  :' ---chainnl fr bestellung
  chs%=12  :' ---chainnl fr strasse
  chc%=13  :' ---chainnl fr Arbeit
           :' ---ofs% Begin Nummer put
 xlen%=50  :' ---lang Berich von INPUT
 cx%(300)=1:' ---offset fr speichern bestellung
 dim fd$(30),px%(33),lt$(20),flg&(4),pv#(19)
' fp$(50)
' -----------------------------------------------------------------------
' Window+Index
' flg&(0)=Programm              : flg&(1)=index       : flg&(2)=input
' flg&(3)=input                 : flg&(4)=

' ------------------------------------------------------------------------
  dim wp$(20),wd$(21),wx%(20),ofs%(15),ix&(10),idl%(1),idp%(1),md%(4)
  dim wid%(9)
'--------------------------------------------------------------------------
  %mouse=1
  $include "stdio.h"
  $include "win_man.h"
  $include "dbinput.h"
  for t%=0 to 15
    get chp%,100+t%
       ofs%(t%)=cvl(mid$(fc$(chp%),46,4))
  next t%
  ix%=int(len(fc$(chi%))/4)                     :' summe record oan line
  goto main
' -------------
' Programmsende
' -------------
PEND:
    cp%(00)=cp%(00)-1
    if cp%(00)<1 then
     ATTRIB "paramet.dat",1
     ATTRIB "paramet.dat",2
     ATTRIB "window.dat",1
     ATTRIB "window.dat",2
     ATTRIB "index.dat",1
     ATTRIB "index.dat",2
     ATTRIB "c:\pb310\com.pbl",2
     close : end
    end if
    rem - Close Window
    rem - Rewrite Program Infos
    rem - Read Chain Program
    rem - Chain Program
    get chp%,cp%(cp%(0)) : cm$(chp%)=fc$(chp%)
    fd$=rtrim$(mid$(cm$(chp%),1,08))
    chain fd$
    close
    end

LPEND:
    decr lps%
    lam$=rtrim$(mid$(lp$(lps%),28,10))
    chain lam$

main:
     on timer(1) gosub WDTIM
     timer on

