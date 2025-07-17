import ballerinax/ai;
import ballerinax/googleapis.gcalendar;
import ballerinax/googleapis.gmail;

final ai:OpenAiProvider _personal_assistantModel = check new (openAPIKey, ai:GPT_4O);
final ai:Agent _personal_assistantAgent = check new (
    systemPrompt = {
        role: "Personal AI Assistant",
        instructions: string `You are Nova, a smart AI assistant helping me stay organized and efficient.

Your primary responsibilities include:
- Calendar Management: Scheduling, updating, and retrieving events from the calendar as per the user's needs.
- Email Assistance: Reading, summarizing, composing, and sending emails while ensuring clarity and professionalism.
- Context Awareness: Maintaining a seamless understanding of ongoing tasks and conversations to 
  provide relevant responses.
- Privacy & Security: Handling user data responsibly, ensuring sensitive information is kept confidential,
  and confirming actions before executing them.

Guidelines:
- Respond in a natural, friendly, and professional tone.
- Always confirm before making changes to the user's calendar or sending emails.
- Provide concise summaries when retrieving information unless the user requests details.
- Prioritize clarity, efficiency, and user convenience in all tasks.`
    }, model = _personal_assistantModel, tools = [listUnreadEmails, readSpecificEmail, sendEmail, listCalendarEvents, createCalendarEvent]
);

# List unread emails in the inbox. 
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/ballerinax_googleapis.gmail_4.1.0.png"}
isolated function listUnreadEmails() returns gmail:ListMessagesResponse|error {
    gmail:ListMessagesResponse gmailListmessagesresponse = check gmailClient->/users/["me"]/messages.get(q = "is:unread");
    return gmailListmessagesresponse;
}

# Read a specific email. 
# + id - The ID of the message to retrieve. This ID is usually retrieved using 
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/ballerinax_googleapis.gmail_4.1.0.png"}
isolated function readSpecificEmail(string id) returns gmail:Message|error {
    gmail:Message gmailMessage = check gmailClient->/users/["me"]/messages/[id].get(format = "full");
    return gmailMessage;
}

# Send emails to a specified recipient. 
# + payload - The message to be sent. 
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/ballerinax_googleapis.gmail_4.1.0.png"}
isolated function sendEmail(gmail:MessageRequest payload) returns gmail:Message|error {
    gmail:Message gmailMessage = check gmailClient->/users/["me"]/messages/send.post(payload);
    return gmailMessage;
}

# List calendar events. 
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/ballerinax_googleapis.gcalendar_4.0.1.png"}
isolated function listCalendarEvents() returns gcalendar:Events|error {
    gcalendar:Events gcalendarEvents = check gcalendarClient->/calendars/["primary"]/events.get();
    return gcalendarEvents;
}

# Create events. 
# + payload - Data required to create an event 
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/ballerinax_googleapis.gcalendar_4.0.1.png"}
isolated function createCalendarEvent(gcalendar:Event payload) returns gcalendar:Event|error {
    gcalendar:Event gcalendarEvent = check gcalendarClient->/calendars/["primary"]/events.post(payload);
    return gcalendarEvent;
}
