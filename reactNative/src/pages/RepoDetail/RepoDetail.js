import React, { Component } from 'react';
import PropTypes from 'prop-types';

import { StyleSheet, Text, View, ScrollView, Button } from 'react-native';

import NavigationBar, { NAV_BAR_HEIGHT } from '../../components/NavigationBar';

class RepoDetail extends Component {
  onBackPress = () => {
    const { history } = this.props;
    history.goBack();
  }

  navigateToIssues = (repoName) => {
    const { history } = this.props;
    history.push(`/issues/${repoName}`);
  }

  render() {
    const { match, appState } = this.props;
    const { repoId } = match.params;

    const repo = appState.getRepoById(repoId);

    console.log('repo>', repo);

    return (
      <View style={styles.container}>
        <NavigationBar
          title={repo.name}
          onLeftIconPress={this.onBackPress}
        />
        <ScrollView style={styles.scrollView} contentContainerStyle={styles.contentContainer}>
          <View style={styles.infoBlock}>
            <Text style={styles.infoName}>
              Repository name:
            </Text>
            <Text style={styles.infoValue}>
              {repo.name}
            </Text>
          </View>
          <View style={styles.infoBlock}>
            <Text style={styles.infoName}>
              Owner:
            </Text>
            <Text style={styles.infoValue}>
              {repo.owner.login}
            </Text>
          </View>
          <View style={styles.infoBlock}>
            <Text style={styles.infoName}>
              Language:
            </Text>
            <Text style={styles.infoValue}>
              {repo.language}
            </Text>
          </View>
          <View style={styles.infoBlock}>
            <Text style={styles.infoName}>
              Stars:
            </Text>
            <Text style={styles.infoValue}>
              {repo.stargazers_count}
            </Text>
          </View>
          <View style={styles.infoBlock}>
            <Text style={styles.infoName}>
              Forks:
            </Text>
            <Text style={styles.infoValue}>
              {repo.forks_count}
            </Text>
          </View>
          <View style={styles.infoBlock}>
            <Text style={styles.infoName}>
              Opened issues:
            </Text>
            <Text style={styles.infoValue}>
              {repo.open_issues_count}
            </Text>
          </View>
          <Text style={styles.description}>
            {repo.description}
          </Text>
          <Button
            onPress={() => this.navigateToIssues(repo.name)}
            title="See Issues"
            color="#841584"
          />
        </ScrollView>
      </View>
    );
  }
}

RepoDetail.propTypes = {
  appState: PropTypes.object.isRequired,
};

export default RepoDetail;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  scrollView: {
    marginTop: NAV_BAR_HEIGHT,
    flex: 1,
    width: '100%',
  },
  contentContainer: {
    marginTop: NAV_BAR_HEIGHT,
    flex: 1,
    flexDirection: 'column',
    paddingVertical: 16,
    alignItems: 'stretch',
    justifyContent: 'flex-start',
  },
  infoBlock: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginLeft: 32,
    marginRight: 32,
    marginBottom: 8,
  },
  infoName: {
    fontSize: 20,
    textAlign: 'left',
    fontWeight: 'bold',
  },
  infoValue: {
    fontSize: 20,
    textAlign: 'left',
  },
  description: {
    margin: 16,
  },
});
