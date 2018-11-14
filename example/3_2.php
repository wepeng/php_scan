<?php
/**
* 测试用例
*
* 二次注入漏洞
*/

//数据取出
$id = $_GET['id'];
$sql = "select * from `admin` where user = '$id'";
$result = mysql_query($sql);
$res = mysql_fetch_assoc($result);
$user = $res['user'];
$pass = $res['pass'];

//数据再次查询
$sql = "select * from `admin` where user = '$user' and pass = '$pass'";
mysql_query($sql);

?>