
import QtQuick 1.1
import Qt.labs.folderlistmodel 1.0

Rectangle {
    id: fileBrowser
    width: 400
    height: 400
    Rectangle {
        id: fileViewHeader
        color: "#531010"
        height: 50
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        Text {
            id: currentFolder
            text: folderModel.folder
            anchors.left: parent.left
            //anchors.right: parentFolder.left
        }
        Image {
            id: parentFolder
            anchors.right: parent.right
            anchors.rightMargin: 0
            source: "../icons/arrow-up.png"
            //anchors.right: parent.right
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    folderModel.folder = folderModel.parentFolder
                }
            }
        }
    }
    ListView {
        id: fileView
        anchors.bottom: parent.bottom
        anchors.top: fileViewHeader.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        model: folderModel
        delegate: fileDelegate
        highlight: fileDelegateHighlight
        clip: true
        focus: true

        FolderListModel {
            id: folderModel
            nameFilters: ["*.avi", "*.mkv", "*.mp4", "*.ogg", "*.ogm", "*.ogv"]
            folder: "file:/home/hanz/Videos/"
        }

        Component {
            id: fileDelegate
            Text {
                text: fileName
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        fileView.currentIndex = index
                    }
                    onClicked: {
                        var path = folderModel.folder + "/" + fileView.currentItem.text
                        console.log("Clicked on " + path + fileView.currentIndex)
                        if (folderModel.isFolder(fileView.currentIndex)) {
                            folderModel.folder = path
                        } else {
                            console.log("Playing " + path)
                            fileBrowserWidget.visible = false
                            player.play(path)
                        }
                    }
                }
            }
        }

        Component {
            id: fileDelegateHighlight
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                color: "red"
                //Text { text: fileName }
            }
        }
    }
}
