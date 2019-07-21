# Stamp to year, month, day and hour
# 스탬프를 년, 월, 일, 시로 변환하기

## Data Sample
## 예제
DROP TABLE IF EXISTS log ;
CREATE TABLE log (
    stamp    varchar(255)
);

INSERT INTO log 
VALUES
    ('2017-07-26 12:02:00')
  , ('2019-04-26 13:02:01')
  , ('2019-08-26 14:02:01')
;

## Using substring
## substring을 이용한 변환 
select
	stamp
    , substring(stamp, 1,4 ) AS year
    , substring(stamp, 6,2 ) AS month
    , substring(stamp, 9,2 ) AS day
    , substring(stamp, 12,2 ) AS hour
from log;
