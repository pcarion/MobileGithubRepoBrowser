/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

import React from 'react';
import { SafeAreaView, StyleSheet, Text } from 'react-native';

import { NativeRouter, Switch, Route } from 'react-router-native';
import { githubRepoUser } from '../app.json';

import mkState from './state';

import Home from './pages/Home';
import IssuesList from './pages/IssuesList';
import RepoDetail from './pages/RepoDetail';
import IssueDetail from './pages/IssueDetail';

// the shared state between components
// we could have used a react context for that, but may be over kill
// as we have very few components
const appState = mkState(githubRepoUser);

// Fake About page
const About = () => <Text style={styles.header}>About</Text>;

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});


const App = () => (
  <SafeAreaView style={styles.container}>
    <NativeRouter>
      <Switch>
        <Route exact path="/" render={props => <Home {...props} appState={appState} />} />
        <Route path="/repoDetail/:repoId" render={props => <RepoDetail {...props} appState={appState} />} />
        <Route path="/issues/:repoName" render={props => <IssuesList {...props} appState={appState} />} />
        <Route path="/issue/:repoName/:issueId" render={props => <IssueDetail {...props} appState={appState} />} />
        <Route path="/about" render={props => <About {...props} appState={appState} />} />
        <Route render={props => <Home {...props} appState={appState} />} />
      </Switch>
    </NativeRouter>
  </SafeAreaView>
);

export default App;
