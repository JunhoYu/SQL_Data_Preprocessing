# Change comma seperated data to row

## Sample Data
DROP TABLE IF EXISTS purchase_log;
CREATE TABLE purchase_log (
    purchase_id integer
  , product_ids varchar(255)
);

INSERT INTO purchase_log
VALUES
    (100001, 'A001,A002,A003')
  , (100002, 'D001,D002')
  , (100003, 'A001')
;


## Using Cross Join for Change comma seperatedd data to row

SET GLOBAL log_bin_trust_function_creators = 1; 

## MySQL Split Function
CREATE FUNCTION SPLIT_STR(
  x VARCHAR(255),
  delim VARCHAR(12),
  pos INT
)
RETURNS VARCHAR(255)
RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),
       LENGTH(SUBSTRING_INDEX(x, delim, pos -1)) + 1),
       delim, '');
      
SELECT
		1 as A
        ,SPLIT_STR( 'a,b,c', ',' , 1) AS p1
;

SELECT *
FROM (
								SELECT 1 AS idx
			UNION ALL SELECT 2 AS idx
            UNION ALL SELECT 3 AS idx
) AS pivot
;

## 문자수의 차이를 이용해서 상품 수를 계산하는 쿼리
SELECT 
	purchase_id
    , product_ids
    ###쉼표의 갯수가 Count 되는 것을 이용해 상품 수를 계산함
    , 1+ char_length(product_ids) - char_length(replace(product_ids, ',' , ''))
    AS purduct_num
FROM
	purchase_log
;

SELECT
	l.purchase_id
	, l.product_ids
    , p.idx
    , SPLIT_STR(l.product_ids, ',', p.idx) AS product_id
FROM
		purchase_log AS l
    JOIN
		(							SELECT 1 AS idx
			UNION ALL		SELECT 2 AS idx
            UNION ALL 	SELECT 3 AS idx
		) AS p 
			ON p.idx <=
				(1 + char_length(l.product_ids) - char_length(replace(l.product_ids, ',', '')))
;