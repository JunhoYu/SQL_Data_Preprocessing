# Comparison
# 비교

## Sample Data
## 데이터 예시
DROP TABLE IF EXISTS monthly_sales;
CREATE TABLE monthly_sales(
    year integer
  , m1   integer
  , m2   integer
  , m3   integer
  , m4   integer
);

INSERT INTO monthly_sales
VALUES
    (2017, 8200, 7200, 6800, 6300)
  , (2018, 8500, 8500, 7000, 9100)
  , (2019, 6200, 8100, NULL , NULL )
;

## Comparison by CASE WHEN, sign(1,0,-1)

select
	year
    , m1
    , m2
    , CASE 
		when m1 < m2 then '+'
        when m1 > m2 then '-'
        else '='
	END AS m1VSm2
    , m2 - m1 AS diff
    , sign(m2-m1) AS sign
FROM monthly_sales
ORDER BY 
	year
;
