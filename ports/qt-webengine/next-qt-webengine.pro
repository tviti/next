TEMPLATE = app
TARGET = next-platform-port

QT += widgets

greaterThan(QT_MAJOR_VERSION, 5): QT += widgets

HEADERS += window.h
SOURCES += window.cpp next-qt-webengine.cpp
