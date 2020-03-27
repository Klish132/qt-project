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

void AuthManager::authentificate(const QString &login, const QString &password)
{
    QUrl url("http://127.0.0.1:53552/auth");

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
        if (reply->error() != QNetworkReply::NoError) {
            this->authError = reply->errorString();
        } else {
            QJsonObject obj = QJsonDocument::fromJson(reply->readAll()).object();
            QString token = obj.value("token").toString();
            this->token = token;
        }
        this->onAuthFinished();
        reply->deleteLater();

    });

}

void AuthManager::onAuthFinished()
{
    qDebug() << "Auth error: " << this->authError;
    qDebug() << "Token: " << this->getToken();
    emit regRequestCompleted(this->authError);
}

QString AuthManager::getToken() {
    return this->token;
}

void AuthManager::registerer(const QString &login, const QString &password)
{
    QUrl url("http://127.0.0.1:53552/register");

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
        if (reply->error() != QNetworkReply::NoError) {
            this->registerError = reply->errorString();
        }
        this->onRegFinished();
        reply->deleteLater();

    });
}

void AuthManager::onRegFinished()
{
    qDebug() << "Register error: " << this->registerError;
    emit regRequestCompleted(this->registerError);
}





