import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.5

Item {
    id: signUpLoader
    visible: true

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
        }
        // Password field
        TextField {
            id: passwordTextField
            width: window.width - 20
            font.pixelSize: 16
            placeholderText: "Password"
        }
        // Repeat pasword field
        TextField {
            id: repeatPasswordTextField
            width: window.width - 20
            font.pixelSize: 16
            placeholderText: "Repeat password"
        }
        // Nickname field
        TextField {
            id: nicknameTextField
            width: window.width - 20
            font.pixelSize: 16
            placeholderText: "Nickname"
        }
        // Sign up button
        Button {
            id: signUpButton
            text: "Sign up"
            anchors.horizontalCenter: parent.horizontalCenter
            enabled: loginTextField.length >= 5 && passwordTextField.length >= 5 && repeatPasswordTextField.length >= 5 && nicknameTextField.length >= 5
            onClicked: {
                loadingIndicatorOpacity.start()
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
        running: true
        opacity: 0
        // Opacity animation
        OpacityAnimator{
            target: loadingIndicator
            id: loadingIndicatorOpacity
            from: 0;
            to: 1;
            duration: 1000
            running: false
        }
    }
}
