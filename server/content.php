<?php
	function hello() {
		exit;
	}
?>
<?php
	require_once('./auth_info.php');
	header('Content-Type:text/xml');
	$pageIndex=$_GET['page'];
	$board = $_GET['board'];
	$gid = $_GET['gid'];
	$MAX_ROW = 10;
	
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
	$queryStr = "select item_id,author,board,index_id,content,replyID,postTime from topic_content_database where board = '".$board."' and group_id = ".$gid." and index_id >".($pageIndex*$MAX_ROW-1)." and index_id <".($pageIndex*$MAX_ROW+$MAX_ROW).";";
	//echo $queryStr;
	//queryStr need more work to solve task_logic
	// (,,,,,)origin_id,board,group_id
	$results = $db->query($queryStr);
	$number_of_results = $results->num_rows;
		
	
	if ( $number_of_results == $MAX_ROW) {
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
		$item->setAttribute('id',htmlspecialchars($row['item_id']));
			$index = $item->appendChild($dom->createElement('index'));
				$index->appendChild($dom->createTextNode(htmlspecialchars($row['index_id'])));
			$cdata = $item->appendChild($dom->createElement('CDATA'));
				$cdata->appendChild($dom->createTextNode(htmlspecialchars($row['content'])));
			$board = $item->appendChild($dom->createElement('board'));
				$board->appendChild($dom->createTextNode(htmlspecialchars($row['board'])));
			//$gid = $item->appendChild($dom->createElement('gid'));
				//$gid->appendChild($dom->createTextNode(htmlspecialchars($row['item_id'])));
			$author = $item->appendChild($dom->createElement('author'));
				$author->appendChild($dom->createTextNode(htmlspecialchars($row['author'])));
			$ptime = $item->appendChild($dom->createElement('postTime'));
				$ptime->appendChild($dom->createTextNode(htmlspecialchars($row['postTime'])));
			$reID = $item->appendChild($dom->createElement('reID'));
				$reID->appendChild($dom->createTextNode(htmlspecialchars($row['replyID'])));
	}
	$results->free();
	$db->close();
				
	$dom->formatOutput = true;
	echo $dom->saveXML();
	
	
?>
