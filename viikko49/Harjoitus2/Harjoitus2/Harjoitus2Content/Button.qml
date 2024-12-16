import QtQuick 2.15

Rectangle {
    width: 200
    height: 50
    radius: 10
    color: buttonColor
    border.color: "black"

    // Nappulalle määritellään text ja buttonColor propertyt
    property string text: "Click me"
    property color buttonColor: "lightblue"

    // Signaali, joka lähetetään, kun nappia klikataan
    signal clicked

    // Animaatio napin skaalautumiselle
    property real scaleFactor: 1.0
    behavior on scaleFactor { NumberAnimation { duration: 100; easing.type: Easing.InOutQuad } }

    // Teksti, joka näkyy napissa
    Text {
        anchors.centerIn: parent
        text: parent.text
        font.pixelSize: 18
        color: "black"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.clicked()  // Lähetetään signaali, kun nappia klikataan
            // Vaihda napin väri, kun sitä klikataan
            parent.buttonColor = parent.buttonColor === "lightblue" ? "lightgreen" : "lightblue"
        }

        // Visuaalinen efekti: nappi pienenee ja palautuu painalluksen aikana
        onPressed: {
            parent.scaleFactor = 0.95  // Nappi pienenee
        }

        onReleased: {
            parent.scaleFactor = 1.0  // Nappi palautuu alkuperäiseen kokoon
        }
    }
}
