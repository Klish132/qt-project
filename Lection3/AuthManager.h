#ifndef AUTHMANAGER_H
#define AUTHMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QString>

class AuthManager : public QObject
{
    Q_OBJECT
public:
    QString authError;
    QString registerError;

    explicit AuthManager(QObject *parent = nullptr);

    void authentificate(const QString &login,
                        const QString &password);

    void registerer(const QString &login,
                        const QString &password);

    QString getToken();

private slots:
    void onRegFinished();
    void onAuthFinished();

signals:
    void regRequestCompleted(QString);
    void authRequestCompleted(QString);


private:
    QNetworkAccessManager _net;
    QString token;

};

#endif // AUTHMANAGER_H
