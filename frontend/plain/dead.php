<?php
if (isset($_GET['password'])) {
	require_once(dirname(__FILE__).'/../../backend/afterlife.php');
	$__message = dead_man_switch($_GET['password'],"ON");
}
?>
<html>
	<body style="text-align:center">
		<form method="GET">
			Password: <input type="password" name="password" value="" />
			<input type="submit" />
		</form>
		<div id="message">
			<pre>
			<?php echo($__message); ?>
			</pre>
		</div>
	</body>
</html>
