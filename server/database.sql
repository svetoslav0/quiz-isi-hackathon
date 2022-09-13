CREATE DATABASE `quiz`;
USE `quiz`;

CREATE TABLE `quiz_category` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(100) NOT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8mb4_0900_ai_ci';


CREATE TABLE `quiz_question` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`description` TEXT NOT NULL,
	`category_id` INT NOT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `FK__quiz_category` FOREIGN KEY (`category_id`) REFERENCES `quiz_category` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8mb4_0900_ai_ci';

CREATE TABLE `quiz_answer` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`description` TEXT NOT NULL,
	`quiz_question_id` INT NOT NULL,
	`is_correct` SMALLINT NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`),
	CONSTRAINT `FK__quiz_question` FOREIGN KEY (`quiz_question_id`) REFERENCES `quiz_question` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8mb4_0900_ai_ci';

CREATE TABLE `job_position` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NOT NULL,
	`description` TEXT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8mb4_0900_ai_ci';

CREATE TABLE `job_position_categories` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`job_position_id` INT NOT NULL,
	`quiz_category_id` INT NOT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8mb4_0900_ai_ci'
;

ALTER TABLE `job_position_categories`
	ADD CONSTRAINT `FK_job_position_categories_job_position` FOREIGN KEY (`job_position_id`) REFERENCES `job_position` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_job_position_categories_quiz_category` FOREIGN KEY (`quiz_category_id`) REFERENCES `quiz_category` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION;


CREATE TABLE `user` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`first_name` VARCHAR(50) NOT NULL,
	`last_name` VARCHAR(50) NOT NULL,
	`email` VARCHAR(100) NOT NULL,
	`password` VARCHAR(100) NOT NULL,
	`phone` VARCHAR(50) NOT NULL,
	`token` VARCHAR(150) NOT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8mb4_0900_ai_ci';


CREATE TABLE `user_application` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`user_id` INT NOT NULL,
	`job_position_id` INT NOT NULL,
	`is_submitted` SMALLINT NOT NULL DEFAULT 0,
	`date_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (`id`),
	CONSTRAINT `FK__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `FK__job_position` FOREIGN KEY (`job_position_id`) REFERENCES `job_position` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='utf8mb4_0900_ai_ci';


CREATE TABLE `user_answers` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`user_id` INT NOT NULL,
	`question_id` INT NOT NULL,
	`answer_id` INT NOT NULL,
	`date_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (`id`)
)
COLLATE='utf8mb4_0900_ai_ci'
;


ALTER TABLE `user_answers`
	ADD CONSTRAINT `FK_user_answers_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_user_answers_quiz_question` FOREIGN KEY (`question_id`) REFERENCES `quiz_question` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	ADD CONSTRAINT `FK_user_answers_quiz_answer` FOREIGN KEY (`answer_id`) REFERENCES `quiz_answer` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION;

