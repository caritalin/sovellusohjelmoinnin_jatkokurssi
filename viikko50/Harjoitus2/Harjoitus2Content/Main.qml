import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 400
    title: "Nopeusmittari"

    // Taustaväri
    Rectangle {
        anchors.fill: parent
        color: "#222222"

        // Mittaritaulu
        Image {
            id: gauge
            source: "gauge.png" // Mittarin taustakuva
            anchors.centerIn: parent
            width: 300
            height: 300

            // Neula
            Image {
                id: needle
                source: "needle.png" // Neulan kuva
                anchors.centerIn: parent
                width: 10
                height: 150

                // Neulan pyörimiskeskus on keskellä neulaa
                transformOrigin: Item.Center

                // Animaatio neulan liikkeelle
                PropertyAnimation {
                    id: needleAnimation
                    target: needle
                    property: "rotation"
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
            }
        }

        // Nopeus-property
        property int speed: 0

        // Nopeuslogiikka
        function updateNeedleRotation() {
            // Asetetaan neulan kulma nopeuden mukaan (0-200 km/h)
            return -90 + (speed / 200) * 180; // Neula liikkkuu välillä -90° ja 90°
        }

        // Painikkeet nopeuden säätämiseen
        Row {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            // Gas (Kiihdytys)
            Button {
                text: "Gas"
                onClicked: {
                    if (speed < 200) {
                        speed += 20; // Lisää nopeutta
                        needleAnimation.to = updateNeedleRotation(); // Päivitetään neulan kulma
                        needleAnimation.start(); // Käynnistetään animaatio
                    }
                }
            }

            // Break (Jarrutus)
            Button {
                text: "Break"
                onClicked: {
                    if (speed > 0) {
                        speed -= 20; // Vähentää nopeutta
                        needleAnimation.to = updateNeedleRotation(); // Päivitetään neulan kulma
                        needleAnimation.start(); // Käynnistetään animaatio
                    }
                }
            }
        }

        // Digitaalinen nopeusnäyttö
        Text {
            anchors.top: gauge.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: speed + " km/h"
            color: "white"
            font.pixelSize: 30
        }
    }
}
