import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Animoitu Kalenteri"

    // Overlay ja päivänäkymä
    Rectangle {
        id: overlay
        anchors.fill: parent
        color: "#80000000" // Läpinäkyvä musta tausta
        visible: false
        z: 1

        Rectangle {
            id: dayView
            width: parent.width * 0.6
            height: parent.height * 0.4
            anchors.centerIn: parent
            color: "white"
            radius: 10
            border.color: "black"

            Column {
                anchors.centerIn: parent
                spacing: 20

                Text {
                    id: selectedDayText
                    text: "Päivä: " + selectedDay
                    font.pointSize: 20
                }

                Button {
                    text: "Sulje"
                    onClicked: {
                        overlay.visible = false
                    }
                }
            }
        }
    }

    property int selectedDay: 0

    // Kalenterinäkymä
    Column {
        spacing: 20
        anchors.centerIn: parent

        Text {
            text: "Joulukuu"
            font.pointSize: 24
            anchors.horizontalCenter: parent.horizontalCenter
        }

        GridView {
            id: calendarGrid
            width: 350 // Leveys asetetaan niin, että 7 solua mahtuu
            height: 300
            cellWidth: calendarGrid.width / 7  // Leveys jaetaan 7:llä
            cellHeight: 50
            model: 31 // Päivämäärät 1-31

            delegate: Rectangle {
                width: calendarGrid.cellWidth
                height: calendarGrid.cellHeight
                color: "lightgray"
                border.color: "gray"

                Text {
                    text: index + 1
                    anchors.centerIn: parent
                    font.pointSize: 14
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        selectedDay = index + 1
                        overlay.visible = true
                    }
                }
            }
        }
    }
}
