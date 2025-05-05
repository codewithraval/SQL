USE PARTITION1;
CREATE TABLE BIT_COURSE(
COURSE_NAME VARCHAR(50),
COURSE_ID INT(10),
COURSE_TITLE VARCHAR(60),
COURSE_DESC VARCHAR(60),
LAUNCH_DATE DATE,
COURSE_FEE INT,
COURSE_MONITOR VARCHAR(60),
COURSE_LAUNCH_YEAR INT);
SELECT * FROM BIT_COURSE;
insert into bit_course values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'jalpa',2019) ,
('aiops' , 101 , 'ML', "this is aiops course" ,'2019-07-07',3540,'jalpa',2019) ,
('dlcvnlp' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'jalpa',2020) ,
('aws cloud' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'jalpa',2020) ,
('blockchain' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'jalpa',2021) ,
('RL' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'jalpa',2022) ,
('Dl' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'jalpa',2022) ,
('interview prep' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'jalpa',2019) ,
('big data' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
('data analytics' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'jalpa',2021) ,
('fsds' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'jalpa',2022) ,
('fsda' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'jalpa',2021) ,
('fabe' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'jalpa',2022) ,
('java' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'jalpa',2020) ,
('MERN' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'jalpa',2019);


SELECT * FROM bit_course WHERE COURSE_LAUNCH_YEAR = 2019;

SELECT *,
CASE 
     WHEN COURSE_NAME = 'JAVA' THEN SYSDATE()
     WHEN COURSE_NAME = 'FSDS' THEN SYSTEM_USER()
     WHEN COURSE_NAME = 'FSDA' THEN 'JAPLA'
     ELSE ' THIS NOT YOUR BATCH'
END AS STATMENT
FROM bit_course;



UPDATE BIT_COURSE
SET COURSE_TITLE = 
CASE    
WHEN COURSE_TITLE = 'ML' THEN 'machine_learning'
ELSE COURSE_TITLE
END;


UPDATE BIT_COURSE
SET COURSE_MONITOR = 
CASE    
WHEN COURSE_MONITOR = 'JALPA' THEN 'JALPA DESAI'
ELSE COURSE_MONITOR
END;

SELECT *,
CASE
     WHEN COURSE_LAUNCH_YEAR = 2019 THEN 'COURSE LAUNCH 2019'
      WHEN COURSE_LAUNCH_YEAR = 2020 THEN 'COURSE LAUNCH 2020'
       WHEN COURSE_LAUNCH_YEAR = 2021 THEN 'COURSE LAUNCH 2021'
       ELSE "THERE IS NO COURE SELECT"
	END AS STAMENT2
    FROM BIT_COURSE;
    
    SELECT *,
    CASE
         WHEN COURSE_MONITOR = 'JALPA DESAI' THEN 'BHARGAV RAVAL'
    ELSE COURSE_MONITOR
    END STATMENT4
FROM BIT_COURSE;
    
UPDATE BIT_COURSE
SET COURSE_ID =
CASE 
      WHEN COURSE_ID = 1 THEN 101
      ELSE 0
      END;
    
    SELECT * FROM BIT_COURSE;
    
UPDATE BIT_COURSE
SET COURSE_NAME =
CASE    
WHEN COURSE_NAME = 'FSDS'THEN  COURSE_NAME = 'FSDS'
ELSE COURSE_MONITOR
END;    