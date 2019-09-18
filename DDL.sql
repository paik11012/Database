CREATE TABLE classmates(
 name Text,
age INT,
address TEXT
);


CREATE TABLE classmates(
id INTEGER PRIMARY KEY,
name Text,
age INT,
address TEXT
);

CREATE TABLE classmates(
name Text NOT NULL,
age INT NOT NULL,
address TEXT NOT NULL
);


CREATE TABLE tests(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT
);


CREATE TABLE articles(
title TEXT NOT NULL,
content TEXT NOT NULL
);

--테이블 이름 변경
ALTER TABLE articles
RENAME TO news;

--새로운 열 추가
ALTER TABLE news
ADD COLUMN created_at DATETIME;

ALTER TABLE news
ADD COLUMN subtitle TEXT NOT NULL DEFAULT 1;