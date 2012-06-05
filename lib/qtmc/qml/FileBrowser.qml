/*
 * This file is part of QtMC.
 * Copyright 2012, Hans van Leeuwen
 *
 * QMC is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 1.1
import Qt.labs.folderlistmodel 1.0

Item {
    id: fileBrowser

    signal fileSelected(string path)

    Item {
        id: fileViewHeader
        //color: "#531010"
        height: 50
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        Text {
            id: currentFolder
            text: folderModel.folder
            color: "white"
            font.pixelSize: 25
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
                color: "white"
                font.pixelSize: 15
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        fileView.currentIndex = index
                    }
                    onClicked: {
                        var path = folderModel.folder + "/" + fileView.currentItem.text
                        if (folderModel.isFolder(fileView.currentIndex)) {
                            folderModel.folder = path
                        } else {
                            fileSelected(path)
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
