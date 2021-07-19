/*SELECT 구문은 DB 내부의 자료를 조회하는 구문입니다.
SELECT 컬럼명1,컬럼명2... FROM 테이블 이름 WHRER 조건;
형식으로 주로 사용*/

/* SELECT 구문을 활용하기에 앞서서 사용할 데이터베이스(스키마)를 지정해야 한다. 이를 위해 USE 구문을 사용. 
아래 구문은 좌측 SCHEMAS에서 employees를 우클릭 한 후 set as default as schema를 
클릭하는 것과 같은 효과입니다.*/

-- employees 데이터 베이스가 지금부터 모든 명령을 받습니다.
-- 한 줄 주석은 좌측과 같이 "-- 주석내용" 으로 작성합니다. 
use employees;

-- ict03 데이터 베이스가 지금부터 모든 명령을 받습니다.
use ict03;

-- employees 데이터 베이스 내부의 employees table 조회
-- SQL 구문은 명령구문시 무조건 대문자, 테이블 명이나 호칭등은 소문자로 작성하는 것이 관례
-- 무조건 지켜야 하는것은 아니지만 가독성을 위해 되도록 지켜야한다.
SELECT * FROM employees;

-- 원래 테이블 조회시는 데이터베이스명.테이블명 으로 모두 표기해야 합니다.
SELECT * FROM employees.employees;

-- 컬럼을 전체가 아닌 임의로 가져올때는 컬럼명을 ,로 구분합니다.
-- 이 경우 모든 컬럼이 아닌 일부 컬럼만 조회할 수도 있으며
-- 심지어 한 개의 컬럼만 조회하는 등 개수조절도 가능함.
-- 앞뒤 , 순서 에 따라 출력시에도 순서가 바뀜 1,2,3 / 2,3,1   <- 출력순서도 이렇게 나옴
-- !! cmd에서 실행시에도 ; 꼭 붙여야함!!!
SELECT first_name, last_name, gender FROM employees;

-- CMD 환경에서는 좌측 스키마 처럼 DB 목록을 보여주는 창이 없으므로
-- 아래 명령어를 통해 DB목록을 확인할수 있다.
SHOW databases;

-- 현재 DB정보를 조회하기 위해서는
SHOW TABLE STATUS;

-- 특정 테이블의 컬럼 정보를 조회하고 싶다면 아래 명령어를 씁니다.
-- DESCRIBE 테이블명; 혹은 DESC 테이블명;
DESCRIBE employees;
DESC employees;

-- 보통 DB는 그냥 생성하지만 간혹 DB가 있는데 초기화하기 위해 만약 기존에 같은 이름을 가진
-- DB가 존재한다면 삭제하고 다시 말들라는 명령을 내리기도 합니다.
-- 아래처럼 조건문을 이용해서 처리합니다.
DROP DATABASE IF EXISTS sqlDB;  -- sqlDB 가 존재시 삭제
CREATE DATABASE sqlDB DEFAULT CHARACTER SET utf8;

