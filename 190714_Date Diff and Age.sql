# Date Diff and Age
# 날짜 차이, 나이 구하기

## Sample Data
DROP TABLE IF EXISTS mst_users_with_dates;
CREATE TABLE mst_users_with_dates (
    user_id        varchar(255)
  , register_stamp varchar(255)
  , birth_date     varchar(255)
);

INSERT INTO mst_users_with_dates
VALUES
    ('U001', '2017-02-28 10:00:00', '1998-03-15')
  , ('U002', '2015-03-29 10:00:00', '1995-02-21')
  , ('U003', '2012-03-01 10:00:00', '1990-11-29')
;

## Date Diff and Korean Age
## 가입 경과 일수와 한국 나이의 차이

SELECT
	user_id
    , current_date() as today
    , date (timestamp(register_stamp)) AS register_date
    , datediff(current_date(), date(timestamp(register_stamp))) diff_date
    , birth_date
    , round((datediff(current_date(), birth_date))/365)+1 AS Korean_age 
FROM
	mst_users_with_dates
;

#위 내용은 SQL 레시피  (한빛미디어) - 82P를 참고하였습니다.