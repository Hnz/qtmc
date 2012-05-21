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

#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeView>
#include <QTranslator>
#include "qtmc.h"
#include "../mediadb/mediadb.h"
#include "../qtmc_global.h"

#define TS_PREFIX "qtmc_"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    MediaDB *mediadb = new MediaDB();
    qDebug() << "MediaDB version" << mediadb->version() << QString(QTMC_VERSION);

    QTranslator translator;
    QString lang = "fr_FR";
    translator.load( TS_PREFIX + lang, ":/ts/");
    app.installTranslator(&translator);

    QDeclarativeView *view = new QDeclarativeView;
    view->setSource(QUrl("qrc:/qml/main.qml"));
    view->show();

    //QtMC w;
    //w.show();
    return app.exec();
}
