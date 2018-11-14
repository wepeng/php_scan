-- phpMyAdmin SQL Dump
-- version 3.3.7
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2015 年 08 月 12 日 13:39
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- 转存表中的数据 `del_paths`
--

INSERT INTO `del_paths` (`id`, `md5`, `points_id`, `lines_id`, `check`, `start_file`, `start_line`, `end_file`, `end_line`, `remark`) VALUES
(4, '243228c663af0895122779f4adef44d3', 'a:2:{i:0;s:1:"7";i:1;s:1:"8";}', 'a:1:{i:0;s:1:"1";}', 0, '/1.php', 7, '/1.php', 8, '存在代码执行漏洞。'),
(3, '243228c663af0895122779f4adef44d3', 'a:2:{i:0;s:1:"7";i:1;s:1:"8";}', 'a:1:{i:0;s:1:"1";}', 0, '/1.php', 7, '/1.php', 8, '存在代码执行漏洞。'),
(5, '243228c663af0895122779f4adef44d3', 'a:2:{i:0;s:1:"7";i:1;s:1:"8";}', 'a:1:{i:0;s:1:"1";}', 0, '/1.php', 7, '/1.php', 8, '存在代码执行漏洞。'),
(6, '243228c663af0895122779f4adef44d3', 'a:2:{i:0;s:1:"7";i:1;s:1:"8";}', 'a:1:{i:0;s:1:"1";}', 0, '/1.php', 7, '/1.php', 8, '存在代码执行漏洞。'),
(7, '243228c663af0895122779f4adef44d3', 'a:2:{i:0;s:1:"7";i:1;s:1:"8";}', 'a:1:{i:0;s:1:"1";}', 0, '/1.php', 7, '/1.php', 8, '存在代码执行漏洞。'),
(8, '243228c663af0895122779f4adef44d3', 'a:2:{i:0;s:1:"7";i:1;s:1:"8";}', 'a:1:{i:0;s:1:"1";}', 0, '/1.php', 7, '/1.php', 8, '存在代码执行漏洞。'),
(9, '243228c663af0895122779f4adef44d3', 'a:2:{i:0;s:1:"7";i:1;s:1:"8";}', 'a:1:{i:0;s:1:"1";}', -2, '/1.php', 7, '/1.php', 8, '存在代码执行漏洞。');

-- --------------------------------------------------------

--
-- 表的结构 `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `id` int(11) NOT NULL auto_increment,
  `file` text character set utf8 NOT NULL,
  `edit` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `files`
--

INSERT INTO `files` (`id`, `file`, `edit`) VALUES
(1, '/1.php', 0);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `lines`
--

INSERT INTO `lines` (`id`, `point_u_id`, `point_v_id`, `variables_ids`) VALUES
(1, 7, 8, 'a:1:{i:0;s:1:"1";}');

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `paths`
--

INSERT INTO `paths` (`id`, `md5`, `points_id`, `lines_id`, `check`, `start_file`, `start_line`, `end_file`, `end_line`, `remark`) VALUES
(1, '243228c663af0895122779f4adef44d3', 'a:2:{i:0;s:1:"7";i:1;s:1:"8";}', 'a:1:{i:0;s:1:"1";}', 0, '/1.php', 7, '/1.php', 8, '存在代码执行漏洞。');

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
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- 转存表中的数据 `points`
--

INSERT INTO `points` (`id`, `file`, `line_number`, `level`, `position`, `content`, `role_id`) VALUES
(1, '/1.php', 1, -2, -2, '﻿<?php\r\n/**\r\n* 测试用例\r\n*\r\n* 简单测试系统是否正常工作\r\n*/\r\n\r\n\r\n\r\n\r\n', -1),
(2, '/1.php', 2, -2, -2, '/**\r\n* 测试用例\r\n*\r\n* 简单测试系统是否正常工作\r\n*/\r\n\r\n\r\n\r\n', -1),
(3, '/1.php', 3, -2, -2, '* 测试用例\r\n*\r\n* 简单测试系统是否正常工作\r\n*/\r\n\r\n\r\n', -1),
(4, '/1.php', 4, -2, -2, '*\r\n* 简单测试系统是否正常工作\r\n*/\r\n\r\n', -1),
(5, '/1.php', 5, -2, -2, '* 简单测试系统是否正常工作\r\n*/\r\n', -1),
(6, '/1.php', 6, -2, -2, '*/', -1),
(7, '/1.php', 7, 0, 1, '$a = $_GET[''id''];', 1),
(8, '/1.php', 8, 1, -1, 'eval($a);', 1),
(9, '/1.php', 9, -2, -2, '?>', -1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `role`
--

INSERT INTO `role` (`id`, `role`, `describe`, `level`, `remark`) VALUES
(1, 'guest', 'guest', 1, '??');

-- --------------------------------------------------------

--
-- 表的结构 `variables`
--

CREATE TABLE IF NOT EXISTS `variables` (
  `id` int(11) NOT NULL auto_increment,
  `variable` text character set utf8 NOT NULL,
  `value` text character set utf8 NOT NULL,
  `use` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `variables`
--

INSERT INTO `variables` (`id`, `variable`, `value`, `use`) VALUES
(1, '$a', ' $_GET[''id'']', 1);
