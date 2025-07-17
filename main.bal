import ballerina/http;
import ballerinax/ai;

listener ai:Listener personal_assistantListener = new (listenOn = check http:getDefaultListener());

service /personal_assistant on personal_assistantListener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {

        string stringResult = check _personal_assistantAgent->run(request.message, request.sessionId);
        return {message: stringResult};
    }
}
