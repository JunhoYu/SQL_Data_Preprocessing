# Greatest, least and average
# 최대,최솟값 

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

## Greatest, least and average

SELECT
	year
    , greatest( coalesce(m1,0), coalesce(m2,0), coalesce(m3,0), coalesce(m4,0)) as Greatest
    , least( coalesce(m1,0), coalesce(m2,0), coalesce(m3,0), coalesce(m4,0)) as Least
    , (coalesce(m1,0) + coalesce(m2,0) + coalesce(m3,0) + coalesce(m4,0))/4 as Average
    , (coalesce(m1,0) + coalesce(m2,0) + coalesce(m3,0) + coalesce(m4,0))
    /(SIGN(coalesce(m1,0)) + SIGN(coalesce(m2,0)) + SIGN(coalesce(m3,0)) + SIGN(coalesce(m4,0))) as Average_Except_Null
FROM monthly_sales
ORDER BY 
	year
;
