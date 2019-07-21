# Extract Top N
# 상위 N개만 추출하기 

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

## Using subquery for Extracting Top N
## 서브 쿼리를 이용한 상위 N개 추출
SELECT
		category
        , product_id
        , score
        , ROW_NUMBER()
			OVER(PARTITION BY category ORDER BY score DESC) AS `rank`
FROM popular_products;


## Using subquery for Extract Top 2
## 서브쿼리를 이용한 상위 2개의 내역 추출
SELECT *
FROM
	(SELECT
		category
        , product_id
        , score
        , ROW_NUMBER()
			OVER(PARTITION BY category ORDER BY score DESC) AS `rank`
	FROM popular_products
    ) AS popular_products_with_rank
WHERE `rank` <= 2
ORDER BY category, `rank`
;