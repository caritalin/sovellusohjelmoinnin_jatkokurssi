import React from 'react';
import { StyleSheet, Text, View, Image } from 'react-native';

const WeatherInfo = ({ temp, wind, weather }) => {
  return (
    <View style={styles.weatherInfo}>
      <Text style={styles.weather}>{weather}</Text>
      <Image
        style={styles.weatherIcon}
        source={require('../assets/sunny.png')} // Vaihda kuvake oman säätilan mukaiseksi
      />
      <Text style={styles.temp}>{temp}</Text>
      <Text style={styles.wind}>Tuulen nopeus: {wind}</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  weatherInfo: {
    flex: 3,
    justifyContent: 'center',
    alignItems: 'center',
  },
  weather: {
    fontSize: 20,
  },
  weatherIcon: {
    width: 100,
    height: 100,
    marginVertical: 10,
  },
  temp: {
    fontSize: 32,
    fontWeight: 'bold',
  },
  wind: {
    fontSize: 16,
  },
});

export default WeatherInfo;
