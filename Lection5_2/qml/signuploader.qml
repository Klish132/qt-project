import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.5
import AuthManager 1.0
import QtQuick.Dialogs 1.2

Item {
    id: signUpLoader
    visible: true

    AuthManager {
        id: authManager
        onRegRequestCompleted: {
            console.log(error)
            if (error == "") {
                signUpDialog.setText("You have successfully signed up.")
                signUpDialog.open()
            } else {
                signUpDialog.setText("Error while signing up.")
                signUpDialog.setDetailedText("Error: " + error)
                signUpDialog.open()
            }
        }
    }

    MessageDialog {
        id: signUpDialog
        title: "Registration result"
        onAccepted:
            close()
    }

    // Sign up top text
    Text {
        id: signUpTitleText
        text: "SIGN UP"
        color: "#404040"
        font.pixelSize: 25
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
    }
    // Sign up fields column
    Column {
        id: signUpColumn
        anchors.top: signUpTitleText.bottom
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
        // Password field
        ViewableTextField {
            id: passwordTextField
            width: window.width - 20
            placeholderText: "Password"
        }
        // Repeat pasword field
        ViewableTextField {
            id: repeatPasswordTextField
            width: window.width - 20
            placeholderText: "Repeat password"
        }
        // Nickname field
        TextField {
            id: nicknameTextField
            width: window.width - 20
            font.pixelSize: 16
            placeholderText: "Nickname"
            selectByMouse: true
        }
        // Sign up button
        Button {
            id: signUpButton
            text: "Sign up"
            anchors.horizontalCenter: parent.horizontalCenter
            enabled: loginTextField.length >= 5 &&
                     passwordTextField.length >= 5 &&
                     repeatPasswordTextField.length >= 5 &&
                     nicknameTextField.length >= 5 &&
                     (passwordTextField.text == repeatPasswordTextField.text)
            onClicked: {
                authManager.registerer(loginTextField.text, passwordTextField.text)
            }
        }
    }
    // Loading Indicator
    BusyIndicator {
        id: loadingIndicator
        anchors.top: signUpColumn.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        width: 50; height: 50
        running: authManager.regProcessing
        opacity: 0
        // Opacity animation
        OpacityAnimator{
            target: loadingIndicator
            id: loadingIndicatorOpacity
            from: 0;
            to: 1;
            duration: 1000
            running: authManager.regProcessing
        }
    }
}
