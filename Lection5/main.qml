import QtQuick 2.13
import QtQuick.Window 2.13

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: "States"
    minimumHeight: 200
    minimumWidth: 200

    Item {
        anchors.fill: parent
        state: window.height >= window.width ? "portrait" : "landscape"
        states:
            [
            State {
                name: "portrait"
                PropertyChanges {
                    target:photo
                    color: "red"
                    anchors.topMargin: 20
                }
                AnchorChanges {
                    target: photo
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                AnchorChanges {
                    target: name
                    anchors.top: photo.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            },
            State {
                name: "landscape"
                PropertyChanges {
                    target: photo
                    color: "blue"
                    anchors.leftMargin: 20
                }
                AnchorChanges {
                    target: photo
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                AnchorChanges {
                    target: name
                    anchors.left: photo.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        ]

        Rectangle {
            id:photo
            width: 100
            height: 100

        }
        Text {
            id:name
            text: "name"

        }
    }
}
