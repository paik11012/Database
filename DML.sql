INSERT INTO classmates(name, age)
VALUES("홍길동", 23);

SELECT * FROM classmates;

INSERT INTO classmates
VALUES("김선바", 29,"가양");

INSERT INTO classmates
VALUES("김지원", 22,"경기"),("백토순",2,"일산");

--sqlite는 프라미어 키를 지정하지 않으면 rowid를 자동으로 정의한다
SELECT rowid, * FROM classmates;

--classmates에서 id랑 이름 column만 가져오기
SELECT rowid, name FROM classmates;


--classmates에서 id랑 이름 1개만 가져오기
SELECT rowid, name FROM classmates LIMIT 1;

--세번째 값 하나만 가져오기
SELECT rowid, name FROM classmates LIMIT 1 OFFSET 2;

--id, name, cloumn 중 주소가 서울인 사람만 가져오기
SELECT * FROM classmates WHERE address="서울";

--중복 없이 가져오기
SELECT DISTINCT age FROM classmates;

--특정 데이터 삭제하기
DELETE FROM classmates WHERE rowid = 3;

INSERT INTO tests VALUES(1, "둘리"),(2,"고길동");

UPDATE classmates
    SET name="홍길동", address="제주도"
    WHERE rowid=4;

SELECT * FROM users WHERE age >= 30;

SELECT last_name, age FROM users WHERE age >= 30 AND last_name="김";

--몇 개 있는지 세기
SELECT COUNT(age) FROM users;

--30살 이상 평균 나이
SELECT AVG(age) FROM users WHERE age >= 30;

SELECT MAX(balance), last_name, first_name FROM users;

--30살이상인 사람의 계좌 평균 잔액
SELECT AVG(balance) FROM users WHERE age >= 30;

-- LIKE
SELECT * FROM users WHERE age LIKE "2%";
SELECT * FROM users WHERE phone LIKE "02-%";
SELECT * FROM users WHERE first_name LIKE "%준";
SELECT * FROM users WHERE phone LIKE "%5114%";

--정렬 asc, desc
SELECT * FROM users ORDER BY age DESC LIMIT 15;
SELECT * FROM users ORDER BY age, last_name ASC LIMIT 10;

--계좌잔액순 내림차순 정렬해 해당하는 사람의 성과 이름 10개 뽑기
SELECT last_name, first_name, balance FROM users ORDER BY balance DESC LIMIT 10;

