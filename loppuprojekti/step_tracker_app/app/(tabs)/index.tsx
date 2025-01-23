import React, { useState } from "react";
import {
    StyleSheet,
    View,
    Text,
    TextInput,
    Button,
    FlatList,
    TouchableOpacity,
    Image,
    Alert,
    Dimensions,
} from "react-native";

// Hae näytön mitat
const { width, height } = Dimensions.get("window");

// Vakioarvot palkkien koon ja marginaalien laskemiseen
const ITEM_MARGIN = 10; // Palkkien välimatka

// Näytön kokoon perustuvat rajoitukset
const SMALL_SCREEN_THRESHOLD = 600; // Rajapyykki pienen ja suuren näytön välillä
const SMALL_SCREEN_ITEM_SIZE = 120; // Palkin koko pienellä näytöllä
const LARGE_SCREEN_ITEM_SIZE = 150; // Palkin koko suurella näytöllä

export default function App() {
    const [steps, setSteps] = useState("");
    const [goals, setGoals] = useState(
        Array.from({ length: 30 }, (_, i) => ({
            stepGoal: (i + 1) * 1000, // 1000 -> 30000
            completed: false,
        }))
    );

    // Päätä näytön asettelu koon perusteella
    const isSmallScreen = width < SMALL_SCREEN_THRESHOLD;
    const ITEM_SIZE = isSmallScreen ? SMALL_SCREEN_ITEM_SIZE : LARGE_SCREEN_ITEM_SIZE;
    const numColumns = isSmallScreen ? 2 : Math.floor(width / (ITEM_SIZE + ITEM_MARGIN * 2));

    // Lisää tai päivitä suoritettu askeltavoite
    const handleAddStep = () => {
        const stepValue = parseInt(steps);

        // Tarkista, että syöte on numero ja se on vähintään 1000
        if (stepValue >= 1000 && stepValue <= 30000) {
            // Pyöristä alaspäin lähimpään tuhanteen
            const roundedStepValue = Math.floor(stepValue / 1000) * 1000;

            setGoals((prevGoals) =>
                prevGoals.map((goal) =>
                    goal.stepGoal === roundedStepValue
                        ? { ...goal, completed: true }
                        : goal
                )
            );
            setSteps(""); // Tyhjennä syötekenttä
        } else {
            alert("Syötä validi askelmäärä (vähintään 1000 ja korkeintaan 30000).");
        }
    };


    // Poista suoritus askeltavoitteesta
    const handleRemoveStep = (stepGoal: number) => {
        setGoals((prevGoals) =>
            prevGoals.map((goal) =>
                goal.stepGoal === stepGoal ? { ...goal, completed: false } : goal
            )
        );
    };

    // Poista kaikki suoritukset
    const handleRemoveAllSteps = () => {
        Alert.alert("Varmistus", "Haluatko varmasti tyhjentää suoritukset?", [
            { text: "Peruuta", style: "cancel" },
            {
                text: "Tyhjennä",
                style: "destructive",
                onPress: () => {
                    setGoals((prevGoals) =>
                        prevGoals.map((goal) => ({ ...goal, completed: false }))
                    );
                },
            },
        ]);
    };

    // Laske suoritetut tavoitteet
    const completedGoals = goals.filter((goal) => goal.completed).length;
    const progressPercentage = (completedGoals / goals.length) * 100;

    return (
        <View style={styles.container}>
            <Text style={styles.title}>Askeltavoiteseuranta</Text>

            {/* Suoritusprosenttipalkki */}
            <View style={styles.progressContainer}>
                <View style={[styles.progressBar, { width: `${progressPercentage}%` }]} />
            </View>
            <Text style={styles.progressText}>
                Suoritettu: {completedGoals}/{goals.length} ({progressPercentage.toFixed(0)}%)
            </Text>

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
                numColumns={numColumns} // Dynaamisesti lasketaan sarakkeiden määrä
                keyExtractor={(item) => item.stepGoal.toString()}
                renderItem={({ item }) => (
                    <View
                        style={[
                            styles.goalItem,
                            {
                                width: ITEM_SIZE,
                                height: ITEM_SIZE,
                                margin: ITEM_MARGIN,
                            },
                            item.completed && styles.completedGoal,
                        ]}
                    >
                        <Text style={styles.goalText}>{item.stepGoal}</Text>
                        {item.completed && (
                            <TouchableOpacity
                                onPress={() => handleRemoveStep(item.stepGoal)}
                                style={styles.trashButton}
                            >
                                <Image
                                    source={require("./trash-icon.png")}
                                    style={styles.trashIcon}
                                />
                            </TouchableOpacity>
                        )}
                    </View>
                )}
            />

            {/* Poista kaikki suoritukset -painike */}
            <TouchableOpacity style={styles.clearButton} onPress={handleRemoveAllSteps}>
                <Text style={styles.clearButtonText}>Tyhjennä</Text>
            </TouchableOpacity>
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
    progressContainer: {
        height: 20,
        backgroundColor: "#e0e0e0",
        borderRadius: 10,
        overflow: "hidden",
        marginBottom: 10,
    },
    progressBar: {
        height: "100%",
        backgroundColor: "#4caf50",
    },
    progressText: {
        fontSize: 16,
        textAlign: "center",
        marginBottom: 20,
    },
    goalItem: {
        borderWidth: 1,
        borderColor: "#ddd",
        borderRadius: 10,
        backgroundColor: "#fff",
        alignItems: "center",
        justifyContent: "space-between",
        padding: 10,
    },
    goalText: {
        fontSize: 18,
        fontWeight: "bold",
        textAlign: "center",
    },
    completedGoal: {
        backgroundColor: "#c8e6c9",
    },
    trashButton: {
        marginTop: 5,
    },
    trashIcon: {
        width: 24,
        height: 24,
    },
    clearButton: {
        backgroundColor: "#f44336",
        padding: 15,
        borderRadius: 10,
        marginTop: 10,
    },
    clearButtonText: {
        color: "#fff",
        fontSize: 18,
        textAlign: "center",
    },
});
