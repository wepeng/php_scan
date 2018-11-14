-- phpMyAdmin SQL Dump
-- version 3.3.7
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2015 年 08 月 29 日 02:03
-- 服务器版本: 5.0.90
-- PHP 版本: 5.2.14

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `php_check`
--

-- --------------------------------------------------------

--
-- 表的结构 `del_paths`
--

CREATE TABLE IF NOT EXISTS `del_paths` (
  `id` int(11) NOT NULL auto_increment,
  `md5` text character set utf8 NOT NULL,
  `points_id` text character set utf8 NOT NULL,
  `lines_id` text character set utf8 NOT NULL,
  `check` int(11) NOT NULL,
  `start_file` text character set utf8 NOT NULL,
  `start_line` int(11) NOT NULL,
  `end_file` text character set utf8 NOT NULL,
  `end_line` int(11) NOT NULL,
  `remark` text character set utf8 NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `del_paths`
--


-- --------------------------------------------------------

--
-- 表的结构 `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `id` int(11) NOT NULL auto_increment,
  `file` text character set utf8 NOT NULL,
  `edit` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- 转存表中的数据 `files`
--

INSERT INTO `files` (`id`, `file`, `edit`) VALUES
(1, '/1.php', 0),
(2, '/2.php', 0),
(3, '/3.php', 0),
(8, './1_1.php', 0),
(5, './3_2.php', 0),
(6, './3_1.php', 0),
(9, './1_2.php', 0),
(12, '4_1.php', 0),
(11, '/4_2.php', 0),
(14, './4_3.php', 0),
(15, './5_1.php', 0),
(16, './5_2.php', 0),
(17, './6.php', 0);

-- --------------------------------------------------------

--
-- 表的结构 `lines`
--

CREATE TABLE IF NOT EXISTS `lines` (
  `id` int(11) NOT NULL auto_increment,
  `point_u_id` int(11) NOT NULL,
  `point_v_id` int(11) NOT NULL,
  `variables_ids` text character set utf8 NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- 转存表中的数据 `lines`
--

INSERT INTO `lines` (`id`, `point_u_id`, `point_v_id`, `variables_ids`) VALUES
(1, 7, 8, 'a:1:{i:0;s:1:"1";}'),
(2, 24, 30, 'a:0:{}'),
(3, 30, 38, 'a:2:{i:0;s:1:"4";i:1;s:1:"5";}'),
(-1, -1, -1, 'a:0:{}'),
(4, 62, 70, 'a:2:{i:0;s:1:"2";i:1;s:1:"3";}'),
(5, 94, 95, 'a:1:{i:0;s:1:"6";}'),
(6, 95, 103, 'a:0:{}'),
(7, 112, 116, 'a:0:{}'),
(8, 145, 148, 'a:0:{}'),
(9, 148, 149, 'a:0:{}'),
(10, 129, 133, 'a:0:{}'),
(11, 189, 192, 'a:0:{}'),
(12, 192, 202, 'a:0:{}'),
(13, 202, 205, 'a:0:{}'),
(15, 215, 217, 'a:0:{}');

-- --------------------------------------------------------

--
-- 表的结构 `paths`
--

CREATE TABLE IF NOT EXISTS `paths` (
  `id` int(11) NOT NULL auto_increment,
  `md5` text character set utf8 NOT NULL,
  `points_id` text character set utf8 NOT NULL,
  `lines_id` text character set utf8 NOT NULL,
  `check` int(11) NOT NULL,
  `start_file` text character set utf8 NOT NULL,
  `start_line` int(11) NOT NULL,
  `end_file` text character set utf8 NOT NULL,
  `end_line` int(11) NOT NULL,
  `remark` text character set utf8 NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=70 ;

--
-- 转存表中的数据 `paths`
--

INSERT INTO `paths` (`id`, `md5`, `points_id`, `lines_id`, `check`, `start_file`, `start_line`, `end_file`, `end_line`, `remark`) VALUES
(1, '243228c663af0895122779f4adef44d3', 'a:2:{i:0;s:1:"7";i:1;s:1:"8";}', 'a:1:{i:0;s:1:"1";}', 1, '/1.php', 7, '/1.php', 8, '123456'),
(2, 'c5412258332a5b68efbc7623301ed46b', 'a:1:{i:0;s:2:"16";}', 'a:0:{}', 1, '/2.php', 7, '', 0, ''),
(3, '1771a61f4ea96b09e2c886d0d12645c0', 'a:3:{i:0;s:2:"24";i:1;s:2:"30";i:2;s:2:"38";}', 'a:2:{i:0;s:1:"2";i:1;s:1:"3";}', 1, '/3.php', 7, '/3.php', 21, ''),
(4, 'f056400afee03a86d4e9cf2055e05c2b', 'a:2:{i:0;s:2:"62";i:1;s:2:"70";}', 'a:1:{i:0;s:1:"4";}', 1, './3_2.php', 8, './3_2.php', 16, ''),
(5, '3dfcfe8f948346118c807c7549e4d378', 'a:1:{i:0;s:2:"81";}', 'a:0:{}', 1, './3_1.php', 7, '', 0, ''),
(6, '1bff5f936610fc078c47ca24123cb656', 'a:3:{i:0;s:2:"24";i:1;s:2:"30";i:2;s:2:"38";}', 'a:2:{i:0;s:2:"-1";i:1;s:1:"3";}', 1, '/3.php', 7, '/3.php', 21, ''),
(7, 'a96400e50b548138d4404c2139f93f30', 'a:2:{i:0;s:2:"24";i:1;s:2:"38";}', 'a:1:{i:0;s:2:"-1";}', 1, '/3.php', 7, '/3.php', 21, ''),
(8, '1d8a4b3953862e72efbc00be556cd609', 'a:3:{i:0;s:2:"24";i:1;s:2:"62";i:2;s:2:"70";}', 'a:2:{i:0;s:2:"-1";i:1;s:1:"4";}', 1, '/3.php', 7, './3_2.php', 16, ''),
(9, '450ab794ec43c512ec27e34ec93c764d', 'a:2:{i:0;s:2:"24";i:1;s:2:"70";}', 'a:1:{i:0;s:2:"-1";}', 1, '/3.php', 7, './3_2.php', 16, ''),
(10, '5a7bae7f60ca4d443318a23dfe3e3b45', 'a:3:{i:0;s:2:"81";i:1;s:2:"30";i:2;s:2:"38";}', 'a:2:{i:0;s:2:"-1";i:1;s:1:"3";}', 1, '/3.php', 21, './3_1.php', 7, ''),
(11, '709fa631bb20e1eaa6b019d89b790792', 'a:2:{i:0;s:2:"81";i:1;s:2:"38";}', 'a:1:{i:0;s:2:"-1";}', 1, '/3.php', 21, './3_1.php', 7, ''),
(12, '7b3485c38e884f0d82ed24eb76cceefa', 'a:3:{i:0;s:2:"81";i:1;s:2:"62";i:2;s:2:"70";}', 'a:2:{i:0;s:2:"-1";i:1;s:1:"4";}', 1, './3_2.php', 16, './3_1.php', 7, ''),
(58, '2af52fd6894074cba45f4fd4132098bc', 'a:1:{i:0;s:3:"178";}', 'a:0:{}', 1, './4_3.php', 8, '', 0, '可能存在越权漏洞'),
(60, 'f0125e45edc76a8fcd8d366555a3c453', 'a:3:{i:0;s:3:"145";i:1;s:3:"148";i:2;s:3:"149";}', 'a:2:{i:0;s:1:"8";i:1;s:1:"9";}', 1, '4_1.php', 12, '4_1.php', 8, ''),
(62, '4abbd9a7b620a2560f3d40e3e746f5c4', 'a:2:{i:0;s:2:"81";i:1;s:2:"70";}', 'a:1:{i:0;s:2:"-1";}', 1, './3_2.php', 16, './3_1.php', 7, ''),
(61, 'ee8522a8a098c133485d126e95e1edbe', 'a:2:{i:0;s:3:"129";i:1;s:3:"133";}', 'a:1:{i:0;s:2:"10";}', 1, '/4_2.php', 12, '/4_2.php', 8, '可能存在越权漏洞'),
(59, '0af53e2ec3015034bf78b7680716efcb', 'a:3:{i:0;s:2:"94";i:1;s:2:"95";i:2;s:3:"103";}', 'a:2:{i:0;s:1:"5";i:1;s:1:"6";}', 1, './1_2.php', 7, './1_1.php', 7, ''),
(68, '1a90bd1071c1003c1fa8a9b6110695ae', 'a:3:{i:0;s:2:"81";i:1;s:3:"129";i:2;s:3:"133";}', 'a:2:{i:0;s:2:"-1";i:1;s:2:"10";}', 0, './3_1.php', 7, '/4_2.php', 12, '可能存在越权漏洞'),
(67, 'd531af3706f6bc4a133f75aa5f4bdbdd', 'a:3:{i:0;s:2:"24";i:1;s:3:"129";i:2;s:3:"133";}', 'a:2:{i:0;s:2:"-1";i:1;s:2:"10";}', 0, '/3.php', 7, '/4_2.php', 12, '可能存在越权漏洞'),
(69, 'bcf1fb1c9c757397147a20807468ca36', 'a:2:{i:0;s:3:"215";i:1;s:3:"217";}', 'a:1:{i:0;s:2:"15";}', 0, './6.php', 7, './6.php', 9, '控制a可以造成DDOS漏洞。');

-- --------------------------------------------------------

--
-- 表的结构 `points`
--

CREATE TABLE IF NOT EXISTS `points` (
  `id` int(11) NOT NULL auto_increment,
  `file` text character set utf8 NOT NULL,
  `line_number` int(11) NOT NULL,
  `level` int(11) default '-3',
  `position` int(11) default '-3',
  `content` text character set utf8 NOT NULL,
  `role_id` int(11) NOT NULL default '-1',
  `db_action` text NOT NULL,
  `db_line` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=225 ;

--
-- 转存表中的数据 `points`
--

INSERT INTO `points` (`id`, `file`, `line_number`, `level`, `position`, `content`, `role_id`, `db_action`, `db_line`) VALUES
(1, '/1.php', 1, -2, -2, '﻿<?php\r\n/**\r\n* 测试用例\r\n*\r\n* 简单测试系统是否正常工作\r\n*/\r\n\r\n\r\n\r\n\r\n', -1, '', ''),
(2, '/1.php', 2, -2, -2, '/**\r\n* 测试用例\r\n*\r\n* 简单测试系统是否正常工作\r\n*/\r\n\r\n\r\n\r\n', -1, '', ''),
(3, '/1.php', 3, -2, -2, '* 测试用例\r\n*\r\n* 简单测试系统是否正常工作\r\n*/\r\n\r\n\r\n', -1, '', ''),
(4, '/1.php', 4, -2, -2, '*\r\n* 简单测试系统是否正常工作\r\n*/\r\n\r\n', -1, '', ''),
(5, '/1.php', 5, -2, -2, '* 简单测试系统是否正常工作\r\n*/\r\n', -1, '', ''),
(6, '/1.php', 6, -2, -2, '*/', -1, '', ''),
(7, '/1.php', 7, 0, 1, '$a = $_GET[''id''];', 1, '', ''),
(8, '/1.php', 8, 1, -1, 'eval($a);', 1, '', ''),
(9, '/1.php', 9, -2, -2, '?>', -1, '', ''),
(10, '/2.php', 1, -2, -2, '﻿<?php', -1, '', ''),
(11, '/2.php', 2, -2, -2, '/**', -1, '', ''),
(12, '/2.php', 3, -2, -2, '* 测试用例', -1, '', ''),
(13, '/2.php', 4, -2, -2, '*', -1, '', ''),
(14, '/2.php', 5, -2, -2, '* 简单测试只有一条语句的情况下系统是否正常工作', -1, '', ''),
(15, '/2.php', 6, -2, -2, '*/', -1, '', ''),
(16, '/2.php', 7, 1, 1, 'eval($_GET[''id'']);', 1, '', ''),
(17, '/2.php', 8, -2, -2, '?>', -1, '', ''),
(18, '/3.php', 1, -2, -2, '﻿<?php\r\n/**\r\n* 测试用例\r\n*\r\n* 二次注入漏洞\r\n*/\r\n\r\n\r\n\r\n\r\n', -1, '', ''),
(19, '/3.php', 2, -2, -2, '/**\r\n* 测试用例\r\n*\r\n* 二次注入漏洞\r\n*/\r\n\r\n\r\n\r\n', -1, '', ''),
(20, '/3.php', 3, -2, -2, '* 测试用例\r\n*\r\n* 二次注入漏洞\r\n*/\r\n\r\n\r\n', -1, '', ''),
(21, '/3.php', 4, -2, -2, '*\r\n* 二次注入漏洞\r\n*/\r\n\r\n', -1, '', ''),
(22, '/3.php', 5, -2, -2, '* 二次注入漏洞\r\n*/\r\n', -1, '', ''),
(23, '/3.php', 6, -2, -2, '*/', -1, '', ''),
(24, '/3.php', 7, 1, 1, '//数据插入\r\n$user = $_GET[''user''];\r\n$pass = $_GET[''pass''];\r\n$sql = "INSERT INTO `admin` (`user`, `pass`) VALUES (''$user'', ''$pass'')";\r\nmysql_query($sql);\r\n\r\n\r\n\r\n', 1, 'in', 'admin#user&admin#pass'),
(25, '/3.php', 8, -2, -2, '$user = $_GET[''user''];\r\n$pass = $_GET[''pass''];\r\n$sql = "INSERT INTO `admin` (`user`, `pass`) VALUES (''$user'', ''$pass'')";\r\nmysql_query($sql);\r\n\r\n\r\n', -1, '', ''),
(26, '/3.php', 9, -2, -2, '$pass = $_GET[''pass''];\r\n$sql = "INSERT INTO `admin` (`user`, `pass`) VALUES (''$user'', ''$pass'')";\r\nmysql_query($sql);\r\n\r\n', -1, '', ''),
(27, '/3.php', 10, -2, -2, '$sql = "INSERT INTO `admin` (`user`, `pass`) VALUES (''$user'', ''$pass'')";\r\nmysql_query($sql);\r\n', -1, '', ''),
(28, '/3.php', 11, -2, -2, 'mysql_query($sql);', -1, '', ''),
(29, '/3.php', 12, -2, -2, '', -1, '', ''),
(30, '/3.php', 13, 1, 0, '//数据取出\r\n$id = $_GET[''id''];\r\n\r\n$sql = "select * from `admin` where user = ''$id''";\r\n\r\n$result = mysql_query($sql);\r\n\r\n$res = mysql_fetch_assoc($result);\r\n\r\n$user = $res[''user''];\r\n\r\n$pass = $res[''pass''];\r\n', 1, 'out', 'admin#id&admin#user&admin#pass'),
(31, '/3.php', 14, -2, -2, '$id = $_GET[''id''];', -1, '', ''),
(32, '/3.php', 15, -2, -2, '$sql = "select * from `admin` where user = ''$id''";', -1, '', ''),
(33, '/3.php', 16, -2, -2, '$result = mysql_query($sql);', -1, '', ''),
(34, '/3.php', 17, -2, -2, '$res = mysql_fetch_assoc($result);', -1, '', ''),
(35, '/3.php', 18, -2, -2, '$user = $res[''user''];', -1, '', ''),
(36, '/3.php', 19, -2, -2, '$pass = $res[''pass''];', -1, '', ''),
(37, '/3.php', 20, -2, -2, '', -1, '', ''),
(38, '/3.php', 21, 1, -1, '//数据再次查询\r\n$sql = "select * from `admin` where user = ''$user'' and pass = ''$pass''";\r\n\r\nmysql_query($sql);\r\n', 1, 'out', 'admin#id&admin#user&admin#pass'),
(39, '/3.php', 22, -2, -2, '$sql = "select * from `admin` where user = ''$user'' and pass = ''$pass''";', -1, '', ''),
(40, '/3.php', 23, -2, -2, 'mysql_query($sql);', -1, '', ''),
(41, '/3.php', 24, -2, -2, '\r\n?>\r\n', -1, '', ''),
(42, '/3.php', 25, -2, -2, '?>', -1, '', ''),
(94, './1_1.php', 7, 0, 1, '$a = $_GET[''id''];', 1, '', ''),
(93, './1_1.php', 6, -2, -2, '*/', -1, '', ''),
(92, './1_1.php', 5, -2, -2, '* 简单测试系统是否正常工作', -1, '', ''),
(91, './1_1.php', 4, -2, -2, '*', -1, '', ''),
(89, './1_1.php', 2, -2, -2, '/**', -1, '', ''),
(90, './1_1.php', 3, -2, -2, '* 测试用例', -1, '', ''),
(88, './1_1.php', 1, -2, -2, '﻿<?php\r\n/**\r\n\r\n* 测试用例\r\n\r\n*\r\n\r\n* 简单测试系统是否正常工作\r\n\r\n*/\r\n', -1, '', ''),
(55, './3_2.php', 1, -2, -2, '﻿<?php\r\n/**\r\n\r\n* 测试用例\r\n\r\n*\r\n\r\n* 二次注入漏洞\r\n\r\n*/\r\n\r\n\r\n', -1, '', ''),
(56, './3_2.php', 2, -2, -2, '/**', -1, '', ''),
(57, './3_2.php', 3, -2, -2, '* 测试用例', -1, '', ''),
(58, './3_2.php', 4, -2, -2, '*', -1, '', ''),
(59, './3_2.php', 5, -2, -2, '* 二次注入漏洞', -1, '', ''),
(60, './3_2.php', 6, -2, -2, '*/', -1, '', ''),
(61, './3_2.php', 7, -2, -2, '', -1, '', ''),
(62, './3_2.php', 8, 1, 1, '//数据取出\r\n$id = $_GET[''id''];\r\n\r\n$sql = "select * from `admin` where user = ''$id''";\r\n\r\n$result = mysql_query($sql);\r\n\r\n$res = mysql_fetch_assoc($result);\r\n\r\n$user = $res[''user''];\r\n\r\n$pass = $res[''pass''];\r\n', 1, 'out', 'admin#user&admin#pass'),
(63, './3_2.php', 9, -2, -2, '$id = $_GET[''id''];', -1, '', ''),
(64, './3_2.php', 10, -2, -2, '$sql = "select * from `admin` where user = ''$id''";', -1, '', ''),
(65, './3_2.php', 11, -2, -2, '$result = mysql_query($sql);', -1, '', ''),
(66, './3_2.php', 12, -2, -2, '$res = mysql_fetch_assoc($result);', -1, '', ''),
(67, './3_2.php', 13, -2, -2, '$user = $res[''user''];', -1, '', ''),
(68, './3_2.php', 14, -2, -2, '$pass = $res[''pass''];', -1, '', ''),
(69, './3_2.php', 15, -2, -2, '', -1, '', ''),
(70, './3_2.php', 16, 1, -1, '//数据再次查询\r\n$sql = "select * from `admin` where user = ''$user'' and pass = ''$pass''";\r\n\r\nmysql_query($sql);\r\n', 1, 'out', 'admin#user&admin#pass'),
(71, './3_2.php', 17, -2, -2, '$sql = "select * from `admin` where user = ''$user'' and pass = ''$pass''";', -1, '', ''),
(72, './3_2.php', 18, -2, -2, 'mysql_query($sql);', -1, '', ''),
(73, './3_2.php', 19, -2, -2, '\r\n?>\r\n', -1, '', ''),
(74, './3_2.php', 20, -2, -2, '?>', -1, '', ''),
(75, './3_1.php', 1, -2, -2, '﻿<?php\r\n/**\r\n\r\n* 测试用例\r\n\r\n*\r\n\r\n* 二次注入漏洞\r\n\r\n*/\r\n', -1, '', ''),
(76, './3_1.php', 2, -2, -2, '/**', -1, '', ''),
(77, './3_1.php', 3, -2, -2, '* 测试用例', -1, '', ''),
(78, './3_1.php', 4, -2, -2, '*', -1, '', ''),
(79, './3_1.php', 5, -2, -2, '* 二次注入漏洞', -1, '', ''),
(80, './3_1.php', 6, -2, -2, '*/', -1, '', ''),
(81, './3_1.php', 7, 1, 1, '//数据插入\r\n$user = $_GET[''user''];\r\n$pass = $_GET[''pass''];\r\n$sql = "INSERT INTO `admin` (`user`, `pass`) VALUES (''$user'', ''$pass'')";\r\nmysql_query($sql);\r\n\r\n\r\n\r\n', 1, 'in', 'admin#user&admin#pass'),
(82, './3_1.php', 8, -2, -2, '$user = $_GET[''user''];\r\n$pass = $_GET[''pass''];\r\n$sql = "INSERT INTO `admin` (`user`, `pass`) VALUES (''$user'', ''$pass'')";\r\nmysql_query($sql);\r\n\r\n\r\n', -1, '', ''),
(83, './3_1.php', 9, -2, -2, '$pass = $_GET[''pass''];\r\n$sql = "INSERT INTO `admin` (`user`, `pass`) VALUES (''$user'', ''$pass'')";\r\nmysql_query($sql);\r\n\r\n', -1, '', ''),
(84, './3_1.php', 10, -2, -2, '$sql = "INSERT INTO `admin` (`user`, `pass`) VALUES (''$user'', ''$pass'')";\r\nmysql_query($sql);\r\n', -1, '', ''),
(85, './3_1.php', 11, -2, -2, 'mysql_query($sql);', -1, '', ''),
(86, './3_1.php', 12, -2, -2, '?>', -1, '', ''),
(95, './1_1.php', 8, 0, 0, 'include ''1_2.php'';', 1, '', ''),
(96, './1_1.php', 9, -2, -2, '?>', -1, '', ''),
(97, './1_2.php', 1, -2, -2, '﻿<?php\r\n/**\r\n\r\n* 测试用例\r\n\r\n*\r\n\r\n* 简单测试系统是否正常工作\r\n\r\n*/\r\n', -1, '', ''),
(98, './1_2.php', 2, -2, -2, '/**', -1, '', ''),
(99, './1_2.php', 3, -2, -2, '* 测试用例', -1, '', ''),
(100, './1_2.php', 4, -2, -2, '*', -1, '', ''),
(101, './1_2.php', 5, -2, -2, '* 简单测试系统是否正常工作', -1, '', ''),
(102, './1_2.php', 6, -2, -2, '*/', -1, '', ''),
(103, './1_2.php', 7, 1, -1, 'eval($a);', 1, '', ''),
(104, './1_2.php', 8, -2, -2, '?>', -1, '', ''),
(153, '4_1.php', 16, -2, -2, '\r\n?>\r\n', -1, '', ''),
(151, '4_1.php', 14, -2, -2, '	show_admin();', -1, '', ''),
(150, '4_1.php', 13, -2, -2, '	//显示管理', -1, '', ''),
(149, '4_1.php', 12, 0, -1, '{\r\n	//显示管理\r\n\r\n	show_admin();\r\n\r\n} //if\r\n', 4, '', ''),
(148, '4_1.php', 11, 1, 0, 'if(mysql_num_rows($result)>0)', 2, '', ''),
(145, '4_1.php', 8, 1, 1, '//权限判断\r\n$sql = "select * from `admin` where user = ''$user'' and pass = ''$pass''";\r\n\r\n$result = mysql_query($sql);\r\n', 1, '', ''),
(146, '4_1.php', 9, -2, -2, '$sql = "select * from `admin` where user = ''$user'' and pass = ''$pass''";', -1, '', ''),
(144, '4_1.php', 7, -2, -2, '', -1, '', ''),
(143, '4_1.php', 6, -2, -2, '*/', -1, '', ''),
(141, '4_1.php', 4, -2, -2, '*', -1, '', ''),
(140, '4_1.php', 3, -2, -2, '* 测试用例', -1, '', ''),
(139, '4_1.php', 2, -2, -2, '/**', -1, '', ''),
(138, '4_1.php', 1, -2, -2, '﻿<?php\r\n/**\r\n\r\n* 测试用例\r\n\r\n*\r\n\r\n* 越权漏洞判断-无漏洞\r\n\r\n*/\r\n\r\n\r\n', -1, '', ''),
(122, '/4_2.php', 1, -2, -2, '﻿<?php\r\n/**\r\n\r\n* 测试用例\r\n\r\n*\r\n\r\n* 越权漏洞判断-有漏洞\r\n\r\n*/\r\n\r\n\r\n', -1, '', ''),
(123, '/4_2.php', 2, -2, -2, '/**', -1, '', ''),
(124, '/4_2.php', 3, -2, -2, '* 测试用例', -1, '', ''),
(125, '/4_2.php', 4, -2, -2, '*', -1, '', ''),
(126, '/4_2.php', 5, -2, -2, '* 越权漏洞判断-有漏洞', -1, '', ''),
(127, '/4_2.php', 6, -2, -2, '*/', -1, '', ''),
(128, '/4_2.php', 7, -2, -2, '', -1, '', ''),
(129, '/4_2.php', 8, 1, 1, '//权限判断\r\n$sql = "select * from `admin` where user = ''$user'' and pass = ''$pass''";\r\n\r\n$result = mysql_query($sql);\r\n', 1, 'out', 'admin#user&admin#pass'),
(130, '/4_2.php', 9, -2, -2, '$sql = "select * from `admin` where user = ''$user'' and pass = ''$pass''";', -1, '', ''),
(131, '/4_2.php', 10, -2, -2, '$result = mysql_query($sql);', -1, '', ''),
(132, '/4_2.php', 11, -2, -2, '', -1, '', ''),
(133, '/4_2.php', 12, 0, -1, '//显示管理界面\r\nshow_admin();\r\n', 4, '', ''),
(134, '/4_2.php', 13, -2, -2, 'show_admin();', -1, '', ''),
(135, '/4_2.php', 14, -2, -2, '\r\n\r\n?>\r\n\r\n', -1, '', ''),
(136, '/4_2.php', 15, -2, -2, '\r\n?>\r\n', -1, '', ''),
(137, '/4_2.php', 16, -2, -2, '?>', -1, '', ''),
(152, '4_1.php', 15, -2, -2, '} //if', -1, '', ''),
(147, '4_1.php', 10, -2, -2, '$result = mysql_query($sql);', -1, '', ''),
(142, '4_1.php', 5, -2, -2, '* 越权漏洞判断-无漏洞', -1, '', ''),
(154, '4_1.php', 17, -2, -2, '?>', -1, '', ''),
(182, './4_3.php', 12, -2, -2, '?>', -1, '', ''),
(181, './4_3.php', 11, -2, -2, '\r\n?>\r\n', -1, '', ''),
(180, './4_3.php', 10, -2, -2, '\r\n\r\n?>\r\n\r\n', -1, '', ''),
(179, './4_3.php', 9, -2, -2, 'show_admin();', -1, '', ''),
(178, './4_3.php', 8, 0, 1, '//显示管理界面\r\nshow_admin();\r\n', 4, '', ''),
(177, './4_3.php', 7, -2, -2, '', -1, '', ''),
(176, './4_3.php', 6, -2, -2, '*/', -1, '', ''),
(175, './4_3.php', 5, -2, -2, '* 越权漏洞判断-有漏洞', -1, '', ''),
(174, './4_3.php', 4, -2, -2, '*', -1, '', ''),
(173, './4_3.php', 3, -2, -2, '* 测试用例', -1, '', ''),
(172, './4_3.php', 2, -2, -2, '/**', -1, '', ''),
(171, './4_3.php', 1, -2, -2, '﻿<?php\r\n/**\r\n\r\n* 测试用例\r\n\r\n*\r\n\r\n* 越权漏洞判断-有漏洞\r\n\r\n*/\r\n\r\n\r\n', -1, '', ''),
(183, './5_1.php', 1, -2, -2, '﻿<?php\r\n/**\r\n\r\n* 测试用例\r\n\r\n*\r\n\r\n* 环判断\r\n\r\n*/\r\n', -1, '', ''),
(184, './5_1.php', 2, -2, -2, '/**', -1, '', ''),
(185, './5_1.php', 3, -2, -2, '* 测试用例', -1, '', ''),
(186, './5_1.php', 4, -2, -2, '*', -1, '', ''),
(187, './5_1.php', 5, -2, -2, '* 环判断', -1, '', ''),
(188, './5_1.php', 6, -2, -2, '*/', -1, '', ''),
(189, './5_1.php', 7, 0, 1, '//过程A\r\necho ''A'';\r\n', 1, '', ''),
(190, './5_1.php', 8, -2, -2, 'echo ''A'';', -1, '', ''),
(191, './5_1.php', 9, -2, -2, '', -1, '', ''),
(192, './5_1.php', 10, 0, 0, '//显示管理界面\r\ninclude ''5_2.php'';\r\n', 1, '', ''),
(193, './5_1.php', 11, -2, -2, 'include ''5_2.php'';', -1, '', ''),
(194, './5_1.php', 12, -2, -2, '\r\n?>\r\n', -1, '', ''),
(195, './5_1.php', 13, -2, -2, '?>', -1, '', ''),
(196, './5_2.php', 1, -2, -2, '﻿<?php\r\n/**\r\n\r\n* 测试用例\r\n\r\n*\r\n\r\n* 环判断\r\n\r\n*/\r\n', -1, '', ''),
(197, './5_2.php', 2, -2, -2, '/**', -1, '', ''),
(198, './5_2.php', 3, -2, -2, '* 测试用例', -1, '', ''),
(199, './5_2.php', 4, -2, -2, '*', -1, '', ''),
(200, './5_2.php', 5, -2, -2, '* 环判断', -1, '', ''),
(201, './5_2.php', 6, -2, -2, '*/', -1, '', ''),
(202, './5_2.php', 7, 0, 1, '//过程A\r\necho ''B'';\r\n', 1, '', ''),
(203, './5_2.php', 8, -2, -2, 'echo ''B'';', -1, '', ''),
(204, './5_2.php', 9, -2, -2, '', -1, '', ''),
(205, './5_2.php', 10, 0, 0, '//显示管理界面\r\ninclude ''5_1.php'';\r\n', 1, '', ''),
(206, './5_2.php', 11, -2, -2, 'include ''5_1.php'';', -1, '', ''),
(207, './5_2.php', 12, -2, -2, '\r\n?>\r\n', -1, '', ''),
(208, './5_2.php', 13, -2, -2, '?>', -1, '', ''),
(209, './6.php', 1, -2, -2, '﻿<?php', -1, '', ''),
(210, './6.php', 2, -2, -2, '/**\r\n* 测试用例\r\n\r\n*\r\n\r\n* DDOS漏洞\r\n\r\n*/\r\n', -1, '', ''),
(211, './6.php', 3, -2, -2, '* 测试用例', -1, '', ''),
(212, './6.php', 4, -2, -2, '*', -1, '', ''),
(213, './6.php', 5, -2, -2, '* DDOS漏洞', -1, '', ''),
(214, './6.php', 6, -2, -2, '*/', -1, '', ''),
(215, './6.php', 7, 0, 1, '//获取参数\r\n$a = $_GET[''a''];\r\n', 1, '', ''),
(216, './6.php', 8, -2, -2, '$a = $_GET[''a''];', -1, '', ''),
(217, './6.php', 9, 0, -1, '\r\n//循环\r\n\r\nfor($i=0; $i<$a; $a++)\r\n\r\n{\r\n\r\n	echo ''1'';\r\n\r\n}\r\n', 1, '', ''),
(218, './6.php', 10, -2, -2, '//循环', -1, '', ''),
(219, './6.php', 11, -2, -2, 'for($i=0; $i<$a; $a++)', -1, '', ''),
(220, './6.php', 12, -2, -2, '{', -1, '', ''),
(221, './6.php', 13, -2, -2, '	echo ''1'';', -1, '', ''),
(222, './6.php', 14, -2, -2, '}', -1, '', ''),
(223, './6.php', 15, -2, -2, '\r\n?>\r\n', -1, '', ''),
(224, './6.php', 16, -2, -2, '?>', -1, '', '');

-- --------------------------------------------------------

--
-- 表的结构 `role`
--

CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL auto_increment,
  `role` text character set utf8 NOT NULL,
  `describe` text character set utf8 NOT NULL,
  `level` int(11) NOT NULL,
  `remark` text character set utf8 NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `role`
--

INSERT INTO `role` (`id`, `role`, `describe`, `level`, `remark`) VALUES
(1, 'guest', '访客', 1, '访客'),
(2, 'drive', '权限切换点', 2, '如果没有权限切换点直接进入高级别权限，则存在越权漏洞。'),
(4, 'admin', '管理员', 3, '管理员');

-- --------------------------------------------------------

--
-- 表的结构 `variables`
--

CREATE TABLE IF NOT EXISTS `variables` (
  `id` int(11) NOT NULL auto_increment,
  `variable` text character set utf8 NOT NULL,
  `value` text character set utf8 NOT NULL,
  `use` int(11) NOT NULL,
  `from` int(11) NOT NULL COMMENT '0代表用户，1代表数据库',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `variables`
--

INSERT INTO `variables` (`id`, `variable`, `value`, `use`, `from`) VALUES
(1, '$a', ' $_GET[''id'']', 1, 0),
(2, '$user', '$_GET[''user''];', 1, 0),
(3, '$pass', '$_GET[''pass'']', 1, 0),
(4, '$user', '$res[''user''];', 1, 1),
(5, '$pass', '$res[''pass''];', 1, 1),
(6, '$a', '$_GET[''id'']', 1, 0);
