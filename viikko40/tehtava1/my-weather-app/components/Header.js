import React from 'react';
import { StyleSheet, Text, View } from 'react-native';

const Header = ({ city }) => {
  return (
    <View style={styles.header}>
      <Text style={styles.city}>{city}</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  header: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f8f9fa',
  },
  city: {
    fontSize: 24,
    fontWeight: 'bold',
  },
});

export default Header;
