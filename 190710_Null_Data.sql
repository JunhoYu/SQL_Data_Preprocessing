# How to handle null data
# Null 값을 변환하는 방법

## Data Sample
## 예시
DROP TABLE IF EXISTS null_in_discount;
CREATE TABLE null_in_discount (
    id varchar(255)
  , cost      integer
  , discount      integer
);

INSERT INTO null_in_discount
VALUES
    ('1E1', 2230, NULL)
  , ('1E2', 5620,  500)
  , ('1E3', 1870, NULL)
;

## Using 'coalesce'
## coalesce를 이용한 변환

select
	id
    , cost
    , discount
    , cost - discount AS test1
    , cost - coalesce(discount, 0) AS null_to_0
from null_in_discount;
