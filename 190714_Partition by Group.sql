# Using 'Partition By-Over' for avg by group
# 집약 함수의 사용

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

## PARTITION BY -- OVER
## 집약 함수 이용을 통한  집단별 평균 구하기
SELECT  
	user_id
	, product_id
    , score
    , AVG(score) OVER() AS avg_score
    , AVG(score) OVER(PARTITION BY user_id) AS user_avg_score
    , score - (AVG(score) OVER(PARTITION BY user_id)) AS avg_diff
FROM
	review
;


## 
#위 내용은 SQL 레시피  (한빛미디어) - 97P를 참고하였습니다.