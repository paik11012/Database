데이터베이스로 얻는 장점 한 번 검색해보기

관계형 데이터베이스 관리 시스템

한 개 데이터 = 튜플/ row, col

sqpite-서버가 아닌 응용 프로그램에 넣어 사용하는 가벼운 데이터베이스, 오픈소스



스키마: 데이터를 어떻게 저장하겠다 약속

DML!!!데이터 조작 언어

sqlite3 tutorial.sqlite3 열겠다

```sql
$ sqlite3 tutorial.sqlite3
SQLite version 3.29.0 2019-07-10 17:32:03
Enter ".help" for usage hints.
sqlite> .databases
main: C:\Users\student\Development\Database\tutorial.sqlite3
sqlite> .help
sqlite> .mode csv
sqlite> .import hellodb.csv examples
sqlite>
```

examples란 이름으로 테이블 만들기

모든 데이터 선택하기

```
sqlite> SELECT * FROM examples;
1,"길동","홍",600,"충청도",010-2424-1232
```

이쁘게 열로 보기

```sql
sqlite> .headers on
sqlite> .mode column
sqlite> SELECT * FROM examples;
id          first_name  last_name   age         country     phone
----------  ----------  ----------  ----------  ----------  -------------
1           길동          홍           600         충청도         010-2424-1232
sqlite>
```

새로 데이터 만들기

```sql
sqlite> CREATE TABLE classmates(
   ...>         id INTEGER PRIMARY KEY,
   ...>         name Text
   ...> );
sqlite> .tables
classmates  examples
sqlite>
```

확인하기

```sql
sqlite> .tables
classmates  examples

sqlite> .schema examples
CREATE TABLE examples(
  "id" TEXT,
  "first_name" TEXT,
  "last_name" TEXT,
  "age" TEXT,
  "country" TEXT,
  "phone" TEXT
);
sqlite>
```

삭제

```
sqlite> DROP TABLE classmates;
sqlite> .tables
examples
```

## 데이터 넣기

```
sqlite> INSERT INTO classmates(name, age)
   ...> VALUES("홍길동", 23);
```

```
INSERT INTO classmates
VALUES("조생원", 30,"서울");
```

ROWID

sqlite는 따로 pk속성의 컬럼을 작성하지 않으면 자동으로 값이 증가하는 rowid를 자동으로 정의한다

```sql
sqlite> SELECT rowid, * FROM classmates;
rowid       name        age         address
----------  ----------  ----------  ----------
1           홍길동         23
2           조생원         30          서울
sqlite>
```

다시 PK랑 not null넣어서 만들기

```sql
sqlite> DROP TABLE classmates;
sqlite> CREATE TABLE classmates(
   ...>         id INTEGER PRIMARY KEY,
   ...>         name TEXT NOT NULL,
   ...>         age INT NOT NULL,
   ...>         address TEXT NOT NULL
   ...>         );
```

```sql
sqlite> INSERT INTO classmates(name, age)
   ...> VALUES("홍길동", 23);
Error: NOT NULL constraint failed: classmates.address
```

아이디값 직접 넣어라

```sql
sqlite> INSERT INTO classmates
   ...> VALUES("조생원", 30,"서울");
Error: table classmates has 4 columns but 3 values were supplied
```

다 명시

```sql
sqlite> INSERT INTO classmates
   ...> VALUES("1","조생원", 30,"서울");
sqlite> SELECT * FROM classmates;
id          name        age         address
----------  ----------  ----------  ----------
1           조생원         30          서울
sqlite>
```

여러개 넣기

```sql
sqlite> INSERT INTO classmates
   ...> VALUES("가나다", 30,"서울"),("김선바",29,"가양동");
sqlite> SELECT * FROM classmates;
name        age         address
----------  ----------  ----------
조생원         30          서울
가나다         30          서울
김선바         29          가양동
```

select

```sql
SELECT rowid, name FROM classmates;
```

```sql
--classmates에서 id랑 이름 1개만 가져오기
SELECT rowid, name FROM classmates LIMIT 1;
```

세 번째에 있는 값 하나 가져오기

```sql
sqlite> SELECT rowid, name FROM classmates LIMIT 1 OFFSET 2;
rowid       name
----------  ----------
3           김선바
```

주소가 서울인 사람만 가져온다면?

