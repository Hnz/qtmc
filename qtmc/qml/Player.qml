/*
 * This file is part of QtMC.
 * Copyright 2012, Hans van Leeuwen
 *
 * QMC is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published
 * by the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 1.1
import QtMultimediaKit 1.1

Rectangle {

    function play(source){
        videoPlayer.source = source
        videoPlayer.play()
    }

    Text {
        id: info
        text: qsTr("text")
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Video {
        id: videoPlayer
        anchors.top: info.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: playerControlBar.top
        Keys.onSpacePressed: player.paused = !player.paused
        Keys.onLeftPressed: player.position -= 5000
        Keys.onRightPressed: player.position += 5000
        source: "/home/hanz/Videos/sintel_trailer-720p.ogv"
    }

    Rectangle {
        id: playerControlBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "grey"
        height: 50

        Image {
            id: playicon
            source: "../icons/media-playback-start.png"
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    videoPlayer.play()
                }
            }
        }

        Image {
            id: pauseicon
            source: "../icons/media-playback-pause.png"
            anchors.left: playicon.right
            anchors.bottom: parent.bottom
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    videoPlayer.pause()
                }
            }
        }

        Image {
            id: stopicon
            source: "../icons/media-playback-stop.png"
            anchors.left: pauseicon.right
            anchors.bottom: parent.bottom
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    videoPlayer.stop()
                }
            }
        }

        Slider {
            id: videoSlider
            anchors.left: stopicon.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.margins: 10
            onValueChanged: {
                console.log("PP")
            }
        }
    }
}
