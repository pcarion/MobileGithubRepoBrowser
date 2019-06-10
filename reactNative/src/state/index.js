export default function mkState(githubRepoUser) {
  const state = {
    repos: [],
    issues: [],
  };

  return {
    async getListOfRepos() {
      return fetch(`https://api.github.com/users/${githubRepoUser}/repos`)
        .then(response => response.json())
        .then((responseJson) => {
          state.repos = [...responseJson];
          return responseJson;
        })
        .catch((error) => {
          console.log(error);
          throw error;
        });
    },
    async getListOfIssues(repoName) {
      return fetch(`https://api.github.com/repos/${githubRepoUser}/${repoName}/issues`)
        .then(response => response.json())
        .then((responseJson) => {
          console.log('@@@@ issues>', responseJson);
          state.issues = [...responseJson];
          return responseJson;
        })
        .catch((error) => {
          console.log(error);
          throw error;
        });
    },
    getRepoById(repoId) {
      // in the state, the ids are stored as numbers, but they are strings in the URL
      return state.repos.find(r => `${r.id}` === repoId);
    },
    getIssueById(issueId) {
      // in the state, the ids are stored as numbers, but they are strings in the URL
      return state.issues.find(r => `${r.id}` === issueId);
    },
  };
}

// https://api.github.com/repos/intuit/LocationManager/issues
