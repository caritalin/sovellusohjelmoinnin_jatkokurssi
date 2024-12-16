import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Sääsovellus"

    property string cityName: "Helsinki"
    property int temperature: 5

    Rectangle {
        width: parent.width
        height: parent.height

        // Gradientin värit riippuvat lämpötilasta
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: temperature < 0 ? "darkblue" : (temperature > 30 ? "red" : "lightblue")
            }
            GradientStop {
                position: 1.0
                color: temperature < 0 ? "darkblue" : (temperature > 30 ? "red" : "lightblue")
            }
        }

        Column {
            anchors.centerIn: parent
            spacing: 20

            Row {
                spacing: 10
                Text {
                    id: cityText
                    text: cityName + ": " + temperature + "°C"
                    font.pixelSize: 24
                    color: "white"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            cityName = (cityName === "Helsinki") ? "Tampere" : "Helsinki"
                            temperature = (cityName === "Helsinki") ? 5 : -1
                            cityText.color = cityText.color === "white" ? "yellow" : "white"
                        }
                    }
                }

                // Ilmansuunnan ja sään mukaan vaihteleva kuvake
                Image {
                    source: temperature < 0 ? "snowy.png" : (temperature > 30 ? "sunny.png" : "cloudy.png")
                    width: 50
                    height: 50
                }
            }

            // Lisäkomponentteja, jotka voi halutessaan lisätä
            Text {
                text: "Terve! Tämä on sääsovellus."
                font.pixelSize: 16
                color: "white"
            }
        }
    }
}
