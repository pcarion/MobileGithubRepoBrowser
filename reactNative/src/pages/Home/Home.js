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

class Home extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      loading: false,
      repositories: [],
    };
  }

  async componentDidMount() {
    const { appState } = this.props;

    this.setState({
      loading: true,
    });
    try {
      const repos = await appState.getListOfRepos();
      this.setState({
        loading: false,
        repositories: [...repos],
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

  navigateToRepo = (item) => {
    const { history } = this.props;
    history.push(`/repoDetail/${item.id}`);
  }

  renderItem = (data) => {
    return (
      <TouchableOpacity style={styles.list} onPress={() => this.navigateToRepo(data.item)}>
        <Text style={styles.repoName}>{data.item.name}</Text>
        <Text style={styles.repoDescription}>{data.item.description}</Text>
      </TouchableOpacity>
    );
  }

  render() {
    const { loading, repositories } = this.state;

    if (loading) {
      return (
        <View style={styles.loader}>
          <ActivityIndicator size="large" color="#0c9" />
        </View>
      );
    }

    return (
      <View style={styles.container}>
        <Text style={styles.h2text}>
          List of Repos
        </Text>
        <FlatList
          data={repositories}
          ItemSeparatorComponent={this.FlatListItemSeparator}
          renderItem={item => this.renderItem(item)}
          keyExtractor={item => item.id.toString()}
        />
      </View>
    );
  }
}

Home.propTypes = {
  appState: PropTypes.object.isRequired,
};

export default withRouter(Home);

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  h2text: {
    marginTop: 10,
    fontFamily: 'Helvetica',
    fontSize: 24,
    fontWeight: 'bold',
  },
  loader: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff',
  },
  list: {
    margin: 16,
    justifyContent: 'center',
    borderRadius: 2,
  },
  repoName: {
    fontFamily: 'Verdana',
    fontSize: 16,
    paddingBottom: 8,
  },
  repoDescription: {
    fontFamily: 'Verdana',
    fontSize: 12,
  },
});
