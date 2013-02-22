
#login in bbs
curl --data "id=czFedora&passwd=19930424Cz&auto=on&webtype=wforum" -c cookie.txt http://bbs.whu.edu.cn/bbslogin.php

#kick_multi
#curl --data "id=czFedora&passwd=19930424Cz&kick_multi=1" http://bbs.whu.edu.cn/bbslogin.php?mainurl=

#cookie
#WWWPARAMS=0; UTMPKEY=4289383; UTMPNUM=5; UTMPUSERID=czFedora; uchome_auth=d785N00Fm8BkOnrpg7iP5Q7UoaR0p70E55iCdfY54GIm5SfcusrxOOmnDj4OX7AqHWo29tZeIwFIRFkDylQlZhQJ%2FQ; uchome_loginuser=czFedora; JishiGou_0gilwS_auth=6558lWGe0qDxJiSpRhQhMumeKDqN8istmN7xUmc7o9UHyywGihxF%2B1YnsgRYAWeMSMpxLPntAafn7GzN7733eow

#post
curl --data "board=Test&reID=0&username=czFedora&font=&subject=Re xiaoru+&Content=huashuo+++&signature=1&Submit=post" -b cookie.txt http://bbs.whu.edu.cn/wForum/dopostarticle.php

#logout
curl -b cookie.txt http://bbs.whu.edu.cn/bbslogout.php

#remove cookie.txt
rm cookie.txt
