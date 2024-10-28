# Hexo Deploy Action

This [GitHub action](https://github.com/features/actions) will handle the building and deploying process of hexo project.

## Getting Started

You can view an example of this below.

```yml
name: Build and Deploy

on:
  push:
    branches: [ "main" ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@master

    - name: Build and Deploy
      uses: ericpuwang/hexo-deploy-action@main
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        BRANCH: gh_pages
        PUBLISH_DIR: ./public
```

## Configuration

Below you'll find a description of what each option does.

| Key  | Value Information | Type | Required |
| ------------- | ------------- | ------------- | ------------- |
| `GITHUB_TOKEN` | [configuring permission](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#configuring-the-default-github_token-permissions). default `${{ secrets.GITHUB_TOKEN }}` | `secret` | **Yes** |
| `BRANCH`  | The branch the action should deploy to. default `gh_pages` | `env` | **No** |
| `PUBLISH_DIR`  | The folder the action should deploy. default `./public`| `env` | **No** |