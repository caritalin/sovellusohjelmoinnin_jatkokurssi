import QtQuick 2.15
import QtQuick.Controls 2.15
import "Button.qml"  // Tuodaan mukautettu nappikomponentti

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Komponentit ja logiikka"

    // Pääkäyttöliittymän tausta
    Rectangle {
        width: parent.width
        height: parent.height
        color: "lightgray"

        Column {
            anchors.centerIn: parent
            spacing: 20

            // Ensimmäinen nappi
            Button {
                text: "Change Background"
                buttonColor: "lightgreen"
                onClicked: {
                    // Vaihda taustaväri, kun nappia klikataan
                    parent.color = (parent.color === "lightgray") ? "lightyellow" : "lightgray"
                }
            }

            // Toinen nappi
            Button {
                text: "Print Message"
                buttonColor: "lightcoral"
                onClicked: {
                    // Tulosta viesti konsoliin, kun nappia klikataan
                    console.log("Nappi painettu!")
                }
            }

            // Kolmas nappi
            Button {
                text: "Reset"
                buttonColor: "lightblue"
                onClicked: {
                    // Nollaa kaikki taustat ja viestit
                    parent.color = "lightgray"
                    console.log("Taustaväri ja viestit nollattu.")
                }
            }
        }
    }
}
