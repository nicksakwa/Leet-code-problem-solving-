# SQL Solutions Documentation

This `docs/` folder explains the SQL solutions in this repository and groups the most important patterns used across the files.

## What is included

- `docs/system-architecture-and-design.md` — high-level architecture, design patterns, and algorithmic concepts used in the SQL solutions.
- `docs/technical-reference-manual.md` — a grouped reference for the most common SQL clauses and why they were used in this repository.

## How the SQL solutions are grouped

The SQL files are organized into the following natural categories:

- `customerorders/` — customer, order, and sales analysis using JOINs, aggregation, and filtering.
- `salesproducts/` — product analytics, first-year sales, and joins between sales and product metadata.
- `Employees/` — employee ranking, salary queries, manager relationships, and conditional updates.
- `countries/` / `rateoftripcancellation/` / `qualitypercentage/` — business reporting queries that use `GROUP BY`, `CASE`, and conditional aggregates.
- `game-play-analysis/` / `stadium/` / `person_queries/` — analytic queries with window functions, derived tables, and event-based date logic.
- `treenode-problems/` / `triangle-problem/` / `exchangeseatproblem/` — classification and conditional output queries using `CASE`.
- `duplicateemail/` — duplicate detection and deletion using grouping and self-joins.
- `movies/` — simple filter and sort examples.

## How to use these docs

1. Open `docs/README.md` for the overview and category map.
2. Review `docs/system-architecture-and-design.md` for architecture and algorithmic concepts.
3. Open `docs/technical-reference-manual.md` for clause-level reasoning and grouped query explanations.