```sql
sqlite> SELECT * FROM classmates WHERE address="서울";
name        age         address
----------  ----------  ----------
조생원         30          서울
가나다         30          서울
```

중복없이 가져오자

```sql
sqlite> SELECT DISTINCT age FROM classmates;
age
----------
30
29
sqlite>
```

특정 조건 삭제하기

```
sqlite> DELETE FROM classmates WHERE rowid = 1;
```



새로운 테이블 만들기

```sql
CREATE TABLE tests(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT
);
```

PK값 재사용하지 말자

```sql
sqlite> INSERT INTO tests (name) VALUES ("마이클");
sqlite> SELECT * FROM tests;
id          name
----------  ----------
1           둘리
3           마이클
```



## 	UPDATE

```
UPDATE classmates
    SET name="홍길동", address="제주도"
    WHERE rowid=4;
```



# CSV

```
sqlite> .mode csv
sqlite> .import users.csv users
```

나이가 30 이상

```sql
sqlite> SELECT * FROM users WHERE age >= 30;
	    SELECT last_name, age FROM users WHERE age >= 30 AND last_name="김";
```

## Expressions - count

이 데이터가 몇개인지 세기

```sql
sqlite> SELECT COUNT(age) FROM users;
COUNT(age)
----------
1000
```

30살 이상인 사람의 평균 나이

```sql
sqlite> SELECT AVG(age) FROM users WHERE age >= 30;
AVG(age)
----------------
35.1763285024155
```

users에서 계좌 잔액이 가장 높은 사람과 액수

```sql
sqlite> SELECT MAX(balance), last_name, first_name FROM users;
MAX(balance)  last_name   first_name
------------  ----------  ----------
990000        김           선영
```

## LIKE  *

패턴을 확인해 해당하는 값 반환

_  이 자리에 한 개의 문자가 존재해야 함

% 이 자리에 문자가 있을수도 없을수도 있다

2% 2로시작하는 값

%2% 2가 들어가는 값

1_ _ _ _ 1로 시작하고 네자리인 값

```
SELECT * FROM users WHERE age LIKE "2%";
```



## 정렬

나이 오름차순 정렬해 상위 10개 뽑기

```
sqlite> SELECT * FROM users ORDER BY age ASC LIMIT 10;
```

나이순 성 순 오름차순 상위 10개

```
SELECT * FROM users ORDER BY age, last_name ASC LIMIT 10;
```

계좌잔액순 내림차순 정렬해 해당하는 사람의 성과 이름 10개 뽑기

```
SELECT last_name, first_name, balance FROM users ORDER BY balance DESC LIMIT 10;
```



## ALTER

새로 articles라는 테이블 만들기

```sql
sqlite> CREATE TABLE articles(
   ...> title TEXT NOT NULL,
   ...> content TEXT NOT NULL
   ...> );
```

```
INSERT INTO articles VALUES ('1번째 글','고양이'),('2번째 글','개냥이');
```

테이블 이름 변경하기

```sql
sqlite> ALTER TABLE articles
   ...> RENAME TO news;
sqlite> SELECT * FROM news;
title       content
----------  ----------
1번째 글       고양이
2번째 글       개냥이
sqlite>
```

특정 테이블에 새로운 컬럼 추가

```
sqlite> ALTER TABLE news
   ...> ADD COLUMN created_at DATETIME NOT NULL;
Error: Cannot add a NOT NULL column with default value NULL
-- 오류 떰
```

문제 해결 

1) not null 빼고 열 추가하기

```mysql
sqlite> SELECT * FROM news;
title       content     created_at
----------  ----------  ----------
1번째 글       고양이
2번째 글       개냥이
sqlite>
```

```sql
sqlite> INSERT INTO news Values('title','content',datetime('now','localtime'));
sqlite> SELECT * FROM news;
title       content     created_at
----------  ----------  ----------
1번째 글       고양이
2번째 글       개냥이
title       content     2019-09-18
sqlite>
```

2) default값을 넣어서 추가한다

```sql
sqlite> ALTER TABLE news
   ...> ADD COLUMN subtitle TEXT NOT NULL DEFAULT 1;
sqlite> SELECT * FROM news;
title       content     created_at  subtitle
----------  ----------  ----------  ----------
1번째 글       고양이                     1
2번째 글       개냥이                     1
title       content     2019-09-18  1
sqlite>
```

