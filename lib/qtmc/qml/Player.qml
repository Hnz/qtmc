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
import QtMultimediaKit 1.1

Item {
    id: player

    function isImage(extention) {
        for (var image_extention in ['jpg', 'gif', 'png']) {
            if (extention === image_extention) {
                return true
            }
        }
        return false
    }

    function play(source) {
        var extention = source.split('.').pop();

        if (isImage(source)) {
            imagePlayer.visible = true
            imagePlayer.source = source
        } else {
            imagePlayer.visible = false
            videoPlayer.source = source
            videoPlayer.play()
        }
    }

    Image {
        id: imagePlayer
        anchors.fill: parent
        visible: false
        fillMode: Image.Stretch
    }

    Video {
        id: videoPlayer
        focus: true
        visible: true
        anchors.fill: parent
        Keys.onSpacePressed: videoPlayer.paused = !videoPlayer.paused
        Keys.onLeftPressed: videoPlayer.position -= 5000
        Keys.onRightPressed: videoPlayer.position += 5000
        source: "/home/hanz/Videos/sintel_trailer-720p.ogv"

        Timer {
            id: hidePlayerControlBar
            interval: 2000
            onTriggered: playerControlBar.visible = false
        }

        MouseArea {
            anchors.fill: parent
            onDoubleClicked: videoPlayer.paused = !videoPlayer.paused
            onMousePositionChanged: {
                playerControlBar.visible = true
                hidePlayerControlBar.start()
            }
        }

        Rectangle {
            id: playerControlBar
            visible: false
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

            Item {
                id: slider; width: 400; height: 16

                // value is read/write.
                property real value: 1
                onValueChanged: updatePos();
                property real maximum: 1
                property real minimum: 1
                property int xMax: width - handle.width - 4
                onXMaxChanged: updatePos();
                onMinimumChanged: updatePos();

                function updatePos() {
                    if (maximum > minimum) {
                        var pos = 2 + (value - minimum) * slider.xMax / (maximum - minimum);
                        pos = Math.min(pos, width - handle.width - 2);
                        pos = Math.max(pos, 2);
                        handle.x = pos;
                    } else {
                        handle.x = 2;
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    border.color: "white"; border.width: 0; radius: 8
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#66343434" }
                        GradientStop { position: 1.0; color: "#66000000" }
                    }
                }

                Rectangle {
                    id: handle; smooth: true
                    y: 2; width: 30; height: slider.height-4; radius: 6
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "lightgray" }
                        GradientStop { position: 1.0; color: "gray" }
                    }

                    MouseArea {
                        id: mouse
                        anchors.fill: parent; drag.target: parent
                        drag.axis: Drag.XAxis; drag.minimumX: 2; drag.maximumX: slider.xMax+2
                        onPositionChanged: { value = (maximum - minimum) * (handle.x-2) / slider.xMax + minimum; }
                    }
                }
            }
        }
    }
}
