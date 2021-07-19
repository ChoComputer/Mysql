CREATE TABLE scores (
    uname VARCHAR(20) NOT NULL PRIMARY KEY,
    uno INT NOT NULL,
    uclass VARCHAR(2) NOT NULL,
    uage INT NOT NULL,
    umath INT NOT NULL,
    ueng INT NOT NULL,
    ucom INT NOT NULL
);

INSERT INTO scores 
VALUES
('강기범',11,'2반',28,31,70,38),('강영훈',10,'1반',27,55,79,60),('김영수',1,'1반',20,85,72,70),
('김자바',4,'1반',20,50,54,42),('김진수',2,'2반',25,90,80,62),('김진영',6,'3반',35,41,68,95),
('마영수',15,'3반',26,85,85,76),('박자바',3,'3반',22,63,95,58),('박찬기',14,'2반',26,76,82,90),
('박철훈',9,'3반',29,89,32,71),('이영수',5,'2반',31,92,51,96),('진강훈',12,'3반',24,100,81,67),
('진성환',8,'2반',27,56,57,68),('최성훈',7,'1반',22,81,43,32),('최준영',13,'1반',21,69,88,32)
;
  DROP TABLE scores;
SELECT 
   uclass, AVG(umath), AVG(ueng), AVG(ucom)
FROM
 (SELECT * FROM scores ORDER BY uclass ASC
 LIMIT 18446744073709551615) AS student GROUP BY uclass;
 
SELECT 
   uclass, uname, MAX(ucom)
FROM
 (SELECT * FROM scores ORDER BY uclass ASC
LIMIT 18446744073709551615) AS student GROUP BY uclass;
