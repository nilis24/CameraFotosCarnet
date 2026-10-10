#include "PhotoManager.h"
#include <QFile>
#include <QImage>
#include <QDebug>

void PhotoManager::processPhoto(const QString &sourcePath, const QUrl &destination, int width, int height)
{
    QImage image(sourcePath);
    if (image.isNull()) {
        qWarning() << "Could not open" << sourcePath;
        return;
    }

    QImage scaledImage = image.scaled(width, height,
                                      Qt::KeepAspectRatioByExpanding,
                                      Qt::SmoothTransformation);
    int x = (scaledImage.width() - width) / 2;
    int y = (scaledImage.height() - height) / 2;
    QImage croppedImage = scaledImage.copy(x, y, width, height);

    if (!croppedImage.save(destination.toLocalFile()))
        qWarning() << "Could not save to" << destination.toLocalFile();

    QFile::remove(sourcePath);      // delete the original photo from the Pictures folder
}

void PhotoManager::discardPhoto(const QString &path)
{
    QFile::remove(path);
}