-- 테이블을 생성합니다.
-- 테이블 생성시 적힌 제약조건과 컬럼명을 활용해 만들어주세요.
use sqlDB;
CREATE TABLE userTbl(
	userID char(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    pnum CHAR(11),
    height INT,
    mDate DATE
    );
    
    -- primary key 각 테이블을 대표 할수 있는 대표 데이터를 저장하는 컬럼에 붙인다.
    -- 모든 테이블은 무조건 하나의 primary key 를 갖는다.
    -- primary key 는 자동으로 중복을 방지하고, null 값도 받을수 없다.
    
    -- foreign key(외래 키)
    -- 쇼핑몰의 구매자는 반드시 회원이어야 하듯
    -- 특정 테이블의 값만 해당 컬럼에 들어올 수 있도록 거는 제약조건
    -- foreign key 를 거는 컬럼의 자료형과이름, 크기는 같아야한다.
    -- 양 쪽 모두에서 같아야함. char(8) 임 여기에선 둘다 
    -- 참조컬럼에 있는 자료만 타겟 컬럼으로 들어올수 있다.
    -- 지금 같은 경우는 buyTbl의 userID에는 userTbl의 userID에 존재하는 데이터만 저장가능.

    
CREATE TABLE buyTbl (
    num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userID CHAR(8) NOT NULL,
    prodName CHAR(6) NOT NULL,
    groupName CHAR(4),
    price INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (userID)
        REFERENCES userTbl (userID)
); 

-- 테이블 삭제는 DROP TABLE 테이블명; 으로 한다. 
-- DB처럼 삭제시 IF EXISTS를 쓸수 있습니다.
use sqldb;
DROP TABLE IF EXISTS userTbl;
DROP TABLE buyTbl;

INSERT INTO userTbl (userID,name,birthYear,addr,pnum,height,mDate) 
 VALUES('LSG', '이승기', 1987, '서울', '01111111111', 182, '2008-8-8')
,('KBS', '김범수', 1979, '경남', '01122222222', 173, '2012-4-4')
,('KKH', '김경호', 1971, '전남', '01133333333', 177, '2007-7-7')
,('JYP', '조용필', 1950, '경기', '01144444444', 166, '2009-4-4')
,('SSK', '성시경', 1979, '서울', null, 186, '2013-12-12')
,('LJB', '임재범', 1963, '서울', '01166666666', 182, '2009-9-9')
,('YJS', '윤종신', 1969, '경남', null, 170, '2005-5-5')
,('EJW', '은지원', 1972, '경북', '01188888888', 174, '2014-3-3')
,('JKW', '조관우', 1965, '경기', '01199999999', 172, '2010-10-10')
,('BBK', '바비킴', 1973, '서울', '01100000000', 176, '2013-5-5');

INSERT INTO buyTbl(num,userID,prodName,groupName,price,amount) 
VALUES(null, 'KBS', '운동화', null, 30, 2)
,(null, 'KBS', '노트북', '전자', 1000, 1)
,(null, 'JYP', '모니터', '전자', 200, 1)
,(null, 'BBK', '모니터', '전자', 200, 5)
,(null, 'KBS', '청바지', '의류', 50, 3)
,(null, 'BBK', '메모리', '전자', 80, 10)
,(null, 'SSK', '책', '서적', 15, 5)
,(null, 'EJW', '책', '서적', 15, 2)
,(null, 'EJW', '청바지', '의류', 50, 1)
,(null, 'BBK', '운동화', NULL, 30, 2)
,(null, 'EJW', '책', '서적', 15, 1)
,(null, 'BBK', '운동화', NULL, 30, 2);

-- buyTbl 에 임의로 INSERT 구문을 이용해서 없는 userID를 정해 데이터 입력 시도해보기 
INSERT INTO buyTbl VALUES(null, 'CHO', '드라곤볼', NULL, 99, 99); 
use sqlDB;

SELECT * FROM userTbl;
SELECT * FROM buyTbl;

-- 여태까지의 SELECT 구문은 조건 없이 모든 데이터를 조회했습니다.
-- 극단적인경우 employees 테이블의 수십만 row를 다 조회하다 보니
-- 조회시간만 오래 걸리는 경우가 발생
-- 따라서 조건에 맞도록 필터링을 할 수 있고, 이를 위해 사용하는 구문은 WHERE구문임
-- SELECT 컬럼명1, 컬럼명2... FROM 테이블명 WHERE 컬럼명+조건식;

SELECT * FROM userTbl WHERE name ='김경호';

-- 관계연산자를 활용해서 대소비교를 하거나
-- and, or을 이용해 조건 여러개를 연결할수 있다.
-- 1970년생 이후 출생 하였으며, 키가 182 이상인 사람의 아이디와 이름을 조회하는 구문을 아래에 작성하기
SELECT userId, name FROM userTbl WHERE height >= 182 and birthYear >= 1970;

-- 키가 180이상 , 183 이하인 사람만 필터링하기
SELECT * FROM userTbl WHERE (height <=183) and (height >=180);

-- 위와 같이 범위를 정하는 구문은 BETWEEN ~ AND 로 간단하게 구현합니다.
SELECT * FROM userTbl WHERE height between 180 AND 183;

-- 위와 같이 숫자는 연속된 범위를 갖기 때문에 범위 연산자로 처리가 가능하나
-- addr 같은 자료는 서울이 크고 크다던가 경남이 작다던가 하는 연산적 처리가 
-- 불가능 하다. 먼저 지역이 경남, 전남,경북 인 사람의 정보를 WHERE 로 조회하기
SELECT * FROM userTbl WHERE addr = '경남' OR '전남' OR '경북';

-- in 키워드를 사용하면 컬럼명 in ( 데이터1,2,3,4,...);
-- 특정 컬럼에 괄호에 담긴 데이터가 포함되는 경우를 전부 출력합니다.
SELECT *FROM userTbl WHERE addr IN ('경남','전남','경북');

-- like 연산자는 일종의 표현 양식을 만들어 줍니다.
-- like 연산자를 이용하면 %(어떤문자든지 혹은 몇글자던지상관 없다)라고 불리는 와일드카드나 
-- 혹은 _(한글자)라고 불리는 와일드 카드구문을 사용해
-- 매치되는문자, 문자열을 찾습니다.
-- 김씨를 찾는 케이스(%는 뒤에 몇글자가 오던지 상관이 없다. 0~무한)
SELECT * FROM userTbl WHERE name LIKE '김%';  

-- 김씨를 찾는 케이스 (_는 한글자임)
SELECT * FROM userTbl WHERE name LIKE '김__';

-- 서브쿼리(하위쿼리)란 1차적 결과를 얻어놓고, 거기서 다시 조회구문을 중첩해서 날리는것을 의미함
-- 김경호보다 키가 큰 사람을 조회하는 예시를 보겠습니다.

-- 원시적 방법
-- 1.김경호의 키를 where절을 이용해 확인
SELECT height FROM userTbl WHERE name ='김경호';
-- 2. 확인한 김경호의 키를 쿼리문에 넣는다
SELECT name, height FROM userTbl WHERE height > 177;

-- 서브쿼리 활용 방법
-- 서브쿼리는 FROM 절 다음에 () 를 이용해서 
-- SELECT 구문을 한 번 더 활용합니다.
SELECT name, height from userTbl WHERE height > 
                   (SELECT height FROM userTbl WHERE name ='김경호'); 

-- 지역이 경남인 사람들 중 키가 제일 큰 사람보다
-- 키가 더 큰 타 지역 사람을 구하시오
SELECT 
    name, height, addr
FROM
    userTbl
WHERE
    height > (SELECT 
            MAX(height)
        FROM
            userTbl
        WHERE
            addr = '경남');   
                 -- 내풀이 addr max 위치 바꾸서 해서 틀렸엇음
                 
-- ANY , ALL , SOME 구문은 서브쿼리와 조합해서 사용합니다.
-- 지역이 경남인 사람보다 키가 큰 사람을 찾는 쿼리문
SELECT 
    *
FROM
    userTbl
WHERE
    height >= (SELECT 
            height
        FROM
            userTbl
        WHERE
            addr = '경남');
  -- 경남사람들중 어느 사람 키(170,173)에 기준해야 될지 몰라 오류가 뜸
  
 -- ANY 구문을 사용하면 (170 보다 크거나 같은) OR (173 보다 크거나 같은)  조건으로 들어감(개별 값 하나하나에 대해 or 이 걸린다)
 -- 즉 170 보다 크거나 같다로 결론이 나옴
SELECT * FROM userTbl WHERE height >= ANY 
                   (SELECT height FROM userTbl WHERE addr='경남');

-- ALL 구문을 사용하면 (170보다 크거나 같은) AND (173~) 조건으로 들어감 개별조건하나하나에 AND가 걸린다.
-- 즉 173 보다 크거나 같다로 결론이 나옴
SELECT * FROM userTbl WHERE height >= ALL (SELECT height FROM userTbl WHERE addr='경남');

-- ANY 를 사용함에 있어서 = 로 조건 비교를 하는 경우는 사실상 in 키워드와 같은 효과를 냅니다.
SELECT name,height FROM userTbl WHERE height = ANY
                       (SELECT height FROM userTbl WHERE addr='경남');

-- ORDER BY는 결과물의 갯수나 종류에는 영향을 미치지 않지만 결과물을 순서대로 (오름차순,내림차순) 정렬하는 기능을 가짐.
-- SELECT 컬럼명 FROM 테이블명 ORDER BY 기준컬럼 정렬기준;
-- 정렬순서는 ASC(오름차순) ,DESC(내림차순) 이 있으며 입력이 없을경우 ASC가 기본임
-- 가입한 순서 (mDate순으로 오름차순 조회 해주세요)
SELECT * FROM userTbl ORDER BY mDate ASC;

-- 정렬시 동점인 부분을 처리하기 위해 ORDER BY 절을 두개이상 동시에 나열할 수도 있다.
-- 아래 코드는 키로 내림차순을 하되, 동점 이면 생일을 기준으로 오름차순으로 나열합니다.
SELECT * FROM userTbl ORDER BY height DESC, birthYear ASC;   -- 앞에꺼가 우선이됨

-- DISTINCT는 결과물로 나온 컬럼의 중복 값을 다 제거하고
-- 고유 값을 하나씩만 남깁니다.
-- 아래 코드는 지역 종류 5개(데이터 개수는 10개)를 파악하기 어렵습니다.
SELECT addr FROM userTbl;
-- 중복값을 하나로 출력하기 위해 출력컬럼 앞에 DISTINCT를 붙입니다.
SELECT DISTINCT addr FROM userTbl;

-- 출력 요소의 갯수를 제한할때는 limit 구문을 사용합니다.
use employees;
-- 데이터가 300000개에 가깝다 보니 모든 데이터를 보여주지 않고 1000개만 보여주도록 설정되어있습니다.(cmd는 기본제한이없다)
SELECT * FROM employees;
-- 테이블명 뒤에 limit 숫자; 가 오는 경우 적은 숫자 만큼만 결과창에 보여줍니다
-- 하나만 적으면 0~n(인덱스임! 실제 0아님 인덱스 0 1 2 3 임!) / 10,10; 이면 인덱스(10)번이후 부터 10개 출력
SELECT * FROM employees limit 10;
SELECT * FROM employees limit 20,10;

-- !!!! GROUP BY 는 같은 데이터를 하나의 그룹으로 묶어 줍니다.
-- 조건절은 WHERE이 아닌 HAVING으로 처리를 한다
USE sqlDB;
-- 하기 데이터에서 각 인물 별로 구매한 개수 총합을 구해보자
SELECT userID,amount FROM buyTbl ORDER BY userID;

-- SELECT 컬럼명, 집계함수(컬럼명2).. FROM 테이블명 GROUP BY 묶을 컬럼명;
SELECT userID,sum(amount) FROM buyTbl GROUP BY userID;

-- 각 유저별 구매 물품의 평균가를 구해보세요(총액이아님) (평균은 AVG)
SELECT userID,AVG(price) FROM buyTbl GROUP BY userID;
SELECT userID AS Name , AVG(price) AS Money FROM buyTbl GROUP BY userID;

-- 각 유저별 총 구매액을 구하기

SELECT userID,sum(price*amount) AS Totalmoney FROM buyTbl GROUP BY userID;

-- 각 물품그룹별 총 판매 금액을 집계해주세요
-- 컬럼명은 AS '변경명칭' 으로 변경할 수 있습니다. -- 오라클은 ' ' 없이함
SELECT groupName,sum(price*amount) AS '총매출' FROM buyTbl GROUP BY groupName;


-- 자주쓰는 집계함수 정리
-- AVG() 평균 / MIN() 최소값 / MAX() 최대값 / COUNT() 로우 개수 / COUNT(DISTINCT) 종류 개수
-- STDEV() 표준편차 / VAR_SAMP() 분산

-- userTbl에서 키가 가장 큰 회원을 찾아주세요
SELECT * FROM userTbl WHERE height=(SELECT MAX(height) FROM userTbl);
-- userTbl에서 키가 가장 작은 회원
SELECT * FROM userTbl WHERE height=(SELECT MIN(height) FROM userTbl);
SELECT * FROM userTbl WHERE MIN(height); -- 내가 푼거 
-- userTbl 가수 전체 키 평균
SELECT AVG(height) FROM userTbl ;
SELECT * FROM userTbl WHERE AVG(height); -- 내가 푼거 

-- GROUP BY 절에서는 조건절로 WHERE 을 쓰지 않습니다.
-- WHERE 을 대신해 HAVING절을 사용합니다.
-- 사용법은 완전히 WHERE과 동일.
-- 우선 사용자별 총 구매액을 다시 구해봅시다.
SELECT userID, SUM(price* amount) AS '총구매액' FROM buyTbl GROUP BY userID;
-- 여기서 구매액이 1000이 넘는 사람들만 남겨보기
SELECT userID, SUM(price* amount) AS '총구매액' 
                                 FROM buyTbl GROUP BY userID
                                 HAVING SUM(price*amount)>1000;




                   


  