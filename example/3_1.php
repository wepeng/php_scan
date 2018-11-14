<?php
/**
* 测试用例
*
* 二次注入漏洞
*/
//数据插入
$user = $_GET['user'];
$pass = $_GET['pass'];
$sql = "INSERT INTO `admin` (`user`, `pass`) VALUES ('$user', '$pass')";
mysql_query($sql);
?>