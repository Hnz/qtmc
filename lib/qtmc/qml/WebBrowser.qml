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
import QtWebKit 1.0

Rectangle {
    id: webBrowser
    width: 400
    height: 400

    property string urlString : "http://www.nu.nl/"

    Rectangle {
        id: header
        color: "lightgrey"
        anchors { top: parent.top; left: parent.left; right: parent.right; bottom: webView.top }
        height: 50
        Rectangle {
            color: "white"
            radius: 3
            border.color: "grey"
            anchors.fill: parent
            anchors.margins: 15
            TextInput {
                text: urlString
                color: "blue"
                anchors.fill: parent
            }
        }
    }

    WebView {
        id: webView
        url: webBrowser.urlString
        //onProgressChanged: header.urlChanged = false
        anchors { top: header.bottom; left: parent.left; right: parent.right; bottom: parent.bottom }
    }
}
