# Add rank in table
# 수치 자료를 이용한 순위 테이블의 추가

## Sample Data
## 예제 자료

DROP TABLE IF EXISTS product_sales;
CREATE TABLE product_sales (
    category_name varchar(255)
  , product_id    varchar(255)
  , sales         integer
);

INSERT INTO product_sales
VALUES
    ('dvd' , 'D001', 50000)
  , ('dvd' , 'D002', 20000)
  , ('dvd' , 'D003', 10000)
  , ('cd'  , 'C001', 30000)
  , ('cd'  , 'C002', 20000)
  , ('cd'  , 'C003', 10000)
  , ('book', 'B001', 20000)
  , ('book', 'B002', 15000)
  , ('book', 'B003', 10000)
  , ('book', 'B004',  5000)
;

## Using Common Table Expression (CTE) ans WITH for rank
## CTE와 WITH의 사용

WITH
product_sales_ranking AS(
	SELECT
		category_name
        , product_id
        , sales
        ### 카테고리 이름 별 그룹 후 내림차순으로 정렬함으로써 순위 정보를 추가
        , ROW_NUMBER() OVER(PARTITION BY category_name ORDER BY sales DESC) AS RA
	FROM
		product_sales
)

SELECT * 
FROM product_sales_ranking
;

## Unique Rank
## 유니크한 순위 목록 구하


WITH
product_sale_ranking AS(
	SELECT
		category_name
        , product_id
        , sales
        , ROW_NUMBER() OVER(PARTITION BY category_name ORDER BY sales DESC) AS `rank`
	FROM
		product_sales
)
, mst_rank AS (
	SELECT DISTINCT `rank`
	FROM product_sale_ranking
)
SELECT * 
FROM mst_rank
;

## Table with Vertical Rank 
## 순위를 수직적으로 표시하기.

WITH
product_sale_ranking AS(
	SELECT
		category_name
        , product_id
        , sales
        , ROW_NUMBER() OVER(PARTITION BY category_name ORDER BY sales DESC) AS `rank`
	FROM
		product_sales
)
, mst_rank AS (
	SELECT DISTINCT `rank`
	FROM product_sale_ranking
)
SELECT
	m.`rank`
    , r1.product_id AS dvd
    , r1.sales AS dvd_sales
    , r2.product_id AS cd
    , r2.sales AS cd_sales
    , r3.product_id AS book
    , r3.sales AS book_sales
FROM
		mst_rank AS m
	LEFT JOIN
		product_sale_ranking AS r1
        ON m.`rank` = r1.`rank`
        AND r1.category_name = 'dvd'
	LEFT JOIN
		product_sale_ranking AS r2
        ON  m.`rank` = r2.`rank`
        AND r2.category_name = 'cd'
	LEFT JOIN
		product_sale_ranking AS r3
        ON m.`rank` = r3.`rank`
        AND r3.category_name = 'book'
ORDER BY m.`rank`
;
 
#위 내용은 SQL 레시피  (한빛미디어) - 130P를 참고하였습니다.
 