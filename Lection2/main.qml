import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.5
import "qml"

Window {
    id: window
    visible: true
    width: 280
    height: 500
    title: "Authorization"
    property int instance: 1

    Loader {
        id: authLoader
        anchors.fill: parent
        anchors.top: top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        source: (window.instance == 1) ? "qml/signinloader.qml" : "qml/signuploader.qml"
    }

    // Bottom row
    Row {
        id: promptRow
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        // Sign in prompt button
        Prompt {
            id:sIP
            enabled: !instance
            text: "Sign in"
            font.underline: instance
            onClicked: {
                window.instance = 1
            }
        }
        Text {
            id: slash
            text: "/"
            font.pixelSize: 16
            color: "#404040"
        }
        // Sign up prompt button
        Prompt {
            id:sUP
            enabled: instance
            text: "Sign up"
            font.underline: !instance
            onClicked: {
                window.instance = 0
            }
        }
    }
}
