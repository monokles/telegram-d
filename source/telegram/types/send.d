/**
 *  This module contains all send types. 
 *
 *  These are the data structures that (in JSON form) can be sent to the Telegram servers, 
 *  and they represent the different methods exposed by the Telegram API.
 *
 *  See the parameters of each call described on the following page:
 *  https://core.telegram.org/bots/api#available-methods
 */
module telegram.types.send;

public import telegram.types.receive;

import vibe.data.serialization;

struct sendMessage(T)
{
    static assert(is(T == long) || is(T == string));
    enum callName = "sendMessage";

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



