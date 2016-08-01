/**
 * This module contains all types returned by telegram as defined in https://core.telegram.org/bots/api#available-types
 *
 * The only exception to this is the FileInput type, as this is supposed to be binary data.
 */
module telegram.types;

import vibe.data.serialization;

/**
 * This object represents an audio file to be treated as music by the Telegram clients.
 */
struct Audio
{
    ///Unique identifier for this file
    string file_id;

    ///Duration of the audio in seconds as defined by sender
    int duration;

    ///Optional. Performer of the audio as defined by sender or by audio tags
    @optional string performer;

    ///Optional. Title of the audio as defined by sender or by audio tags
    @optional string title;

    ///Optional. MIME type of the file as defined by sender
    @optional string mime_type;

    ///Optional. File size
    @optional int file_size;
}

/**
 * This object represents an incoming callback query from a callback button in an inline keyboard.
 * If the button that originated the query was attached to a message sent by the bot,
 * the field message will be presented. 
 * If the button was attached to a message sent via the bot (in inline mode), 
 * the field inline_message_id will be presented.
 */
struct CallbackQuery
{
    ///Unique identifier for this query
    string id;

    ///Sender
    User from;

    ///Optional. Message with the callback button that originated the query. Note that message content and message date will not be available if the message is too old
    @optional Message message;

    ///Optional. Identifier of the message sent via the bot in inline mode, that originated the query
    @optional string inline_message_id;

    ///Data associated with the callback button. 
    //Be aware that a bad client can send arbitrary data in this field
    string data;
}

/**
 * This object represents a chat
 */
struct Chat
{
    ///Unique identifier for this chat
    long id;

    ///Type of chat, can be either `private`, `group`, `supergroup` or `channel`
    string type;

    ///Optional. Title, for channels and group chats
    @optional string title;

    ///Optional. Username, for private chats, supergroups and channels if available
    @optional string username;

    ///Optional. First name of the other party in a private chat
    @optional string first_name;

    ///Optional. Last name of the other party in a private chat
    @optional string last_name;
}
/**
 * This object contains information about one member of the chat.
 */
struct ChatMember
{
    ///Information about the user
    User user;

    ///The member's status in the chat. 
    //Can be “creator”, “administrator”, “member”, “left” or “kicked”
    string status; 
}

/**
 * This object represents a phone contact.
 */
struct Contact
{
    ///Contact's phone number
    string phone_number;

    ///Contact's first name
    string first_name;

    ///Optional. Contact's last name
    @optional string last_name;

    ///Optional. Contact's user identifier in Telegram
    @optional int user_id;
}

/**
 * This object represents a general file (as opposed to photos, voice messages and audio files).
 */
struct Document
{
    ///Unique file identifier
    string file_id;

    ///Optional. Document thumbnail as defined by sender
    @optional PhotoSize thumb;

    ///Optional. Original filename as defined by sender
    @optional string file_name;

    ///Optional. MIME type of the file as defined by sender
    @optional string mime_type;

    ///Optional. File size
    @optional int file_size;
}

/**
 * This object represents a file ready to be downloaded. 
 *
 * The file can be downloaded via the link https://api.telegram.org/file/bot<token>/<file_path>. It is guaranteed that the link will be valid for at least 1 hour. 
 * When the link expires, a new one can be requested by calling getFile.
 * Maximum file size to download is 20 MB
 */
struct File
{
    ///Unique identifier for this file
    string file_id;

    ///Optional. File size, if known
    @optional int file_size;

    ///Optional. File path. Use https://api.telegram.org/file/bot&lt;token&gt;/&lt;file_path&gt; to get the file.
    @optional string file_path;
}

/**
 * Upon receiving a message with this object, Telegram clients will display 
 * a reply interface to the user (act as if the user has selected the bot‘s message 
 * and tapped ’Reply'). 
 *
 * This can be extremely useful if you want to create user-friendly 
 * step-by-step interfaces without having to sacrifice privacy mode.
 */
struct ForceReply
{
    ///Shows reply interface to the user, as if they manually 
    //selected the bot‘s message and tapped ’Reply'
    bool force_reply;

    /**Optional. Use this parameter if you want to force reply from specific users only. 
     *
     * Targets: 
     * 1) users that are @mentioned in the text of the Message object; 
     * 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.
     */
    @optional bool selective;
}

/**
 * This object represents one button of an inline keyboard. 
 * You *must* use exactly one of the optional fields.
 *
 *  Note: 
 *  This will only work in Telegram versions released after 9 April, 2016. Older clients will display unsupported message.
 */
struct InlineKeyboardButton
{
    ///Label text on the button
    string text;

    ///Optional. HTTP url to be opened when button is pressed
    @optional string url;

    ///Optional. Data to be sent in a callback query to the bot when button is pressed, 1-64 bytes
    @optional string callback_data;

