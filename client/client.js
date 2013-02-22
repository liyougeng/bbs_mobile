// Put your custom code here
//ajax for : get more/next/forward reply info 10 items
/* 4 -hot top 10 */
function getXMLHttpRequest(){
	var req = false;
	try {
		req = new XMLHttpRequest();
	} catch ( err ) {
		try{
			req = new ActiveXObject('Msxml2.XMLHTTP');
		} catch ( err ) {
			try {
				req = new ActiveXObject('Microsoft.XMLHTTP');
			}catch ( err ){
				req = false ; 
			}
		}
	}
	return req;
}
function getHotTopic() {
				//var thePage = 'http://127.0.0.1/html/pro/mobi/4/hot.php'
				var thePage = '../server/hot.php'
				myRand = parseInt(Math.random()*99999999999); //rand="+myRand+"&
				var str = ""+((new Date).getYear()+1900)+"-"+((new Date).getMonth()+1)+"-"+"12"+" 0:0:1";
				var theURL = thePage +"?rand="+myRand+"&id="+str;
				myReq.open("GET",theURL, true);
				//myReq.setRequestHeader('Content-Type','text/xml');
				myReq.onreadystatechange = theHTTPResponse;
				myReq.send(null);
				
}
function theHTTPResponse() {
	if (myReq.readyState == 4 ){
			if ( myReq.status == 200 ) {
				if ( myReq.responseXML.getElementsByTagName("item").length < 10 )
					return false;
				for (var i = 0; i < 10;i++) {
					var item = myReq.responseXML.getElementsByTagName("item")[i];
					var info = item.getElementsByTagName("info")[0].childNodes[0].nodeValue;
					var n = item.getElementsByTagName("n")[0].childNodes[0].nodeValue;
					var board = item.getElementsByTagName("board")[0].childNodes[0].nodeValue;
					var gid = item.getElementsByTagName("gid")[0].childNodes[0].nodeValue;
					var author = item.getElementsByTagName("author")[0].childNodes[0].nodeValue;
					var link = "javascript:loadContent('"+board+"','"+gid+"','"+info+"');";
					var id = "info_"+i;
					var sp = "sp_"+i;
					document.getElementById(id).innerHTML = info;//myReq.responseText;
					document.getElementById(sp).innerHTML = n;
					document.getElementById(id).href = link;
					document.getElementById(id).title = "postAuthor:"+author;
				}
			} else {
				document.getElementById('info_0').innerHTML = "myReq";//.getAllResponseHeaders();//myReq.responseText;	
			}	
		} else {
		document.getElementById('info_0').innerHTML = "..."
	}
}

/* 2 -content list  */
function getMoreContent(nContentPage,boardName,gid) {
				var thePage = '../server/content.php'
				myRand = parseInt(Math.random()*99999999999);// rand="+myRand+"& 
				var	theURL = thePage +"?rand="+myRand+"&board="+boardName+"&gid="+gid+"&page="+nContentPage;
				contentReq.open("GET",theURL, true);
				//contentReq.setRequestHeader('Content-Type','text/xml');
				contentReq.onreadystatechange = theHTTPResponseContent;
				contentReq.send(null);
				
}
function theHTTPResponseContent() {
	if (contentReq.readyState == 4 ){
		var fore="<a data-theme=\"c\" href=\"#\" class=\"ui-collapsible-heading-toggle ui-btn ui-btn-icon-left ui-corner-top ui-btn-up-c\"><span class=\"ui-btn-inner ui-corner-top\"><span class=\"ui-btn-text\">";
		var back="\<span class=\"ui-collapsible-heading-status\"> click to collapse contents</span></span><span class=\"ui-btn ui-btn-up-d ui-btn-icon-left ui-btn-corner-all ui-shadow\" data-theme=\"d\"><span class=\"ui-btn-inner ui-btn-corner-all ui-corner-top\"><span class=\"ui-btn-text\"></span><span class=\"ui-icon ui-icon-shadow ui-icon-minus\"></span></span></span></span></a>";
			if ( contentReq.status == 200 ) {
				var num_content = contentReq.responseXML.getElementsByTagName("item").length;
				num_content = num_content > 10 ? 10 : num_content;
				if ( num_content < 1 ) {
					env_nContentPage --;
					if ( env_nContentPage < 0)
						env_nContentPage =0;
					//handle empty situation,if it it next-btn err dialog else it is topic link,
				if ( env_nContentPage == 0)
					history.back();
					return false;
				}
				var i = 0;
				for (; i < num_content ; i++ ) {
					var item = contentReq.responseXML.getElementsByTagName("item")[i];
					var index= item.getElementsByTagName("index")[0].childNodes[0].nodeValue;
					var data = item.getElementsByTagName("CDATA")[0].childNodes[0].nodeValue;
					var reID = item.getElementsByTagName("reID")[0].childNodes[0].nodeValue;
					var author = item.getElementsByTagName("author")[0].childNodes[0].nodeValue;
					var postTime = item.getElementsByTagName("postTime")[0].childNodes[0].nodeValue;
					var board = item.getElementsByTagName("board")[0].childNodes[0].nodeValue;
					var title = fore + index+"楼:"+author +back;
					data =" "+author +","+postTime + "<hr/>" + data;
					var area = i+"_content_id";
					var head = "h_content_"+i;
					var div = "text_content_"+i;
					var auID = "id_info_id_"+i;
					var reIDlink = "reply_id_"+i;
					
					document.getElementById(area).style.display = "block";
					document.getElementById(head).innerHTML = title;//contentReq.responseText;
					document.getElementById(div).innerHTML = data;//
					document.getElementById(auID).href="javascript:IDDetail('"+author+"');";
					document.getElementById(reIDlink).href="javascript:replyTo('"+board+"','"+reID+"');";
					
				}
				for (;i < 10; i++) {
					var area = i+"_content_id";
					var head = "h_content_"+i;
					var div = "text_content_"+i;
					var auID = "id_info_id_"+i;
					var reIDlink = "reply_id_"+i;
					document.getElementById(area).style.display = "none";
					document.getElementById(head).innerHTML = "";//contentReq.responseText;
					document.getElementById(div).innerHTML = "";//
					document.getElementById(auID).href="javascript:IDDetail('bot');";
					document.getElementById(reIDlink).href="javascript:replyTo("+0+","+0+");";
				}
			}
				//document.getElementById('topic_a_0').innerHTML = "contentReq";//.getAllResponseHeaders();//contentReq.responseText;		
		} else {
		//document.getElementById('h_content_0').innerHTML = "...";
	}
}
function getContent(bWay) {
	if (bWay) {
		env_nContentPage++;
	} else {
		env_nContentPage--;
	}
	if (env_nContentPage < 0 )
		env_nContentPage = 0;
	getMoreContent(env_nContentPage,env_boardName,env_gid);
}

