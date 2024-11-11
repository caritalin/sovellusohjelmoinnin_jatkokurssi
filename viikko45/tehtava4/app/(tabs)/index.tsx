import React, { useState, useEffect } from 'react';
import { Button, Text, View, Alert } from 'react-native';
import * as Location from 'expo-location';

export default function Index() {
  const [location, setLocation] = useState<{ latitude: number; longitude: number } | null>(null);
  const [isTracking, setIsTracking] = useState(false);
  const [subscription, setSubscription] = useState<Location.LocationSubscription | null>(null);

  // Käynnistä tai pysäytä sijainnin seuranta painikkeella
  const toggleLocationTracking = async () => {
    if (isTracking) {
      // Lopeta seuranta
      subscription?.remove();
      setSubscription(null);
      setIsTracking(false);
    } else {
      // Pyydä lupaa sijainnin käyttämiseen
      const { status } = await Location.requestForegroundPermissionsAsync();
      if (status !== 'granted') {
        Alert.alert("Lupa evätty", "Sovellus tarvitsee sijaintiluvan toimiakseen oikein.");
        return;
      }

      // Aloita sijainnin seuranta
      const newSubscription = await Location.watchPositionAsync(
        {
          accuracy: Location.Accuracy.High,
          timeInterval: 1000, // Päivitä sijainti 1 sekunnin välein
          distanceInterval: 1, // Päivitä, kun käyttäjä liikkuu vähintään 1 metri
        },
        (newLocation) => {
          setLocation({
            latitude: newLocation.coords.latitude,
            longitude: newLocation.coords.longitude,
          });
        }
      );
      setSubscription(newSubscription);
      setIsTracking(true);
    }
  };

  // Pysäytä sijainnin seuranta komponentin poistuessa
  useEffect(() => {
    return () => {
      subscription?.remove();
    };
  }, [subscription]);

  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Text>Paikkatiedon seuraaminen</Text>
      {location ? (
        <View>
          <Text>Leveysaste: {location.latitude}</Text>
          <Text>Pituusaste: {location.longitude}</Text>
        </View>
      ) : (
        <Text>Ei paikkatietoa saatavilla</Text>
      )}
      <Button
        title={isTracking ? "Lopeta seuranta" : "Aloita seuranta"}
        onPress={toggleLocationTracking}
      />
    </View>
  );
}
