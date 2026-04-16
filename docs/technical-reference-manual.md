# Technical Reference Manual

This manual groups the SQL solutions by query style and explains why each major SQL construct was used.

## 1. Simple retrieval queries

### Purpose
Return rows directly from a single table using conditions.

### Why `SELECT`
`SELECT` chooses the columns or expressions the query should return.

### Why `FROM`
`FROM` identifies the source table for the data.

### Why `WHERE`
`WHERE` filters records to only those that satisfy the condition.

### Why a single `SELECT` statement
Simple problems such as `movies/nonboringmovies.sql` only need one table, so no joins or nested queries are required.

### Examples
- `movies/nonboringmovies.sql`
- `rising-temperature/risingtemperature.sql` (self-comparison using a join)

## 2. Aggregation queries with `GROUP BY`

### Purpose
Summarize multiple rows into grouped results.

### Why `GROUP BY`
`GROUP BY` collects rows that share the same value(s) for one or more columns, so aggregate functions like `COUNT`, `SUM`, or `AVG` can compute summary values per group.

### Why `HAVING`
`HAVING` filters groups after aggregation. It is used when conditions depend on the result of an aggregate function.

### Why `ORDER BY`
`ORDER BY` sorts groups when the answer requires ranking or top results, such as choosing the customer with most orders.

### Common queries
- `studentsclass/classpercourse.sql`
- `customerorders/customermostorders.sql`
- `qualitypercentage/qualitypercentage.sql`
- `countries/transactioncountries.sql`

### Why `ASC` / `DESC`
- `ASC` sorts from lowest to highest.
- `DESC` sorts from highest to lowest.

Most `GROUP BY` queries use this when the result order matters or when retrieving the largest/smallest group first.

## 3. Conditional output with `CASE` / `WHEN`

### Purpose
Return different values depending on row conditions.

### Why `CASE`
`CASE` allows the query to choose result values conditionally. It can classify rows or build conditional aggregates.

### Why `WHEN`
`WHEN` defines each condition inside the `CASE` expression.

### Common queries
- `treenode-problems/treenodeproblem.sql` — classify rows as `Root`, `Inner`, or `Leaf`.
- `triangle-problem/triangleproblem.sql` — identify triangle type.
- `exchangeseatproblem/exchangeseat.sql` — apply conditional seat-change logic.
- `countries/transactioncountries.sql` and `rateoftripcancellation/rateoftripcancellations.sql` — conditional counts and sums.

## 4. Membership and nested queries with `IN` / `NOT IN`

### Purpose
Filter rows based on membership in a set produced by another query.

### Why `IN`
`IN` tests whether a value appears in the result set of a subquery or a fixed list.

### Why nested `SELECT`
A nested `SELECT` computes the set of values used for membership tests or comparison.

### When used
- `insuranceinvestment/insuranceinvestment.sql`: select rows whose `tiv_2015` value appears more than once.
- `salesproduct1styear.sql`: select first-year sales for each product using a nested `SELECT` with `MIN(year)`.
- `customerorders/salesorders.sql`: exclude salespeople who appear in a subquery of Red company orders.
- `Employees/employeemanager.sql`: find managers with five or more direct reports.

### Why nested `SELECT` instead of join
When the query only needs to test membership or compare values against a computed set, a subquery is often simpler and clearer than a join.

## 5. Join patterns: `INNER JOIN` and `LEFT JOIN`

### Purpose
Combine data from multiple tables based on matching keys.

### Why `INNER JOIN`
`INNER JOIN` returns rows only when both tables match on the join condition.

### Common `INNER JOIN` queries
- `salesproducts/salesproductsjoin.sql` — connect product names to sales data.
- `customerorders/salesproduct.sql` — filter products by sales date range.
- `customerorders/salesorders.sql` — find orders for a specific company.
- `rateoftripcancellation/rateoftripcancellations.sql` — require both client and driver users to be valid.

### Why `LEFT JOIN`
`LEFT JOIN` preserves all rows from the left table, even if there is no match in the right table.

### Common `LEFT JOIN` queries
- `customerorders/customernotordering.sql` — return customers with no orders.
- `customerorders/customer2019orders.sql` — count each user’s 2019 orders, including users with zero orders.
- `Employees/employeebonus.sql` — include all employees and match bonus information if present.

### Why use `LEFT JOIN` instead of `INNER JOIN`
Use `LEFT JOIN` when the query must keep rows that have no match on the joined table, often to find missing or optional relationships.

## 6. Window and analytic functions

### Purpose
Compute row-wise calculations over ordered partitions while keeping individual rows.

### Common queries
- `rank-scores/rankscores.sql` — `DENSE_RANK()` assigns ranks based on score.
- `Numbers/leadwindowfunction.sql` — `LEAD()` compares consecutive rows.
- `person_queries/lastpersonbusturn.sql` — running cumulative weights.

### Why not `GROUP BY`
Window functions preserve one row per input row, while `GROUP BY` collapses rows. Use window functions when you need comparisons or ordering across rows without losing detail.

## 7. Duplicate detection and cleanup

### Purpose
Find repeated values or delete duplicate records.

### Common queries
- `duplicateemail/duplicateemail.sql` — identify duplicate emails using `GROUP BY` and `HAVING`.
- `duplicateemail/Deleteduplicateemails.sql` — delete records where a duplicate exists.

### Why `GROUP BY` and `HAVING`
`GROUP BY` groups rows by the suspected duplicate key, and `HAVING COUNT(*) > 1` identifies groups with more than one occurrence.

## 8. Why `AND` and `OR`

### Purpose
Combine filter conditions in the `WHERE` clause.

### Why `AND`
`AND` requires both conditions to be true. It narrows the result set.

Example:
- `movies/nonboringmovies.sql`: `id % 2 = 1 AND description != 'boring'`

### Why `OR`
`OR` allows either condition to be true. It broadens the result set.

Example use cases:
- choose rows matching one of several allowed statuses,
- include rows from multiple possible categories.

### Why combined logic matters
Using `AND` and `OR` correctly ensures the query returns exactly the intended rows and avoids accidental over-inclusion or exclusion.

## 9. Frequent reasons for query choices

### When to use a single query
If the problem only needs filtering, sorting, or projection from one table, a single `SELECT` is sufficient.

### When to use a nested query
If the answer depends on a computed set, a max/min value, or the existence of related values, a nested `SELECT` is often the cleanest solution.

### When to use a join
If the result requires columns from two or more tables or if rows must be matched by relationship keys.

### When to use `CASE`
If the output should change based on conditions, or if a conditional expression is needed inside an aggregate.

### When to use `GROUP BY`
If the question asks for summary metrics per category, such as counts, sums, averages, or rates.
