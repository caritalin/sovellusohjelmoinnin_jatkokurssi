import React, { useState } from 'react';
import { Button, Text, View } from 'react-native';
import { Accelerometer } from 'expo-sensors';

export default function Index() {
  const [data, setData] = useState({ x: 0, y: 0, z: 0 });
  const [isActive, setIsActive] = useState(false);

  const toggleSensor = () => {
    if (isActive) {
      Accelerometer.removeAllListeners();
    } else {
      Accelerometer.addListener(accelerometerData => {
        setData(accelerometerData);
      });
    }
    setIsActive(!isActive);
  };

  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Text>Tehtava1 - React Native ja Expo Web</Text>
      <Text>Kiihtyvyysanturi</Text>
      <Text>X: {data.x.toFixed(2)}</Text>
      <Text>Y: {data.y.toFixed(2)}</Text>
      <Text>Z: {data.z.toFixed(2)}</Text>
      
      <Button title={isActive ? "Lopeta lukeminen" : "Aloita lukeminen"} onPress={toggleSensor} />
    </View>
  );
}
