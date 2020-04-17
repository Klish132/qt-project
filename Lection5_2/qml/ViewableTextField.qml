import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Window 2.13

Item {
    id: root
    height: textField.height
    property int length: textField.length
    property string text: textField.text
    property alias placeholderText: textField.placeholderText

    states: [
        State {
            name: "shown"
            when: showButton.pressed
            PropertyChanges {
                target: textField
                echoMode: TextInput.Normal
            }
        },
        State {
            name: "hidden"
            when: showButton.released
            PropertyChanges {
                target: textField
                echoMode: TextInput.Password
            }
        }
    ]

    TextField {
        id: textField
        font.pixelSize: 16
        width: parent.width - showButton.width - 5
        placeholderText: "Password"
        selectByMouse: true
        state: "hidden"
    }
    Button {
        id: showButton
        anchors.left: textField.right
        anchors.leftMargin: 5
        text: "👀"
        font.pixelSize: 16
        width: textField.height
    }
}
