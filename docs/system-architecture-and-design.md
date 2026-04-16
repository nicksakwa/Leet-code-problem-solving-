# System Architecture and Design

This document describes the architecture of the SQL solution collection, the design patterns used, and the underlying data concepts.

## Repository architecture

The repository is organized by problem domain, not by database schema. Each folder contains one or more SQL files solving a single LeetCode-style problem.

Key folder types:

- `customerorders/` — relational order and customer analytics.
- `salesproducts/` — product sales analysis and join-based lookups.
- `Employees/` — employee salary and reporting queries.
- `countries/`, `rateoftripcancellation/`, `qualitypercentage/` — business reporting and aggregation.
- `game-play-analysis/`, `stadium/`, `person_queries/` — sequence analysis, window functions, and event data.
- `treenode-problems/`, `triangle-problem/`, `exchangeseatproblem/` — classification of records using conditional logic.
- `duplicateemail/` — data-cleaning and duplicate detection.

## Data model view

Although this repository does not define a single shared schema, the SQL patterns imply standard relational data structures:

- Tables represent collections of records.
- Columns are attributes used for filtering, grouping, sorting, and joining.
- Primary keys, foreign keys, and indexed fields are implied by join columns such as `customerId`, `product_id`, and `user_id`.

## Design patterns used in solutions

### 1. Filtering and projection

Many queries use a single `SELECT` with a `FROM` and `WHERE` to return rows that satisfy conditions.

Example patterns:

- `movies/nonboringmovies.sql`: filter odd IDs and remove boring descriptions.
- `rising-temperature/risingtemperature.sql`: compare adjacent days using a self-join and a date relationship.

This pattern is the simplest and is chosen when no aggregation or multi-table relationship is needed.

### 2. Aggregation with `GROUP BY`

Group-based aggregation is common across business-reporting problems.

Examples:

- `countries/transactioncountries.sql`
- `qualitypercentage/qualitypercentage.sql`
- `studentsclass/classpercourse.sql`
- `customerorders/customermostorders.sql`

These queries summarize groups of rows by one or more keys and compute counts, sums, averages, or rates.

### 3. Conditional aggregation with `CASE`

`CASE` is used when output values depend on row conditions or when aggregate values need conditional inclusion.

Examples:

- `countries/transactioncountries.sql`: count approved and rejected transactions separately.
- `rateoftripcancellation/rateoftripcancellations.sql`: compute cancellation rate only when the status is one of two values.
- `qualitypercentage/qualitypercentage.sql`: count ratings below a threshold.

### 4. Joins for relational lookups

`INNER JOIN` and `LEFT JOIN` appear when a query needs fields from multiple tables.

Examples:

- `salesproducts/salesproductsjoin.sql`: join `Sales` with `Product` to show names alongside prices.
- `customerorders/customer2019orders.sql`: left join users with orders to count orders per user in 2019.
- `customerorders/customernotordering.sql`: left join to find customers with no matching orders.
- `game-play-analysis/returninggamersanalysis.sql`: join activity rows to first-login derived values.

### 5. Subqueries and derived tables

Nested `SELECT` statements are used to compute intermediate results before the outer query filters or joins.

Examples:

- `insuranceinvestment/insuranceinvestment.sql`: find duplicate `tiv_2015` values and exclude duplicate locations.
- `customerorders/customerproducts.sql`: compare distinct purchased products to the full product list.
- `Employees/employeehighestsalaryperdepartmet.sql`: find highest salary per department using a subquery and tuple membership.
- `game-play-analysis/returninggamersanalysis.sql`: compute first login dates per user and then join back.

This design isolates complex logic, improves readability, and keeps each query step focused.

### 6. Window and analytic functions

A few queries use window functions to compute running totals, ranks, or row-based comparisons.

Examples:

- `rank-scores/rankscores.sql` — `DENSE_RANK()` for ranking scores.
- `Numbers/leadwindowfunction.sql` — `LEAD()` to compare consecutive rows.
- `person_queries/lastpersonbusturn.sql` — running total over ordered turns.

These patterns are used when the problem requires ordered analysis without collapsing rows.

## Algorithmic and complexity concepts

SQL query performance is best understood as data flow through relational operations.

### Table scans and filters

- A single-table `SELECT ... FROM ... WHERE ...` is conceptually a scan over rows.
- If indexed predicates exist, the database can narrow the scan.
- Complexity is typically proportional to the number of rows examined.

### Aggregation and grouping

- `GROUP BY` requires grouping rows by key and computing aggregates.
- The engine may use hashing or sorting internally.
- Cost is generally `O(N)` for the scan plus additional grouping overhead.

### Joins

- `INNER JOIN` combines rows only when a match exists on both sides.
- `LEFT JOIN` retains all rows from the left table and adds matching right-side values.
- Join cost depends on join strategy; common implementations include nested loops, hash joins, and merge joins.

### Subqueries

- A correlated or nested subquery may cause the engine to evaluate a subset of rows before the outer query runs.
- In these solutions, nested selects are often used for membership tests, aggregation results, or derived lookups.

### Window functions

- Window functions process rows in order and compute values across partitions.
- They are often more efficient than equivalent self-join or repeated aggregate patterns.

## Why this design works for LeetCode-style SQL

- Problems are solved with clarity first, using standard SQL building blocks.
- Each query uses the most direct relational operator for the task: filter, aggregate, join, or conditional expression.
- The solutions avoid unnecessary complexity while still demonstrating the key SQL concepts expected by LeetCode.
