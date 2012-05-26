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

Player {
    id: player
    width: 960
    height: 540
    color: "#000000"

    Rectangle {
        id: topbar
        color: "transparent"
        height: 50;
        anchors.top: parent.top;
        anchors.left: parent.left
        anchors.right: parent.right

        TextEdit {
            id: searchbar
            focus: true
            anchors.centerIn: parent
            color: "white"
            text: qsTr("Search")
            font.family: "Droid Sans"
            font.bold: false
            font.pixelSize: 25
        }

        Image {
            smooth: true
            id: movie
            source: "../icons/video-television.png"
            anchors.right: music.left
            anchors.margins: 10

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    main.source = "TrackListView.qml"
                }
            }
        }

        Image {
            id: music
            source: "../icons/speaker.png"
            anchors.right: tv.left
            anchors.margins: 10

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    main.source = "music/View.qml"
                }
            }
        }

        Image {
            id: tv
            source: "../icons/tv.png"
            anchors.right: news.left
            anchors.margins: 10

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    main.source = "tv/View.qml"
                }
            }
        }

        Image {
            id: news
            source: "../icons/rss.png"
            anchors.right: game.left
            anchors.margins: 10

            Image {
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        main.source = "news/View.qml"
                    }
                }
            }
        }

        Image {
            id: game
            source: "../icons/joystick.png"
            anchors.right: weather.left
            anchors.margins: 10

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    main.source = "game/View.qml"
                }
            }
        }

        Image {
            id: weather
            source: "../icons/feed-subscribe.png"
            anchors.right: exit.left
            anchors.margins: 10

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    main.source = "weather/View.qml"
                }
            }
        }

        Image {
            id: exit
            source: "../icons/system-shutdown.png"
            //fillMode: Image.PreserveAspectFit
            //anchors.top: parent.top
            //anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.margins: 10

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Qt.quit()
                }
            }
        }
    }

    Widget {
        id: fileBrowserWidget
        anchors.fill: parent
        anchors.margins: 65

        FileBrowser {
             anchors.fill: parent
             anchors.margins: 10
         }
    }
}
