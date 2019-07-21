# CUM_SCORE, First and last Value in window function
# CUM_SCORE-스코어를 모두 더한 값, 

## Sample Data
## 예시 데이터
DROP TABLE IF EXISTS popular_products;
CREATE TABLE popular_products (
    product_id varchar(255)
  , category   varchar(255)
  , score      numeric
);

INSERT INTO popular_products
VALUES
    ('A001', 'action', 94)
  , ('A002', 'action', 81)
  , ('A003', 'action', 78)
  , ('A004', 'action', 64)
  , ('D001', 'drama' , 90)
  , ('D002', 'drama' , 82)
  , ('D003', 'drama' , 78)
  , ('D004', 'drama' , 58)
;


## Using Window Function
## 윈도우 함수의 사용

SELECT
	product_id
    , score
    , ROW_NUMBER() OVER(ORDER BY score DESC) AS 'row'
    , SUM(score) OVER(ORDER BY score DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_score
    ### 윈도우 함수의 개념사용 
    ##### 윈도우함수 OVER ( PARTITION BY expr ORDER BY expr [ASC | DESC] ROWS[RANGE] 
    ##### BETWEEN UNBOUNDED PRECEDING[CURRENT ROW] AND UNBOUNDED FOLLOWING[CURRENT ROW] )
			#ROWS : 부분집합인 윈도우 크기를 물리적인 단위로 행 집합을 지정
			#RANGE : 논리적인 주소에 의해 행 집합을 지정
			#BETWEEN ~ AND : 윈도우의 시작과 끝 위치를 지정
			#UNBOUNDED PRECEDING : 윈도우 시작 위치가 첫 번째 로우임을 의미
			#UNBOUNDED FOLLOWING : 윈도우 마지막 위치가 마지막 로우임을 위미
			#CURRENT ROW : 윈도우 시작 위치가 현재 로우임을 의미
            ## 참고 링크: https://sites.google.com/site/smcgbu/home/gongbu-iyagi/windouhamsu
	, FIRST_VALUE(product_id) 
		OVER( ORDER BY score DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS first_val
	, LAST_VALUE(product_id)
		OVER( ORDER BY score DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_val
    
FROM popular_products
ORDER BY 'row'
;