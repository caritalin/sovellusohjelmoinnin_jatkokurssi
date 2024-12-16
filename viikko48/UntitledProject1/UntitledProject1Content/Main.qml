import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Harjoitus 3"

    Rectangle {
        id: background
        anchors.fill: parent
        color: "lightblue"

        Text {
            id: greetingText
            text: "Hello, World!"
            anchors.centerIn: parent
            font.pixelSize: 24
        }

        Button {
            id: actionButton
            text: "Change"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20

            onClicked: {
                // Change the rectangle's color and text, and rotate it
                background.color = background.color === "lightblue" ? "lightgreen" : "lightblue";
                greetingText.text = greetingText.text === "Hello, World!" ? "Welcome!" : "Hello, World!";
                background.rotation = background.rotation === 0 ? 45 : 0;
            }
        }
    }
}
