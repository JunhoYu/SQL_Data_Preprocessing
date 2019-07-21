# Combine tables vertically
# 세로로 테이블 결합하기

## Sample data
## 예제 데이터
DROP TABLE IF EXISTS app1_mst_users;
CREATE TABLE app1_mst_users (
    user_id varchar(255)
  , name    varchar(255)
  , email   varchar(255)
);

INSERT INTO app1_mst_users
VALUES
    ('U001', 'Sato'  , 'sato@example.com'  )
  , ('U002', 'Suzuki', 'suzuki@example.com')
;

DROP TABLE IF EXISTS app2_mst_users;
CREATE TABLE app2_mst_users (
    user_id varchar(255)
  , name    varchar(255)
  , phone   varchar(255)
);

INSERT INTO app2_mst_users
VALUES
    ('U001', 'Ito'   , '080-xxxx-xxxx')
  , ('U002', 'Tanaka', '070-xxxx-xxxx')
;

## Using UNION ALL
## UNION ALL을 이용한 결합

SELECT 'app1' AS app_name, user_id, name, email 
FROM app1_mst_users
UNION ALL
SELECT 'app2' AS app_name, user_id, name, NULL AS emailm 
FROM app2_mst_users
;