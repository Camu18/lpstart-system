mgetkf:
   num%=0 : l%=0 : h$=""
   do
       get chw%,wnd%+num% : xy$=rtrim$(fc$(chw%))+"+"
       for i%=1 to len(xy$)
           i$=mid$(xy$,i%,1)
           x%=asc(i$)
           if x%<48 or x%>57 then
              if h$<>"" then
                 px%(l%)=val(h$) : h$="" :incr l%
              end if
           else
              h$=h$+i$
           end if
      next i%
      if right$(xy$,2)="++" then incr num% else exit
   loop
return


