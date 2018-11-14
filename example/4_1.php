<?php
/**
* 测试用例
*
* 越权漏洞判断-无漏洞
*/

//权限判断
$sql = "select * from `admin` where user = '$user' and pass = '$pass'";
$result = mysql_query($sql);
if(mysql_num_rows($result)>0)
{
	//显示管理
	show_admin();
} //if

?>