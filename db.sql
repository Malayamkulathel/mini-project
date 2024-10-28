/*
SQLyog Community v13.0.1 (64 bit)
MySQL - 8.0.33 : Database - expensetracker
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`expensetracker` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `expensetracker`;

/*Table structure for table `app_category` */

DROP TABLE IF EXISTS `app_category`;

CREATE TABLE `app_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Image` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `app_category` */

insert  into `app_category`(`id`,`Name`,`Image`) values 
(2,'food','food'),
(3,'medical','medical'),
(4,'education','education');

/*Table structure for table `app_complaint` */

DROP TABLE IF EXISTS `app_complaint`;

CREATE TABLE `app_complaint` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Complaint` varchar(50) NOT NULL,
  `Reply` varchar(50) NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_complaint_USER_id_2d526439_fk_app_user_id` (`USER_id`),
  CONSTRAINT `app_complaint_USER_id_2d526439_fk_app_user_id` FOREIGN KEY (`USER_id`) REFERENCES `app_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `app_complaint` */

insert  into `app_complaint`(`id`,`Date`,`Complaint`,`Reply`,`USER_id`) values 
(1,'2024-10-26','not working properly','will fix',1);

/*Table structure for table `app_feedback` */

DROP TABLE IF EXISTS `app_feedback`;

CREATE TABLE `app_feedback` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Feedback` varchar(50) NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_feedback_USER_id_97cd3eed_fk_app_user_id` (`USER_id`),
  CONSTRAINT `app_feedback_USER_id_97cd3eed_fk_app_user_id` FOREIGN KEY (`USER_id`) REFERENCES `app_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `app_feedback` */

insert  into `app_feedback`(`id`,`Date`,`Feedback`,`USER_id`) values 
(2,'2024-10-26','good',1);

/*Table structure for table `app_login` */

DROP TABLE IF EXISTS `app_login`;

CREATE TABLE `app_login` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Type` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `app_login` */

insert  into `app_login`(`id`,`Username`,`Password`,`Type`) values 
(1,'admin','admin','admin'),
(2,'sara@gmail.com','sara1234','user'),
(3,'sana@gmail.com','sana1234','user');

/*Table structure for table `app_notification` */

DROP TABLE IF EXISTS `app_notification`;

CREATE TABLE `app_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Notification` varchar(100) NOT NULL,
  `Status` varchar(100) NOT NULL,
  `Date` date NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_notification_USER_id_0e7071dd_fk_app_user_id` (`USER_id`),
  CONSTRAINT `app_notification_USER_id_0e7071dd_fk_app_user_id` FOREIGN KEY (`USER_id`) REFERENCES `app_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `app_notification` */

insert  into `app_notification`(`id`,`Notification`,`Status`,`Date`,`USER_id`) values 
(1,'You exceeded your current target of ₹2000, you already spend ₹7300','viewed','2024-10-26',1),
(2,'You exceeded your current target of ₹5000, you already spend ₹5500','viewed','2024-10-26',2),
(3,'You exceeded your current target of ₹5000, you already spend ₹41000','viewed','2024-10-26',2);

/*Table structure for table `app_threshold` */

DROP TABLE IF EXISTS `app_threshold`;

CREATE TABLE `app_threshold` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Threshold` int NOT NULL,
  `Date` date NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_threshold_USER_id_00ebc7e5_fk_app_user_id` (`USER_id`),
  CONSTRAINT `app_threshold_USER_id_00ebc7e5_fk_app_user_id` FOREIGN KEY (`USER_id`) REFERENCES `app_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `app_threshold` */

insert  into `app_threshold`(`id`,`Threshold`,`Date`,`USER_id`) values 
(1,2000,'2024-10-26',1),
(2,5000,'2024-10-26',2);

/*Table structure for table `app_transaction` */

DROP TABLE IF EXISTS `app_transaction`;

CREATE TABLE `app_transaction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Type` varchar(50) NOT NULL,
  `Amount` int NOT NULL,
  `CATEGORY_id` bigint NOT NULL,
  `USER_id` bigint NOT NULL,
  `Details` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_transaction_CATEGORY_id_74da0307_fk_app_category_id` (`CATEGORY_id`),
  KEY `app_transaction_USER_id_7963778c_fk_app_user_id` (`USER_id`),
  CONSTRAINT `app_transaction_CATEGORY_id_74da0307_fk_app_category_id` FOREIGN KEY (`CATEGORY_id`) REFERENCES `app_category` (`id`),
  CONSTRAINT `app_transaction_USER_id_7963778c_fk_app_user_id` FOREIGN KEY (`USER_id`) REFERENCES `app_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `app_transaction` */

insert  into `app_transaction`(`id`,`Date`,`Type`,`Amount`,`CATEGORY_id`,`USER_id`,`Details`) values 
(5,'2024-10-01','Income',10000,4,2,'mes'),
(6,'2024-10-02','Income',20000,3,2,'medical'),
(7,'2024-10-26','Expense',1000,4,2,'edu'),
(9,'2024-09-18','Expense',600,2,2,'burger'),
(11,'2024-10-25','Expense',40000,3,2,'operation'),
(12,'2024-10-30','Expense',500,2,1,'burger');

/*Table structure for table `app_user` */

DROP TABLE IF EXISTS `app_user`;

