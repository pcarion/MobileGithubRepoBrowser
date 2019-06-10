# GithubRepoBrowserRN
sample app to browse a Github repo, in react Native

| iOS        | Android |
| ------------- |-------- |
| ![Browser App on iOS](https://raw.githubusercontent.com/pcarion/GithubRepoBrowserRN/master/docs/ios-demo.gif) | ![Browser App on Android](https://raw.githubusercontent.com/pcarion/GithubRepoBrowserRN/master/docs/android-demo.gif) |

## Inital steps to build a RN application

### Create app

Create app with:

```
react-native init GithubRepoBrowserRN
```

### Add eslint
You can't _really_ work in Javascript without `eslint` so...:

```
yarn add --dev eslint babel-eslint eslint-config-airbnb eslint-plugin-jsx-a11y eslint-plugin-react eslint-plugin-import
```

add `.eslintrc.json` with rules suitable for the project.


### Add router

```
yarn add react-router-native
```

and then define routes is `App.js`

### Main classes / files

* `src/index.js` : entry point of the app - shared between iOS and Android as the design is the same. We instantiate `App` which is in:

* `src/App.js`: actual entry point of the app. No visual component there, but the definition of the routes of the application with `react-router-native`. We have 4 routes (pages) in the app:

| Route Path | Page Name | file | quick description |
| ---------- | --------- | ---- | ----------------- |
| `/` | Home | `src/pages/Home/Home.js` | The list of all the repos associated to a user (property `githubRepoUser` in `app.json`) |
| `/repoDetail/:repoId` | RepoDetail | `src/pages/RepoDetail/RepoDetail.js` | Information about a given repository |
| `/issues/:repoName` | IssuesList | `src/pages/IssuesList/IssuesList.js` | List of issues associated to a given repository |
| `/issue/:repoName/:issueId` | IssueDetail | `src/pages/IssueDetail/IssueDetail.js` | Detail information about an issue |

* `src/state/index.js`: model/state for the app. This module is in charge of doing the Github API calls. In a _real_ RN app, we would use a more sophisticated state management like [redux](https://redux.js.org/) or [Mobx](https://mobx.js.org/).
* `src/components/NavigationBar/NavigationBar.js`: the only reusable components for that app: that's the header of the pages to allow the back navigation.


