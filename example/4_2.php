<?php
/**
* 测试用例
*
* 越权漏洞判断-有漏洞
*/

//权限判断
$sql = "select * from `admin` where user = '$user' and pass = '$pass'";
$result = mysql_query($sql);

//显示管理界面
show_admin();


?>