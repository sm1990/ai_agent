import ballerinax/googleapis.gcalendar;
import ballerinax/googleapis.gmail;

final gmail:Client gmailClient = check new ({
    auth: {
        refreshToken: refreshToken,
        clientId: clientId,
        clientSecret: clientSecret
    }
});
final gcalendar:Client gcalendarClient = check new ({
    auth: {
        refreshToken: refreshToken,
        clientId: clientId,
        clientSecret: clientSecret
    }
});
