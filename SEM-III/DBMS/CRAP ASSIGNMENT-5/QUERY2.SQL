-- RUN THIS COMMAND BEFORE RUNNING FURTHER QUERIES
INSERT INTO Apply
SELECT s1.sID, 'Berkeley', 'CSE', 'Y'
FROM student s1
WHERE s1.sID IN
      (SELECT s.sID FROM student s WHERE s.sID NOT IN (SELECT a.sID FROM apply a where a.cName = 'Berkeley'));


-- QUERY-18
SELECT DISTINCT cName
FROM APPLY OUTER_TABLE
WHERE NOT EXISTS(SELECT DISTINCT sID
                 FROM APPLY
                 WHERE sID NOT IN (
                     SELECT DISTINCT sID
                     FROM APPLY
                     WHERE cNAME = OUTER_TABLE.cName));

-- QUERY-19
SELECT DISTINCT sID
FROM APPLY
MINUS
SELECT DISTINCT sID
FROM APPLY
WHERE cName = 'Stanford';


-- QUERY-20
SELECT DISTINCT sID
FROM APPLY
MINUS
SELECT DISTINCT sID
FROM APPLY
WHERE cName = 'Stanford'
   OR cName = 'Berkeley';


-- QUERY-21
SELECT cName AS NAME
FROM COLLEGE
UNION ALL
SELECT sName AS NAME
FROM STUDENT;


-- QUERY-22
CREATE TABLE ApplicationInfo
(
    sID                    INTEGER,
    sName                  VARCHAR(10),
    number_of_applications NUMBER(2)
);

INSERT INTO ApplicationInfo
SELECT sID, sName, COUNT(*)
FROM STUDENT
         NATURAL JOIN APPLY
GROUP BY sID, sName;


-- QUERY-23
CREATE TABLE ApplicationData
(
    sID   INTEGER,
    sName VARCHAR(10),
    cName VARCHAR(10),
    state VARCHAR(10)
);

INSERT INTO ApplicationData
SELECT STUDENT.sID, sName, APPLY.cName, state
FROM STUDENT
         LEFT JOIN APPLY
         ON STUDENT.sID = APPLY.sID
         LEFT JOIN COLLEGE
         ON APPLY.cName = COLLEGE.cName
GROUP BY STUDENT.sID, sName, APPLY.cName, state
ORDER BY sID;



-- QUERY-24
UPDATE APPLY
SET decision = 'N'
WHERE cName = 'Stanford'
  AND sID IN (SELECT sID FROM APPLY WHERE cName = 'Berkeley');

-- QUERY-25
DELETE
FROM APPLY
WHERE cName IN (SELECT cName FROM COLLEGE WHERE state = 'NY');