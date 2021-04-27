# OrlovM/Wiki-Action
Manage your wiki files in your repository. This action will push changes to the wiki repository.


---
### Features

- Automaticly pushes changes from specified directiory to the wiki.
- Uses author from repository's git commit.
- Uses the commit message from repository's git commit. 
- It's easy to pull request/merge wiki files. 

---
### Usage


```yaml
name: Update Wiki

on:
  push:
    paths:
      - 'wiki/**'
    branches:
      - master
jobs:
  update-wiki:
    runs-on: ubuntu-latest
    name: Update wiki
    steps:
    - uses: actions/checkout@v2
    - uses: OrlovM/Wiki-Action@v0.1.16
      with:
        path: 'wiki'
        token: ${{ secrets.GITHUB_TOKEN }}
```
---
The possible inputs are:

- `path`: (string, required): The directory where your files are located. 
- `token`: (string, required): GitHub access token. In common case it will be appropriate to use GitHub provided action token "${{ secrets.GITHUB_TOKEN }}". More info: https://docs.github.com/en/actions/reference/authentication-in-a-workflow

