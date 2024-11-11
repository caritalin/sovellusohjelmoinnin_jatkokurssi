import React, { useState } from 'react';
import { Button, Text, View, Alert } from 'react-native';
import * as Location from 'expo-location';

export default function Index() {
  const [location, setLocation] = useState<{ latitude: number; longitude: number } | null>(null);

  const getLocation = async () => {
    // Pyydä käyttäjältä lupaa sijainnin käyttämiseen
    const { status } = await Location.requestForegroundPermissionsAsync();
    
    if (status !== 'granted') {
      // Näytä ilmoitus, jos lupa evätään
      Alert.alert(
        "Sijaintilupa evätty",
        "Sovellus tarvitsee sijaintiluvan toimiakseen oikein. Voit antaa luvan sovelluksen asetuksista."
      );
      return;
    }

    // Hae käyttäjän sijainti, jos lupa on saatu
    const currentLocation = await Location.getCurrentPositionAsync({});
    setLocation({
      latitude: currentLocation.coords.latitude,
      longitude: currentLocation.coords.longitude,
    });
  };

  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Text>Paikkatiedon hakeminen</Text>
      {location ? (
        <View>
          <Text>Leveysaste: {location.latitude}</Text>
          <Text>Pituusaste: {location.longitude}</Text>
        </View>
      ) : (
        <Text>Paina nappia hakeaksesi sijainnin</Text>
      )}
      <Button title="Hae sijainti" onPress={getLocation} />
    </View>
  );
}
