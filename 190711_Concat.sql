# Concat - Make a connection between string
# Concat 기능을 이용한 문자열 연결

## Sample Data
## 데이터 예시
DROP TABLE IF EXISTS location;
CREATE TABLE location (
    id   varchar(255)
  , city varchar(255)
  , sector varchar(255)
);

INSERT INTO location
VALUES
    ('U001', '서울특별시', '강남구')
  , ('U002', '안양시', '동안구'  )
  , ('U003', '세종시', '1타운')
;
## Using Concat
## Concat을 이용한 문자열 연결
select 
	*
	,concat(city,sector) as fullname	
from 
location;