<?php

	/**
	* 本函数用于生成点和函数来回的路径(暂停)
	* 
	* $point_id : 点到函数的路径
	*/
	function set_point_function_paths($point_id)
	{
		$sql = "select * from `points` where `id`='$point_id'";
		$result = mysql_query($sql);
		$res = mysql_fetch_assoc($result);
		$functions_line = unserialize($res['functions_line']);
		foreach($functions_line as $value)
		{
			$functions_id = $value['functions_id'];
			$functions_ids = $value['functions_ids'];
			
		} //foreach
	} //function set_point_function_paths

	/**
	* 本函数用于获取文件的函数
	*
	* $file_id：文件的ID
	*
	* 返回值：文件函数列表的html
	*/
	function get_files_functions_by_file_id($file_id)
	{
		$sql = "select * from `functions` where `file_id`='$file_id'";
		$result = mysql_query($sql);
		$content = '';
		while($res=mysql_fetch_assoc($result))
		{
			$file = $res['file'];
			$name = $res['name'];
			$id = $res['id'];
			$points = $res['points'];
			$content .= "<tr><td><input name='function_points' type='radio' value='$points' /><input name='function_id' type='radio' value='$id' /></td><td>$file</td><td>$name</td></tr>";
		}
		$content = "<form action='' method='POST'><input type='submit' value='提交'><table class='itable'><caption>函数列表</caption>
					<tr><td>选择</td><td>所在文件</td><td>文件名</td></tr>$content</table></form>";
		//file_put_contents("./html/files_functions.html", $content);
		return $content;
	}
	
	/**
	* 本函数用于获取并生成文件和函数
	*/
	function get_files_functions()
	{
		$sql = "select * from `functions` order by `file`";
		$result = mysql_query($sql);
		$content = '';
		while($res=mysql_fetch_assoc($result))
		{
			$file = $res['file'];
			$name = $res['name'];
			$id = $res['id'];
			//$points = $res['points'];
			$content .= "<tr><td><input name='function_id' type='radio' value='$id' /></td><td>$file</td><td>$name</td></tr>";
		}
		$content = "<form action='' method='POST'><input type='submit' value='提交'><table class='itable'><caption>函数列表</caption>
					<tr><td>选择</td><td>所在文件</td><td>文件名</td></tr>$content</table></form>";
		file_put_contents("./html/files_functions.html", $content);
	}

	/**
	* 本函数用于可能存在二次注入路径的获取
	*
	*/
	function second_insert()
	{
		//找出所有更新数据的表
		$sql = "select * from `points` where `db_action`='in'";
		$result = mysql_query($sql);
		while($res = mysql_fetch_assoc($result))
		{
			//遍历
			$column = explode("&", $res['db_line']);
			
			//获取入点之前的所有路径
			$points_id = addslashes(serialize($res['id']));
			$sql = "select * from `paths` where `points_id` like '%$points_id%'";
			$path_in = mysql_query($sql);
			$i = 0;
			$paths_in = Array();
			while($res_path = mysql_fetch_assoc($path_in))
			{
				$temp_points_id = unserialize($res_path['points_id']);
				$temp_lines_id = unserialize($res_path['lines_id']);
				//截断路径
				$paths_in[$i]['points_id'] = Array();
				$paths_in[$i]['lines_id'] = Array();
				$j = -1;
				foreach($temp_points_id as $value)
				{
					$paths_in[$i]['points_id'][] = $value;
					if($j>=0)
					{
						$paths_in[$i]['lines_id'][] = $temp_lines_id[$j];
					}
					$j++;
					if($value == $res['id'])
					{
						break;
					}
				}
				$i++;
			}
			$paths_in = array_unique($paths_in);
			//print_r($paths_in);exit;
			//print_r($column);exit;
			
			$paths = Array();
			$i = 0;
			
			$columns = "";
			foreach($column as $value)
			{
				$columns .= "`db_line` like '%$value%' or ";
			}
			$columns = substr($columns, 0, -4);
			$sql = "select * from `points` where `db_action`='out' and ($columns)";
			$result_in = mysql_query($sql);
			while($res_in = mysql_fetch_assoc($result_in))
			{
				$center_id = $res_in['id'];
				//echo "==";
				$points_id = addslashes(serialize($res_in['id']));
				//echo $points_id = addslashes(substr($points_id, strpos("{", $points_id), -1));
				//找出取出数据点的路径
				$sql = "select * from `paths` where `points_id` like '%$points_id%'";
				$result_out = mysql_query($sql);
				while($res_out = mysql_fetch_assoc($result_out))
				{
					//拼接路径
					//入点之前的所有路径+出点之后的所有路径的组合
					$path_out = unserialize($res_out['points_id']);
					$line_out = unserialize($res_out['lines_id']);
					//echo $center_id.'==';print_r($path_out);

					if(in_array($center_id, $path_out))
					{
						foreach($path_out as $key=>$value)
						{
							if($value == $center_id)
							{
								break;
							} else {
								unset($path_out[$key]);
								unset($line_out[$key]);
							}//else if　
						} //foreach
						//print_r($path_out);
						//print_r($line_out);exit;
						foreach($paths_in as $value)
						{
							//echo '入：';
							//print_r($value['points_id']);
							//echo '出：';
							//print_r($path_out);
							$paths[$i]['points_id'] = array_merge($value['points_id'], $path_out);
							$paths[$i]['lines_id'] = array_merge($value['lines_id'], array('-1'), $line_out);
							insert_path($paths[$i]['points_id'], $paths[$i]['lines_id']);
							$i++;
						} //foreach
					} //if
				} //while
			} //while
		} //while
	} //second_insert
	
	
	//print_r($static_role);exit;
	function get_role($role_id)
	{
		global $static_role;
		if($role_id==-1)
		{
			return;
		} else {
			//echo $role_id;exit;
			return $static_role[$role_id]['role'];
		}
	}
	
	function get_level($level)
	{
		global $static_level;
		if($level == 1)
		{
			return "<a style='color:red;'>危险</a>";
		} else {
			return $static_level[$level];
		}
	}
	
	
	function get_variables($variables_ids)
	{
		if(empty($variables_ids))
		{
			return;
		}
		$ids = implode(",", $variables_ids);
		$sql = "SELECT * FROM `variables` where `id` in ($ids)";
		$result = mysql_query($sql);
		$content = "";
		while($res = mysql_fetch_assoc($result))
		{
			if($res['from'] == 1)
			{
				$content .= "<a style='color:red'>".$res['variable']."=".$res['value']."(来自数据库)</a><br/>";
			} else {
				$content .= $res['variable']."=".$res['value']."<br/>";
			}
			
		}
		return $content;
	}
	
	/**
	* 越权漏洞判断
	*
	* $path路径数组
	* $path_id路径的ID 
	*
	* 默认权限切换点为2
	*/
	function unauthorized($path, $path_id)
	{
		//print_r($paths);//exit;
		//print_r($paths_id);//exit;
		$vul = false;
		$path = implode(",", $path);
		$sql = "select * from `points` where `id` in ($path) order by  find_in_set(id,'$path')";
		$result = mysql_query($sql);
		$res = mysql_fetch_assoc($result);
		$drive = true;
		//print_r($res);
		$pre = $res['role_id'];
		if($pre > 2)
		{
			$vul = true;
		} else if($res['role_id'] == 2)
		{
			$drive = false;
		} //if
		while($res = mysql_fetch_assoc($result))
		{
			//$now = $res['role_id'];
			//echo "\r\n$pre:$now\r\n";
			if($pre < $res['role_id'])
			{
				$vul = true;
			} //if
			$pre = $res['role_id'];
			if($res['role_id'] == 2)
			{
				$drive = false;
			} //if
		} //while
		//echo "\r\nvul:";
		//print_r($vul);//exit;
		//echo "\r\ndrive:";
		//print_r($drive);//exit;
		//echo "\r\n";
		if($vul && $drive)
		{
			if($path_id!=-1)
			{
				$sql = "update `paths` set `remark` = '可能存在越权漏洞' where `id` = '$path_id'";
				mysql_query($sql);
			}
			return true;//插入数据或更新成功
		}
		return false; //不插入数据库
	} //function unauthorized
	
	function insert_path($path, $lines_id)
	{
		//插入数据库
		$tmp_paths = addslashes(serialize($path));
		$tmp_lines_id = addslashes(serialize($lines_id)); 
		$md5 = md5($tmp_paths.$tmp_lines_id);
				
		$sql = "SELECT *  FROM `paths` WHERE `md5` LIKE '$md5'";
		$result_md5 = mysql_query($sql);
		$res_md5 = mysql_fetch_assoc($result_md5);
		if(!isset($res_md5['id']))
		{
			$start = $path[0];
			//echo ':';
			$end = end($path);
			//echo "\r\n";
			$sql = "select * from `points` where id in($start,$end) order by find_in_set(id,'$start,$end')";
			//echo "\r\n";
			$result = mysql_query($sql);
			$res = mysql_fetch_assoc($result);
			$start_file = $res['file'];
			$start_line = $res['line_number'];
			$res = mysql_fetch_assoc($result);
			$end_file = $res['file'];
			$end_line = $res['line_number'];
			
			$sql = "INSERT INTO `paths` (`id`, `points_id`, `lines_id`, `check`, `md5`, `start_file`, `start_line`, `end_file`, `end_line`, `remark` ) VALUES 
					(NULL, '$tmp_paths', '$tmp_lines_id', '0', '$md5', '$start_file', '$start_line', '$end_file', '$end_line', '');";
			mysql_query($sql);
			unauthorized($path, mysql_insert_id());
		} //if
	} //function insert_path
	
	/**
	* 函数调用处理函数
	*
	* $path：不包含函数路径的路径
	* $path_all：包含函数路径的全部路径
	* $lines_id：不包含函数线的线
	* $lines_id_all：包含函数线的全部线
	* $functions_line：函数ID的数组，serialize之后的值
	* $path_level：路径是否为危险路径
	* $v：下一个节点。
	*/
	function deal_function($path, $path_all, $lines_id, $lines_id_all, $functions_line, $path_level, $v)
	{
		if(!empty($functions_line))
		{
			$functions_line = unserialize($functions_line);
			foreach($functions_line as $value)
			{
				$sql = "select * from `functions` where `id`='$value'";
				$result_line = mysql_query($sql);
				$res_line = mysql_fetch_assoc($result_line);
				$paths = unserialize($res_line['paths']);
				if(!empty($paths))
				{
					foreach($paths as $value)
					{
						$path_all = array_merge($path_all, $value['path']);
						$sum = count($value['path']);
						for($i=0; $i<=$sum; $i++)
						{
							$lines_id_all[] = -1;
						}
						if($value['end'])
						{
							insert_path($path_all, $lines_id_all);
						} else {
							dep($path, $path_all, $lines_id, $lines_id_all, $v, $path_level);
						}//else if
					} //foreach
				} //if
			} //foreach 
		} else {
			dep($path, $path_all, $lines_id, $lines_id_all, $v, $path_level);
		}
	} //function deal_function
	

	/**
	* 2015-08-11：添加越权漏洞判断，如果有以低于权限的用户函数访问高权限用户函数的情况就判断为越权漏洞。
	* 2015-09-01：添加函数调用功能，改变$path数组，
	*
	* $path：不包含函数路径的路径
	* $path_all：包含函数路径的全部路径
	* $lines_id：不包含函数线的线
	* $lines_id_all：包含函数线的全部线
	* $u：当前的点
	* $path_level：当前的路径是否危险。
	*/
	function dep($path, $path_all, $lines_id, $lines_id_all, $u, $path_level)
	{
		$sql = "SELECT * FROM `lines` WHERE `point_u_id`='$u'";
		//echo "\r\nnum:";
		$result = mysql_query($sql);
		//将可能危险的路径存入数据库
		//echo mysql_num_rows($result);
		//print_r($path);
		//echo "\r\n";
		//如果没有指向了且为危险路径则将路径存入数据库
		if(mysql_num_rows($result) == 0)
		{
			//如果没有指向了则将路径存入数据库
			insert_path($path_all, $lines_id_all);
		} else {
			while($res = mysql_fetch_assoc($result))
			{
				//判断点是否出现两次来判断是否有环路发生,
				if(in_array($res['point_v_id'], $path))
				{
					echo "发生环路了！<br/>";
					print_r($path);
					print_r($lines_id);
					echo $res['id'];
					exit;
				}
				//lines
				$lines_id[] = $res['id'];
				$lines_id_all[] = $res['id'];
				//points
				$v = $res['point_v_id'];
				$path[]  = $v;
				$path_all[] = $v;
				$sql = "select * from `points` where `id`='$v'";
				$result_v = mysql_query($sql);
				$res_v = mysql_fetch_assoc($result_v);
				if($res_v['level'] == 1)
				{
					$path_level = 1;//危险，默认为0
				} //if
				deal_function($path, $path_all, $lines_id, $lines_id_all, $res_v['functions_line'], $path_level, $v);
				array_pop($lines_id);
				array_pop($path);
				array_pop($lines_id_all);
				array_pop($path_all);
			} //while
		} //if else
	} //dep
   
?>