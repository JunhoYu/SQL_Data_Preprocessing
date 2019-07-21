# Using RANK, DENSE RANK, ROW_NUMBER, LAG and LEAD
#  등수 관련 선, 후 행의 표시

## Sample Data
## 예시 데이터
DROP TABLE IF EXISTS popular_products;
CREATE TABLE popular_products (
    product_id varchar(255)
  , category   varchar(255)
  , score      numeric
);

INSERT INTO popular_products
VALUES
    ('A001', 'action', 94)
  , ('A002', 'action', 81)
  , ('A003', 'action', 78)
  , ('A004', 'action', 64)
  , ('D001', 'drama' , 90)
  , ('D002', 'drama' , 82)
  , ('D003', 'drama' , 78)
  , ('D004', 'drama' , 58)
;


## ROW_NUMBER() OVER(ORDER BY score DESC), RANK(), DENSE_RANK(), LAG, LEAD
## 각종 집계함수의 사용

SELECT
	product_id
    , score
    , ROW_NUMBER() OVER(ORDER BY score DESC) AS 'row'
    , RANK() OVER(ORDER BY score DESC) AS 'rank'
    , DENSE_RANK() OVER(ORDER BY score DESC) AS denes_rank
    , LAG(product_id) OVER(ORDER BY score DESC) AS lag1
		###LAG-score를 기준으로 현재 행 보다 앞에 있는 행 출력
    , LAG(product_id, 2) OVER(ORDER BY score DESC) AS lag2
    , LEAD(product_id) OVER(ORDER BY score DESC) AS lead1
		###LEAD-score를 기준으로 현재 행 보다 뒤에 있는 행 출력
    , LEAD(product_id, 2) OVER(ORDER BY score DESC) AS lead2
FROM popular_products
ORDER BY 'row'
;