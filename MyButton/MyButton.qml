import QtQuick 2.0

Rectangle {
        id: button
        width: 64
        height: 64

        property alias operation: buttonText.text
        signal clicked

        color: "midnightblue"
        //anchors.left : undefined
        anchors.centerIn: parent


        Rectangle {
                id: shade

                anchors.fill: button;
                color: "red"
                opacity: 0
}
        Text {
            id: buttonText
            anchors.centerIn:parent
            color: "white"
            font.pointSize: 16
            font.bold: true


        }




        MouseArea {
               id: mouseArea
               anchors.fill: parent
               onClicked: {
                   button.clicked();
                   //button.state == 'clicked' ? button.state = "" : button.state = 'clicked';
           }

           states:  State {
                   name: "pressed" ; when: mouseArea.pressed == true

                   PropertyChanges { target: shade; opacity: .4 }
               }
}

}






