/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : vue-books-project

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 18/04/2023 15:35:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for borrow_book
-- ----------------------------
DROP TABLE IF EXISTS `borrow_book`;
CREATE TABLE `borrow_book`  (
  `borrow_id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `book_id` int NULL DEFAULT NULL COMMENT '图书id',
  `reader_id` int NULL DEFAULT NULL COMMENT '读者id',
  `borrow_time` datetime NULL DEFAULT NULL COMMENT '借书时间',
  `return_time` datetime NULL DEFAULT NULL COMMENT '还书时间',
  `apply_status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '0: 待审核 1： 已审核  2：拒绝',
  `borrow_status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '0：审核中1:在借中  2：已还   3：拒绝',
  `return_status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '1: 正常还书 2：异常还书 3：丢失',
  `excepion_text` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '异常还书备注',
  `apply_text` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '审核拒绝备注',
  PRIMARY KEY (`borrow_id`) USING BTREE,
  INDEX `book_id`(`book_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 124 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of borrow_book
-- ----------------------------
INSERT INTO `borrow_book` VALUES (83, 5, 8, '2022-02-16 18:30:52', '2022-02-23 00:00:00', '1', '2', '2', '超时', NULL);
INSERT INTO `borrow_book` VALUES (84, 2, 8, '2022-02-16 18:30:52', '2022-02-23 00:00:00', '1', '2', '3', '损坏', NULL);
INSERT INTO `borrow_book` VALUES (85, 7, 8, '2022-02-17 00:17:01', '2022-02-18 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (86, 8, 14, '2022-02-18 14:37:21', '2022-02-28 00:00:00', '1', '2', '2', '超时', NULL);
INSERT INTO `borrow_book` VALUES (87, 10, 14, '2022-02-18 14:37:21', '2022-03-31 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (88, 11, 14, '2022-02-18 14:37:21', '2022-03-31 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (89, 12, 14, '2022-02-18 14:37:21', '2022-03-31 00:00:00', '1', '2', '1', NULL, NULL);
INSERT INTO `borrow_book` VALUES (90, 8, 14, '2022-02-18 14:37:49', '2022-03-10 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (91, 10, 13, '2022-02-18 15:30:42', '2022-02-28 00:00:00', '1', '2', '3', '丢失\n', NULL);
INSERT INTO `borrow_book` VALUES (92, 11, 13, '2022-02-18 15:30:42', '2022-02-28 00:00:00', '1', '2', '1', NULL, NULL);
INSERT INTO `borrow_book` VALUES (93, 7, 17, '2022-02-18 15:39:03', '2022-03-01 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (94, 8, 17, '2022-02-18 15:39:03', '2022-03-31 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (95, 5, 13, '2022-03-01 10:20:07', '2022-04-01 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (96, 5, 16, '2022-03-02 09:07:38', '2022-05-12 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (97, 6, 16, '2022-03-02 09:10:00', '2022-04-01 00:00:00', '0', '0', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (98, 16, 18, '2022-03-02 09:30:43', '2022-04-15 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (102, 19, 15, '2022-03-03 22:52:00', '2022-04-20 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (103, 20, 15, '2022-03-03 22:52:00', '2022-04-20 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (104, 14, 12, '2022-03-04 14:52:32', '2022-04-07 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (105, 13, 12, '2022-03-04 19:49:08', '2022-04-01 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (106, 34, 15, '2022-03-04 21:52:42', '2022-04-01 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (107, 6, 17, '2022-03-05 11:29:09', '2022-03-31 00:00:00', '1', '2', '1', NULL, NULL);
INSERT INTO `borrow_book` VALUES (108, 2, 17, '2022-03-05 11:32:00', '2022-03-31 00:00:00', '1', '2', '1', NULL, NULL);
INSERT INTO `borrow_book` VALUES (109, 2, 13, '2022-03-05 12:31:26', '2022-03-31 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (110, 5, 13, '2022-03-05 12:31:26', '2022-03-31 00:00:00', '1', '1', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (111, 2, 13, '2022-03-05 12:33:33', '2022-03-31 00:00:00', '0', '0', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (112, 2, 6, '2023-04-18 15:29:51', '2023-04-19 00:00:00', '0', '0', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (113, 5, 6, '2023-04-18 15:29:51', '2023-04-19 00:00:00', '0', '0', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (114, 6, 6, '2023-04-18 15:29:51', '2023-04-19 00:00:00', '0', '0', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (115, 8, 6, '2023-04-18 15:29:51', '2023-04-19 00:00:00', '0', '0', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (116, 8, 6, '2023-04-18 15:30:33', '2023-04-19 00:00:00', '0', '0', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (117, 10, 6, '2023-04-18 15:30:33', '2023-04-19 00:00:00', '0', '0', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (118, 11, 6, '2023-04-18 15:30:33', '2023-04-19 00:00:00', '0', '0', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (119, 12, 6, '2023-04-18 15:30:33', '2023-04-19 00:00:00', '0', '0', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (120, 14, 6, '2023-04-18 15:30:33', '2023-04-19 00:00:00', '0', '0', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (121, 15, 6, '2023-04-18 15:30:33', '2023-04-19 00:00:00', '0', '0', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (122, 16, 6, '2023-04-18 15:30:33', '2023-04-19 00:00:00', '0', '0', NULL, NULL, NULL);
INSERT INTO `borrow_book` VALUES (123, 17, 6, '2023-04-18 15:30:33', '2023-04-19 00:00:00', '0', '0', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_books
-- ----------------------------
DROP TABLE IF EXISTS `sys_books`;
CREATE TABLE `sys_books`  (
  `book_id` int NOT NULL AUTO_INCREMENT COMMENT '图书id',
  `category_id` int NULL DEFAULT NULL COMMENT '分类id',
  `book_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '图书名称',
  `book_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '图书条码',
  `book_place_num` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '书架号',
  `book_auther` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '作者',
  `book_product` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '出版社',
  `book_price` decimal(18, 2) NULL DEFAULT NULL COMMENT '价格',
  `book_store` int NULL DEFAULT 0 COMMENT '库存',
  PRIMARY KEY (`book_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_books
-- ----------------------------
INSERT INTO `sys_books` VALUES (2, 3, '数字上的中国', '974651231', 'C1-2', '黄奇帆，陈春花', '中信出版社', 68.00, 2);
INSERT INTO `sys_books` VALUES (5, 3, '赢在IPO', '7846113213', 'C2-1', '谢晖，杜超，林可成', '人民邮电出版社', 79.80, 2);
INSERT INTO `sys_books` VALUES (6, 5, '编程真好玩', '71313456466', 'E2-2', '(日)冈田哲郎', '中国青年出版社', 129.00, 4);
INSERT INTO `sys_books` VALUES (7, 5, 'Python3网络爬虫开发', '7841354646', 'E2-3', '崔庆才', '人民邮电出版社', 139.80, 6);
INSERT INTO `sys_books` VALUES (8, 1, '花物语', '789461312321', 'A2-4', '(日)寺田寅彦', '清华大学出版社', 58.00, 2);
INSERT INTO `sys_books` VALUES (10, 1, '凡·高的故事', '9787547924655', 'A1-4', '让-雅克·莱维柯', '上海书画出版社', 88.00, 2);
INSERT INTO `sys_books` VALUES (11, 1, '老舍经典作品选', '7801155025', 'A1-1', '老舍', '当代世界出版社', 53.90, 1);
INSERT INTO `sys_books` VALUES (12, 1, '国技论略', '7537720053', 'A1-5', '徐哲东', '山西科学技术出版社', 46.60, 5);
INSERT INTO `sys_books` VALUES (13, 1, '巴山夜雨', '7505948504', 'A1-6', '张恨水', '中国文联出版社', 66.30, 0);
INSERT INTO `sys_books` VALUES (14, 1, '激情岁月', '9787501179886', 'A1-7', '洛蔚', '新华出版社', 65.20, 3);
INSERT INTO `sys_books` VALUES (15, 4, '趣味物理学', '9787500680444', 'D1-1', '(俄)别莱利曼(Я. И. Перельман)著', '中国青年出版社', 63.20, 4);
INSERT INTO `sys_books` VALUES (16, 1, '朝花夕拾·呐喊', '9787807105589', 'A2-4', '鲁迅著', '济南出版社', 44.70, 1);
INSERT INTO `sys_books` VALUES (17, 1, '动物庄园', '9787539958293', 'A1-8', '[英] 乔治?奥威尔', '江苏文艺出版社', 25.00, 5);
INSERT INTO `sys_books` VALUES (18, 1, '一炮走红的国家', '9787508639581', 'A1-9', '鲁奇尔·夏尔马', '中信出版社', 34.00, 7);
INSERT INTO `sys_books` VALUES (19, 1, '茶花女', '9787501600069', 'A1-10', '小仲马', '外国文学出版社', 43.00, 2);
INSERT INTO `sys_books` VALUES (20, 2, '时间简史', '9787535732309', 'B1-1', '[英] 史蒂芬·霍金', '湖南科学技术出版社', 65.00, 3);
INSERT INTO `sys_books` VALUES (21, 1, '黑铁时代', '9787561327739', 'A1-11', '王小波', '陕西师范大学出版社', 44.30, 4);
INSERT INTO `sys_books` VALUES (22, 2, '资治通鉴', '9787101067163', 'B1-2', '司马迁', '中华书局', 56.60, 6);
INSERT INTO `sys_books` VALUES (23, 2, '使命·旗帜', '2323124343', 'B2-2', '文华', '四川人民出版社', 69.90, 6);
INSERT INTO `sys_books` VALUES (24, 2, '当代中国生态文明', '9787101067166', 'B2-4', '段娟', '五洲传播出版社', 62.00, 4);
INSERT INTO `sys_books` VALUES (25, 2, '我是共产党员', '3434325345', 'B1-7', '任仲文', '人民日报出版社', 48.00, 3);
INSERT INTO `sys_books` VALUES (26, 6, '我那些成长的烦恼', '9787570117338', 'F1-1', '梁晓生', '山东教育出版社', 35.00, 5);
INSERT INTO `sys_books` VALUES (27, 6, '光芒', '978710106332', 'F1-2', '刘海栖', '山东教育出版社', 38.00, 6);
INSERT INTO `sys_books` VALUES (28, 6, '千山鸟飞', '9787101021163', 'F1-3', '杨映川', '广西教育出版社', 28.00, 6);
INSERT INTO `sys_books` VALUES (29, 4, '鸿蒙应用开发实战', '544433322345', 'D1-1', '张荣超', '人民邮电出版社', 56.60, 5);
INSERT INTO `sys_books` VALUES (30, 4, '6G需求与愿景', '5434546562', 'D1-2', '张平，李文璟，牛凯', '人民邮电出版社', 159.00, 7);
INSERT INTO `sys_books` VALUES (31, 10, '科普期刊编辑艺术', '9787122375094', 'G1-1', '苗雨雁', '化学工业出版社', 68.00, 5);
INSERT INTO `sys_books` VALUES (32, 4, '万物原理', '9787521736250', 'D1-3', '(美)弗兰克·维尔切克', '中信出版社', 59.30, 4);
INSERT INTO `sys_books` VALUES (33, 3, '旅游经济学', '9787811382457', 'C1-6', '郑元同', '西南财经大学出版社', 49.80, 6);
INSERT INTO `sys_books` VALUES (34, 1, '红楼梦', '9787500120803', 'A3-1', '(清)曹雪芹', '中国对外翻译出版公司', 13.80, 4);
INSERT INTO `sys_books` VALUES (35, 2, '职场进化论', '9787544767804', 'B2-2', '柏燕谊', '译林出版社', 39.80, 4);
INSERT INTO `sys_books` VALUES (36, 1, '夜行歌', '9787505965232', 'A3-1', '紫微流年', '人民邮电出版社', 56.60, 4);

-- ----------------------------
-- Table structure for sys_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_category`;
CREATE TABLE `sys_category`  (
  `category_id` int NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `category_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '分类名称',
  `order_num` int NULL DEFAULT NULL COMMENT '序号',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_category
-- ----------------------------
INSERT INTO `sys_category` VALUES (1, '文学', 1);
INSERT INTO `sys_category` VALUES (2, '人文社科', 2);
INSERT INTO `sys_category` VALUES (3, '经济管理', 3);
INSERT INTO `sys_category` VALUES (4, '科技科普', 4);
INSERT INTO `sys_category` VALUES (5, '计算机与互联网', 5);
INSERT INTO `sys_category` VALUES (6, '少儿', 6);
INSERT INTO `sys_category` VALUES (10, '杂志', 7);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` int NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `parent_id` int NULL DEFAULT NULL COMMENT '父级菜单id',
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '菜单名称',
  `code` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '权限字段',
  `name` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '路由name',
  `path` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '路由path',
  `url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '组件路径',
  `type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '类型(0 目录 1菜单，2按钮)',
  `icon` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '菜单图标',
  `parent_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '上级菜单名称',
  `order_num` int NULL DEFAULT NULL COMMENT '序号',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', 'sys:menu:setting', 'system', '/system', '', '0', 'el-icon-setting', '顶级菜单', 1, '2021-12-02 19:19:28', NULL);
INSERT INTO `sys_menu` VALUES (2, 1, '用户管理', 'sys:useList:index', 'sysUserList', '/sysUserList', '/system/sysUserList', '1', 'el-icon-user-solid', '系统管理', 2, '2021-12-02 19:25:31', '2022-02-11 11:45:15');
INSERT INTO `sys_menu` VALUES (3, 1, '角色管理', 'sys:sysRoleList:index', 'sysRoleList', '/sysRoleList', '/system/sysRoleList', '1', 'el-icon-thirdjiaoseguanli', '系统管理', 3, '2021-12-02 19:27:25', '2022-02-11 14:09:18');
INSERT INTO `sys_menu` VALUES (4, 1, '菜单管理', 'sys:menu:index', 'sysMenuList', '/sysMenuList', '/system/sysMenuList', '1', 'tree', '系统管理', 3, '2022-01-02 13:20:44', NULL);
INSERT INTO `sys_menu` VALUES (5, 2, '新增', 'sys:user:add', '', '', '', '2', '', '用户管理', 1, '2022-01-02 13:21:15', NULL);
INSERT INTO `sys_menu` VALUES (6, 2, '编辑', 'sys:user:edit', '', '', '', '2', '', '用户管理', 2, '2022-01-02 13:21:36', '2022-01-08 20:37:50');
INSERT INTO `sys_menu` VALUES (7, 2, '删除', 'sys:user:delete', '', '', '', '2', '', '用户管理', 3, '2022-01-02 13:21:55', '2022-01-08 20:38:11');
INSERT INTO `sys_menu` VALUES (8, 3, '新增', 'sys:role:add', '', '', '', '2', '', '角色管理', 1, '2022-01-02 13:22:21', NULL);
INSERT INTO `sys_menu` VALUES (9, 3, '编辑', 'sys:role:edit', '', '', '', '2', '', '角色管理', 2, '2022-01-02 13:22:38', NULL);
INSERT INTO `sys_menu` VALUES (10, 3, '删除', 'sys:role:delete', '', '', '', '2', '', '角色管理', 3, '2022-01-02 13:22:56', NULL);
INSERT INTO `sys_menu` VALUES (11, 4, '新增', 'sys:menu:add', '', '', '', '2', '', '菜单管理', 1, '2022-01-02 13:23:17', NULL);
INSERT INTO `sys_menu` VALUES (14, 0, '读者管理', 'sys:reader:root', 'reader', '/reader', '', '0', 'el-icon-thirdduzheguanli', '顶级菜单', 2, '2022-01-02 13:24:42', '2022-02-11 14:21:56');
INSERT INTO `sys_menu` VALUES (15, 14, '读者列表', 'sys:reader:list', 'readerList', '/readerList', '/reader/readerList', '1', 'el-icon-thirdduzheliebiao', '读者管理', 1, '2022-01-02 13:25:29', '2022-02-11 14:22:29');
INSERT INTO `sys_menu` VALUES (16, 15, '新增', 'sys:reader:add', '', '', '', '2', '', '读者列表', 1, '2022-01-02 13:25:47', NULL);
INSERT INTO `sys_menu` VALUES (17, 15, '编辑', 'sys:reader:edit', '', '', '', '2', '', '读者列表', 2, '2022-01-02 13:26:06', NULL);
INSERT INTO `sys_menu` VALUES (18, 15, '删除', 'sys:reader:delete', '', '', '', '2', '', '读者列表', 3, '2022-01-02 13:26:25', NULL);
INSERT INTO `sys_menu` VALUES (19, 0, '图书管理', 'sys:book:index', 'book', '/book', '', '0', 'el-icon-thirdtushuguanli', '顶级菜单', 3, '2022-01-02 13:27:11', '2022-02-11 14:11:59');
INSERT INTO `sys_menu` VALUES (20, 19, '图书分类', 'sys:bookCategory:index', 'bookCategory', '/bookCategory', '/book/bookCategory', '1', 'el-icon-thirdfenlei1', '图书管理', 1, '2022-01-02 13:28:10', '2022-02-11 14:13:53');
INSERT INTO `sys_menu` VALUES (21, 19, '图书列表', 'sys:bookList:list', 'bookList', '/bookList', '/book/bookList', '1', 'el-icon-thirdtushuliebiao-miaoxian', '图书管理', 2, '2022-01-02 13:28:59', '2022-02-11 14:22:48');
INSERT INTO `sys_menu` VALUES (22, 20, '新增', 'sys:bookCategory:add', '', '', '', '2', '', '图书分类', 1, '2022-01-02 13:29:31', NULL);
INSERT INTO `sys_menu` VALUES (23, 20, '编辑', 'sys:bookCategory:edit', '', '', '', '2', '', '图书分类', 2, '2022-01-02 13:29:52', NULL);
INSERT INTO `sys_menu` VALUES (24, 20, '删除', 'sys:bookCategory:delete', '', '', '', '2', '', '图书分类', 3, '2022-01-02 13:30:12', NULL);
INSERT INTO `sys_menu` VALUES (25, 21, '新增', 'sys:bookList:add', '', '', '', '2', '', '图书列表', 1, '2022-01-02 13:30:42', NULL);
INSERT INTO `sys_menu` VALUES (26, 21, '编辑', 'sys:bookList:edit', '', '', '', '2', '', '图书列表', 2, '2022-01-02 13:30:56', NULL);
INSERT INTO `sys_menu` VALUES (27, 21, '删除', 'sys:bookList:delete', '', '', '', '2', '', '图书列表', 3, '2022-01-02 13:31:10', NULL);
INSERT INTO `sys_menu` VALUES (28, 0, '借阅管理', 'sys:borrow:index', 'borrow', '/borrow', '', '0', 'el-icon-thirdjieyueguanli1', '顶级菜单', 5, '2022-01-02 13:32:02', '2022-02-11 14:23:29');
INSERT INTO `sys_menu` VALUES (29, 28, '借书管理', 'sys:bookBorrow:index', 'bookBorrow', '/bookBorrow', '/borrow/bookBorrow', '1', 'el-icon-thirdjieshuguanli', '借阅管理', 1, '2022-01-02 13:33:07', '2022-02-11 14:23:13');
INSERT INTO `sys_menu` VALUES (30, 28, '还书管理', 'sys:bookReturn:index', 'bookReturn', '/bookReturn', '/borrow/bookReturn', '1', 'el-icon-thirdhuanshuguanli', '借阅管理', 2, '2022-01-02 13:33:58', '2022-02-11 14:23:43');
INSERT INTO `sys_menu` VALUES (31, 28, '借阅查看', 'sys:borrowLook:index', 'borrowLook', '/borrowLook', '/borrow/borrowLook', '1', 'el-icon-s-cooperation', '借阅管理', 3, '2022-01-02 13:34:48', NULL);
INSERT INTO `sys_menu` VALUES (32, 0, '公告管理', 'sys:notice:index', 'notice', '/notice', '', '0', 'el-icon-thirdgonggaoguanli', '顶级菜单', 6, '2022-01-02 13:35:27', '2022-02-11 14:12:36');
INSERT INTO `sys_menu` VALUES (33, 32, '公告列表', 'sys:noticeList:index', 'noticeList', '/noticeList', '/notice/noticeList', '1', 'el-icon-thirdgonggaoliebiao', '公告管理', 1, '2022-01-02 13:36:14', '2022-02-26 17:05:46');
INSERT INTO `sys_menu` VALUES (34, 29, '借书', 'sys:bookBorrow:borrow', '', '', '', '2', '', '借书管理', 1, '2022-01-02 13:37:03', '2022-01-08 18:15:23');
INSERT INTO `sys_menu` VALUES (37, 30, '新增', 'sys:bookReturn:add', '', '', '', '2', '', '还书管理', 1, '2022-01-02 13:38:01', NULL);
INSERT INTO `sys_menu` VALUES (38, 30, '编辑', 'sys:bookReturn:edit', '', '', '', '2', '', '还书管理', 2, '2022-01-02 13:38:17', NULL);
INSERT INTO `sys_menu` VALUES (39, 30, '删除', 'sys:bookReturn:delete', '', '', '', '2', '', '还书管理', 3, '2022-01-02 13:38:31', NULL);
INSERT INTO `sys_menu` VALUES (40, 31, '新增', 'sys:borrowLook:add', '', '', '', '2', '', '借阅查看', 1, '2022-01-02 13:38:58', NULL);
INSERT INTO `sys_menu` VALUES (41, 31, '编辑', 'sys:borrowLook:edit', '', '', '', '2', '', '借阅查看', 2, '2022-01-02 13:39:27', NULL);
INSERT INTO `sys_menu` VALUES (42, 31, '删除', 'sys:borrowLook:delete', '', '', '', '2', '', '借阅查看', 3, '2022-01-02 13:39:41', NULL);
INSERT INTO `sys_menu` VALUES (43, 33, '新增', 'sys:noticeList:add', '', '', '', '2', '', '公告列表', 1, '2022-01-02 13:40:07', NULL);
INSERT INTO `sys_menu` VALUES (44, 33, '编辑', 'sys:noticeList:edit', '', '', '', '2', '', '公告列表', 2, '2022-01-02 13:40:19', NULL);
INSERT INTO `sys_menu` VALUES (45, 33, '删除', 'sys:noticeList:delete', '', '', '', '2', '', '公告列表', 3, '2022-01-02 13:40:33', NULL);
INSERT INTO `sys_menu` VALUES (46, 33, '查看', 'sys:notice:look', '', '', '', '2', '', '公告列表', 4, '2022-01-08 18:13:03', NULL);
INSERT INTO `sys_menu` VALUES (47, 31, '借阅管理--查看', 'sys:borrowLook:look', '', '', '', '2', '', '借阅查看', 4, '2022-01-08 18:14:15', NULL);
INSERT INTO `sys_menu` VALUES (48, 15, '读者列表---审核', 'sys:reader:apply', '', '', '', '2', '', '读者列表', 4, '2022-01-08 20:35:38', NULL);
INSERT INTO `sys_menu` VALUES (49, 4, '菜单管理--编辑', 'sys:menu:edit', '', '', '', '2', '', '菜单管理', 2, '2022-01-08 20:39:15', NULL);
INSERT INTO `sys_menu` VALUES (50, 4, '菜单管理---删除', 'sys:menu:delete', '', '', '', '2', '', '菜单管理', 3, '2022-01-08 20:39:43', NULL);
INSERT INTO `sys_menu` VALUES (51, 31, '借阅查看---审核', 'sys:borrowLook:apply', '', '', '', '2', '', '借阅查看', 5, '2022-01-08 20:47:18', NULL);
INSERT INTO `sys_menu` VALUES (52, 31, '借阅查看---续期', 'sys:borrowLook:addTime', '', '', '', '2', '', '借阅查看', 5, '2022-01-09 12:40:12', NULL);
INSERT INTO `sys_menu` VALUES (53, 2, '用户管理----重置密码', 'sys:user:resetpassword', '', '', '', '2', '', '用户管理', 6, '2022-01-11 17:43:28', NULL);
INSERT INTO `sys_menu` VALUES (54, 15, '读者管理----重置密码功能', 'sys:reader:resetpassword', '', '', '', '2', '', '读者列表', 6, '2022-01-11 17:44:32', NULL);

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `notice_title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '标题',
  `notice_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '内容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '请按时还书', '大家看完之后，按时还书', '2022-01-02 11:40:48');
INSERT INTO `sys_notice` VALUES (4, '放假通知', '本馆于3月25日放假，请读者在25号之前归还将到期书籍，如不按时归还，将扣除对应的费用。', '2022-01-10 14:04:54');
INSERT INTO `sys_notice` VALUES (8, '开馆通知', '本馆将于4月1日开放。\n', '2022-03-03 22:00:50');

-- ----------------------------
-- Table structure for sys_reader
-- ----------------------------
DROP TABLE IF EXISTS `sys_reader`;
CREATE TABLE `sys_reader`  (
  `reader_id` int NOT NULL AUTO_INCREMENT COMMENT '读者id',
  `learn_num` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '学生证号码',
  `username` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '姓名',
  `id_card` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '身份证号码',
  `sex` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '电话',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '密码',
  `type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '类型',
  `check_status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '审核状态 0：未审核  1：已审核',
  `user_status` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '用户状态 0:停用  1：启用',
  `class_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '班级',
  PRIMARY KEY (`reader_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_reader
-- ----------------------------
INSERT INTO `sys_reader` VALUES (6, '班尼特', '2021001', '789456463313134343', '0', '18687116200', 'f379eaf3c831b04de153469d1bec345e', '1', '1', '1', '软件1班');
INSERT INTO `sys_reader` VALUES (7, '可莉', '2021002', '443228945613212313', '0', '18787171603', 'f379eaf3c831b04de153469d1bec345e', '1', '1', '1', '机械1班');
INSERT INTO `sys_reader` VALUES (8, '重云', '2021003', '441678646113213331', '0', '18465461132', 'f379eaf3c831b04de153469d1bec345e', '1', '1', '1', '软件1班');
INSERT INTO `sys_reader` VALUES (10, '凯亚', '2021005', '489445112123343424', '0', '18687116223', 'f379eaf3c831b04de153469d1bec345e', '1', '1', '1', '软件3班');
INSERT INTO `sys_reader` VALUES (12, '七七', '2022001', '444458884666323451', '1', '18465461132', 'f379eaf3c831b04de153469d1bec345e', '1', '1', '1', '财会2班');
INSERT INTO `sys_reader` VALUES (13, '温迪', '2022002', '343434333333424445', '1', '18465461132', 'f379eaf3c831b04de153469d1bec345e', '1', '1', '1', '软工6班');
INSERT INTO `sys_reader` VALUES (14, '嘟嘟可', '2022003', '432333227736432441', '1', '13222222222', 'f379eaf3c831b04de153469d1bec345e', '1', '1', '1', '数据2班');
INSERT INTO `sys_reader` VALUES (15, '锅巴', '2022005', '443332222224323434', '0', '18465461132', 'f379eaf3c831b04de153469d1bec345e', '1', '1', '1', '软工4班');
INSERT INTO `sys_reader` VALUES (16, '琴', '2022006', '444333322453423243', '1', '18465461132', 'f379eaf3c831b04de153469d1bec345e', '1', '1', '1', '数据1班');
INSERT INTO `sys_reader` VALUES (17, '白宇', '2022007', '202133334444432224', '1', '18465461132', 'f379eaf3c831b04de153469d1bec345e', '1', '1', '1', '软件3班');
INSERT INTO `sys_reader` VALUES (18, '钟离', '2022009', '441571648745434354', '0', '18465461132', 'f379eaf3c831b04de153469d1bec345e', '1', '1', '1', '软工1班');
INSERT INTO `sys_reader` VALUES (21, 'user', '1001', '124879548745647894', '0', '15855324444', 'e10adc3949ba59abbe56e057f20f883e', '', '0', '1', '4');

-- ----------------------------
-- Table structure for sys_reader_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_reader_role`;
CREATE TABLE `sys_reader_role`  (
  `reader_role_id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `reader_id` int NULL DEFAULT NULL COMMENT '读者id',
  `role_id` int NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`reader_role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_reader_role
-- ----------------------------
INSERT INTO `sys_reader_role` VALUES (8, 9, 5);
INSERT INTO `sys_reader_role` VALUES (10, 11, 5);
INSERT INTO `sys_reader_role` VALUES (27, 19, 5);
INSERT INTO `sys_reader_role` VALUES (32, 10, 5);
INSERT INTO `sys_reader_role` VALUES (33, 15, 5);
INSERT INTO `sys_reader_role` VALUES (34, 6, 5);
INSERT INTO `sys_reader_role` VALUES (35, 7, 5);
INSERT INTO `sys_reader_role` VALUES (36, 8, 5);
INSERT INTO `sys_reader_role` VALUES (37, 12, 5);
INSERT INTO `sys_reader_role` VALUES (38, 14, 5);
INSERT INTO `sys_reader_role` VALUES (40, 18, 5);
INSERT INTO `sys_reader_role` VALUES (41, 20, 5);
INSERT INTO `sys_reader_role` VALUES (42, 13, 5);
INSERT INTO `sys_reader_role` VALUES (43, 16, 5);
INSERT INTO `sys_reader_role` VALUES (44, 17, 5);
INSERT INTO `sys_reader_role` VALUES (45, 21, 5);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` int NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '角色名称',
  `role_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '角色类型 1：系统用户  2：读者',
  `remark` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', '1', '超级管理员', '2021-12-06 13:50:28', NULL);
INSERT INTO `sys_role` VALUES (2, '管理员', '1', '管理员', '2022-02-15 15:40:19', NULL);
INSERT INTO `sys_role` VALUES (5, '读者', '2', '读者角色', '2022-02-15 15:40:06', NULL);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_menu_id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int NULL DEFAULT NULL COMMENT '角色id',
  `menu_id` int NULL DEFAULT NULL COMMENT '菜单id',
  PRIMARY KEY (`role_menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 740 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (482, 5, 29);
INSERT INTO `sys_role_menu` VALUES (483, 5, 34);
INSERT INTO `sys_role_menu` VALUES (484, 5, 47);
INSERT INTO `sys_role_menu` VALUES (485, 5, 52);
INSERT INTO `sys_role_menu` VALUES (486, 5, 46);
INSERT INTO `sys_role_menu` VALUES (487, 5, 28);
INSERT INTO `sys_role_menu` VALUES (488, 5, 31);
INSERT INTO `sys_role_menu` VALUES (489, 5, 32);
INSERT INTO `sys_role_menu` VALUES (490, 5, 33);
INSERT INTO `sys_role_menu` VALUES (618, 1, 1);
INSERT INTO `sys_role_menu` VALUES (619, 1, 2);
INSERT INTO `sys_role_menu` VALUES (620, 1, 5);
INSERT INTO `sys_role_menu` VALUES (621, 1, 6);
INSERT INTO `sys_role_menu` VALUES (622, 1, 7);
INSERT INTO `sys_role_menu` VALUES (623, 1, 53);
INSERT INTO `sys_role_menu` VALUES (624, 1, 3);
INSERT INTO `sys_role_menu` VALUES (625, 1, 8);
INSERT INTO `sys_role_menu` VALUES (626, 1, 9);
INSERT INTO `sys_role_menu` VALUES (627, 1, 10);
INSERT INTO `sys_role_menu` VALUES (628, 1, 4);
INSERT INTO `sys_role_menu` VALUES (629, 1, 11);
INSERT INTO `sys_role_menu` VALUES (630, 1, 49);
INSERT INTO `sys_role_menu` VALUES (631, 1, 50);
INSERT INTO `sys_role_menu` VALUES (632, 1, 14);
INSERT INTO `sys_role_menu` VALUES (633, 1, 15);
INSERT INTO `sys_role_menu` VALUES (634, 1, 16);
INSERT INTO `sys_role_menu` VALUES (635, 1, 17);
INSERT INTO `sys_role_menu` VALUES (636, 1, 18);
INSERT INTO `sys_role_menu` VALUES (637, 1, 48);
INSERT INTO `sys_role_menu` VALUES (638, 1, 54);
INSERT INTO `sys_role_menu` VALUES (639, 1, 19);
INSERT INTO `sys_role_menu` VALUES (640, 1, 20);
INSERT INTO `sys_role_menu` VALUES (641, 1, 22);
INSERT INTO `sys_role_menu` VALUES (642, 1, 23);
INSERT INTO `sys_role_menu` VALUES (643, 1, 24);
INSERT INTO `sys_role_menu` VALUES (644, 1, 21);
INSERT INTO `sys_role_menu` VALUES (645, 1, 25);
INSERT INTO `sys_role_menu` VALUES (646, 1, 26);
INSERT INTO `sys_role_menu` VALUES (647, 1, 27);
INSERT INTO `sys_role_menu` VALUES (648, 1, 28);
INSERT INTO `sys_role_menu` VALUES (649, 1, 29);
INSERT INTO `sys_role_menu` VALUES (650, 1, 34);
INSERT INTO `sys_role_menu` VALUES (651, 1, 30);
INSERT INTO `sys_role_menu` VALUES (652, 1, 37);
INSERT INTO `sys_role_menu` VALUES (653, 1, 38);
INSERT INTO `sys_role_menu` VALUES (654, 1, 39);
INSERT INTO `sys_role_menu` VALUES (655, 1, 31);
INSERT INTO `sys_role_menu` VALUES (656, 1, 40);
INSERT INTO `sys_role_menu` VALUES (657, 1, 41);
INSERT INTO `sys_role_menu` VALUES (658, 1, 42);
INSERT INTO `sys_role_menu` VALUES (659, 1, 47);
INSERT INTO `sys_role_menu` VALUES (660, 1, 51);
INSERT INTO `sys_role_menu` VALUES (661, 1, 52);
INSERT INTO `sys_role_menu` VALUES (662, 1, 43);
INSERT INTO `sys_role_menu` VALUES (663, 1, 44);
INSERT INTO `sys_role_menu` VALUES (664, 1, 45);
INSERT INTO `sys_role_menu` VALUES (665, 1, 59);
INSERT INTO `sys_role_menu` VALUES (666, 1, 32);
INSERT INTO `sys_role_menu` VALUES (667, 1, 33);
INSERT INTO `sys_role_menu` VALUES (668, 6, 14);
INSERT INTO `sys_role_menu` VALUES (669, 6, 15);
INSERT INTO `sys_role_menu` VALUES (670, 6, 16);
INSERT INTO `sys_role_menu` VALUES (671, 6, 17);
INSERT INTO `sys_role_menu` VALUES (672, 6, 18);
INSERT INTO `sys_role_menu` VALUES (673, 6, 48);
INSERT INTO `sys_role_menu` VALUES (674, 6, 54);
INSERT INTO `sys_role_menu` VALUES (675, 6, 19);
INSERT INTO `sys_role_menu` VALUES (676, 6, 20);
INSERT INTO `sys_role_menu` VALUES (677, 6, 22);
INSERT INTO `sys_role_menu` VALUES (678, 6, 23);
INSERT INTO `sys_role_menu` VALUES (679, 6, 24);
INSERT INTO `sys_role_menu` VALUES (680, 6, 21);
INSERT INTO `sys_role_menu` VALUES (681, 6, 25);
INSERT INTO `sys_role_menu` VALUES (682, 6, 26);
INSERT INTO `sys_role_menu` VALUES (683, 6, 27);
INSERT INTO `sys_role_menu` VALUES (684, 6, 28);
INSERT INTO `sys_role_menu` VALUES (685, 6, 29);
INSERT INTO `sys_role_menu` VALUES (686, 6, 34);
INSERT INTO `sys_role_menu` VALUES (687, 6, 30);
INSERT INTO `sys_role_menu` VALUES (688, 6, 37);
INSERT INTO `sys_role_menu` VALUES (689, 6, 38);
INSERT INTO `sys_role_menu` VALUES (690, 6, 39);
INSERT INTO `sys_role_menu` VALUES (691, 6, 31);
INSERT INTO `sys_role_menu` VALUES (692, 6, 40);
INSERT INTO `sys_role_menu` VALUES (693, 6, 41);
INSERT INTO `sys_role_menu` VALUES (694, 6, 42);
INSERT INTO `sys_role_menu` VALUES (695, 6, 47);
INSERT INTO `sys_role_menu` VALUES (696, 6, 51);
INSERT INTO `sys_role_menu` VALUES (697, 6, 52);
INSERT INTO `sys_role_menu` VALUES (698, 6, 32);
INSERT INTO `sys_role_menu` VALUES (699, 6, 33);
INSERT INTO `sys_role_menu` VALUES (700, 6, 43);
INSERT INTO `sys_role_menu` VALUES (701, 6, 44);
INSERT INTO `sys_role_menu` VALUES (702, 6, 45);
INSERT INTO `sys_role_menu` VALUES (703, 6, 46);
INSERT INTO `sys_role_menu` VALUES (704, 2, 14);
INSERT INTO `sys_role_menu` VALUES (705, 2, 15);
INSERT INTO `sys_role_menu` VALUES (706, 2, 16);
INSERT INTO `sys_role_menu` VALUES (707, 2, 17);
INSERT INTO `sys_role_menu` VALUES (708, 2, 18);
INSERT INTO `sys_role_menu` VALUES (709, 2, 48);
INSERT INTO `sys_role_menu` VALUES (710, 2, 54);
INSERT INTO `sys_role_menu` VALUES (711, 2, 19);
INSERT INTO `sys_role_menu` VALUES (712, 2, 20);
INSERT INTO `sys_role_menu` VALUES (713, 2, 22);
INSERT INTO `sys_role_menu` VALUES (714, 2, 23);
INSERT INTO `sys_role_menu` VALUES (715, 2, 24);
INSERT INTO `sys_role_menu` VALUES (716, 2, 21);
INSERT INTO `sys_role_menu` VALUES (717, 2, 25);
INSERT INTO `sys_role_menu` VALUES (718, 2, 26);
INSERT INTO `sys_role_menu` VALUES (719, 2, 27);
INSERT INTO `sys_role_menu` VALUES (720, 2, 28);
INSERT INTO `sys_role_menu` VALUES (721, 2, 29);
INSERT INTO `sys_role_menu` VALUES (722, 2, 34);
INSERT INTO `sys_role_menu` VALUES (723, 2, 30);
INSERT INTO `sys_role_menu` VALUES (724, 2, 37);
INSERT INTO `sys_role_menu` VALUES (725, 2, 38);
INSERT INTO `sys_role_menu` VALUES (726, 2, 39);
INSERT INTO `sys_role_menu` VALUES (727, 2, 31);
INSERT INTO `sys_role_menu` VALUES (728, 2, 40);
INSERT INTO `sys_role_menu` VALUES (729, 2, 41);
INSERT INTO `sys_role_menu` VALUES (730, 2, 42);
INSERT INTO `sys_role_menu` VALUES (731, 2, 47);
INSERT INTO `sys_role_menu` VALUES (732, 2, 51);
INSERT INTO `sys_role_menu` VALUES (733, 2, 52);
INSERT INTO `sys_role_menu` VALUES (734, 2, 32);
INSERT INTO `sys_role_menu` VALUES (735, 2, 33);
INSERT INTO `sys_role_menu` VALUES (736, 2, 43);
INSERT INTO `sys_role_menu` VALUES (737, 2, 44);
INSERT INTO `sys_role_menu` VALUES (738, 2, 45);
INSERT INTO `sys_role_menu` VALUES (739, 2, 46);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '登录账户',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '登录密码',
  `phone` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '用户电话',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '邮箱',
  `sex` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '0:男 1：女',
  `is_admin` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否为超级管理员 1：是 0：否',
  `is_account_non_expired` tinyint NULL DEFAULT NULL COMMENT '帐户是否过期(1 未过期，0已过期)',
  `is_account_non_locked` tinyint NULL DEFAULT NULL COMMENT '帐户是否被锁定(1 未锁定，0已锁定)',
  `is_credentials_non_expired` tinyint NULL DEFAULT NULL COMMENT '密码是否过期(1 未过期，0已过期)',
  `is_enabled` tinyint NULL DEFAULT NULL COMMENT '帐户是否可用(1 可用，0 删除用户)',
  `nick_name` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '姓名',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (3, 'admin', 'f379eaf3c831b04de153469d1bec345e', '12323434344', '11232324344@qq.com', '0', '1', 1, 1, 1, 1, 'admin', '2021-11-30 15:05:04', '2022-03-08 14:58:57');
INSERT INTO `sys_user` VALUES (9, 'gly1', 'f379eaf3c831b04de153469d1bec345e', '13232434321', '1458957737@qq.com', '1', '0', 1, 1, 1, 1, '管理员1', '2022-02-14 21:31:52', '2022-03-08 14:59:14');
INSERT INTO `sys_user` VALUES (10, 'sd', 'd41d8cd98f00b204e9800998ecf8427e', '1343423434', '133233322@qq.com', '0', '0', 1, 1, 1, 1, '管理员2', '2022-02-18 15:26:21', '2022-03-08 14:59:35');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_role_id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `role_id` int NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`user_role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (8, 4, 1);
INSERT INTO `sys_user_role` VALUES (9, 6, 3);
INSERT INTO `sys_user_role` VALUES (14, 7, 5);
INSERT INTO `sys_user_role` VALUES (18, 5, 1);
INSERT INTO `sys_user_role` VALUES (20, 8, 7);
INSERT INTO `sys_user_role` VALUES (27, 11, 6);
INSERT INTO `sys_user_role` VALUES (33, 3, 1);
INSERT INTO `sys_user_role` VALUES (34, 9, 2);
INSERT INTO `sys_user_role` VALUES (35, 10, 2);

SET FOREIGN_KEY_CHECKS = 1;
