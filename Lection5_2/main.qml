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

    Item {
        id: mainItem
        anchors.fill: parent
        property int currentWindowState: 1 // 1 == Sign in state / 2 == Sign up state
        state: "signIn"

        states: [
            State {
                name: "signIn"
                PropertyChanges {target: windowStateLoader; source: "qml/signinloader.qml"}
                PropertyChanges {target: mainItem; currentWindowState: 1}

            },
            State {
                name: "signUp"
                PropertyChanges {target: windowStateLoader; source: "qml/signuploader.qml"}
                PropertyChanges {target: mainItem; currentWindowState: 0}
            }
        ]

        // Window state loader
        Loader {
            id: windowStateLoader
            anchors.fill: parent
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
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
                enabled: !mainItem.currentWindowState
                text: "Sign in"
                font.underline: mainItem.currentWindowState
                onClicked: {
                    mainItem.state = "signIn"
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
                enabled: mainItem.currentWindowState
                text: "Sign up"
                font.underline: !mainItem.currentWindowState
                onClicked: {
                    mainItem.state = "signUp"
                }
            }
        }
    }

}
