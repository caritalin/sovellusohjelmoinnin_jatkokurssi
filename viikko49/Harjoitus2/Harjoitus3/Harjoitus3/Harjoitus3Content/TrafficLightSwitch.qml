import QtQuick 2.15
import QtQuick.Controls 2.15

// Kytkin, joka hallitsee liikennevalojen tilaa
Rectangle {
    width: 150
    height: 50
    color: checked ? "#4CAF50" : "#E0E0E0"  // Vihreä, kun päällä, harmaa, kun pois päältä
    radius: 25
    border.color: "black"

    property bool checked: false

    MouseArea {
        anchors.fill: parent
        onClicked: {
            checked = !checked
            switchStateChanged()
        }
    }

    Text {
        anchors.centerIn: parent
        text: checked ? "Valot päällä" : "Valot pois"
        color: checked ? "white" : "black"  // Valaistus: valkoinen, kun päällä; musta, kun pois päältä
        font.pixelSize: 18
    }

    signal switchStateChanged()
}
