<!-- omit in toc -->
# gru ― GitHub Repository Updater Tool

[![tests](https://github.com/angelmadames/github-repo-updater/actions/workflows/rubocop.yml/badge.svg)](https://github.com/angelmadames/github-repo-updater/actions/workflows/rubocop.yml)

<!-- omit in toc -->
- [📒 Summary](#-summary)
- [⚙️ Setup](#️-setup)
- [🚀 Run it](#-run-it)
  - [ℹ️ Help](#ℹ️-help)
  - [➡️ Update labels](#️-update-labels)
  - [➡️ Update repo settings](#️-update-repo-settings)
  - [➡️ Remove old tags](#️-remove-old-tags)

## 📒 Summary

I got tired of manually updating default settings, adding labels, and rotating
old tags on each repository. GitHub, specifically, allows you to set default
settings  at the organization level for new repositories but it is not possible
to  apply those to previously created repositories automatically.

The purpose of this script is to set a default set of labels
to an specified repository.

> Made with Ruby :gem: for learning purposes.

## ⚙️ Setup

- Create a GitHub [access token](https://github.com/settings/tokens).
- Create the dotenv (`.env`) file using the example `.env.example`
  file and update it accordingly.
- Change your settings in the `config.yml` file.
- Install the script dependencies using `bundle`:

  ```shell
  bundle install
  ```

## 🚀 Run it

Run the script on your terminal:

### ℹ️ Help

```shell
./gru.rb help         # Show all available commands
./gru.rb help labels  # Show help for a command
```

### ➡️ Update labels

```shell
./gru.rb labels add
./gru.rb labels remove
```

### ➡️ Update repo settings

```shell
./gru.rb repo update
./gru.rb repo update-all
```

### ➡️ Remove old tags

```shell
./gru.rb tags list
./gru.rb tags remove-stale
```
