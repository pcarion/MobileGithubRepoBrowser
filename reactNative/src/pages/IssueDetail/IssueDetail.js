import React, { Component } from 'react';
import PropTypes from 'prop-types';

import { StyleSheet, Text, View, ScrollView } from 'react-native';

import Markdown from 'react-native-markdown-renderer';

import NavigationBar, { NAV_BAR_HEIGHT } from '../../components/NavigationBar';

class IssueDetail extends Component {
  onBackPress = () => {
    const { history } = this.props;
    history.goBack();
  }

  render() {
    const { match, appState } = this.props;
    const { issueId } = match.params;

    const issue = appState.getIssueById(issueId);

    console.log('issue>', issue);

    return (
      <View style={styles.container}>
        <NavigationBar
          title={`issue # ${issue.number}`}
          onLeftIconPress={this.onBackPress}
        />
        <ScrollView style={styles.scrollView} contentContainerStyle={styles.contentContainer}>
          <View style={styles.infoBlock}>
            <Text style={styles.infoName}>
              {issue.title}
            </Text>
          </View>
          <View style={styles.description}>
            <Markdown>{issue.body}</Markdown>
          </View>
        </ScrollView>
      </View>
    );
  }
}

IssueDetail.propTypes = {
  appState: PropTypes.object.isRequired,
};

export default IssueDetail;

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
    justifyContent: 'flex-start',
    marginLeft: 32,
    marginRight: 32,
    marginBottom: 8,
  },
  infoName: {
    fontSize: 20,
    textAlign: 'left',
  },
  infoValue: {
    fontSize: 20,
    textAlign: 'left',
  },
  description: {
    margin: 16,
  },
});