    /**Optional. If set, pressing the button will prompt the user to select one of their chats, 
     * open that chat and insert the bot‘s username and the specified inline query in the input field. 
     *
     * Can be empty, in which case just the bot’s username will be inserted.
     *
     * Note: This offers an easy way for users to start using your bot in inline mode when they are currently in a private chat with it. 
     * Especially useful when combined with switch_pm… actions:
     * in this case the user will be automatically returned to the chat they switched from, 
     * skipping the chat selection screen.
     */
    @optional string switch_inline_query;
}

/**
 * This object represents an inline keyboard that appears right next to the message it belongs to. 
 *
 * Note: 
 * This will only work in Telegram versions released after 9 April, 2016. Older clients will display unsupported message.
 */
struct InlineKeyboardMarkup
{
    ///Array of button rows, each represented by an Array of InlineKeyboardButton objects
    InlineKeyboardButton[][] inline_keyboard;
}

/**
 * This object represents one button of the reply keyboard. 
 * For simple text buttons String can be used instead of this object 
 * to specify text of the button. Optional fields are mutually exclusive.
 *
 * Note: 
 * request_contact and request_location options will only work in Telegram versions released after 9 April, 2016. Older clients will ignore them.
 */
struct KeyboardButton
{
    ///Text of the button. If none of the optional fields are used, it will be sent to the bot as a message when the button is pressed
    string text;

    ///Optional. If True, the user's phone number will be sent as a contact when the button is pressed. Available in private chats only
    @optional bool request_contact;

    ///Optional. If True, the user's current location will be sent when the button is pressed. Available in private chats only
    @optional bool request_location;
}

/**
 * This object represents a point on the map.
 */
struct Location
{
    ///Longitude as defined by sender
    float longitude;

    ///Latitude as defined by sender
    float latitude;
}


/**
 * This object represents a message.
 */
struct Message
{
    ///Unique message identifier
    int message_id;

    ///Optional. Sender, can be empty for messages sent to channels
    @optional User from;

    ///Date the message was sent in Unix time
    long date;

    ///Conversation the message belongs to
    Chat chat;

    ///Optional. For forwarded messages, sender of the original message
    @optional User forward_from;

    ///Optional. For messages forwarded from a channel, information about the original channel
    @optional Chat forward_from_chat;

    ///Optional. For forwarded messages, date the original message was sent in Unix time
    @optional int forward_date;

    ///Optional. For replies, the original message. 
    //Note that the Message object in this field will not contain 
    //further reply_to_message fields even if it itself is a reply.
    @optional Message* reply_to_message;

    ///Optional. Date the message was last edited in Unix time
    @optional int edit_date;

    ///Optional. For text messages, the actual UTF-8 text of the message, 0-4096 characters.
    @optional string text;

    ///Optional. For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text
    @optional MessageEntity[] entities;

    ///Optional. Message is an audio file, information about the file
    @optional Audio audio;

    ///Optional. Message is a general file, information about the file
    @optional Document document;

    ///Optional. Message is a photo, available sizes of the photo
    @optional PhotoSize[] photo;

    ///Optional. Message is a sticker, information about the sticker
    @optional Sticker sticker;

    ///Optional. Message is a video, information about the video
    @optional Video video;

    ///Optional. Message is a voice message, information about the file
    @optional Voice voice;

    ///Optional. Caption for the document, photo or video, 0-200 characters
    @optional string caption;

    ///Optional. Message is a shared contact, information about the contact
    @optional Contact contact;

    ///Optional. Message is a shared location, information about the location
    @optional Location location;

    ///Optional. Message is a venue, information about the venue
    @optional Venue venue;

    ///Optional. A new member was added to the group, information about them (this member may be the bot itself)
    @optional User new_chat_member;

    ///Optional. A member was removed from the group, information about them (this member may be the bot itself)
    @optional User left_chat_member;

    ///Optional. A chat title was changed to this value
    @optional string new_chat_title;

    ///Optional. A chat photo was change to this value
    @optional PhotoSize[] new_chat_photo;

    ///Optional. Service message: the chat photo was deleted
    @optional bool delete_chat_photo;

    ///Optional. Service message: the group has been created
    @optional bool group_chat_created;

    ///Optional. Service message: the supergroup has been created. 
    //This field can‘t be received in a message coming through updates, because bot can’t be a member of a supergroup when it is created. 
    //It can only be found in reply_to_message if someone replies to a very first message in a directly created supergroup.
    @optional bool supergroup_chat_created;

    ///Optional. Service message: the channel has been created. This field can‘t be received in a message coming through updates, because bot can’t be a member of a channel when it is created. It can only be found in reply_to_message if someone replies to a very first message in a channel.
    @optional bool channel_chat_created;

    ///Optional. The group has been migrated to a supergroup with the specified identifier. 
    @optional long migrate_to_chat_id; 

    ///Optional. The supergroup has been migrated from a group with the specified identifier.
    @optional long migrate_from_chat_id;

    ///Optional. Specified message was pinned. Note that the Message object in this field will not contain further reply_to_message fields even if it is itself a reply.
    @optional Message* pinned_message;
}

/**
 * This object represents one special entity in a text message. 
 * For example, hashtags, usernames, URLs, etc.
 */
