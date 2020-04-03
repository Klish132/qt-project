#ifndef AUTHMANAGER_H
#define AUTHMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QString>

class AuthManager : public QObject
{
    Q_OBJECT
public:

    explicit AuthManager(QObject *parent = nullptr);

    void authentificate(const QString &login,
                        const QString &password);

    void registerer(const QString &login,
                        const QString &password);

signals:
    void regRequestCompleted(QString);
    void authRequestCompleted(QString, QString);

private:
    QNetworkAccessManager _net;
};

#endif // AUTHMANAGER_H
