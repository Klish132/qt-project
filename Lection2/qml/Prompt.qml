import QtQuick 2.0

Text {
    id: prompt
    text: "Prompt"
    font.pixelSize: 16
    color: "#404040"

    signal clicked()

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            prompt.clicked()
        }
    }
}
