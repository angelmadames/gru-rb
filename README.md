# GitHub Labels Updater

## Summary

I got really tired of manually updating labels on each repository
I had to manage as a DevOps Engineer. GitHub, specifically, allows
you to set a default set of labels at the organization label but
it is not possible to apply those to old repositories.

The purpose of this script is to set a default set of labels
to a given repository automatically. I was learning Ruby at the time
of writing this script thus why it is written in Ruby.

## Setup

- Create the dotenv (`.env`) file using the example `.env.example`
  file and update it accordingly.
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
./main.rb

# Or
ruby main.rb
```
