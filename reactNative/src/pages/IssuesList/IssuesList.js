import React from 'react';
import {
  StyleSheet,
  View,
  ActivityIndicator,
  FlatList,
  Text,
  TouchableOpacity
} from 'react-native';
import PropTypes from 'prop-types';

import {
  withRouter
} from 'react-router-native';

import NavigationBar, { NAV_BAR_HEIGHT } from '../../components/NavigationBar';


class IssuesList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      loading: false,
      issues: [],
    };
  }

  async componentDidMount() {
    const { match, appState } = this.props;
    const { repoName } = match.params;


    this.setState({
      loading: true,
    });
    try {
      const issues = await appState.getListOfIssues(repoName);
      this.setState({
        loading: false,
        issues: [...issues],
      });
    } catch (err) {
      console.log(err);
    }
  }

  FlatListItemSeparator = () => {
    return (
      <View style={{
        height: 0.5,
        width: '100%',
        backgroundColor: 'rgba(0,0,0,0.5)',
      }}
      />
    );
  }

  onBackPress = () => {
    const { history } = this.props;
    history.goBack();
  }

  navigateToIssue = (item) => {
    const { history, match } = this.props;
    const { repoName } = match.params;

    history.push(`/issue/${repoName}/${item.id}`);
  }

  renderItem = (data) => {
    return (
      <TouchableOpacity style={styles.list} onPress={() => this.navigateToIssue(data.item)}>
        <View style={styles.line1}>
          <Text style={styles.textLine1}>[{data.item.state}] {data.item.title}</Text>
        </View>
        <View style={styles.line2}>
          <Text style={styles.textLine2}># {data.item.number} opened by {data.item.user.login}</Text>
        </View>
      </TouchableOpacity>
    );
  }

  render() {
    const { loading, issues } = this.state;

    if (loading) {
      return (
        <View style={styles.loader}>
          <ActivityIndicator size="large" color="#0c9" />
        </View>
      );
    }

    return (
      <View style={styles.container}>
        <NavigationBar
          title="Issues list"
          onLeftIconPress={this.onBackPress}
        />

        <FlatList
          style={styles.scrollView}
          data={issues}
          ItemSeparatorComponent={this.FlatListItemSeparator}
          renderItem={item => this.renderItem(item)}
          keyExtractor={item => item.id.toString()}
        />
      </View>
    );
  }
}

IssuesList.propTypes = {
  appState: PropTypes.object.isRequired,
};

export default withRouter(IssuesList);

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  scrollView: {
    marginTop: 2 * NAV_BAR_HEIGHT,
    flex: 1,
    width: '100%',
  },
  line1: {
    flexDirection: 'row',
    justifyContent: 'flex-start',
    margin: 8,
  },
  line2: {
    flexDirection: 'row',
    justifyContent: 'flex-start',
    margin: 8,
  },
  loader: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff',
  },
  list: {
    margin: 4,
    justifyContent: 'center',
    borderRadius: 2,
  },
  textLine1: {
    fontFamily: 'Verdana',
    fontSize: 16,
    paddingLeft: 5,
  },
  textLine2: {
    fontFamily: 'Verdana',
    fontSize: 12,
    paddingLeft: 5,
  },
});
