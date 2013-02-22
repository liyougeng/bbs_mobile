<?php
	function hello() {
		exit;
	}
?>
<?php
	$MAX_ROW = 7;
	require_once('./auth_info.php');
	header('Content-Type:text/xml');
	$boardName=$_GET['board'];
	$boarditemPage = $_GET['page'] ;
	$boarditemPage = $boarditemPage > 0 ? $boarditemPage : 0;
	
	$dom = new DOMDocument('1.0','utf-8');							//create document
	$page = $dom->appendChild($dom->createElement('page')); //create root node
	$page->setAttribute('id',$id);
	//$page->setAttribute('test','辛辛苦苦的准备,结果是');
	
	@ $db = new mysqli($host,$user,$password,'tmp');
	if ( mysqli_connect_errno()) {
		$page->setAttribute('state','error');
		$dom->formatOutput = true;
		echo $dom->saveXML();
		$db->close();
		exit;
	}
	$low_index = $boarditemPage*$MAX_ROW;
	$up_index = $low_index+$MAX_ROW;
	$queryStr = "select group_id,title,board,origin_id,rank_times from board_topic_database where board = '";
	$queryStr =$queryStr.$boardName."' order by recent_time desc LIMIT ".$low_index.",".$up_index.";";
	//echo "<!--".$queryStr."-->";
	//queryStr need more work to solve task_logic
	
	$results = $db->query($queryStr);
	$number_of_results = $results->num_rows;
		
	
	if ( $number_of_results == $MAX_ROW ) {
		$page->setAttribute('state','ok');
	 }else if ( $number_of_results < 1) {
		$page->setAttribute('state','empty');
		$number_of_results = 0;
	} else if ( $number_of_results > $MAX_ROW ) { //impossible
		$number_of_results = $MAX_ROW;
		$page->setAttribute('state','ok');
	} else {
		$page->setAttribute('state','less');
	}
	for ( $i = 0; $i < $number_of_results;$i++ ) {
		$row = $results->fetch_assoc();
		$item = $page->appendChild($dom->createElement('item'));
		$item->setAttribute('id',htmlspecialchars($row['group_id']));
			$info = $item->appendChild($dom->createElement('info'));
				$info->appendChild($dom->createTextNode(htmlspecialchars($row['title'])));
			$num = $item->appendChild($dom->createElement('n'));
				$num->appendChild($dom->createTextNode(htmlspecialchars($row['rank_times'])));
			$board = $item->appendChild($dom->createElement('board'));
				$board->appendChild($dom->createTextNode(htmlspecialchars($row['board'])));
			$gid = $item->appendChild($dom->createElement('gid'));
				$gid->appendChild($dom->createTextNode(htmlspecialchars($row['group_id'])));
			$author = $item->appendChild($dom->createElement('oriID'));
				$author->appendChild($dom->createTextNode(htmlspecialchars($row['origin_id'])));
	}
	$results->free();
	$db->close();
				
	$dom->formatOutput = true;
	echo $dom->saveXML();
	
	
?>
