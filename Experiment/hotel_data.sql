/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : hotel_data

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 22/11/2018 16:05:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hotel
-- ----------------------------
DROP TABLE IF EXISTS `hotel`;
CREATE TABLE `hotel`  (
  `hotel_id` int(11) NOT NULL,
  `hotel_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stars` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`hotel_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hotel
-- ----------------------------
INSERT INTO `hotel` VALUES (1, '惠民旅馆', 5);
INSERT INTO `hotel` VALUES (2, '风景旅馆', 4);
INSERT INTO `hotel` VALUES (3, '商务旅馆', 4);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `order_id` int(11) NOT NULL COMMENT 'joer',
  `room_id` int(11) NULL DEFAULT NULL,
  `start_date` date NULL DEFAULT NULL,
  `leave_date` date NULL DEFAULT NULL,
  `amount` int(11) NULL DEFAULT NULL,
  `payment` int(11) NULL DEFAULT NULL,
  `create_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `room_order_id`(`room_id`) USING BTREE,
  CONSTRAINT `room_order_id` FOREIGN KEY (`room_id`) REFERENCES `room_type` (`room_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (0, 6, '2018-11-14', '2018-11-15', 4, 2000, '2018-11-01');
INSERT INTO `order` VALUES (1, 5, '2018-11-14', '2018-11-16', 2, 2100, '2018-11-01');
INSERT INTO `order` VALUES (2, 1, '2018-11-14', '2018-11-14', 5, 2500, '2018-11-01');
INSERT INTO `order` VALUES (3, 8, '2018-11-14', '2018-11-16', 2, 1296, '2018-11-01');
INSERT INTO `order` VALUES (4, 4, '2018-11-14', '2018-11-16', 2, 2400, '2018-11-01');

-- ----------------------------
-- Table structure for room_info
-- ----------------------------
DROP TABLE IF EXISTS `room_info`;
CREATE TABLE `room_info`  (
  `info_id` int(11) NOT NULL,
  `date` date NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `remain` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `room_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `room_info_key`(`room_id`) USING BTREE,
  CONSTRAINT `room_info_key` FOREIGN KEY (`room_id`) REFERENCES `room_type` (`room_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of room_info
-- ----------------------------
INSERT INTO `room_info` VALUES (1, '2018-11-14', 500.00, '5', 1);
INSERT INTO `room_info` VALUES (2, '2018-11-15', 500.00, '4', 1);
INSERT INTO `room_info` VALUES (3, '2018-11-16', 600.00, '6', 1);
INSERT INTO `room_info` VALUES (4, '2018-11-14', 300.00, '6', 2);
INSERT INTO `room_info` VALUES (5, '2018-11-15', 300.00, '5', 2);
INSERT INTO `room_info` VALUES (6, '2018-11-16', 400.00, '5', 2);
INSERT INTO `room_info` VALUES (7, '2018-11-14', 200.00, '4', 3);
INSERT INTO `room_info` VALUES (8, '2018-11-15', 200.00, '3', 3);
INSERT INTO `room_info` VALUES (9, '2018-11-16', 300.00, '4', 3);
INSERT INTO `room_info` VALUES (10, '2018-11-14', 450.00, '5', 4);
INSERT INTO `room_info` VALUES (11, '2018-11-15', 300.00, '5', 4);
INSERT INTO `room_info` VALUES (12, '2018-11-16', 450.00, '5', 4);
INSERT INTO `room_info` VALUES (13, '2018-11-14', 400.00, '2', 5);
INSERT INTO `room_info` VALUES (14, '2018-11-15', 250.00, '2', 5);
INSERT INTO `room_info` VALUES (15, '2018-11-16', 400.00, '2', 5);
INSERT INTO `room_info` VALUES (16, '2018-11-14', 300.00, '1', 6);
INSERT INTO `room_info` VALUES (17, '2018-11-15', 200.00, '1', 6);
INSERT INTO `room_info` VALUES (18, '2018-11-16', 300.00, '5', 6);
INSERT INTO `room_info` VALUES (19, '2018-11-14', 300.00, '2', 7);
INSERT INTO `room_info` VALUES (20, '2018-11-15', 250.00, '3', 7);
INSERT INTO `room_info` VALUES (21, '2018-11-16', 300.00, '8', 7);
INSERT INTO `room_info` VALUES (22, '2018-11-14', 250.00, '1', 8);
INSERT INTO `room_info` VALUES (23, '2018-11-15', 200.00, '1', 8);
INSERT INTO `room_info` VALUES (24, '2018-11-16', 200.00, '5', 8);
INSERT INTO `room_info` VALUES (25, '2018-11-14', 200.00, '2', 9);
INSERT INTO `room_info` VALUES (26, '2018-11-15', 150.00, '4', 9);
INSERT INTO `room_info` VALUES (27, '2018-11-16', 150.00, '4', 9);

-- ----------------------------
-- Table structure for room_type
-- ----------------------------
DROP TABLE IF EXISTS `room_type`;
CREATE TABLE `room_type`  (
  `room_id` int(11) NOT NULL,
  `room_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `hotel_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`room_id`) USING BTREE,
  INDEX `hotel_room_key`(`hotel_id`) USING BTREE,
  CONSTRAINT `hotel_room_key` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of room_type
-- ----------------------------
INSERT INTO `room_type` VALUES (1, '大床房', 1);
INSERT INTO `room_type` VALUES (2, '双人房', 1);
INSERT INTO `room_type` VALUES (3, '三人房', 1);
INSERT INTO `room_type` VALUES (4, '海景房', 2);
INSERT INTO `room_type` VALUES (5, '园景房', 2);
INSERT INTO `room_type` VALUES (6, '山景房', 2);
INSERT INTO `room_type` VALUES (7, '总统套房', 3);
INSERT INTO `room_type` VALUES (8, '豪华套房', 3);
INSERT INTO `room_type` VALUES (9, '33号房', 3);

SET FOREIGN_KEY_CHECKS = 1;
