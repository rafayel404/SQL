-- Set operations

/*
  Combines the results of multiple SELECT queries vertically (stacks rows).
  Rules for use:
  1. Both queries must select the EXACT same number of columns.
  2. Corresponding columns must have compatible data types in the same order.
  3. Column names in the final result are taken from the FIRST query.
*/


-- 1. UNION ALL
-- Stacks rows and KEEPS all duplicates. Fast because no deduplication happens.
SELECT * FROM person1
UNION ALL
SELECT * FROM person2;


-- 2. UNION
-- Stacks rows and AUTOMATICALLY REMOVES duplicate rows. Slower than UNION ALL.
SELECT * FROM person1
UNION 
SELECT * FROM person2;


-- 3. INTERSECT (Supported in MySQL 8.0.31+)
-- Returns ONLY the rows that appear in BOTH query results.
SELECT * FROM person1
INTERSECT
SELECT * FROM person2;

-- 4. EXCEPT (Supported in MySQL 8.0.31+)
-- Returns rows from the first query that DO NOT exist in the second query.
-- (Order matters: Query_A EXCEPT Query_B is different than Query_B EXCEPT Query_A)

SELECT * FROM person1
EXCEPT
SELECT * FROM person2;



