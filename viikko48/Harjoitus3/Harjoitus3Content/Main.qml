import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 500
    height: 400
    title: "Visuaalisesti Houkutteleva Sovellus"

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#e0f7fa" // Vaaleansininen taustaväri

        Rectangle {
            id: centerRectangle
            width: 200
            height: 150
            anchors.centerIn: parent
            radius: 20 // Pyöristetyt kulmat
            color: "#ffcc80" // Oranssi suorakulmio

            Text {
                id: greetingText
                text: "Hello, World!"
                anchors.centerIn: parent
                font.pixelSize: 22
                font.bold: true
                color: "#37474f" // Tummanharmaa teksti
            }
        }

        Button {
            id: actionButton
            text: "Change Text and Rotate"
            width: 220
            height: 50
            font.pixelSize: 16
            background: Rectangle {
                color: "#29b6f6" // Sininen painike
                radius: 10
            }
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30

            onClicked: {
                // Vaihda teksti
                if (greetingText.text === "Hello, World!") {
                    greetingText.text = "Welcome!";
                } else {
                    greetingText.text = "Hello, World!";
                }

                // Käännä suorakulmio
                if (centerRectangle.rotation === 0) {
                    centerRectangle.rotation = 45;
                } else {
                    centerRectangle.rotation = 0;
                }
            }
        }
    }
}
