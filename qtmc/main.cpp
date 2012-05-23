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
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/QDeclarativeView>
#include <QtSql/QSqlDatabase>
#include <QTranslator>
#include "qtmc.h"
#include "../mediadb/mediadb.h"
#include "../qtmc_global.h"

#define TS_PREFIX "qtmc_"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // Load settings
    QSettings settings;
    settings.setValue("dbtype", "QSQLITE");
    settings.setValue("dbname", "/tmp/testdb.sqlite3");

    qDebug() << settings.value("dbtype");

    // Open database
    QSqlDatabase db = QSqlDatabase::addDatabase(settings.value("dbtype").toString());
    db.setDatabaseName(settings.value("dbtype").toString());
    //db.setDatabaseName(":memory:");

    // Check if database is open
    if (!db.open()) {
        qWarning() << app.tr("Cannot open database"),
            app.tr("Unable to establish a database connection.\n"
                    "This example needs SQLite support. Please read "
                    "the Qt SQL driver documentation for information how "
                    "to build it.\n\n"
                    "Click Cancel to exit.");
        return 1;
    }

    // Create mediadb
    MediaDB *mediadb = new MediaDB();
    qDebug() << "QtMC version" << QString(QTMC_VERSION);
    qDebug() << "MediaDB version" << mediadb->version();

    // Translator
    QTranslator translator;
    QString lang = "fr_FR";
    translator.load( TS_PREFIX + lang, ":/ts/");
    app.installTranslator(&translator);

    // Create qml-view and connect quit-signal
    QDeclarativeView *view = new QDeclarativeView;
    QObject::connect(view->engine(), SIGNAL(quit()), view, SLOT(close()));

    // Expose c++ object to qml
    QDeclarativeContext *ctxt = view->rootContext();
    ctxt->setContextProperty("MediaDB", mediadb);
    ctxt->setContextProperty("Settings", &settings);

    // Run view
    view->setSource(QUrl("qrc:/qml/main.qml"));
    view->show();

    return app.exec();
}
