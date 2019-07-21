#How to labet the Code
#Label을 만드는 방법

##Data Table Example
##데이터 예시
use SQL_Receipt;

DROP TABLE IF EXISTS Labeling;
CREATE TABLE Labeling(
    id         varchar(255)
  , date   varchar(255)
  , code integer
);

INSERT INTO Labeling
VALUES
    ('ID1', '2019-07-26', 1)
  , ('ID2', '2019-07-26', 2)
  , ('ID3', '2019-07-27', 3)
;

#Change Code to Label
#라벨링
select 
	id
    , CASE 
    WHEN code = 1 THEN 'Cell Phone'
    WHEN code =  2 THEN 'TV'
    WHEN code =  3  THEN 'AC'
    ELSE ''
    
    END AS Label
FROM Labeling
;