/* 3 -board topic */
function getMore(direct,boardName) {
				var thePage = '../server/boarditem.php'
				myRand = parseInt(Math.random()*99999999999);
				var	theURL = thePage +"?rand="+myRand+"&board="+boardName+"&page="+direct;
				boardReq.open("GET",theURL, true);
				//boardReq.setRequestHeader('Content-Type','text/xml');
				boardReq.onreadystatechange = theHTTPResponseBoarditem;
				boardReq.send(null);
				
}
function theHTTPResponseBoarditem() {
	if (boardReq.readyState == 4 ){
			if ( boardReq.status == 200 ) {
				var num = boardReq.responseXML.getElementsByTagName("item").length;
				num = num > 7 ? 7:num;
				if ( num < 1 ) {
					env_nPage --;
					if ( env_nPage < 0)
						env_nPage = 0;
					//handle nothing more function
					return false;
				}
				var i = 0;
				for (; i < num ;i++) {
					var item = boardReq.responseXML.getElementsByTagName("item")[i];
					var info = item.getElementsByTagName("info")[0].childNodes[0].nodeValue;
					var n = item.getElementsByTagName("n")[0].childNodes[0].nodeValue;
					var board = item.getElementsByTagName("board")[0].childNodes[0].nodeValue;
					var gid = item.getElementsByTagName("gid")[0].childNodes[0].nodeValue;
					var oriID = item.getElementsByTagName("oriID")[0].childNodes[0].nodeValue;
					var id = "topic_a_"+i;
					var sp = "topic_sp_"+i;
					document.getElementById(id).innerHTML = info;//boardReq.responseText;
					document.getElementById(sp).innerHTML = n;
					document.getElementById(id).href = "javascript:loadContent('"+board+"','"+gid+"','"+info+"');";
					document.getElementById(id).title = "postOriginID:"+oriID;
					document.getElementById("topic_li_"+i).style.display = "block";
				}
				for (; i < 7 ; i++) {
					var id = "topic_a_"+i;
					var sp = "topic_sp_"+i;
					document.getElementById(id).innerHTML = "";//boardReq.responseText;
					document.getElementById(sp).innerHTML = "";
					document.getElementById(id).href = "";
					document.getElementById(id).title = "";
					document.getElementById("topic_li_"+i).style.display = "none";
				}
			}
				//document.getElementById('topic_a_0').innerHTML = "boardReq";//.getAllResponseHeaders();//boardReq.responseText;		
		} else {
		document.getElementById('topic_a_0').innerHTML = "..."
	}
}
function ajaxInfoBoardTopic(bWay) {
	
	if (bWay) {
		env_nPage++;
	} else {
		env_nPage--;
		if (env_nPage < 0 )
			env_nPage = 0;
	}
	getMore(env_nPage,env_boardName);
}
//window.addEventListener('load',load,false);

/* 5 -board list  */

//other js function
function logout(){
	
}
