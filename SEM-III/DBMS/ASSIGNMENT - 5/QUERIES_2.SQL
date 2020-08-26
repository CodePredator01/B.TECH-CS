-- RUN THIS COMMAND BEFORE RUNNING FURTHER QUERIES
INSERT INTO Apply
SELECT s1.sID, 'Berkeley', 'CSE', 'Y'
FROM student s1
WHERE s1.sID IN
      (SELECT s.sID FROM student s WHERE s.sID NOT IN (SELECT a.sID FROM apply a where a.cName = 'Berkeley'));


-- Q18. Find college where all the student have applied.
SELECT DISTINCT cName
FROM APPLY OUTER_TABLE
WHERE NOT EXISTS(
        SELECT DISTINCT sID
        FROM APPLY
        WHERE sID NOT IN (
                SELECT DISTINCT sID
                FROM APPLY
                WHERE cNAME = OUTER_TABLE.cName));

-- Q19. Find sid of student who have not applied to Stanford.
SELECT DISTINCT sID
FROM APPLY
MINUS
SELECT DISTINCT sID
FROM APPLY
WHERE cName = 'Stanford';

-- Q20. Find sid of Student that applied to both Stanford and Berkeley.
SELECT DISTINCT sID
FROM APPLY
MINUS
SELECT DISTINCT sID
FROM APPLY
WHERE cName = 'Stanford'
   OR cName = 'Berkeley';

-- Q21. Give list of all names including all names of colleges and students.
SELECT DISTINCT sName, cName
FROM STUDENT, APPLY
WHERE APPLY.sID = STUDENT.sID
ORDER BY sName;

-- Q22. Create a table ApplicationInfo having columns sID: int, sName: varchar2(10) and number_of_applications: number(2) they filed?
--      Populate this table with appropriate data using insert command.
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

-- Q23. Create table ApplicationData and load with ID, name and college where they applied with state of college (remember to include details of ALL 
--      students that have applied or not applied) on runtime using single query.
CREATE TABLE ApplicationData(
    sID INTEGER,
    sName VARCHAR(10),
    cName VARCHAR(10),
    state VARCHAR(2)
);
INSERT INTO ApplicationData
SELECT STUDENT.sID, sName,
    APPLY.cName, state
FROM STUDENT
    LEFT JOIN APPLY ON APPLY.sID = sTUDENT.sID
    LEFT JOIN COLLEGE ON APPLY.cName = COLLEGE.cName
ORDER BY STUDENT.sID;

-- Q24. Stanford decide not to take any student who have also applied to its rival Berkeley turn their application decision to N.
UPDATE APPLY OUTER_TABLE
SET decision = 'N'
WHERE cName = 'Stanford'
  AND 'Berkeley' IN (SELECT DISTINCT cName FROM APPLY WHERE sID = OUTER_TABLE.sID);


-- Q25. Delete applications that are filed to city ‘ New York ’.
DELETE FROM APPLY
WHERE cName IN (
        SELECT cName FROM COLLEGE
        WHERE state = 'NY'
    );