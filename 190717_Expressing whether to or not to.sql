# Expressing whether to or not to
# O, X - 여부의 표현
 
## Sample Data
## 예시 데이터
DROP TABLE IF EXISTS mst_users_with_card_number;
CREATE TABLE mst_users_with_card_number (
    user_id     varchar(255)
  , card_number varchar(255)
);

INSERT INTO mst_users_with_card_number
VALUES
    ('U001', '1234-xxxx-xxxx-xxxx')
  , ('U002', NULL                 )
  , ('U003', '5678-xxxx-xxxx-xxxx')
;

DROP TABLE IF EXISTS purchase_log;
CREATE TABLE purchase_log (
    purchase_id integer
  , user_id     varchar(255)
  , amount      integer
  , stamp       varchar(255)
);

INSERT INTO purchase_log
VALUES
    (10001, 'U001', 200, '2017-01-30 10:00:00')
  , (10002, 'U001', 500, '2017-02-10 10:00:00')
  , (10003, 'U001', 200, '2017-02-12 10:00:00')
  , (10004, 'U002', 800, '2017-03-01 10:00:00')
  , (10005, 'U002', 400, '2017-03-02 10:00:00')
;

## Using CASE WHEN, SIGN to express whether to or not to
## CASE WHEN, SIGN을 이용한 이력의 표현
SELECT
	m.user_id
    , m.card_number
	, COUNT(p.user_id) AS purchase_count
    , CASE WHEN m.card_number IS NOT NULL THEN 1 ELSE 0 END AS has_card
    , SIGN(COUNT(p.user_id)) AS has_purchased
FROM 
		mst_users_with_card_number AS m
	LEFT JOIN
		purchase_log AS p
        ON m.user_id = p.user_id
# GROUP BY를 사용하지 않으면, 실행이 안된다. 기존의 행을 유지하고 싶은 경우엔 기존의 열을 GROUP BY에 기입해야만 함
GROUP BY m.user_id, m.card_number
;

#위 내용은 SQL 레시피  (한빛미디어) - 130P를 참고하였습니다.
