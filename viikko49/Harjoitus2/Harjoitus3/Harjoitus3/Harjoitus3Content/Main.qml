import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 600
    title: "Liikennevalot"

    // Liikennevalot
    property bool lightsOn: true  // Tämä kontrolloi valojen tilaa (päälle/pois)

    Column {
        anchors.centerIn: parent
        spacing: 20

        // Liikennevalojen järjestys
        Rectangle {
            width: 100
            height: 300
            color: "black"
            radius: 10
            Column {
                anchors.centerIn: parent
                spacing: 20

                // Punainen valo
                Rectangle {
                    width: 80
                    height: 80
                    color: lightsOn ? "red" : "transparent"
                    radius: 40
                    opacity: lightsOn ? 1 : 0
                }

                // Keltainen valo
                Rectangle {
                    width: 80
                    height: 80
                    color: (lightsOn && currentLight === "yellow") ? "yellow" : (lightsOn ? "transparent" : "yellow")
                    radius: 40
                    opacity: (lightsOn || currentLight === "yellow") ? 1 : 0
                }

                // Vihreä valo
                Rectangle {
                    width: 80
                    height: 80
                    color: lightsOn ? "green" : "transparent"
                    radius: 40
                    opacity: lightsOn ? 1 : 0
                }
            }
        }

        // Kytkin liikennevalojen tilan kytkemiseksi päälle tai pois
        TrafficLightSwitch {
            anchors.horizontalCenter: parent.horizontalCenter
            onSwitchStateChanged: {
                lightsOn = !lightsOn
                if (lightsOn) {
                    currentLight = "red"
                } else {
                    currentLight = "yellow" // Kun valot pois päältä, keltainen vilkkuu
                }
            }
        }

        // Timer, joka vaihtaa valojen tilaa
        Timer {
            id: lightTimer
            interval: 1000
            running: lightsOn && currentLight === "red"
            repeat: true
            onTriggered: {
                if (currentLight === "red") {
                    currentLight = "yellow"
                } else if (currentLight === "yellow") {
                    currentLight = "green"
                } else {
                    currentLight = "red"
                }
            }
        }
    }
}
