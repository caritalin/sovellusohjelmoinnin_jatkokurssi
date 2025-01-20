import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 500
    height: 500
    title: "Dynaaminen ListView"

    // ListModel, joka alustetaan tyhjäksi
    ListView {
        id: listView
        width: parent.width
        height: parent.height

        model: ListModel {}

        delegate: Item {
            width: listView.width
            height: 50

            Rectangle {
                width: parent.width
                height: 50
                color: "lightblue"
                border.color: "black"

                Text {
                    anchors.centerIn: parent
                    text: modelData
                }
            }
        }
    }

    // Tekstikenttä ja painike
    Column {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20

        TextField {
            id: textField
            width: parent.width
            placeholderText: "Lisää uusi elementti"
        }

        Button {
            text: "Lisää"
            width: parent.width
            onClicked: {
                // Lisätään uusi elementti ListModeliin
                if (textField.text !== "") {
                    listView.model.append({ "modelData": textField.text })
                    textField.text = "" // Tyhjennetään tekstikenttä
                }
            }
        }
    }
}
