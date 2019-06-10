import React from 'react';
import PropTypes from 'prop-types';

import {
  View,
  Text,
  Image,
  TouchableHighlight,
  StyleSheet,
} from 'react-native';

export const NAV_BAR_HEIGHT = 44;

const COLORS = {
  highlight: 'rgba(0, 0, 0, 0.1)',
};

const styles = StyleSheet.create({
  navbar: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    height: NAV_BAR_HEIGHT,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    alignSelf: 'stretch',
    marginBottom: 20,
    marginTop: 20,
    backgroundColor: '#cdcdcd',
  },
  title: {
    flex: 2,
    color: 'white',
    textAlign: 'center',
    fontSize: 28,
    letterSpacing: 0,
    fontFamily: 'AvenirNextCondensed-DemiBold',
  },
  iconRight: {
    height: NAV_BAR_HEIGHT * 0.6,
    width: NAV_BAR_HEIGHT * 0.6,
    resizeMode: 'contain',
    marginRight: 10,
  },
  iconLeft: {
    height: NAV_BAR_HEIGHT * 0.6,
    width: NAV_BAR_HEIGHT * 0.6,
    resizeMode: 'contain',
    marginLeft: 10,
  },
});

const backIcon = require('../../assets/chevron-left.png');

const renderIcon = (icon, onIconPress, iconStyle) => {
  const touchableProps = {
    onPress: onIconPress,
  };

  if (onIconPress) {
    return (
      <TouchableHighlight underlayColor={COLORS.highlight} {...touchableProps}>
        <Image
          style={iconStyle}
          source={icon}
        />
      </TouchableHighlight>
    );
  }

  return (
    <Image
      style={iconStyle}
      source={{ uri: 'navbar-button-transparent' }}
    />
  );
};

const NavigationBar = ({
  title,
  onLeftIconPress
}) => (
  <View style={styles.navbar}>
    { renderIcon(backIcon, onLeftIconPress, styles.iconLeft) }
    <Text style={styles.title}>{title}</Text>
  </View>
);

NavigationBar.propTypes = {
  title: PropTypes.string.isRequired,
  onLeftIconPress: PropTypes.func.isRequired,
};

export default NavigationBar;
