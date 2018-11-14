<?php
	set_time_limit(0);
	
	require "include/conn.php";
	include 'static.php';
	include 'function.php';
	include 'html/header.html';
	
	//echo get_role(0);
	$level = Array("-3"=>"未判断", "-2"=>"不判断", "0"=>"不危险", "1"=>"危险");
	$position = Array("-3"=>"未判断", "-2"=>"不判断", "-1"=>"结束行", "0"=>"中间行", "1"=>"开始行");
				
	$url_this = "http://".$_SERVER ['HTTP_HOST'].$_SERVER['PHP_SELF'].'?'.$_SERVER['QUERY_STRING'];  //当前的url
	//echo $url_this;
	
	
	if(empty($_GET['action'])) 
	{
		//首页
		include 'html/index.html';
	} else {
		$action = trim($_GET['action']);
		switch($action)
		{
		case 'db_manager':
			/** *暂时不启用*
			if(isset($_FILES['file']))
			{
				//删除数据库
				$sql = "drop database 'test_php_check'";
				
				//新建数据库
				$sql = "create datebase 'test_php_check'";
				
				//获取上传文件
				$file = "upfile/".$_FILES["file"]["name"];
				echo "Path: " . $_POST["path"] . "<br />";
				echo "Upload: " . $_FILES["file"]["name"] . "<br />";
				move_uploaded_file($_FILES["file"]["tmp_name"], $file);
				echo "Stored in: " . $file;
				echo "<br/><br/>";
				
				//插入数据库
				
				
				unlink($file);
			}
			include 'html/up_file.html';
			*/
			$sql = "show tables from `test_php_check`";
			$result = mysql_query($sql);
			echo '<table class="itable">
						<caption>数据库列表</caption>
						<tr>
						<th>表名</th>
						<th>列名</th>
						</tr>';
			while($res = mysql_fetch_assoc($result))
			{
				$table = $res['Tables_in_test_php_check'];
				$sql = "show columns from `$table` from `test_php_check`";
				$result_in = mysql_query($sql);
				while($res_in = mysql_fetch_assoc($result_in))
				{
					$column = $res_in['Field'];
					echo "<tr><th>$table</th><th>$column</th></tr>";
				}
			}
			echo '</table>';
			break;
		case 'role_manager':
			if(isset($_POST['level']))
			{
				$sql = "INSERT INTO `role` (`id`, `role`, `describe`, `level`, `remark`) VALUES (NULL, '".$_POST['role']."', '".$_POST['describe']."', '".$_POST['level']."', '".$_POST['remark']."')";
				mysql_query($sql);
			}
			$sql = "select * from `role`";
			$result = mysql_query($sql);
			echo '<table class="itable">
						<caption>角色列表</caption>
						<tr>
						<th>ID</th>
						<th>角色</th>
						<th>描述</th>
						<th>级别</th>
						<th>备注</th>
						</tr>';
			while($res = mysql_fetch_assoc($result))
			{
				echo '<tr>
						<th>'.$res['id'].'</th>
						<th>'.$res['role'].'</th>
						<th>'.$res['describe'].'</th>
						<th>'.$res['level'].'</th>
						<th>'.$res['remark'].'</th>
						</tr>';
				
			}
			echo '</table>';
			echo '<br/><br/><hr/><br/><br/><div align="center"><form action="" method="post">
						  <p>角色：<input type="text" name="role" /></p>
						  <p>描述：<input type="text" name="describe" /></p>
						  <p>级别：<input type="text" name="level" /></p>
						  <p>备注：<input type="text" name="remark" /></p>
						  <input type="submit" value="添加角色" />
						  </form></div>';
			
			break;
			
		case 'up_file': //上传文件
			if(isset($_FILES['file']))
			{
				
				//上传文件
				$file = "upfile/".$_FILES["file"]["name"];
				echo "Path: " . $_POST["path"] . "<br />";
				echo "Upload: " . $_FILES["file"]["name"] . "<br />";
				move_uploaded_file($_FILES["file"]["tmp_name"], $file);
				echo "Stored in: " . $file;
				echo "<br/><br/>";
				
				$path = $_POST["path"];
				
				//判断文件是否已存在
				$sql = "select * from `files` where `file` like '$path'";
				if(mysql_num_rows(mysql_query($sql)) > 0)
				{
					echo 'file exsit.';
					exit;
				}
				$sql = "INSERT INTO `files` (`id`, `file`) VALUES (NULL, '$path')";
				mysql_query($sql);
				$file_id = mysql_insert_id();
				//处理文件
				$up_file = file_get_contents($file);
				$up_file = explode("\r\n", $up_file);
				//print_r($up_file);echo "<b/>";
				foreach($up_file as $key=>$value)
				{
					//echo $key;echo "<b/>";
					$value = addslashes($value);
					$key++;
					$sql = "INSERT INTO `points` (`id`, `file`, `file_id`,`line_number`, `content`) VALUES (NULL, '$path', '$file_id', '$key', '$value')";
					mysql_query($sql);
				}//echo 'ok';exit;
				
				unlink($file);
			} else {
				include "html/up_file.html";
			} //else
			break; //up_student_class
		
		case 'information':
			if(isset($_GET['in_action']) &&  $_GET['in_action']=='add_remark' && isset($_GET['points_id']))
			{
				if(isset($_POST['remark']))
				{
					$remark = $_POST['remark'];
					$points_id = $_GET['points_id'];
					$sql = "update `points` set `remark`='$remark' where `id`='$points_id'";
					mysql_query($sql);
					header("Location:".$_POST['refer']);
				} else {
					$refer = $_SERVER['HTTP_REFERER'];	
					echo '<form action="#" method="post" enctype="multipart/form-data">
					<a>点备注：</a><br/>
					<textarea name="remark" cols="90" rows="4"></textarea>
					<br/>
					<input name="refer" type="hidden" value="'.$refer.'" />
					<input type="submit" name="submit" value="提交备注" />
					</form>';
				}
			} else if(isset($_GET['in_action']) && isset($_GET['files_id']) &&  $_GET['in_action']=='line_function' && isset($_GET['points_id'])) {
				include './html/information_line_function.html';
			} else if(isset($_GET['in_action']) && isset($_GET['files_id']) &&  $_GET['in_action']=='add_function')
			{
				include './html/information_add_function.html';
			} else if(isset($_GET['in_action']) && isset($_GET['files_id']) &&  $_GET['in_action']=='add_function_path')
			{
				include './html/information_add_function_path.html';
			} else if(isset($_GET['in_action']) && isset($_GET['files_id']) &&  $_GET['in_action']=='del')
			{
				$id = $_GET['files_id'];
				$sql = "select * from `files` where `id`='$id'";
				$result = mysql_query($sql);
				$res = mysql_fetch_assoc($result);
				$file = $res['file'];
				$sql = "delete from `points` where `file` like '$file'";
				mysql_query($sql);
				$sql = "delete from `files` where `id`='$id'";
				mysql_query($sql);
				header("Location:".$_SERVER['HTTP_REFERER']);
				//paths呢？
			} else if(isset($_GET['points_id'])){
				if(isset($_GET['in_action']) && $_GET['in_action']=='line_db')
				{
					$id = $_GET['points_id'];
					$sql = "select * from `points` where `points`.`id` ='$id'";
					$result = mysql_query($sql);
					while($res = mysql_fetch_assoc($result))
					{
						if(empty($res['db_action']))
						{
							break;
						}
						$db_aciton = $res['db_action'];
						$db_line = explode("&", $res['db_line']);
						echo "<table class='itable'>
									<caption>目前关联的数据库,操作$db_aciton</caption><tr>
									<th>表名</th>
									<th>列名</th>
									</tr>";
						foreach($db_line as $value)
						{
							$value = explode("#", $value);
							$table = $value[0];
							$colmn = $value[1];
							echo "<tr>
									<th>$table</th>
									<th>$colmn</th>
									</tr>";
						} //foreach
						echo "</table><br/><br/><hr/><br/>";
					} //while
					
					if(isset($_POST['refer']) && isset($_POST['db']) && isset($_POST['table']))
					{
						$id = $_GET['points_id'];
						$db = $_POST['db'];
						$table = implode("&", $_POST['table']);
						$sql = "UPDATE  `points` SET  `db_action` =  '$db',`db_line` =  '$table' WHERE  `points`.`id` ='$id'";
						mysql_query($sql);
						header("Location:".$_POST['refer']);
						exit;
					}
					$sql = "show tables from `test_php_check`";
					$result = mysql_query($sql);
					$refer = $_SERVER['HTTP_REFERER'];
					echo '<form action="#" method="post" enctype="multipart/form-data">
							<div align="center">
								<input name="db" type="radio" value="in" />数据插入
								<input name="db" type="radio" value="out" />数据取出
							</div><br/><hr/><br/>
							<input name="refer" type="hidden" value="'.$refer.'" />
						  <table class="itable">
								<caption>数据库列表</caption>
								<tr>
								<th>选择</th>
								<th>表名</th>
								<th>列名</th>
								</tr>';
					while($res = mysql_fetch_assoc($result))
					{
						$table = $res['Tables_in_test_php_check'];
						$sql = "show columns from `$table` from `test_php_check`";
						$result_in = mysql_query($sql);
						while($res_in = mysql_fetch_assoc($result_in))
						{
							$column = $res_in['Field'];
							echo "<tr><th><input name='table[]' type='checkbox' value='$table#$column' /></th><th>$table</th><th>$column</th></tr>";
						}
					}
					echo '</table><input type="submit" name="submit" value="提交" /></form>';
				} else if(isset($_GET['in_action']) && $_GET['in_action']=='add_variable')
				{
					echo '<form action="" method="post">
						  <p>变量名 <input type="text" name="variable" /></p>
						  <p>变量值<input type="text" name="value" /></p>
						  <p><input name="from" type="radio" value="0" checked/>来自用户
								<input name="from" type="radio" value="1" />来自数据库</p>
								<input name="from" type="radio" value="-1" />来自文件</p>
						  <p><input type="text" name="refer" value="';
						  echo $_SERVER['HTTP_REFERER'];
						  echo '"/></p>
								  <input type="submit" value="Submit" />
								</form>';
					if(isset($_POST['variable']) && isset($_POST['value'])) {
						$variable = $_POST['variable'];
						$value = $_POST['value'];
						$from = $_POST['from'];
						$sql = "INSERT INTO `variables` (`id`, `variable`, `value`, `use`, `from`) VALUES (NULL, '$variable', '$value', 0, '$from');";
						mysql_query($sql);
						header("Location:".$_POST['refer']);
					}
				} else if(isset($_GET['in_action']) && $_GET['in_action']=='no_check')
				{
					$sql = "UPDATE `points` SET `level` = '-2', `position` = '-2' WHERE `id` = '".$_GET['points_id']."'";
					mysql_query($sql);
					$refer = $_SERVER['HTTP_REFERER'];
					header("location:".$refer);
				} else if(isset($_GET['in_action']) && $_GET['in_action']=='merge'){
					if($_GET['preid'] == -1){
						echo 'error!';
						exit;
					}

					$preid = $_GET['preid'];
					$id = $_GET['points_id'];
					$sql = "select * from `points` where id='$preid' or id='$id'";
					$result = mysql_query($sql);
					$content = "";
					while($res = mysql_fetch_assoc($result))
					{
						$content .= $res['content']."\r\n";
					}
					$content = addslashes($content);
					$sql = "update `points` set `content` = '$content' where `id`='$preid'";
					mysql_query($sql);

					$sql = "UPDATE `points` SET `level` = '-2', `position` = '-2' WHERE `id` = '".$_GET['points_id']."'";
					mysql_query($sql);
					$refer = $_SERVER['HTTP_REFERER'];
					header("location:".$refer);
				}else if(isset($_GET['in_action']) && $_GET['in_action']=='line'){
					echo '<form action="" method="post">
						<a href="';
						echo $url_this;
					echo '&in_action=add_variable">添加变量</a><br/><hr/><br/>
						<table class="itable">
						<caption>现有的变量</caption>
						<tr>
						<th>选择</th>
						<th>ID</th>
						<th>变量名</th>
						<th>变量值</th>
						<th>变量来源</th>
						</tr>';
			
					if(isset($_POST['v_file']) && isset($_POST['v_line']))
					{
						$file = $_POST['v_file'];
						$line = $_POST['v_line'];
						$sql = "SELECT id  FROM `points` WHERE `file` LIKE '$file' AND `line_number` = $line";
						$res = mysql_query($sql);
						$res = mysql_fetch_assoc($res);
						$point_v_id = $res['id'];
						if(empty($point_v_id))
						{
							echo 'v is not found!';
							exit;
						}
						
						if(isset($_POST['checkbox']))
						{
							foreach($_POST['checkbox'] as $value)
							{
								$sql = "UPDATE  `variables` SET  `use` =  '1' WHERE  `id` ='$value'";
								mysql_query($sql);
							}
						} else {
							$_POST['checkbox']  = array();
						}
						$point_u_id = $_GET['points_id'];
						
						$ids = addslashes(serialize($_POST['checkbox']));
						$sql = "INSERT INTO `lines` (`id`, `point_u_id`, `point_v_id`, `variables_ids`) VALUES (NULL, '$point_u_id', '$point_v_id', '$ids')";
						mysql_query($sql);
					}
					
					$sql = "SELECT * FROM  `variables` where `use`=0";
					$res = mysql_query($sql);
					while($value = mysql_fetch_assoc($res))
					{
						echo "<tr>
							<td><input name='checkbox[]' value='".$value['id']."' type='checkbox'/></td>
							<td>".$value['id']."</td>
							<td>".$value['variable']."</td>
							<td><pre>".htmlspecialchars($value['value'])."</pre></td>
							<td>".$variables_from[$value['from']]."</td>
							</tr>";
					}
					echo "<a>目标文件：</a><input name='v_file' type='input'/><br/><a>目标文件所在行：</a><input name='v_line' type='input'/><br/><hr/></table>";
					echo '<input type="submit" value="添加线" /><hr/>';
					echo '</form>
							<hr/>
							<table class="itable">
									<caption>现有的线</caption>
									<tr>
									<th>文件A</th>
									<th>所在行</th>
									<th>文件B</th>
									<th>所在行</th>
									</tr>';
					$point_u_id = $_GET['points_id'];
					$sql = "select * from `lines` where `point_u_id`='$point_u_id'";
					$result = mysql_query($sql);
					while($res = mysql_fetch_assoc($result))
					{
						$u = $res['point_u_id'];
						$v = $res['point_v_id'];
						$sql = "select * from `points` where id ='$u'";
						$res_u = mysql_fetch_assoc(mysql_query($sql));
						$sql = "select * from `points` where id ='$v'";
						$res_v = mysql_fetch_assoc(mysql_query($sql));
						echo "<tr>
							<td>".$res_u['file']."</td>
							<td>".$res_u['line_number']."</td>
							<td>".$res_v['file']."</td>
							<td>".$res_v['line_number']."</td>
							</tr>";
					}
					echo '</table>';
					echo "<a href='index.php?action=information&files_id=".$_GET['files_id']."'>返回文件！</a>";
				} else {
					echo '<div align="center"><form action="" method="post">
						    <p>点位置:<input type="radio" value="1" name="position">入口行
									<input type="radio" value="0" name="position" checked >中间行
									<input type="radio" value="-1" name="position">结束行
									</p><br/><hr/><br/>
						    <p>危险级别:<input type="radio" value="1" name="level">危险
									<input type="radio" value="0" name="level" checked >不危险
									</p><br/><hr/><br/>
							<p>角色:<input type="radio" value="-1" name="role_id" checked >未定义';
					foreach($static_role as $key => $value)
					{
						echo '<input type="radio" value="'.$key.'" name="role_id">'.$value['role'];
					}
					echo '</p><br/><hr/><br/>
						  <input type="submit" value="提交" />
						  <p><input type="text" name="refer" value="';
					echo $_SERVER['HTTP_REFERER'];
					echo '"/></p>	</form></div>';
					//改写角色
					if(isset($_POST['role_id']))
					{
						$role_id = $_POST['role_id'];
						$sql = "UPDATE `points` SET `role_id` = '$role_id' WHERE `id` = '".$_GET['points_id']."'";
						mysql_query($sql);
					}
					if(isset($_POST['position']) && isset($_POST['level']))
					{
						$position = $_POST['position'];
						$level = $_POST['level'];
						$sql = "UPDATE `points` SET `level` = '$level', `position` = '$position' WHERE `id` = '".$_GET['points_id']."'";
						mysql_query($sql);
						header("Location:".$_POST['refer']);
					} //if
				}
			} else if(isset($_GET['files_id'])){
				include 'html/information_files.html';
			} else {
				include "html/information.html";
			} //else
			break; 
			
		case 'cal_path':
			include './html/cal_path.html';
			break;
			
		case 'show_path':
			if(isset($_GET['path_id']))
			{
				$id = $_GET['path_id'];
				//删除路径
				if(isset($_GET['inaction']) && $_GET['inaction']=='del')
				{
					//将数据复制到del_paths
					$sql = "insert into del_paths(`md5`,`points_id`,`lines_id`,`check`,`start_file`,`start_line`,`end_file`,`end_line`,`remark`) select `md5`,`points_id`,`lines_id`,`check`,`start_file`,`start_line`,`end_file`,`end_line`,`remark` from paths where id='$id'";
					mysql_query($sql);
					
					//删除paths中以当前路径为前缀的数据，这里必须包括路径和变量
					$sql = "SELECT * FROM  `paths` WHERE  `id` = '$id'";
					$result = mysql_query($sql);
					$res = mysql_fetch_assoc($result);
					
					//check为-2表示这条路径不可能存在
					$points_id = addslashes(substr($res['points_id'], strpos($res['points_id'], "{")+1, -1));
					$lines_id = addslashes(substr($res['lines_id'], strpos($res['lines_id'], "{")+1, -1));
					$sql = 'update `paths` set `check`=-2 where `points_id` like "%'.$points_id.'%" and `lines_id` like "%'.$lines_id.'%"';
					mysql_query($sql);
					//exit;
					//返回查看路径
					$refer = $_SERVER['HTTP_REFERER'];
					header("Location:".$refer);
					exit;
				} else if(isset($_GET['inaction']) && $_GET['inaction']=='checked')
				{
					$sql = "update `paths` set `check`=1 where `id`=$id";
					mysql_query($sql);
					//返回查看路径
					$refer = $_SERVER['HTTP_REFERER'];
					header("Location:./index.php?action=show_path");
					exit;
				}
				//更新备注
				if(isset($_POST['remark']))
				{
					$remark = $_POST['remark'];
					$sql = "update `paths` set `remark` = '$remark' where id='$id'";
					mysql_query($sql);
				}
				echo '<table class="itable">
					<caption>ID为'.$id.'的详细路径</caption>
						<tr>
						<th>文件名</th>
						<th>文件所在行</th>
						<th style="text-align:left">代码</th>
						<th>危险级别</th>
						<th>变量</th>
						<th>备注</th>
						</tr>';
				//数据库中lines表必须存在一个ID为-1的列
				$sql = "SELECT * FROM  `paths` WHERE  `id` = '$id'";
				$result = mysql_query($sql);
				$res = mysql_fetch_assoc($result);
				$points_id = implode(",", unserialize($res['points_id']));
				$lines_id = implode(",", unserialize($res['lines_id']));
				$remark = $res['remark'];
				$sql = "select * from `lines` where `id` in ($lines_id) order by find_in_set(id,'$lines_id')";
				$result_lines = mysql_query($sql);
				$sql = "select * from `points` where `id` in ($points_id) order by find_in_set(id,'$points_id')";
				$result = mysql_query($sql);
				while($res = mysql_fetch_assoc($result))
				{
					$lines = @mysql_fetch_assoc($result_lines);
					echo "<tr>
							<th>".$res['file']."</th>
							<th>".$res['line_number']."</th>
							<td style='text-align:left'><pre>".trim(htmlspecialchars($res['content']))."</pre></td>
							<th>";
					echo get_level($res['level']);
					echo "</th>
							<th>";
					echo get_variables(unserialize($lines['variables_ids']));
					$point_remark = $res['remark'];
					echo "</th><th>$point_remark</th>
					</tr>"; 
				} //while
				echo "<tr><th>备注：</th><th colspan='4'>$remark</th></tr>";
				echo '</table><br/><hr/><br/><p><div align="center">
					<form action="#" method="post" enctype="multipart/form-data">
					<a>路径备注：</a><br/>
					<textarea name="remark" cols="90" rows="4"></textarea>
					<br/>
					<input type="submit" name="submit" value="提交备注" />
					</form>
					</div></p><br/><hr/><br/><p><a href="'.$url_this.'&inaction=del">这条路径不可能存在的，删除这条路径(以这条路径开头的都不在列出)</a></p><br/><hr/><br/>
					<p><a href="'.$url_this.'&inaction=checked">已判断的路径</a></p>';
			} else {
				echo '<table class="itable">
					<caption>显示路径</caption>
						<tr>
						<th>ID</th>
						<th>起点文件</th>
						<th>起点行</th>
						<th>终点文件</th>
						<th>终点行</th>
						<th>备注</th>
						<th>查看</th>
						</tr>';
		
				//取出所有未判断的路径
				$sql = "SELECT * FROM  `paths` WHERE  `check` =0 LIMIT 0 , 30";
				$result = mysql_query($sql);
				while($res = mysql_fetch_assoc($result))
				{
					$path_id = $res['id'];
					echo "<tr>
					<th>$path_id</th>
					<th>".$res['start_file']."</th>
					<th>".$res['start_line']."</th>
					<th>".$res['end_file']."</th>
					<th>".$res['end_line']."</th>
					<th>".$res['remark']."</th>
					<th><a href='$url_this&path_id=$path_id'>查看</a></th>
					</tr>";
				} //while
				echo '</table>';
			} //else if
			break;
			
		default:
			echo '系统出错了，请联系管理员。';
			break;
		} //switch
	} //else
	include 'html/footer.html';
?>