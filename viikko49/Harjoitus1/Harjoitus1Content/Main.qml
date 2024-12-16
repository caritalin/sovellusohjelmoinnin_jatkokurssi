import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Harjoitus1"

    property string cityName: "Helsinki"
    property int temperature: 0
    property string weatherIcon: ""
    property string errorMessage: ""

    Rectangle {
        width: parent.width
        height: parent.height

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
                }

                Image {
                    source: "https://openweathermap.org/img/wn/" + weatherIcon + "@2x.png"
                    width: 50
                    height: 50
                }
            }

            Text {
                text: "Terve! Tämä on sääsovellus."
                font.pixelSize: 16
                color: "white"
            }

            Text {
                text: errorMessage
                font.pixelSize: 16
                color: "red"
                visible: errorMessage !== ""
            }

            Button {
                text: "Päivitä sää"
                onClicked: fetchWeather()
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                text: "Vaihda kaupunki"
                onClicked: changeCity()
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    function fetchWeather() {
        var apiKey = "a240e2ff1c9c0d936c91e2a04f73beab";
        var url = "https://api.openweathermap.org/data/2.5/weather?q=" + cityName + "&units=metric&appid=" + apiKey;

        var xhr = new XMLHttpRequest();
        xhr.open("GET", url);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);
                temperature = response.main.temp;
                weatherIcon = response.weather[0].icon;
                errorMessage = "";  // Tyhjennä virheilmoitus, jos säädata löytyy
            } else if (xhr.readyState === 4) {
                errorMessage = "Virhe säädatan hakemisessa.";
            }
        };
        xhr.send();
    }

    function changeCity() {
        // Vaihdetaan kaupungin nimi (Helsinki ↔ Tampere)
        cityName = (cityName === "Helsinki") ? "Tampere" : "Helsinki";
        fetchWeather();  // Haetaan uuden kaupungin sää
    }

    Component.onCompleted: fetchWeather()  // Alustava säätiedon haku
}
