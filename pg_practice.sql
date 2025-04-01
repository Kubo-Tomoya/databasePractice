-- 問題1. postgresqlでpracticeデータベースを生成するSQL文を記述してください。

CREATE DATABASE practice;

-- 問題2. postgresqlでpracticeデータベースのusersテーブルを生成するSQL文を記述してください。

CREATE TABLE "users" (
    "id" SERIAL PRIMARY KEY,
    "name" CHAR(255) NOT NULL DEFAULT '' COMMENT '氏名',
    "age" INT NOT NULL DEFAULT 0 COMMENT '年齢',
    `gender` enum('Man','Woman','Other') NOT NULL DEFAULT 'Other' Comment '性別',
);

-- 問題3. postgresqlでpracticeデータベースのjobsテーブルを生成するSQL文を記述してください。

CREATE TABLE "jobs" (
    "id" SERIAL PRIMARY KEY,
    "user_id" INT NOT NULL,
    "name" CHAR(255) NOT NULL DEFAULT '会社員',
    CONSTRAINT "fk_user_id" FOREIGN KEY ("user_id") REFERENCES "users"("id")
);