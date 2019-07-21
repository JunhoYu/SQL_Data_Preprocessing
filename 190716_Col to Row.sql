# Col to Row

## Sample Data

DROP TABLE IF EXISTS quarterly_sales;
CREATE TABLE quarterly_sales (
    year integer
  , q1   integer
  , q2   integer
  , q3   integer
  , q4   integer
);

INSERT INTO quarterly_sales
VALUES
    (2015, 82000, 83000, 78000, 83000)
  , (2016, 85000, 85000, 80000, 81000)
  , (2017, 92000, 81000, NULL , NULL )
;

## Using Pivot table with CROSS JOIN for Col to Row
## 피벗 테이블과 크로스 조인을 이용한, 열을 행을로 바꾸기

SELECT
	q.year
    , CASE
		WHEN p.idx = 1 THEN 'q1'
        WHEN p.idx = 2 THEN 'q2'
        WHEN p.idx = 3 THEN 'q3'
        WHEN p.idx = 4 THEN 'q4'
	END AS `quarter`
    , CASE
		WHEN p.idx = 1 THEN q.q1
        WHEN p.idx = 2 THEN q.q2
        WHEN p.idx = 3 THEN q.q3
        WHEN p.idx = 4 THEN q.q4
	END AS sales
FROM
	quarterly_sales AS q
	CROSS JOIN
		(
							SELECT 1 AS idx
		UNION ALL SELECT 2 AS idx
		UNION ALL SELECT 3 AS idx
		UNION ALL SELECT 4 AS idx
		) AS p
;
        
#위 내용은 SQL 레시피  (한빛미디어) - 111P를 참고하였습니다.