<?php
	//$static_role
	$static_role = Array();
	$sql = "select * from role";
	$result = mysql_query($sql);
	while($res = mysql_fetch_assoc($result))
	{
		$static_role[$res['id']]['role'] = $res['role'];
		$static_role[$res['id']]['level'] = $res['level'];
	}
	//print_r($static_role);exit;
	$static_level = Array("-3"=>"未判断", "-2"=>"不判断", "0"=>"不危险", "1"=>"危险");
	$static_position = Array("-3"=>"未判断", "-2"=>"不判断", "-1"=>"结束行", "0"=>"中间行", "1"=>"开始行");
	$variables_from = Array("0"=>"来源于用户", "1"=>"来源于数据库", "-1"=>"来源于文件");
?>