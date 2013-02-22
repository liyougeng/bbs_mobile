DROP TABLE IF EXISTS hot_topic_database;
CREATE TABLE hot_topic_database ( 
	id integer UNSIGNED NOT NULL AUTO_INCREMENT,
	author VARCHAR(25) NOT NULL,
	title VARCHAR(50) NOT NULL,
	board VARCHAR(15) NOT NULL,
	item_id integer UNSIGNED NOT NULL,
	time timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	rss_time timestamp ,
	rank_times smallint UNSIGNED DEFAULT 0,
	
	PRIMARY KEY (id),
	UNIQUE (item_id),
	INDEX new(time),
	INDEX rnew(rss_time)
)CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS board_list_database;
CREATE TABLE board_list_database (
	board_id integer UNSIGNED NOT NULL AUTO_INCREMENT,
	name_zh VARCHAR(18) NOT NULL,
	name_en VARCHAR(15) NOT NULL,
	today_new_item smallint UNSIGNED NOT NULL DEFAULT 0,
	admin VARCHAR(20) NOT NULL DEFAULT '无版主',
	pCatalog VARCHAR(16) NOT NULL DEFAULT '父分类',
	totalItems integer NOT NULL DEFAULT 1,
	
	PRIMARY KEY (board_id),
	INDEX board_name(name_en),
	INDEX new(today_new_item)	
)CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS board_topic_database;
CREATE TABLE board_topic_database (
	group_id integer UNSIGNED NOT NULL AUTO_INCREMENT,
	title VARCHAR(50) NOT NULL,
	board VARCHAR(15) NOT NULL,
	origin_id integer NOT NULL,
	rank_times smallint UNSIGNED DEFAULT 0,
	init_time timestamp NOT NULL,
	recent_time timestamp NOT NULL,
	
	PRIMARY KEY (group_id),
	INDEX boardCata(board),
	INDEX new(recent_time,origin_id),
	INDEX bnew(board,recent_time,origin_id)	
)CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS topic_content_database;
CREATE TABLE topic_content_database (
	item_id  integer UNSIGNED NOT NULL AUTO_INCREMENT,
	board  VARCHAR(15) NOT NULL,
	group_id  integer UNSIGNED NOT NULL,
	origin_id  integer UNSIGNED NOT NULL,
	index_id  smallint UNSIGNED NOT NULL,	
	author	 VARCHAR(20) NOT NULL,
	replyID	 integer UNSIGNED NOT NULL,
	title	 VARCHAR(50),
	content	 VARCHAR(500),
	postTime  timestamp NOT NULL,	
	PRIMARY KEY (item_id),
	INDEX _group(group_id),
	INDEX _newgroup(group_id,index_id),
	INDEX _newItem(group_id,index_id,postTime)	
)CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS id_info;
create table id_info (  
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	bbs_id VARCHAR (25) NOT NULL,
	nikename VARCHAR (30) ,
	gender tinyint,
	starPos VARCHAR (10),
	QQ VARCHAR (15) DEFAULT 'unknown',
	ICQ VARCHAR (15) DEFAULT 'unknown',
	MSN VARCHAR (30) DEFAULT 'unknown',
	Homepage VARCHAR (50) DEFAULT 'unknown',
	duty VARCHAR (10) DEFAULT '用户',
	MenPai VARCHAR (10) DEFAULT '无',
	JiYanzi SMALLINT UNSIGNED DEFAULT 0,
	Shengmingli SMALLINT UNSIGNED DEFAULT 0,
	BpostTimes SMALLINT UNSIGNED DEFAULT 0,
	logTimes SMALLINT UNSIGNED DEFAULT 0,
	Rank VARCHAR (10) DEFAULT '一般站友',
	LastLog DATETIME ,
	MyRecordTime  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	LastIP VARCHAR (16) DEFAULT '10.25.3.*',
	PRIMARY KEY (id),
	UNIQUE (bbs_id),
	INDEX IJYZ(JiYanzi),
	INDEX ILastLogDate(LastLog),
	INDEX Isml(Shengmingli),
	INDEX IpostTimes(BpostTimes),
	INDEX ImultIndexJY(JiYanzi,Shengmingli,logTimes),
	INDEX ImultIndexLP(logTimes,BpostTimes)
)CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO hot_topic_database (author,title,board,item_id,time,rss_time,rank_times) 
	values 
	('whuxy','辛辛苦苦的准备,结果是','test',0,'2013-2-8 22:12:50','2013-2-7 10:19:36',15),
	('tengz','机器人,Tangze复活,Tangze的实现代码共享','test',1,'2013-2-8 22:12:50','2013-2-7 10:19:36',15),
	('hello','Unix管理的实现代码一览,转自白云','test',2,'2013-2-8 22:12:50','2013-2-7 10:19:36',15),
	('protein','校友聚会邀请你?','test',5,'2013-2-8 22:12:50','2013-2-7 10:19:36',15),
	('cz','生物大分子的实验报告在生科院2楼下午开始','test',4,'2013-2-8 22:12:50','2013-2-7 10:19:36',15),
	('dongrei','dongrei的离任帖子','test',3,'2013-2-8 22:12:50','2013-2-7 10:19:36',15),
	('czFedora','样本数据测试,测试条目','test',6,'2013-2-8 22:12:50','2013-2-7 10:19:36',15),
	('ILoveSor','样本数据测试,版面数据','test',7,'2013-2-8 22:12:50','2013-2-7 10:19:36',15),
	('iphone','版面数据,版面热点,的司法所地方第三的夫斯蒂芬大赛','test',8,'2013-2-8 22:12:50','2013-2-7 10:19:36',15),
	('santa','长度测试,123456987/*-+<a href="a.html">about</a>','test',9,'2013-2-8 22:12:50','2013-2-7 10:19:36',15);

