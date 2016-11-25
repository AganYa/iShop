-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Sep 24, 2016 at 06:05 AM
-- Server version: 5.6.28
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `SmallStore`
--
CREATE DATABASE IF NOT EXISTS `SmallStore` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `SmallStore`;

-- --------------------------------------------------------

--
-- Table structure for table `t_add`
--

CREATE TABLE `t_add` (
  `add_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `goods_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `t_add`
--

INSERT INTO `t_add` (`add_id`, `user_id`, `goods_id`) VALUES
(23, NULL, NULL),
(24, 1, 3),
(25, 1, 4),
(26, NULL, NULL),
(27, NULL, NULL),
(28, 1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `t_goods`
--

CREATE TABLE `t_goods` (
  `goods_id` int(11) NOT NULL,
  `goods_title` varchar(45) DEFAULT NULL,
  `goods_price` varchar(45) DEFAULT NULL,
  `goods_img` varchar(200) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `goods_desc` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `t_goods`
--

INSERT INTO `t_goods` (`goods_id`, `goods_title`, `goods_price`, `goods_img`, `type_id`, `goods_desc`) VALUES
(1, '欧洲站女装秋装女2016新款潮 牛仔连衣裙秋 春秋长袖中长款牛仔裙 ', '¥ 188.00', 'http://localhost:55555/SmallStore/images/header/00.png', 2, ''),
(2, '大码女装秋装上衣棉麻白衬衫女长袖 韩范中长款学院风百搭宽松 ', '¥ 49.00', 'http://localhost:55555/SmallStore/images/header/01.png', 2, ''),
(3, '米亲春秋白色帆布鞋女学生韩版小白鞋球鞋厚底松糕休闲鞋平底板鞋 ', '¥ 45.00', 'http://localhost:55555/SmallStore/images/header/02.png', 2, ''),
(4, '休闲裤女秋装新款韩版2016时尚高腰大码弹力小脚裤铅笔裤长裤女潮', '¥ 45.00', 'http://localhost:55555/SmallStore/images/header/07.png', 4, ''),
(5, '春秋新款黑灰高腰牛仔裤女九分裤黑色显瘦紧身小脚裤深蓝修身弹力', '¥ 89.00', 'http://localhost:55555/SmallStore/images/header/01.png', 2, '紧身显瘦 恰当裤长 韩国版型 四季皆宜 时尚百搭 '),
(6, '拉夏贝尔 7m 莫丽菲尔2016秋装新款韩版纯色修身打底裤女', '¥ 99.00', 'http://localhost:55555/SmallStore/images/header/02.png', 2, '7月7日 新品 '),
(7, '韩都衣舍2016韩版女装秋新宽松上衣条纹短款百搭T恤MM5030悜 ', '¥ 89.00 ', 'http://localhost:55555/SmallStore/images/header/04.png', 3, '韩版宽松 时尚条纹 做工精细 面料舒适'),
(8, '裂帛2016秋装新款几何印花拼蕾丝上衣针织圆领长袖T恤 女51160403', '¥ 139.80', 'http://localhost:55555/SmallStore/images/header/05.png', 3, ''),
(9, '秋季秋款打底裤外穿女夏长裤薄款黑色小脚裤弹力铅笔裤紧身女裤子', '¥ 54.00', 'http://localhost:55555/SmallStore/images/header/10.png', 4, '两件减5 三件减10 领券！'),
(10, '乐库优2016秋透气黑色排扣高腰外穿打底裤弹力小脚裤女裤子长裤 ', '¥ 65.00', 'http://localhost:55555/SmallStore/images/header/07.png', 4, '时尚裤腰设计 弹力修身紧致 多色选择 百搭韩版');

-- --------------------------------------------------------

--
-- Table structure for table `t_type`
--

CREATE TABLE `t_type` (
  `type_id` int(11) NOT NULL,
  `t_name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `t_type`
--

INSERT INTO `t_type` (`type_id`, `t_name`) VALUES
(1, '全部'),
(2, '鞋子'),
(3, '上衣'),
(4, '裤子');

-- --------------------------------------------------------

--
-- Table structure for table `t_userinfo`
--

CREATE TABLE `t_userinfo` (
  `user_id` int(11) NOT NULL,
  `user_phone` double DEFAULT NULL,
  `user_pwd` varchar(45) DEFAULT NULL,
  `user_headimg` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `t_userinfo`
--

INSERT INTO `t_userinfo` (`user_id`, `user_phone`, `user_pwd`, `user_headimg`) VALUES
(1, 13005700325, '12345', 'http://localhost:55555/SmallStore/images/headimg/huaji_01.jpg'),
(4, 13005700324, '12345', 'http://localhost:55555/SmallStore/images/headimg/huaji_01.jpg'),
(5, 13005700326, '12345', 'http://localhost:55555/SmallStore/images/headimg/huaji_01.jpg'),
(6, 13005700327, '12345', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `t_add`
--
ALTER TABLE `t_add`
  ADD PRIMARY KEY (`add_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `goods_id` (`goods_id`);

--
-- Indexes for table `t_goods`
--
ALTER TABLE `t_goods`
  ADD PRIMARY KEY (`goods_id`),
  ADD KEY `fk_t_goods_t_type_idx` (`type_id`);

--
-- Indexes for table `t_type`
--
ALTER TABLE `t_type`
  ADD PRIMARY KEY (`type_id`);

--
-- Indexes for table `t_userinfo`
--
ALTER TABLE `t_userinfo`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `t_add`
--
ALTER TABLE `t_add`
  MODIFY `add_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `t_goods`
--
ALTER TABLE `t_goods`
  MODIFY `goods_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `t_type`
--
ALTER TABLE `t_type`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `t_userinfo`
--
ALTER TABLE `t_userinfo`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `t_add`
--
ALTER TABLE `t_add`
  ADD CONSTRAINT `fk_add_id` FOREIGN KEY (`user_id`) REFERENCES `t_userinfo` (`user_id`),
  ADD CONSTRAINT `fk_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `t_goods` (`goods_id`);

--
-- Constraints for table `t_goods`
--
ALTER TABLE `t_goods`
  ADD CONSTRAINT `fk_t_goods_t_type` FOREIGN KEY (`type_id`) REFERENCES `t_type` (`type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