CREATE TABLE `app_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Phone` varchar(50) NOT NULL,
  `Image` varchar(100) NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_user_LOGIN_id_b43bd763_fk_app_login_id` (`LOGIN_id`),
  CONSTRAINT `app_user_LOGIN_id_b43bd763_fk_app_login_id` FOREIGN KEY (`LOGIN_id`) REFERENCES `app_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `app_user` */

insert  into `app_user`(`id`,`Name`,`Phone`,`Image`,`LOGIN_id`) values 
(1,'sara','9544727952','WIN_20240625_14_39_53_Pro_b9eqzQ2.jpg',2),
(2,'sana','8606404229','sana_EJ8KG3Q',3);

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add category',7,'add_category'),
(26,'Can change category',7,'change_category'),
(27,'Can delete category',7,'delete_category'),
(28,'Can view category',7,'view_category'),
(29,'Can add login',8,'add_login'),
(30,'Can change login',8,'change_login'),
(31,'Can delete login',8,'delete_login'),
(32,'Can view login',8,'view_login'),
(33,'Can add user',9,'add_user'),
(34,'Can change user',9,'change_user'),
(35,'Can delete user',9,'delete_user'),
(36,'Can view user',9,'view_user'),
(37,'Can add transaction',10,'add_transaction'),
(38,'Can change transaction',10,'change_transaction'),
(39,'Can delete transaction',10,'delete_transaction'),
(40,'Can view transaction',10,'view_transaction'),
(41,'Can add feedback',11,'add_feedback'),
(42,'Can change feedback',11,'change_feedback'),
(43,'Can delete feedback',11,'delete_feedback'),
(44,'Can view feedback',11,'view_feedback'),
(45,'Can add complaint',12,'add_complaint'),
(46,'Can change complaint',12,'change_complaint'),
(47,'Can delete complaint',12,'delete_complaint'),
(48,'Can view complaint',12,'view_complaint'),
(49,'Can add notification',13,'add_notification'),
(50,'Can change notification',13,'change_notification'),
(51,'Can delete notification',13,'delete_notification'),
(52,'Can view notification',13,'view_notification'),
(53,'Can add threshold',14,'add_threshold'),
(54,'Can change threshold',14,'change_threshold'),
(55,'Can delete threshold',14,'delete_threshold'),
(56,'Can view threshold',14,'view_threshold');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values 
(1,'pbkdf2_sha256$870000$bzQO5qVvHyrEvvYoXbB7NZ$khFD+fn6lppyULAL5H+qrT4d3DzqKqAMRD26hss+XYw=',NULL,1,'admin','','','admin@gmail.com',1,1,'2024-10-26 05:31:28.258320');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(7,'app','category'),
(12,'app','complaint'),
(11,'app','feedback'),
(8,'app','login'),
(13,'app','notification'),
(14,'app','threshold'),
(10,'app','transaction'),
(9,'app','user'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2024-10-26 05:24:37.898587'),
(2,'auth','0001_initial','2024-10-26 05:24:38.483050'),
(3,'admin','0001_initial','2024-10-26 05:24:38.603730'),
(4,'admin','0002_logentry_remove_auto_add','2024-10-26 05:24:38.603730'),
(5,'admin','0003_logentry_add_action_flag_choices','2024-10-26 05:24:38.619404'),
(6,'app','0001_initial','2024-10-26 05:24:39.012622'),
(7,'app','0002_transaction_details','2024-10-26 05:24:39.039943'),
(8,'app','0003_notification_threshold','2024-10-26 05:24:39.186816'),
(9,'contenttypes','0002_remove_content_type_name','2024-10-26 05:24:39.283202'),
(10,'auth','0002_alter_permission_name_max_length','2024-10-26 05:24:39.372683'),
(11,'auth','0003_alter_user_email_max_length','2024-10-26 05:24:39.412559'),
(12,'auth','0004_alter_user_username_opts','2024-10-26 05:24:39.437327'),
(13,'auth','0005_alter_user_last_login_null','2024-10-26 05:24:39.530890'),
(14,'auth','0006_require_contenttypes_0002','2024-10-26 05:24:39.530890'),
(15,'auth','0007_alter_validators_add_error_messages','2024-10-26 05:24:39.541717'),
(16,'auth','0008_alter_user_username_max_length','2024-10-26 05:24:39.609304'),
(17,'auth','0009_alter_user_last_name_max_length','2024-10-26 05:24:39.690259'),
(18,'auth','0010_alter_group_name_max_length','2024-10-26 05:24:39.718697'),
(19,'auth','0011_update_proxy_permissions','2024-10-26 05:24:39.732698'),
(20,'auth','0012_alter_user_first_name_max_length','2024-10-26 05:24:39.812434'),
(21,'sessions','0001_initial','2024-10-26 05:24:39.862921');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('y8mvgk38mq5mzlpjs2oqczjlatllbov5','.eJyrVspLzE1VslIqTixKVNJRysxNB3L0c1NTMhP1wz394o0MjEwMzIxM4w1N4o0t402N4wOK8uOTLFMLqwKN9LIK0oGaSpOVrIx0lNKAlKGOUjKQMtBRyslMAYsWgWglI6VaAJEnHfw:1t4dxh:BQwly3jRGDvUfzoOWZnr4o8IecdYkRESlGeUGP498yQ','2024-11-09 10:24:01.994070');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
