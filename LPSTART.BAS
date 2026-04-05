' LPSTART : Startprogramm
cls
' ----------------
' Common Variables
' ----------------
rem lps%=Programm stupe
rem lp$(1)=Programm Infomation
  dim cm$(015),fc$(30),cp%(9),cx%(299),cl&(15),lp$(3),wd%(3)
  common cm$(1),fc$(1),cp%(1),cx%(1),cl&(1),lps%,lp$(1),wd%(1),wdl%
' -----------------
' Programm-Variable
' -----------------
  dim fd$(30),px%(99),pv#(15)
  chp%=01 :  chw%=02
' -- command$ pro openfiles and chainnel-----------
  fd$(1)=""  : fd$(2)="tuvi"
' ---------------------------------
  gosub opfl : rem - Open Files
  gosub cvar : rem - Common Variable

  get chp%,1
  for t%=00 to 15
      cx%(100+t%)=asc(mid$(fc$(chp%),t%+1,1))
  next t%
   chain "lpmenue"
' ----------------
' Common Variables
' ----------------
cvar:
  rem - Days months jarh
        cx%(231)=0000
        cx%(232)=0031 : cx%(233)=0060 : cx%(234)=0091 : cx%(235)=0121
        cx%(236)=0152 : cx%(237)=0182 : cx%(238)=0213 : cx%(239)=0244
        cx%(240)=0274 : cx%(241)=0305 : cx%(242)=0335 : cx%(243)=0366
        cx%(244)=0397 : cx%(245)=0425 : cx%(246)=0456 : cx%(247)=0486
        cx%(248)=0517 : cx%(249)=0547 : cx%(250)=0578 : cx%(251)=0609
        cx%(252)=0639 : cx%(253)=0670 : cx%(254)=0700 : cx%(255)=0731
        cx%(256)=0762 : cx%(257)=0790 : cx%(258)=0821 : cx%(259)=0851
        cx%(260)=0882 : cx%(261)=0912 : cx%(262)=0943 : cx%(263)=0974
        cx%(264)=1004 : cx%(265)=1035 : cx%(266)=1065 : cx%(267)=1096
        cx%(268)=1127 : cx%(269)=1155 : cx%(270)=1186 : cx%(271)=1216
        cx%(272)=1247 : cx%(273)=1277 : cx%(274)=1308 : cx%(276)=1339
        cx%(277)=1369 : cx%(278)=1400 : cx%(279)=1430 : cx%(279)=1461
  rem - Days of Months
        cx%(280)=0
        cx%(281)=31 : cx%(282)=28 : cx%(283)=31 : cx%(284)=30
        cx%(285)=31 : cx%(286)=30 : cx%(287)=31 : cx%(288)=31
        cx%(289)=30 : cx%(290)=31 : cx%(291)=30 : cx%(292)=31
  rem - System Offsets
        cx%(295)=0100 : rem --- Files
        cx%(296)=1300 : rem --- Programms
        cx%(297)=1000 : rem --- Subfiles
        cx%(298)=2000 : rem --- Daten

  return
' ----------
' Open Files
' ----------
opfl:
     open "r",1,"paramet.dat",128
     field 1,128 as fc$(1)

     if command$=fd$(1) then
        open "r",2,"window.dat",80
        field 2,80 as fc$(2)
        px%(30)=100 : gosub opdata
     end if
     if command$=fd$(2) then
        open "r",2,"tuvi.dat",80
        field 2,80 as fc$(2)
        px%(30)=116 : gosub opdata
     end if
   return
opdata:
     for t%=3 to 15
        get chp%,t%+px%(30)
        fd$(0)=rtrim$(mid$(fc$(chp%),1,12))
        rl%=cvi(mid$(fc$(chp%),37,2))
        if rl%>00 then
           open "r",t%,fd$(0),rl%
           field t%,rl% as fc$(t%)
        end if
     next t%
  return

