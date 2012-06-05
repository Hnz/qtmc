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

Rectangle {
    id: qtmc
    color: "black"
    width: 960
    height: 540

    // This model holds the icons for the sideBar
    ListModel {
        id: sideBarModel
        ListElement {
            name: "Dashboard"
            icon: "../icons/speaker.png"
        }
        ListElement {
            name: "File Browser"
            icon: "../icons/video-television.png"
        }
        ListElement {
            name: "Web Browser"
            icon: "../icons/rss.png"
        }
        ListElement {
            name: "Settings"
            icon: "../icons/tv.png"
        }
    }

    // This Visual Item Model contains all Applications
    VisualItemModel {
        id: appModel
        Item {
            height: view.height
            width: view.width
            Widget {
                anchors.margins: 10
                anchors.fill: parent
                Dashboard {
                    anchors.fill: parent
                }
            }
        }
        Item {
            height: view.height
            width: view.width
            Widget {
                anchors.margins: 10
                anchors.fill: parent
                FileBrowser {
                    anchors.margins: 10
                    anchors.fill: parent
                    onFileSelected: {
                        view.visible = false
                        sideBar.visible = false
                        player.play(path)
                    }
                }
            }
        }
        Item {
            height: view.height
            width: view.width
            Widget {
                anchors.margins: 10
                anchors.fill: parent
                WebBrowser {
                    anchors.margins: 10
                    anchors.fill: parent
                }
            }
        }
        Item {
            height: view.height
            width: view.width
            Widget {
                anchors.margins: 10
                anchors.fill: parent
                Settings {
                    anchors.margins: 10
                    anchors.fill: parent
                }
            }
        }
    }

    // The player is used to play audio, video and images
    Player {
        id: player
        anchors.fill: parent
        Component.onCompleted: play("../wallpapers/hover_my_radio.jpg")
        ListView {
            id: view
            anchors.right: sideBar.left
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            model: appModel
            preferredHighlightBegin: 0
            preferredHighlightEnd: 0
            highlightRangeMode: ListView.StrictlyEnforceRange
            orientation: ListView.Vertical
            clip: true
            snapMode: ListView.SnapOneItem
            flickDeceleration: 1500
            cacheBuffer: appModel.count * width
        }
        Item {
            id: sideBar
            width: 52
            anchors { top: parent.top; bottom: parent.bottom; right: parent.right; margins: 5  }

            ListView {
                anchors.fill: parent
                spacing: 10
                model: sideBarModel
                orientation: ListView.Vertical
                delegate: Rectangle {
                    width: 50
                    height: 50
                    radius: 3
                    color: view.currentIndex == index ? "#999" : "#333"
                    Image {
                        id: appIcon
                        source: icon
                        width: 35
                        height: 35
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: name
                        color: "red"
                        anchors.top: appIcon.bottom
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: view.currentIndex = index
                    }
                }
            }
        }
    }
}
