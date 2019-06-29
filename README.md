## SQL Analyzer

Transaction & JOIN Analyzer for ActiveRecord and MySQL

## What's this

- Analyze SQLs executed in a single transaction
  - Detect write SQLs which are executed in a single transaction
  - Detect SQLs which joins some tables between logically separated DBs
- Do nothing to the real process, just analyze process

## What you can do

### Transaction mode

Analyze transaction started and commited via ActiveRecord public API, and detect tables which to write queries are executed under its transaction.

To set up, just run below on Rails app initialize phase.

```ruby
SqlAnalyzer.init!(mode: :transaction)
```

### Join mode

Analyze queries using JOIN phrase executed via ActiveRecord public API, and detect tables which are JOINed in such query.

To set up, just run below on Rails app initialize phase.

```ruby
SqlAnalyzer.init!(mode: :join)
```
