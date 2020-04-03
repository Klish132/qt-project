#include "AuthManager.h"

#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrl>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDebug>

AuthManager::AuthManager(QObject *parent) : QObject(parent)
{

}

QString AuthManager::getToken() {
    return this->token;
}
void AuthManager::resetState() {
    this->token = "";
    this->authError = "";
    this->registerError = "";
}

void AuthManager::authentificate(const QString &login, const QString &password)
{
    resetState();
    QUrl url("http://127.0.0.1:58721/auth");

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
        this->token = obj.value("token").toString();
        emit authRequestCompleted(reply->errorString(), this->token);
        reply->deleteLater();

    });

}

void AuthManager::registerer(const QString &login, const QString &password)
{
    resetState();
    QUrl url("http://127.0.0.1:58721/register");

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
        emit regRequestCompleted(reply->errorString());
        reply->deleteLater();
    });
}





