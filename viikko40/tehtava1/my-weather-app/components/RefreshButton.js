import React from 'react';
import { StyleSheet, Button, View } from 'react-native';

const RefreshButton = ({ onPress }) => {
  return (
    <View style={styles.buttonContainer}>
      <Button title="Päivitä" onPress={onPress} />
    </View>
  );
};

const styles = StyleSheet.create({
  buttonContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    marginVertical: 20,
  },
});

export default RefreshButton;
