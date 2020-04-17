#include "AuthManager.h"

#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDebug>

AuthManager::AuthManager(QObject *parent) : QObject(parent)
{
    setAuthProcessing(false);
    setRegProcessing(false);
}

void AuthManager::authentificate(const QString &login, const QString &password)
{
    setAuthProcessing(true);
    QUrl url("http://127.0.0.1:59692/auth");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/json");
    QJsonObject body;
    body["login"] = login;
    body["password"] = password;
    QByteArray bodyData = QJsonDocument(body).toJson();
    QNetworkReply *reply = _net.post(request, bodyData);
    connect(reply, &QNetworkReply::finished,
            [this, reply](){
        QString errorMsg = reply->errorString();
        QJsonObject obj = QJsonDocument::fromJson(reply->readAll()).object();
        QString token = obj.value("token").toString();
        QString error = "";
        if (reply->error() != QNetworkReply::NoError)
            error = reply->errorString();
        emit authRequestCompleted(error, token);
        setAuthProcessing(false);
        reply->deleteLater();
    });
}

void AuthManager::registerer(const QString &login, const QString &password)
{
    setRegProcessing(true);
    QUrl url("http://127.0.0.1:59692/register");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/json");
    QJsonObject body;
    body["login"] = login;
    body["password"] = password;
    QByteArray bodyData = QJsonDocument(body).toJson();
    QNetworkReply *reply = _net.post(request, bodyData);
    connect(reply, &QNetworkReply::finished,
            [this, reply](){
        QString error = "";
        if (reply->error() != QNetworkReply::NoError)
            error = reply->errorString();
        emit regRequestCompleted(error);
        setRegProcessing(false);
        reply->deleteLater();
    });
}

bool AuthManager::isAuthProcessing()
{
    return m_isAuthProcessing;
}

bool AuthManager::isRegProcessing()
{
    return m_isRegProcessing;
}

void AuthManager::setAuthProcessing(bool value)
{
    if (m_isAuthProcessing == value)
        return;
    m_isAuthProcessing = value;
    emit authProcessingChanged(value);
}

void AuthManager::setRegProcessing(bool value)
{
    if (m_isRegProcessing == value)
        return;
    m_isRegProcessing = value;
    emit regProcessingChanged(value);
}
