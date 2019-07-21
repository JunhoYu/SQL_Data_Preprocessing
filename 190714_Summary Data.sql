# Summary data of review
#	Review 관련 요약 정보

## Sample Data
## 예시 데이터 
DROP TABLE IF EXISTS review;
CREATE TABLE review (
    user_id    varchar(255)
  , product_id varchar(255)
  , score      numeric
);

INSERT INTO review
VALUES
    ('U001', 'A001', 4.0)
  , ('U001', 'A002', 5.0)
  , ('U001', 'A003', 5.0)
  , ('U002', 'A001', 3.0)
  , ('U002', 'A002', 3.0)
  , ('U002', 'A003', 4.0)
  , ('U003', 'A001', 5.0)
  , ('U003', 'A002', 4.0)
  , ('U003', 'A003', 4.0)
;

## AVG, SUM, AVG, MAX, MIN
## 각 종 요약함수
SELECT  
	user_id
	, COUNT(*) AS total_count
    , COUNT(DISTINCT product_id) AS product_count
    , SUM(score) AS sum
    , AVG(score) AS avg
    , MAX(score) AS max
    , MIN(score) AS min
FROM
	review
GROUP BY
	user_id
;

#위 내용은 SQL 레시피  (한빛미디어) - 95P를 참고하였습니다.