INSERT INTO board_list_database (name_zh,name_en,today_new_item,admin,pCatalog,totalItems)
	VALUES
		('测试版','test',10,'adan','BBS建设',10),
		('Unix_linux','unix',0,'dongrei','电脑技术',0);

INSERT INTO board_topic_database ( title,board,origin_id,rank_times,init_time,recent_time)
VALUES
	('样本数据测试,版面数据','test',1,1,'2013-1-18 11:25:52','2013-2-8 8:18:6'),
	('版面数据,版面热点,的司法所地方第三的夫斯蒂芬大赛','test',2,10,'2013-1-18 11:25:52','2013-2-8 8:18:6'),
	('dongrei的离任帖子','test',3,10,'2013-1-18 11:25:52','2013-2-8 8:18:6'),
	('生物大分子的实验报告在生科院2楼下午开始','test',4,21,'2013-1-18 11:25:52','2013-2-8 8:18:6');
	
INSERT INTO topic_content_database (board,group_id,origin_id,index_id,author,replyID,title,content,postTime)
values
	('test',2,3,0,'dongrei',3,'dongrei的离任帖子','dongrei决定离任unix_linux版面斑竹职务,<br>下面是离任说明:2013-3-1','2013-1-25 11:5:20'),
	('test',2,11,1,'wish',11,'re:dongrei的离任帖子','wish<hr/>dongrei决定离任unix_linux版面斑竹职务,<br>下面是离任说明:2013-3-1','2013-1-29 12:5:20'),
	('test',2,13,2,'cz',13,'re:dongrei的离任帖子','+1<br/>dongrei决定离任unix_linux版面斑竹职务,<br>下面是离任说明:2013-3-1','2013-2-2 13:5:20'),
	('test',2,23,3,'whuxy',23,'re:dongrei的离任帖子','话说 +1<br>dongrei决定离任unix_linux版面斑竹职务,<br>下面是离任说明:2013-3-1','2013-2-5 11:25:20'),
	('test',2,15,4,'czFedora',15,'re:dongrei的离任帖子','+10086<br>wish<br/><br>dongrei决定离任unix_linux版面斑竹职务,<br>下面是离任说明:2013-3-1','2013-2-25 11:15:20');



INSERT INTO hot_topic_database (author,title,board,item_id,time,rss_time,rank_times) 
	values 
	('whuxy','Englin,Ital,Chinpa,what more?','test',0,'2013-2-9 22:12:50','2013-2-7 10:19:36',15),
	('tengz','Englieman,Ital,Chinat more?','test',1,'2013-2-9 22:12:50','2013-2-7 10:19:36',15),
	('hello','Englis,Greman,Ital,Ch,what more?','test',2,'2013-2-9 22:12:50','2013-2-7 10:19:36',15),
	('protein','Englis,Grema,Janpa,what more??','test',5,'2013-2-9 22:12:50','2013-2-7 10:19:36',15),
	('cz','Englis,Greman,It,Janpa,what more?','test',4,'2013-2-9 22:12:50','2013-2-7 10:19:36',15),
	('dongrei','dongrei forever','test',3,'2013-2-9 22:12:50','2013-2-7 10:19:36',15),
	('czFedora','Englis,,China,Janpa,what more?','test',6,'2013-2-9 22:12:50','2013-2-7 10:19:36',15),
	('ILoveSor','Ital,China,Janpa,what more?','test',7,'2013-2-9 22:12:50','2013-2-7 10:19:36',15),
	('iphone','Englis,Greman,Ital,China,Janpa,what more?','test',8,'2013-2-9 22:12:50','2013-2-7 10:19:36',15),
	('santa','Englis,Greman,,123456987/*-+<a href="a.html">about</a>','test',9,'2013-2-9 22:12:50','2013-2-7 10:19:36',15);

INSERT INTO board_list_database (name_zh,name_en,today_new_item,admin,pCatalog,totalItems)
VALUES
	('MyTest','test',10,'adan','BBS-BuildArea',10),
	('Unix_linux','unix',0,'dongrei','ComputerArea',0);

INSERT INTO board_topic_database ( title,board,origin_id,rank_times,init_time,recent_time)
VALUES
	('leTestProtein,onion,and thought','test',1,1,'2013-1-18 11:25:52','2013-2-8 8:18:6'),
	('Samnion,and thought','test',2,10,'2013-1-18 11:25:52','2013-2-8 8:18:6'),
	('dongrei forever','test',3,10,'2013-1-18 11:25:52','2013-2-8 8:18:6'),
	('Samprotein,onion,and thought','test',4,21,'2013-1-18 11:25:52','2013-2-8 8:18:6');
	
INSERT INTO topic_content_database (board,group_id,origin_id,index_id,author,replyID,title,content,postTime)
values
	('test',2,3,0,'dongrei',3,'dongrei forever','form here to there is a horrible sentense?:2013-3-1','2013-1-25 11:5:20'),
	('test',2,11,1,'wish',11,'re:dongrei forever','wish<hr/>dongrei form here to there is a horrible sentense?:2013-3-1','2013-1-29 12:5:20'),
	('test',2,13,2,'cz',13,'re:dongrei forever','+1<br/>dongreiform here to there is a horrible sentense?:2013-3-1','2013-2-2 13:5:20'),
	('test',2,23,3,'whuxy',23,'re:dongrei forever','hs +1<br>dongreiform here to there is a horrible sentense?2013-3-1','2013-2-5 11:25:20'),
	('test',2,15,4,'czFedora',15,'re:dongrei forever','+10086<br>wish<br/><br>dongreiform here to there is a horrible sentense?2013-3-1','2013-2-25 11:15:20');
