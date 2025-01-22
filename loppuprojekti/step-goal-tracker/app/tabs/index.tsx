import React, { useState } from "react";
import { StyleSheet, View, Text, TextInput, Button, FlatList, TouchableOpacity } from "react-native";

export default function App() {
  // Tila askeltavoitteille (1000–30000 välillä)
  const [steps, setSteps] = useState("");
  const [goals, setGoals] = useState(
    Array.from({ length: 30 }, (_, i) => ({
      stepGoal: (i + 1) * 1000, // 1000 -> 30000
      completed: false, // Suoritettu tila
    }))
  );

  // Lisää tai päivitä suoritettu askeltavoite
  const handleAddStep = () => {
    const stepValue = parseInt(steps);
    if (stepValue >= 1000 && stepValue <= 30000 && stepValue % 1000 === 0) {
      setGoals((prevGoals) =>
        prevGoals.map((goal) =>
          goal.stepGoal === stepValue ? { ...goal, completed: true } : goal
        )
      );
      setSteps(""); // Tyhjennä syötekenttä
    } else {
      alert("Syötä validi askelmäärä (1000–30000 väliltä ja 1000:n välein).");
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Askeltavoiteseuranta</Text>
      
      {/* Syötekenttä */}
      <TextInput
        style={styles.input}
        placeholder="Syötä askelmäärä (esim. 1000)"
        keyboardType="numeric"
        value={steps}
        onChangeText={(text) => setSteps(text)}
      />
      
      {/* Lisää-painike */}
      <Button title="Merkitse suoritetuksi" onPress={handleAddStep} />

      {/* Askeltavoitelistaus */}
      <FlatList
        data={goals}
        keyExtractor={(item) => item.stepGoal.toString()}
        renderItem={({ item }) => (
          <TouchableOpacity>
            <View
              style={[
                styles.goalItem,
                item.completed && styles.completedGoal, // Väri muuttuu suoritettuna
              ]}
            >
              <Text style={styles.goalText}>
                {item.stepGoal} askelta {item.completed ? "(Suoritettu)" : ""}
              </Text>
            </View>
          </TouchableOpacity>
        )}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: "#f5f5f5",
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
    marginBottom: 20,
    textAlign: "center",
  },
  input: {
    borderWidth: 1,
    borderColor: "#ccc",
    borderRadius: 5,
    padding: 10,
    marginBottom: 10,
    fontSize: 16,
  },
  goalItem: {
    padding: 15,
    marginVertical: 5,
    borderWidth: 1,
    borderColor: "#ddd",
    borderRadius: 5,
    backgroundColor: "#fff",
  },
  completedGoal: {
    backgroundColor: "#c8e6c9", // Vihreä tausta suoritettuna
  },
  goalText: {
    fontSize: 18,
  },
});
