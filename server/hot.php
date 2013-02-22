<?php
	function hello() {
		exit;
	}
?>
<?php
	require_once('./auth_info.php');
	header('Content-Type:text/xml');
	$id=$_GET['id'];
	
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
	$queryStr = "select id,author,title,board,item_id,rank_times from hot_topic_database where rss_time > '".$id."';";
	//queryStr need more work to solve task_logic
	$results = $db->query($queryStr);
	$number_of_results = $results->num_rows;
		
	
	if ( $number_of_results == 10) {
		$page->setAttribute('state','ok');
	 }else if ( $number_of_results < 1) {
		$page->setAttribute('state','empty');
		$number_of_results = 0;
	} else if ( $number_of_results > 10 ) { //impossible
		$number_of_results = 10;
		$page->setAttribute('state','ok');
	} else {
		$page->setAttribute('state','less');
	}
	for ( $i = 0; $i < $number_of_results;$i++ ) {
		$row = $results->fetch_assoc();
		$item = $page->appendChild($dom->createElement('item'));
		$item->setAttribute('id',htmlspecialchars($row['id']));
			$info = $item->appendChild($dom->createElement('info'));
				$info->appendChild($dom->createTextNode(htmlspecialchars($row['title'])));
			$num = $item->appendChild($dom->createElement('n'));
				$num->appendChild($dom->createTextNode(htmlspecialchars($row['rank_times'])));
			$board = $item->appendChild($dom->createElement('board'));
				$board->appendChild($dom->createTextNode(htmlspecialchars($row['board'])));
			$gid = $item->appendChild($dom->createElement('gid'));
				$gid->appendChild($dom->createTextNode(htmlspecialchars($row['item_id'])));
			$author = $item->appendChild($dom->createElement('author'));
				$author->appendChild($dom->createTextNode(htmlspecialchars($row['author'])));
	}
	$results->free();
	$db->close();
				
	$dom->formatOutput = true;
	echo $dom->saveXML();
	
	
?>