struct MessageEntity
{
    ///Type of the entity. Can be mention (@username), hashtag, 
    //bot_command, url, email, bold (bold text), italic (italic text), 
    //code (monowidth string), pre (monowidth block), text_link (for clickable text URLs), text_mention (for users without usernames)
    string type;

    ///Offset in UTF-16 code units to the start of the entity
    int offset;

    ///Length of the entity in UTF-16 code units
    int length;

    ///Optional. For “text_link” only, url that will be opened after user taps on the text
    @optional string url;

    ///Optional. For “text_mention” only, the mentioned user
    @optional User user;
}

/**
 * This object represents one size of a photo or a file / sticker thumbnail.
 */
struct PhotoSize
{

    ///Unique identifier for this file
    string file_id;

    ///Photo width
    int width;

    ///Photo height
    int height;

    ///Optional. File size
    @optional int file_size;
}

/**
 * Upon receiving a message with this object, Telegram clients will hide 
 * the current custom keyboard and display the default letter-keyboard. 
 *
 * By default, custom keyboards are displayed until a new keyboard is sent by a bot. 
 * An exception is made for one-time keyboards that are hidden immediately 
 * after the user presses a button (see ReplyKeyboardMarkup).
 */
struct ReplyKeyboardHide
{
    ///Requests clients to hide the custom keyboard
    bool hide_keyboard;


    /**Optional. Use this parameter if you want to hide keyboard for specific users only.  
     *
     * Targets: 
     * 1) users that are @mentioned in the text of the Message object; 
     * 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.
     *
     * Example: A user votes in a poll, bot returns confirmation message in reply to the vote 
     * and hides keyboard for that user, while still showing the keyboard with poll options to users 
     * who haven't voted yet.
     */
    @optional bool selective;
}

/**
 * This object represents a custom keyboard with reply options (see Introduction to bots for details and examples).
 */
struct ReplyKeyboardMarkup
{
    ///Array of button rows, each represented by an Array of KeyboardButton objects
    KeyboardButton[][] keyboard;

    ///Optional. Requests clients to resize the keyboard vertically for optimal fit (e.g., make the keyboard smaller if there are just two rows of buttons). Defaults to false, in which case the custom keyboard is always of the same height as the app's standard keyboard.
    @optional bool resize_keyboard;


    ///Optional. Requests clients to hide the keyboard as soon as it's been used. The keyboard will still be available, but clients will automatically display the usual letter-keyboard in the chat – the user can press a special button in the input field to see the custom keyboard again. Defaults to false.
    @optional bool one_time_keyboard;


    ///Optional. Use this parameter if you want to show the keyboard to specific users only. Targets: 1) users that are @mentioned in the text of the Message object; 2) if the bot's message is a reply (has reply_to_message_id), sender of the original message.Example: A user requests to change the bot‘s language, bot replies to the request with a keyboard to select the new language. Other users in the group don’t see the keyboard.
    @optional bool selective;
}

/**
 * This object represents a sticker.
 */
struct Sticker
{
    ///Unique identifier for this file
    string file_id;

    ///Sticker width
    int width;

    ///Sticker height
    int height;

    ///Optional. Sticker thumbnail in .webp or .jpg format
    @optional PhotoSize thumb;

    ///Optional. Emoji associated with the sticker
    @optional string emoji;

    ///Optional. File size
    @optional int file_size;
}

/**
 * This object represents a Telegram bot or user
 */
struct User
{
    ///Unique identifier for this user or bot
    int id;

    ///User‘s or bot’s first name
    string  first_name;

    ///Optional. User‘s or bot’s last name
    @optional string  last_name;

    ///Optional. User‘s or bot’s username
    @optional string  username;
}

/**
 * This object represent a user's profile pictures.
 */
struct UserProfilePhotos
{
    ///Total number of profile pictures the target user has
    int total_count;

    ///Requested profile pictures (in up to 4 sizes each)
    PhotoSize[][] photos;
}

/**
 * This object represents a venue.
 */
struct Venue
{
    ///Venue location
    Location location;

    ///Name of the venue
    string title;

    ///Address of the venue
    string address;

    ///Optional. Foursquare identifier of the venue
    @optional string foursquare_id;
}

/**
 * This object represents a video file.
 */
struct Video
{
    ///Unique identifier for this file
    string file_id;

    ///Video width as defined by sender
    int width;

    ///Video height as defined by sender
    int height;

    ///Duration of the video in seconds as defined by sender
    int duration;

    ///Optional. Video thumbnail
    @optional PhotoSize thumb;

    ///Optional. Mime type of a file as defined by sender
    @optional string mime_type;

    ///Optional. File size
    @optional int file_size;
}

/**
 * This object represents a voice note.
 */
struct Voice
{
    ///Unique identifier for this file
    string file_id;

    ///Duration of the audio in seconds as defined by sender
    int duration;

    ///Optional. MIME type of the file as defined by sender
    @optional string mime_type;

    ///Optional. File size
    @optional int file_size;
}
