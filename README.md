# GitHub Labels Updater

## Summary

I got really tired of manually updating labels on each repository
I had to manage. GitHub, specifically, allows you to set a default
set of labels at the organization level for new repositories but it
is not possible to apply those to previously created repositories
automatically.

The purpose of this script is to set a default set of labels
to a specified repository.

> I made this in Ruby for learning purposes.

## Setup

- Create the dotenv (`.env`) file using the example `.env.example`
  file and update it accordingly.
  - If you don't want existing labels to be deleted, set
    `DELETE_EXISTING_LABELS` to `false`.
- Install the script dependencies using `bundle`:

  ```shell
  bundle install
  ```

  If you don't want to install these `gems` globally, create a `.bundle`
  folder and add a `config` file with the following content:

  ```yaml
  ---
  BUNDLE_PATH: "vendor/bundle"
  ```

  And run `bundle install` again.

## Run it!

Run the script on your terminal:

```shell
./run.rb

# Or
ruby run.rb
```
