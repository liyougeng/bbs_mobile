<!--
GET Method
-->
<?php
	$page = file_get_contents('http://www.example.com/robots.txt');
?>

<?php
	$c = curl_init('http://www.example.com/robots.txt');
	curl_setopt($c, CURLOPT_RETURNTRANSFER, true);
	$page = curl_exec($c);
	curl_close($c);
?>
<!--
POST Method
-->
Example 13-14. Using POST with the http stream
<?php
	$url = 'http://www.example.com/submit.php';
	// The submitted form data, encoded as query-string-style
	// name-value pairs
	$body = 'monkey=uncle&rhino=aunt';
	$options = array('method' => 'POST', 'content' => $body);
	// Create the stream context
	$context = stream_context_create(array('http' => $options));
	// Pass the context to file_get_contents()
	print file_get_contents($url, false, $context);
?>
<?php
	$url = 'http://www.example.com/submit.php';
	// The submitted form data, encoded as query-string-style
	// name-value pairs
	$body = 'monkey=uncle&rhino=aunt';
	$c = curl_init($url);
	curl_setopt($c, CURLOPT_POST, true);
	curl_setopt($c, CURLOPT_POSTFIELDS, $body);
	curl_setopt($c, CURLOPT_RETURNTRANSFER, true);
	$page = curl_exec($c);
	curl_close($c);
?>
<!--
Cookie Problem
-->
Example 13-17. Sending cookies with cURL
<?php
	$c = curl_init('http://www.example.com/needs-cookies.php');
	curl_setopt($c, CURLOPT_COOKIE, 'user=ellen; activity=swimming');
	curl_setopt($c, CURLOPT_RETURNTRANSFER, true);
	$page = curl_exec($c);
	curl_close($c);
?>
<?php
	// A temporary file to hold the cookies
	$cookie_jar = tempnam('/tmp','cookie');
	// log in
	$c = curl_init('https://bank.example.com/login.php?user=donald&password=b1gmoney$');
	curl_setopt($c, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($c, CURLOPT_COOKIEJAR, $cookie_jar);
	$page = curl_exec($c);
	curl_close($c);
	// retrieve account balance
	$c = curl_init('http://bank.example.com/balance.php?account=checking');
	curl_setopt($c, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($c, CURLOPT_COOKIEFILE, $cookie_jar);
	$page = curl_exec($c);
	curl_close($c);
	// make a deposit
	$c = curl_init('http://bank.example.com/deposit.php');
	curl_setopt($c, CURLOPT_POST, true);
	curl_setopt($c, CURLOPT_POSTFIELDS, 'account=checking&amount=122.44');
	curl_setopt($c, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($c, CURLOPT_COOKIEFILE, $cookie_jar);
	$page = curl_exec($c);
	curl_close($c);
	// remove the cookie jar
	unlink($cookie_jar) or die("Can't unlink $cookie_jar");
?>
$.ajax({
	url: 'http://search.twitter.com/search.json?rpp=20&q=from:jreid01',
	dataType: 'json',
	success: function(data) {
	},
	error: function() {
	}
});
