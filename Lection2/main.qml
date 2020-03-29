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
    property int currentWindowState: 1 // 1 == Sign in state / 2 == Sign up state

    // Window state loader
    Loader {
        id: windowStateLoader
        anchors.fill: parent
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        source: (window.currentWindowState == 1)
                ? "qml/signinloader.qml"
                : "qml/signuploader.qml"
    }

    // Bottom row
    Row {
        id: bottomPromptRow
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        // Sign in prompt button
        Prompt {
            id:signInPrompt
            enabled: !currentWindowState
            text: "Sign in"
            font.underline: currentWindowState
            onClicked: {
                window.currentWindowState = 1
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
            id:signUpPrompt
            enabled: currentWindowState
            text: "Sign up"
            font.underline: !currentWindowState
            onClicked: {
                window.currentWindowState = 0
            }
        }
    }
}
