<!-- omit in toc -->

# GitHub Repository Updater

<!-- omit in toc -->
- [GitHub Repository Updater](#github-repository-updater)
  - [Summary](#summary)
  - [Setup](#setup)
  - [Run it!](#run-it)

## Summary

I got really tired of manually updating default settings on each repository
I had to manage. GitHub, specifically, allows you to set default settings
at the organization level for new repositories but it is not possible to
apply those to previously created repositories automatically.

The purpose of this script is to set a default set of labels
to an specified repository.

> Made with Ruby :gem: for learning purposes.

## Setup

- Create a GitHub [access token](https://github.com/settings/tokens).
- Create the dotenv (`.env`) file using the example `.env.example`
  file and update it accordingly.
  - If you don't want existing labels to be deleted, set
    `DELETE_EXISTING_LABELS` to `false`.
- Change your settings in the `config.yml` file.
- Install the script dependencies using `bundle`:

  ```shell
  bundle install
  ```

  > :warning: All gems will be installed in the `vendor/` directory
  > in the root workspace of this repository. To change this behavior
  > change the value of `BUNDLE_PATH` in `.bundle/config`.

## Run it!

Run the script on your terminal:

```shell
./run.rb

# Or
ruby run.rb
```
