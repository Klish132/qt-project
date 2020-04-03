#include <QCoreApplication>

#include "AuthManager.h"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    AuthManager auth;

    auth.registerer("my_login", "my_password");

    auth.authentificate("my_login", "my_password");

    auth.registerer("my_login2", "my_password2");

    auth.authentificate("my_login2", "my_password2");

    return a.exec();
}
