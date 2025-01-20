import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "Yksinkertainen Canvas ja Animaatio"

    Rectangle {
        id: canvas
        anchors.fill: parent
        color: "white"

        // Yksi pallo kerrallaan
        Rectangle {
            id: ball
            width: 20
            height: 20
            radius: 10
            color: "red"
            visible: false // Näkyy vasta, kun klikataan

            // Animaatio pallon liikkeelle
            property real dx: 2
            property real dy: 2

            Timer {
                id: movementTimer
                interval: 16
                running: false
                repeat: true
                onTriggered: {
                    ball.x += ball.dx;
                    ball.y += ball.dy;

                    // Törmäysreunojen tarkistus
                    if (ball.x <= 0 || ball.x + ball.width >= canvas.width) {
                        ball.dx *= -1; // Vaihda suunta x-akselilla
                    }
                    if (ball.y <= 0 || ball.y + ball.height >= canvas.height) {
                        ball.dy *= -1; // Vaihda suunta y-akselilla
                    }
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                // Aseta pallo klikatun kohdan koordinaatteihin
                ball.x = mouse.x - ball.width / 2;
                ball.y = mouse.y - ball.height / 2;
                ball.visible = true;
                movementTimer.start(); // Käynnistä animaatio
            }
        }
    }
}
