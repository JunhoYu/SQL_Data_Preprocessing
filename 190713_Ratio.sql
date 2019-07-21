# Ratio - Click Through Rate
# 나누기를 통한 비율 계산: 항상 0, null로 나누면 안된다는 것을 주의하자!

## Sample Data
DROP TABLE IF EXISTS stats_ratio;
CREATE TABLE stats_ratio (
    DT          varchar(255)
  , ID       varchar(255)
  , impressions integer
  , clicks      integer
);

INSERT INTO stats_ratio
VALUES
    ('2019-04-01', '001', 10000,  300)
  , ('2019-04-01', '002', 13000,  110)
  , ('2019-04-01', '003', 35000, 140)
  , ('2019-04-02', '001',      0,     0)
  , ('2019-04-02', '002', 20000,  130)
  , ('2019-04-02', '003', 30000, 1200)
;

## Ratio

SELECT
	DT
    , ID
    , CASE
		WHEN impressions > 0 THEN 100.0 * clicks / impressions
	END AS ctr
FROM
	stats_ratio
ORDER BY
	DT, ID
;