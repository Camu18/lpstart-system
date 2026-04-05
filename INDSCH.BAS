' ix&(0)=begin nummer : ix&(1)=max rec pro index : ix&(2)=user pro index
' ix&(3)=index ofset  : ix&(4)=mid index         : ix&(5)= du so mod
' ix&(6)=index zeile  : ix&(7)=zeile ix von user : ix&(8)=posion keyb pro ix
' ix%=summe record one line
' -----------------Strasse-----------------
SEARCHR:
    if wd$(14)="ST" then gosub ixreadr else gosub ixreadrs
    ix&(0)=00 : if ix&(2)=00 then return
    skey$=ucase$(screenstr$(row%,dcp%,col%-dcp%))
    DO
       gosub IXFINDR
       if bit(flg&(1),1) and ix&(0)=ix&(2) then return
       if bit(flg&(1),1)<1 and ix&(0)=ix&(2) then return
       if skey$=left$(rkey$,col%-dcp%) then bit set flg&(1),0
       if skey$<=left$(rkey$,col%-dcp%) then ix&(2)=ix&(4) else_
                                                  ix&(0)=ix&(4)+1
    LOOP
XINSERTR:
     ix&(0)=00 : ix0$=mkl$(last&) : ix2$=fc$(chi%) : gosub ixreadr
     skey$=ucase$(rtrim$(screenstr$(row%,dcp%,dto%)))
     DO
        if ix&(2)=0 then exit
        gosub IXFINDR
        if skey$=rkey$ then exit
        if ix&(0)=ix&(2) then exit
        if skey$<rkey$ then ix&(2)=ix&(4) else ix&(0)=ix&(4)+1
     LOOP
     for it%=ix&(6) to ix&(7)
       get chi%,ix&(3)+ix&(8)+it% : ix1$=right$(fc$(chi%),4)
       if ix&(5)>0 then
          ix2$=left$(fc$(chi%),ix&(5)*4)+ix0$+mid$(fc$(chi%),1+ix&(5)*4,_
                                           len(fc$(chi%))-(4+ix&(5)*4))
          ix&(5)=00
       else
          ix2$=ix0$+left$(fc$(chi%),len(fc$(chi%))-4)
       end if
       ix0$=ix1$ : lset fc$(chi%)=ix2$ : put chi%,ix&(3)+ix&(8)+it%
     next it%
    return

IXFINDR:
      ix&(4)=int((ix&(0)+ix&(2))/2) : ix&(5)=ix&(4) mod ix%
      ix&(6)=(ix&(4)-ix&(5))/ix%
      get chi%,ix&(3)+ix&(6)+ix&(8)
        kno&=cvl(mid$(fc$(chi%),1+ix&(5)*4,4))
        get chs%,kno&+ofs%(chs%)
        if kno&>ix&(1) then erm$="ixfindr" : goto prgerrs
        gosub BUIKEYR
    return
BUIKEYR:
      rkey$=""
      rkey$=rkey$+ucase$(rtrim$(mid$(fc$(chs%),dtp%,dtl%)))
    return
IXREADR:
     ix&(1)=cvl(mid$(wd$(wno%),01+dka%*44,4))           :' max rec pro index
     ix&(2)=cvl(mid$(wd$(wno%),05+dka%*44,4))           :' user pro index
     ix&(3)=cvi(mid$(wd$(wno%),09+dka%*44,2))+2         :' index zeile
       vip%=asc(mid$(wd$(wno%),11+dka%*44,1))           :' subfile
     ix&(7)=(ix&(2)-(ix&(2) mod ix%))/ix%
     ix&(8)=(int(ix&(1)/ix%)+1)*(dky%-1)
    return
IXREADRS:
     get chp%,1013
     ix&(1)=cvl(mid$(fc$(chp%),36,4))           :' max rec pro index
     ix&(2)=cvl(mid$(fc$(chp%),40,4))           :' user pro index
     ix&(3)=cvi(mid$(fc$(chp%),44,2))+2         :' index zeile
     idp%(0)=dtp% : idl%(0)=dtl% : dky%=1
     ix&(7)=(ix&(2)-(ix&(2) mod ix%))/ix%
     ix&(8)=(int(ix&(1)/ix%)+1)*(dky%-1)
    return
SEARCHK:
    DO
       if ix&(2)=0 then return
       gosub IXFINDR
       if skey$=left$(rkey$,col%-dcp%) then bit set flg&(1),1
       if skey$<=left$(rkey$,col%-dcp%) then ix&(2)=ix&(4) else_
                                                  ix&(0)=ix&(4)+1
       if bit(flg&(1),1) and ix&(0)=ix&(2) then return
       if bit(flg&(1),1)=0 and ix&(0)=ix&(2) then return
    LOOP
    return
ERROPR:
     print "idex voll"
    RETURN

PRGERRS:
    print erm$
    close
    end
DSPLS:
     wid%(9)=wno% : wnd%=wid%(3) : wno%=03 : gosub mwind
     get chi%,ix&(3)+ix&(6)+ix&(8)
     for t%=00 to wx%(11)*wx%(12)+1
       if ix&(5)+t%<ix% then
          kno&=cvl(mid$(fc$(chi%),1+(ix&(5)+t%)*4,4))
       else
          get chi%,ix&(3)+ix&(6)+ix&(8)+1
          kno&=cvl(mid$(fc$(chi%),1+(ix&(5)+t%-ix%)*4,4))
       end if
       get chs%,kno&+ofs%(chs%)
       if ucase$(mid$(fc$(chs%),dtp%,col%-dcp%))<>ucase$(screenstr$(row%,_
            dcp%,col%-dcp%)) then exit for
       printf wx%(0)+wx%(10)+t%,wx%(1)+1,rtrim$(mid$(fc$(chs%),dtp%,dtl%)),_
                                                                  cx%(100)
     next t%
    return

strass:
   do
     if lastkeyx=%ESC then exit
     if ddb%<>10 then exit
     gosub searchr
     if bit(flg&(1),0) then
        if bit(flg&(1),1) then closewindow
        bit set flg&(1),1 : gosub dspls : bit set flg&(1),2
     else
        if bit(flg&(1),1) then closewindow : bit reset flg&(1),1
        bit reset flg&(1),2
     end if
     if lastkeyx=%aenter then
         printf row%,dcp%,rtrim$(fd$(20)),cx%(104) : closewindow
         bit reset flg&(1),2: wno%=wid%(9) : wid%(9)=00
         if ix&(5)+frow%>=ix% then
            get chi%,ix&(3)+ix&(6)+ix&(8)+1
            kno&=cvl(mid$(fc$(chi%),1+(ix&(5)+frow%-ix%)*4,4))
         else
            get chi%,ix&(3)+ix&(6)+ix&(8)
            kno&=cvl(mid$(fc$(chi%),1+(ix&(5)+frow%)*4,4))
         end if
         get chs%,kno&+ofs%(chs%)
         for wt%=wt%+1 to wt%+2
            gosub mreadi
            printf row%,dcp%,rtrim$(mid$(fc$(chs%),dtp%,dtl%)),cx%(104)
         next wt% : decr wt%,3
         gosub mreadh:gosub mreadi:col%=dcp%+len(rtrim$(fd$(20)))
         ddb%=00
     end if
     wno%=01:bit reset flg&(1),0 : gosub mkyb
   loop
   return

