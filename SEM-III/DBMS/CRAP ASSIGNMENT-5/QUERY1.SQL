-- QUERY-1
SELECT DISTINCT APPLY.sID, sName
FROM APPLY
         LEFT JOIN STUDENT
                   ON APPLY.sID = STUDENT.sID
WHERE major = 'CS'
ORDER BY sName;



-- QUERY-2
SELECT DISTINCT sID, sName
FROM STUDENT
WHERE sizeHS = (SELECT sizeHS FROM STUDENT WHERE sName = 'Jay')
ORDER BY sName;



-- QUERY-3
SELECT DISTINCT sID, sName
FROM STUDENT
WHERE sizeHS = (SELECT sizeHS FROM STUDENT WHERE sName = 'Jay')
  AND sName != 'Jay'
ORDER BY sName;



-- QUERY-4
SELECT DISTINCT sID, sName, GPA
FROM STUDENT
WHERE GPA != (SELECT GPA FROM STUDENT WHERE sName = 'Irene')
ORDER BY sName;



-- QUERY-5
SELECT DISTINCT cName
FROM APPLY
         LEFT JOIN STUDENT
                   ON apply.sID = student.sID
WHERE sName LIKE 'J%'
ORDER BY cName;



-- QUERY-6
SELECT DISTINCT major
FROM STUDENT
         LEFT JOIN APPLY
                   ON apply.sID = student.sID
WHERE sName = 'Irene'
ORDER BY major;



-- QUERY-7
SELECT DISTINCT APPLY.sID, major
FROM APPLY
         LEFT JOIN STUDENT
                   ON apply.sID = student.sID
WHERE major IN (SELECT DISTINCT major
                FROM STUDENT
                         LEFT JOIN APPLY
                                   ON apply.sID = student.sID
                WHERE sName = 'Irene'
)
ORDER BY sID, major;



-- QUERY-8
SELECT DISTINCT APPLY.sID, major
FROM APPLY
         LEFT JOIN STUDENT
                   ON apply.sID = student.sID
WHERE major IN (SELECT DISTINCT major
                FROM STUDENT
                         LEFT JOIN APPLY
                                   ON apply.sID = student.sID
                WHERE sName = 'Irene'
)
  AND apply.sID != (SELECT sID FROM student WHERE sName = 'Irene')
ORDER BY sID, major;



-- QUERY-9
SELECT COUNT(DISTINCT cName) AS COLLEGE_COUNT
FROM APPLY
WHERE sID = (SELECT sID FROM student WHERE sName = 'Jay');



-- QUERY-10
SELECT sID
FROM APPLY
GROUP BY sID
HAVING COUNT(DISTINCT cName) >= (SELECT COUNT(DISTINCT cName) AS COLLEGE_COUNT
                                 FROM APPLY
                                 WHERE sID = (SELECT sID
                                              FROM student
                                              WHERE sName = 'Jay'
                                 ))
ORDER BY sID;



-- QUERY-11
SELECT *
FROM STUDENT
WHERE sID IN (SELECT sID FROM APPLY WHERE major = 'CS')
  AND sID NOT IN (SELECT sID FROM APPLY WHERE major = 'EE')
ORDER BY sID;



-- QUERY-12
SELECT cName
FROM COLLEGE OUTER_TABLE
WHERE EXISTS(SELECT cName FROM COLLEGE WHERE state = OUTER_TABLE.state AND cName != OUTER_TABLE.cName)
ORDER BY cName;



-- QUERY-13
SELECT cName
FROM APPLY
GROUP BY cName
HAVING COUNT(DISTINCT sID) IN (
    SELECT MAX(ENROLLMENT_COUNT)
    FROM (SELECT COUNT(DISTINCT sID) AS ENROLLMENT_COUNT
          FROM APPLY
          GROUP BY cName) COUNT_TABLE);



-- QUERY-14
SELECT sName
FROM STUDENT
WHERE GPA = (
    SELECT MIN(GPA)
    FROM STUDENT);



-- QUERY-15
SELECT major
FROM APPLY
GROUP BY major
HAVING COUNT(*) = (SELECT MAX(APPLICATION_COUNT)
                   FROM (
                            SELECT COUNT(*) AS APPLICATION_COUNT
                            FROM APPLY
                            GROUP BY major) COUNT_TABLE);



-- QUERY-16
SELECT sID, sName, sizeHS
FROM STUDENT
WHERE sizeHS != (SELECT MIN(sizeHS)
                 FROM STUDENT
)
ORDER BY sID;



-- QUERY-17
SELECT sName, sID
FROM STUDENT OUTER_TABLE
WHERE NOT EXISTS(
        SELECT DISTINCT cName
        FROM APPLY
        WHERE sID = 987
          AND cName
            NOT IN
              (SELECT DISTINCT cName
               FROM APPLY
               WHERE sID = OUTER_TABLE.sID));