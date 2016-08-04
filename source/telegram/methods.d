/**
 *  This module contains all send types. 
 *
 *  These are the data structures that (in JSON form) can be sent to the Telegram servers, 
 *  and they represent the different methods exposed by the Telegram API.
 *
 *  See the parameters of each call described on the following page:
 *  https://core.telegram.org/bots/api#available-methods
 */
module telegram.methods;

public import telegram.types;

import vibe.data.serialization;

struct SendMessage(T)
{
    static assert(is(T == long) || is(T == string));
    enum callName = "sendMessage";
    alias retType = Message; 

    ///Unique identifier for the target chat or username of the target channel (in the format @channelusername)
    T chat_id;

    ///Text of the message to be sent
    string text;

    ///Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
    @optional string parse_mode;

    ///Disables link previews for links in this message
    @optional bool disable_web_page_preview;

    ///Sends the message silently. iOS users will not receive a notification, Android users will receive a notification with no sound.
    @optional bool disable_notification;

    ///If the message is a reply, ID of the original message
    @optional int reply_to_message_id;

    //@optional InlineKeyboardMarkup
    //InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardHide or ForceReply  Optional    Additional interface options. A JSON-serialized object for an inline keyboard, custom reply keyboard, instructions to hide reply keyboard or to force a reply from the user.

}

/**
 * A simple method for testing your bot's auth token. Requires no parameters.
 * Returns basic information about the bot in form of a User object.
 */
struct GetMe
{
    enum callName = "getMe";
    alias retType = User;
}

struct ForwardMessage(T)
{
    static assert(is(T == long) || is(T == string));
    enum callName = "forwardMessage";
    alias retType = Message;

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    T chat_id;

    ///Unique identifier for the chat where the original message was sent 
    //(or channel username in the format @channelusername)
    T from_chat_id;

    ///Sends the message silently. iOS users will not receive a notification, 
    //Android users will receive a notification with no sound.
    @optional bool disable_notification;

    ///Unique message identifier
    int message_id;
}


