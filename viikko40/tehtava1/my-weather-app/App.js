import React from 'react';
import { StyleSheet, View } from 'react-native';
import Header from './components/Header';
import WeatherInfo from './components/WeatherInfo';
import RefreshButton from './components/RefreshButton';

const App = () => {
  const city = "Helsinki"; // Voit vaihtaa kaupungin nimen
  const temp = "12°C"; // Voit vaihtaa lämpötilan
  const wind = "15 km/h"; // Voit vaihtaa tuulen nopeuden
  const weather = "Aurinkoista"; // Voit vaihtaa sään kuvauksen

  const handleRefresh = () => {
    // Lisää logiikka säätietojen päivittämiseen täällä
    console.log("Säätiedot päivitetään...");
  };

  return (
    <View style={styles.container}>
      <Header city={city} />
      <WeatherInfo temp={temp} wind={wind} weather={weather} />
      <RefreshButton onPress={handleRefresh} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
  },
});

export default App;
