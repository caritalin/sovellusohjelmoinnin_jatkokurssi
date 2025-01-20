import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 400
    title: "State ja Transition"

    // Molempien suorakulmioiden tilan synkronointi
    property bool isOn: false

    // Ensimmäinen suorakulmio
    Rectangle {
        id: rect1
        width: isOn ? 300 : 200
        height: isOn ? 150 : 100
        color: isOn ? "green" : "red"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 50

        MouseArea {
            anchors.fill: parent
            onClicked: {
                isOn = !isOn
            }
        }

        states: [
            State {
                name: "on"
                when: isOn
                PropertyChanges { target: rect1; width: 300; height: 150; color: "green" }
            },
            State {
                name: "off"
                when: !isOn
                PropertyChanges { target: rect1; width: 200; height: 100; color: "red" }
            }
        ]

        transitions: Transition {
            from: "off"
            to: "on"
            reversible: true
            ParallelAnimation {
                NumberAnimation { properties: "width, height"; duration: 500 }
                ColorAnimation { property: "color"; duration: 500 }
            }
        }
    }

    // Toinen suorakulmio
    Rectangle {
        id: rect2
        width: isOn ? 300 : 200
        height: isOn ? 150 : 100
        color: isOn ? "green" : "red"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: rect1.bottom
        anchors.topMargin: 20

        MouseArea {
            anchors.fill: parent
            onClicked: {
                isOn = !isOn
            }
        }

        states: [
            State {
                name: "on"
                when: isOn
                PropertyChanges { target: rect2; width: 300; height: 150; color: "green" }
            },
            State {
                name: "off"
                when: !isOn
                PropertyChanges { target: rect2; width: 200; height: 100; color: "red" }
            }
        ]

        transitions: Transition {
            from: "off"
            to: "on"
            reversible: true
            ParallelAnimation {
                NumberAnimation { properties: "width, height"; duration: 500 }
                ColorAnimation { property: "color"; duration: 500 }
            }
        }
    }

    // Power-nappi, joka vaihtaa molempien suorakulmioiden tilaa
    Button {
        text: "Power"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        onClicked: {
            isOn = !isOn
        }
    }
}
