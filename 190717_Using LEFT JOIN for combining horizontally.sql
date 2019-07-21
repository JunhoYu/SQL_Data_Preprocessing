
# Combine tables horizontally
# 테이블을 결함해서 가로로 정렬하기

## Sample data
## 예제 데이터
DROP TABLE IF EXISTS mst_categories;
CREATE TABLE mst_categories (
    category_id integer
  , name        varchar(255)
);

INSERT INTO mst_categories
VALUES
    (1, 'dvd' )
  , (2, 'cd'  )
  , (3, 'book')
;

DROP TABLE IF EXISTS category_sales;
CREATE TABLE category_sales (
    category_id integer
  , sales       integer
);

INSERT INTO category_sales
VALUES
    (1, 850000)
  , (2, 500000)
;

DROP TABLE IF EXISTS product_sale_ranking;
CREATE TABLE product_sale_ranking (
    category_id integer
  , `rank`        integer
  , product_id  varchar(255)
  , sales       integer
);

INSERT INTO product_sale_ranking
VALUES
    (1, 1, 'D001', 50000)
  , (1, 2, 'D002', 20000)
  , (1, 3, 'D003', 10000)
  , (2, 1, 'C001', 30000)
  , (2, 2, 'C002', 20000)
  , (2, 3, 'C003', 10000)
;

## Using JOIN for combining horizontally
## 조인을 이용한 수평 결합
SELECT 
	m.category_id
    , m.name
    , s.sales
    , r.product_id AS sale_product
FROM
		mst_categories AS m
    JOIN
		category_sales AS s
        ON m.category_id = s.category_id
	JOIN 
		product_sale_ranking AS r
        ON m.category_id = r.category_id
;

## Using LEFT JOIN for combining horizontally
## LEFT JOIN을 이용한 마스터 테이블의 행 수를 변경하지 않으며 가로로 정렬하기

SELECT
	m.category_id
    , m.name
    , s.sales
    , r.product_id AS top_sales_product
FROM
		mst_categories AS m
	LEFT JOIN
		category_sales AS s
		ON m.category_id = s.category_id
	LEFT JOIN
		product_sale_ranking AS r
		ON m.category_id = r.category_id
        AND r.rank = 1
		### 카테고리별 최고 매출을 추출
        ### 행의 개수를 일치시키지 않으면 LEFT JOIN이 제대로 되지 않음.
;

## Using Subquery for combining horizontally
## 상관 서브쿼리를 이용한 가로로 정렬

SELECT
	m.category_id
    , m.name
		### 카테고리 별로 매출액 추가하기
    , (SELECT s.sales
		FROM category_sales AS s
        WHERE m.category_id = s.category_id
        ) AS sales
        ### 최고 매출 상품 도출
	, (SELECT r.product_id
		FROM product_sale_ranking AS r
		WHERE m.category_id = r.category_id
		ORDER BY sales DESC
        LIMIT 1
		) AS top_sales_product
FROM
	mst_categories AS m
;

#위 내용은 SQL 레시피  (한빛미디어) - 122P를 참고하였습니다.
