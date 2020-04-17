import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.5
import AuthManager 1.0
import QtQuick.Dialogs 1.2

Item {
    id: signInLoader
    visible: true

    AuthManager {
        id: authManager
        onAuthRequestCompleted: {
            console.log(error)
            if (error == "") {
                signInDialog.setText("You have successfully signed in.")
                signInDialog.setDetailedText("Your token: " + token)
                signInDialog.open()
            } else {
                signInDialog.setText("Error while signing in.")
                signInDialog.setDetailedText("Error: " + error)
                signInDialog.open()
            }
        }
    }

    MessageDialog {
        id: signInDialog
        title: "Authentification result"
        onAccepted:
            close()
    }

    // Sign in top text
    Text {
        id: signInTitleText
        text: "SIGN IN"
        color: "#404040"
        font.pixelSize: 25
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
    }
    // Sign in fields column
    Column {
        id: signInColumn
        anchors.top: signInTitleText.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        // Login field
        TextField {
            id: loginTextField
            width: window.width - 20
            font.pixelSize: 16
            placeholderText: "Login"
            selectByMouse: true
        }
        // Password field with button
        ViewableTextField {
            id: passwordTextField
            width: window.width - 20
        }

        // Sign in button
        Button {
            id: signInButton
            text: "Sign in"
            anchors.horizontalCenter: parent.horizontalCenter
            enabled: loginTextField.length >= 5 &&
                     passwordTextField.length >= 5
            onClicked: {
                authManager.authentificate(loginTextField.text, passwordTextField.text)
            }
        }
    }

    // Loading Indicator
    BusyIndicator {
        id: loadingIndicator
        anchors.top: signInColumn.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        width: 50; height: 50
        running: authManager.authProcessing
        opacity: 0
        // Opacity animation
        OpacityAnimator{
            target: loadingIndicator
            id: loadingIndicatorOpacity
            from: 0;
            to: 1;
            duration: 1000
            running: authManager.authProcessing
        }
    }
}

