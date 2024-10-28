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
        BRANCH: gh_pages
        PUBLISH_DIR: ./public
```

## Configuration

Below you'll find a description of what each option does.

| Key  | Value Information | Type | Required |
| ------------- | ------------- | ------------- | ------------- |
| `BRANCH`  | The branch the action should deploy to. default `gh_pages` | `env` | **No** |
| `PUBLISH_DIR`  | The folder the action should deploy. default `./public`| `env` | **No** |