# /format
format the sql query provided using this format below:

# SQL Formatting Rules

## General Structure
- Use lowercase for all SQL keywords (`select`, `from`, `where`, `join`, etc.)
- Use consistent 2-space indentation for nested structures
- Place each major clause on its own line

## SELECT Statement Formatting

### Column List
- First column starts immediately after `select` or `select distinct`
- Subsequent columns:
  - Comma at the beginning of the line
  - Column name starts exactly 7 characters after the comma
  - Align all column names vertically

Example:
```sql
select distinct
       column1
,      column2
,      column3
```

### Column Aliases
- Use `as` for all aliases
- Align aliases vertically at the end of expressions
- For long expressions, place `as alias_name` at the end with appropriate spacing

Example:
```sql
select distinct
       venue_uuid                                    as venue_uuid
,      organization_uuid                             as uuid
,      first_value(asset_id) over w_asset_last       as asset_id
```

## FROM and JOIN Clauses
- `from` starts at the beginning of the line
- Table name follows with 3 spaces after `from`
- For joins:
  - Join type indented with appropriate spacing
  - `on` conditions aligned under the join
  - Multiple join conditions connected with `and` at the start of new lines

Example:
```sql
from   base b
       join ( select venue_uuid
              ,      cabinet_serial_number
              from   another_table
            ) p
            on p.venue_uuid            = b.venue_uuid
          and p.cabinet_serial_number  = b.cabinet_serial_number
```

## WHERE Clause
- `where` at the beginning of the line
- First condition on the same line after 2 spaces
- Additional conditions:
  - `and`/`or` at the start of the line with 2 spaces
  - Condition follows after 2 more spaces
  - Align comparison operators vertically when possible

Example:
```sql
where  organization_uuid    in ('9ce76aab-7ce0-4012-8ebd-ee6ad6dd7462')
  and  current_asset_status  = 'Active'
  and  nbr_of_months_ago < 3
```

## Window Functions
- Define window aliases at the end of the query
- Format window definition:
  - `window` keyword at start of line
  - Window name and `as` followed by opening parenthesis
  - `partition by` and `order by` on separate lines with proper indentation
  - Closing parenthesis aligned with `window`

Example:
```sql
window w_asset_last as ( partition by venue_uuid
                                   ,  asset_id
                             order by reporting_month_yyyymm desc
                       )
```

## CTEs (Common Table Expressions)
- `with` at the beginning
- CTE name followed by `as (`
- Opening parenthesis on the same line
- CTE body indented
- Closing parenthesis at the beginning of the line
- Comma before next CTE (if any)

Example:
```sql
with base as (
select distinct
       column1
,      column2
from   table_name
),
trending as (
  select b.*
  ,      additional_column
  from   base b
)
```

## CASE Statements
- `case` at appropriate indentation level
- `when` conditions indented 2 spaces from `case`
- `then` on the same line as `when`
- `else` at the same indentation as `when`
- `end` at the same indentation as `case`
- Alias after `end` when used in SELECT

Example:
```sql
,      case
         when best_new_installs <= 3
         then 1
         when worst_new_installs <= 3
         then 1
         end as ind_trending
```

## Additional Rules
- Use single quotes for string literals
- Escape single quotes in strings with `\'`
- Place `order by` at the end of queries
- Group related columns together
- Add comments for complex logic or CTEs
- Maintain consistent spacing for readability
- Align mathematical operators in complex calculations

## Subqueries
- Indent subquery content by 2 spaces from the opening parenthesis
- Format subqueries following the same rules as main queries
- Place closing parenthesis at the same indentation as the opening statement