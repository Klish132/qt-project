#ifndef AUTHMANAGER_H
#define AUTHMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QString>

class AuthManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool regProcessing READ isRegProcessing WRITE setRegProcessing NOTIFY regProcessingChanged);
    Q_PROPERTY(bool authProcessing READ isAuthProcessing WRITE setAuthProcessing NOTIFY authProcessingChanged);
public:
    explicit AuthManager(QObject *parent = nullptr);
    Q_INVOKABLE void authentificate(const QString &login,
                        const QString &password);
    Q_INVOKABLE void registerer(const QString &login,
                        const QString &password);
    bool isRegProcessing();
    bool isAuthProcessing();
    void setRegProcessing(bool value);
    void setAuthProcessing(bool value);
signals:
    void regRequestCompleted(QString error);
    void authRequestCompleted(QString error, QString token);
    void regProcessingChanged(bool value);
    void authProcessingChanged(bool value);
private:
    QNetworkAccessManager _net;
    bool m_isRegProcessing;
    bool m_isAuthProcessing;
};
#endif // AUTHMANAGER_H
