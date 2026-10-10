#ifndef PHOTOMANAGER_H
#define PHOTOMANAGER_H

#include <QObject>
#include <QtQml/qqmlregistration.h>
#include <QString>
#include <QUrl>

class PhotoManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit PhotoManager(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE void processPhoto(const QString &sourcePath, const QUrl &destination, int width, int height);
    Q_INVOKABLE void discardPhoto(const QString &path);
};

#endif // PHOTOMANAGER_H
