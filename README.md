# Hoover

Hoover is the product manager. He can create/update/delete products after you upload a CSV file with products.

## Setup and run

To run this project, you need to have [Elixir](https://elixir-lang.org) installed.

run in the shell:

```sh
mix deps.get
mix phx.server
```

Be sure to have PostgreSQL running as `config/dev.exs` congfigured.

## What is implemented?

* [x] importing products from a CSV file
* [x] basic UI feedback
    * [x] successful imported
    * [x] none imported from CSV file
    * [x] invalid CSV format
* [x] tests
    * [x] unit tests
    * [x] controller tests

## What is not implemented? (Further developing ideas)

* [ ] cleanup the unused APIs and tests created on Phoenix initialization.
* [ ] Transactions. What if some insertions fail during the execution?
* [ ] CSV validating. There are duplicated `part_number` rows in `test/fixtures/data.csv`. In most cases this would be a manual mistake. Should we reject it?
* [ ] Allow user to delete products not presented in the CSV, as the task mentioned. Maybe I can implement it as following:
  * import products as present
  * select all unique `part_number` in the CSV
  * delete all products not in part_numbers above
* [ ] UI tests
* [ ] `credo` for linting
* [ ] CI config (maybe overkill for this project but can't live without it. I used git hooks locally.)
