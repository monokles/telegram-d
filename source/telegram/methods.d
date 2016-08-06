/**
 *  This module contains all telegram methods as structs.
 *
 *  These are the data structures that (in JSON form) can be sent to the Telegram servers, 
 *  and they represent the different methods exposed by the Telegram API.
 *
 *  each method has an enum `callName` referring to the actual name of the Telegram method,
 *  as well as an alias `retType` referring to the type returned as `result` property in the 
 *  QueryResponse object received as response from the Telegram servers.
 *
 *  See the parameters of each call described on the following page:
 *  https://core.telegram.org/bots/api#available-methods
 */
module telegram.methods;

public import telegram.types;

import vibe.data.serialization;

private bool isReplyMarkup(T)()
{ 
    return is(T == InlineKeyboardMarkup) 
        || is(T == ReplyKeyboardMarkup) 
        || is(T == ReplyKeyboardHide) 
        || is(T == ForceReply);
}

private bool isChatId(T)()
{
    return is(T == long) || is(T == string);
}

struct SendMessage(T = long, KBM = InlineKeyboardMarkup)
{
    static assert(isChatId!T);
    static assert(isReplyMarkup!KBM);

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

    ///InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardHide or ForceReply
    //Additional interface options. 
    //A JSON-serialized object for an inline keyboard, custom reply keyboard, 
    //instructions to hide reply keyboard or to force a reply from the user.
    @optional  KBM reply_markup;
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

/**
 * Use this method to forward messages of any kind. On success, the sent Message is returned.
 */
struct ForwardMessage(T = long)
{
    static assert(isChatId!T);

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

/**
 * Use this method to send photos. On success, the sent Message is returned.
 */
struct SendPhoto(ChatId = long, PhotoType = InputType, KBM = InlineKeyboardMarkup)
{
    static assert(isChatId!ChatId);
    static assert(is(PhotoType == InputFile) || is(PhotoType == string));
    static assert(isReplyMarkup!KBM);

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;

    ///Photo to send. You can either pass a file_id as String to resend a photo 
    //that is already on the Telegram servers, or upload a new photo by passing an InputType
    PhotoType photo;

    ///Photo caption (may also be used when resending photos by file_id), 0-200 characters
    @optional string caption;

    ///Sends the message silently. iOS users will not receive a notification, 
    //Android users will receive a notification with no sound.
    @optional bool disable_notification;

    ///If the message is a reply, ID of the original message
    @optional int reply_to_message_id;

    ///InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardHide or ForceReply
    //Additional interface options. 
    //A JSON-serialized object for an inline keyboard, custom reply keyboard, 
    //instructions to hide reply keyboard or to force a reply from the user.
    @optional  KBM reply_markup;
}

/**
 * Use this method to send audio files, if you want Telegram clients to display them 
 * in the music player. 
 *
 * Your audio must be in the .mp3 format. On success, the sent Message is returned. 
 * For sending voice messages, use the sendVoice method instead.
 *
 * Note:
 * Bots can currently send audio files of up to 50 MB in size, 
 * this limit may be changed in the future.
 */
struct SendAudio(ChatId = long, AudioType = InputFile, KBM = InlineKeyboardMarkup)
{
    static assert(isChatId!ChatId);
    static assert(is(AudioType == InputFile) || is(AudioType == string));
    static assert(isReplyMarkup!KBM);

    enum callName = "sendAudio";
    alias retType = Message;

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;

    ///Audio file to send. You can either pass a file_id as String to resend 
    //an audio that is already on the Telegram servers, 
    //or upload a new audio file as InputFile.
    AudioType audio;

    ///Duration of the audio in seconds
    @optional int duration;

    ///Performer
    @optional string performer;

    ///Track name
    @optional string title;

    ///Sends the message silently. iOS users will not receive a notification,
    //Android users will receive a notification with no sound.
    @optional bool disable_notification;

    ///If the message is a reply, ID of the original message
    @optional int reply_to_message_id;

    ///Additional interface options. A JSON-serialized object for 
    //an inline keyboard, custom reply keyboard, instructions to hide reply keyboard 
    //or to force a reply from the user.
    @optional KBM reply_markup;
}

/**
 * Use this method to send general files. On success, the sent Message is returned. 
 *
 * Note:
 * Bots can currently send files of any type of up to 50 MB in size, 
 * this limit may be changed in the future.
 */
struct SendDocument(ChatId = long, DocType = InputFile, KBM = InlineKeyboardMarkup)
{
    static assert(isChatId!ChatId);
    static assert(is(DocType == InputFile) || is(DocType == string));
    static assert(isReplyMarkup!KBM);

    enum callName = "sendDocument";
    alias retType = Message;
    
    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;

    ///File to send. You can either pass a file_id as String to resend a file 
    //that is already on the Telegram servers, 
    //or upload a new file as InputFile.
    DocType document;

    ///Document caption (may also be used when resending documents by file_id), 
    //0-200 characters
    @optional string caption;

    ///Sends the message silently. iOS users will not receive a notification, 
    //Android users will receive a notification with no sound.
    @optional string disable_notification;

    ///If the message is a reply, ID of the original message
    @optional int reply_to_message_id;

    ///Additional interface options. A JSON-serialized object for an inline keyboard, 
    //custom reply keyboard, instructions to hide reply keyboard 
    //or to force a reply from the user.
    @optional KBM reply_markup;
}

/**
 * Use this method to send .webp stickers. On success, the sent Message is returned.
 */
struct SendSticker(ChatId = long, StickType = InputFile, KBM = InlineKeyboardMarkup)
{
    static assert(isChatId!ChatId);
    static assert(is(StickType == InputFile) || is(StickType == string));
    static assert(isReplyMarkup!KBM);

    enum callName = "sendSticker";
    alias retType = Message;
    
    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;

    ///Sticker to send. You can either pass a file_id as String to resend a sticker 
    //that is already on the Telegram servers, 
    //or upload a new sticker as InputFile.
    StickType document;

    ///Sends the message silently. iOS users will not receive a notification, 
    //Android users will receive a notification with no sound.
    @optional string disable_notification;

    ///If the message is a reply, ID of the original message
    @optional int reply_to_message_id;

    ///Additional interface options. A JSON-serialized object for an inline keyboard, 
    //custom reply keyboard, instructions to hide reply keyboard 
    //or to force a reply from the user.
    @optional KBM reply_markup;
    
}

/**
 * Use this method to send video files, 
 *
 * Telegram clients support mp4 videos (other formats may be sent as Document). 
 * On success, the sent Message is returned. 
 *
 * Note: Bots can currently send video files of up to 50 MB in size, 
 * this limit may be changed in the future.
 */
struct SendVideo(ChatId = long, VidType = InputFile, KBM = InlineKeyboardMarkup)
{
    static assert(isChatId!ChatId);
    static assert(is(VidType == InputFile) || is(VidType == string));
    static assert(isReplyMarkup!KBM);

    enum callName = "sendVideo";
    alias retType = Message;

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;

    ///Video to send. You can either pass a file_id as String to resend a video 
    //that is already on the Telegram servers, 
    //or upload a new video file as InputFile.
    VidType video;

    ///Duration of sent video in seconds
    @optional int duration;

    ///Video width
    @optional int width;

    ///Video height
    @optional int height;

    ///Video caption (may also be used when resending videos by file_id)
    //0-200 characters
    @optional string caption;

    ///Sends the message silently. iOS users will not receive a notification, 
    //Android users will receive a notification with no sound.
    @optional bool disable_notification;

    ///If the message is a reply, ID of the original message
    @optional int reply_to_message_id;

    ///Additional interface options. A JSON-serialized object for an inline keyboard, 
    //custom reply keyboard, instructions to hide reply keyboard 
    //or to force a reply from the user.
    @optional KBM reply_markup;
}

/**
 * Use this method to send audio files, if you want Telegram clients 
 * to display the file as a playable voice message. 
 *
 * For this to work, your audio must be in an .ogg file encoded with OPUS 
 * (other formats may be sent as Audio or Document). 
 * On success, the sent Message is returned. 
 *
 * Note: Bots can currently send voice messages of up to 50 MB in size, 
 * this limit may be changed in the future.
 */
struct  SendVoice(ChatId = long, VoiceType = InputFile, KBM = InlineKeyboardMarkup)
{
    static assert(isChatId!ChatId);
    static assert(is(VoiceType == InputFile) || is(VoiceType == string));
    static assert(isReplyMarkup!KBM);

    enum callName = "sendVoice";
    alias retType = Message;

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;

    ///Audio file to send. You can either pass a file_id as String to resend a audio 
    //that is already on the Telegram servers, 
    //or upload a new video file as InputFile.
    VoiceType  voice;

    ///Duration of sent audio in seconds
    @optional int duration;

    ///Sends the message silently. iOS users will not receive a notification, 
    //Android users will receive a notification with no sound.
    @optional bool disable_notification;

    ///If the message is a reply, ID of the original message
    @optional int reply_to_message_id;

    ///Additional interface options. A JSON-serialized object for an inline keyboard, 
    //custom reply keyboard, instructions to hide reply keyboard 
    //or to force a reply from the user.
    @optional KBM reply_markup;
}

/**
 * Use this method to send point on the map. 
 *
 * On success, the sent Message is returned.
 */
struct SendLocation(ChatId = long, KBM = InlineKeyboardMarkup)
{
    static assert(isChatId!ChatId);
    static assert(isReplyMarkup!KBM);

    enum callName = "sendLocation";
    alias retType = Message;

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;

    ///Latitude of location
    float latitude;

    ///Longitude of location
    float longtitude;

    ///Sends the message silently. iOS users will not receive a notification, 
    //Android users will receive a notification with no sound.
    @optional bool disable_notification;

    ///If the message is a reply, ID of the original message
    @optional int reply_to_message_id;

    ///Additional interface options. A JSON-serialized object for an inline keyboard, 
    //custom reply keyboard, instructions to hide reply keyboard 
    //or to force a reply from the user.
    @optional KBM reply_markup;
}

/**
 * Use this method to send information about a venue. 
 *
 * On success, the sent Message is returned.
 */
struct SendVenue(ChatId = long, KBM = InlineKeyboardMarkup)
{
    static assert(isChatId!ChatId);
    static assert(isReplyMarkup!KBM);

    enum callName = "sendVenue";
    alias retType = Message;

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;

    ///Latitude of the venue
    float latitude;

    ///Longitude of the venue
    float longtitude;

    ///Name of the venue
    string title;

    ///Address of the venue
    string address;

    ///Foursquare identifier of the venue
    @optional string foursquare_id;

    ///Sends the message silently. iOS users will not receive a notification, 
    //Android users will receive a notification with no sound.
    @optional bool disable_notification;

    ///If the message is a reply, ID of the original message
    @optional int reply_to_message_id;

    ///Additional interface options. A JSON-serialized object for an inline keyboard, 
    //custom reply keyboard, instructions to hide reply keyboard 
    //or to force a reply from the user.
    @optional KBM reply_markup;
}

/**
 * Use this method to send phone contacts. 
 *
 * On success, the sent Message is returned.
 */
struct SendContact(ChatId = long, KBM = InlineKeyboardMarkup)
{
    static assert(isChatId!ChatId);
    static assert(isReplyMarkup!KBM);

    enum callName = "sendContact";
    alias retType = Message;

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;

    ///Contact's phone number
    string phone_number;

    ///Contact's first name
    string first_name;

    ///Contact's last name
    @optional string last_name;

    ///Sends the message silently. iOS users will not receive a notification, 
    //Android users will receive a notification with no sound.
    @optional bool disable_notification;

    ///If the message is a reply, ID of the original message
    @optional int reply_to_message_id;

    ///Additional interface options. A JSON-serialized object for an inline keyboard, 
    //custom reply keyboard, instructions to hide reply keyboard 
    //or to force a reply from the user.
    @optional KBM reply_markup;
}

/**
 * Use this method when you need to tell the user that something is happening on the bot's side. 
 *
 * The status is set for 5 seconds or less (when a message arrives from your bot, 
 * Telegram clients clear its typing status). 
 * On success, the sent Message is returned.
 *
 * Note: We only recommend using this method when a response from the bot 
 * will take a noticeable amount of time to arrive.
 */
struct SendChatAction(ChatId = long)
{
    static assert(isChatId!ChatId);

    enum callName = "sendChatAction";
    alias retType = Message; //TODO figure out retType

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;

    //TODO this as enum maybe?
    ///Type of action to broadcast. 
    //Choose one, depending on what the user is about to receive: 
    //  typing for text messages, 
    //  upload_photo for photos, 
    //  record_video or upload_video for videos, 
    //  record_audio or upload_audio for audio files, 
    //  upload_document for general files, 
    //  find_location for location data.
    string action;
}

/**
 * Use this method to get a list of profile pictures for a user. 
 *
 * Returns a UserProfilePhotos object.
 */
struct GetUserProfilePhotos
{
    enum callName = "getUserProfilePhotos";
    alias retType = UserProfilePhotos;

    ///Unique identifier of the target user
    int user_id;

    ///Sequential number of the first photo to be returned. 
    //By default, all photos are returned.
    @optional int offset;

    ///Limits the number of photos to be retrieved. 
    //Values between 1—100 are accepted. Defaults to 100.
    @optional int limit;
}

/**
 * Use this method to get basic info about a file and prepare it for downloading. 
 *
 * On success, a File object is returned. 
 * The file can then be downloaded via the link `https://api.telegram.org/file/bot<token>/<file_path>`, where <file_path> is taken from the response. 
 *
 * It is guaranteed that the link will be valid for at least 1 hour. 
 * When the link expires, a new one can be requested by calling getFile again.
 *
 * Note: For the moment, bots can download files of up to 20MB in size. 
 *
 * Note: This function may not preserve original file name. 
 * Mime type of the file and its name (if available) should be saved 
 * when the File object is received.
 */
//TODO create prettier interface for this
struct GetFile
{
    enum callName = "getFile";
    alias retType = File;

    ///File identifier to get info about
    string file_id;
}

/**
 * Use this method to kick a user from a group or a supergroup. 
 *
 * In the case of supergroups, the user will not be able to return to the group 
 * on their own using invite links, etc., unless unbanned first. 
 *
 * Returns true on success
 *
 * Note: The bot must be an administrator in the group for this to work. 
 */
struct KickChatMember(ChatId = long)
{
    static assert(isChatId!ChatId);

    enum callName = "kickChatMember";
    alias retType = bool;

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;

    ///Unique identifier of the target user
    int user_id;
}


/**
 * Use this method for your bot to leave a group, supergroup or channel. 
 *
 * Returns True on success.
 */
struct LeaveChat(ChatId = long)
{
    static assert(isChatId!ChatId);

    enum callName = "leaveChat";
    alias retType = bool;

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;
}


/**
 * Use this method to unban a previously kicked user in a supergroup. 
 *
 * The user will not return to the group automatically, 
 * but will be able to join via link, etc. 
 * Returns True on success.
 *
 * Note:The bot must be an administrator in the group for this to work. 
 */
struct UnbanChatMember(ChatId = long)
{
    static assert(isChatId!ChatId);

    enum callName = "unbanChatMember";
    alias retType = bool;

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;

    ///Unique identifier of the target user
    int user_id;
}

/**
 * Use this method to get up to date information about the chat 
 * (current name of the user for one-on-one conversations, 
 * current username of a user, group or channel, etc.). 
 *
 * Returns a Chat object on success.
 */
struct GetChat(ChatId = long)
{
    static assert(isChatId!ChatId);

    enum callName = "getChat";
    alias retType = Chat;

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;
}

/**
 * Use this method to get a list of administrators in a chat. 
 *
 * On success, returns an Array of ChatMember objects that 
 * contains information about all chat administrators except other bots. 
 * If the chat is a group or a supergroup and no administrators were appointed, 
 * only the creator will be returned.
 */
struct GetChatAdministrators(ChatId = long)
{
    static assert(isChatId!ChatId);

    enum callName = "getChatAdministrators";
    alias retType = ChatMember[];

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;
}

/**
 * Use this method to get the number of members in a chat. 
 *
 * Returns Int on success.
 */
struct GetChatMembersCount(ChatId = long)
{
    static assert(isChatId!ChatId);

    enum callName = "getChatMembersCount";
    alias retType = int;

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;
}

/**
 * Use this method to get information about a member of a chat. 
 *
 * Returns a ChatMember object on success.
 */
struct GetChatMember(ChatId = long)
{
    static assert(isChatId!ChatId);

    enum callName = "getChatMember";
    alias retType = ChatMember;

    ///Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    ChatId chat_id;

    ///Unique identifier of the target user
    int user_id;
}

/**
 * Use this method to send answers to callback queries sent from inline keyboards. 
 *
 * The answer will be displayed to the user as a notification 
 * at the top of the chat screen or as an alert. 
 * On success, True is returned.
 */
struct AnswerCallbackQuery
{
    enum callName = "answerCallbackQuery";
    alias retType = bool;

    ///Unique identifier for the query to be answered
    string callback_query_id;

    ///Text of the notification. If not specified, nothing will be shown to the user
    string text;

    ///If true, an alert will be shown by the client instead of a notification 
    //at the top of the chat screen. Defaults to false.
    @optional bool show_alert;
}


/**
 * Use this method to edit text messages sent by the bot or via the bot (for inline bots). 
 * On success, if edited message is sent by the bot, the edited Message is returned, 
 * otherwise True is returned.
 */
//TODO  function works, but return is not parsed correctly
struct EditMessageText(ChatId = long)
{
    static assert(isChatId!ChatId);
    enum callName = "editMessageText";
    alias retType = Message;

    ///Required if inline_message_id is not specified. 
    //Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    @optional ChatId chat_id;

    ///Required if inline_message_id is not specified. 
    //Unique identifier of the sent message
    @optional int message_id;

    ///Required if chat_id and message_id are not specified. 
    //Identifier of the inline message
    @optional string inline_message_id;

    ///New text of the message
    string text;

    ///Send Markdown or HTML, if you want Telegram apps to show bold, italic, 
    //fixed-width text or inline URLs in your bot's message.
    @optional string parse_mode;

    ///Disables link previews for links in this message
    @optional bool disable_web_page_preview;

    ///A JSON-serialized object for an inline keyboard.
    @optional InlineKeyboardMarkup reply_markup;
}

/**
 * Use this method to edit captions of messages sent by the bot 
 * or via the bot (for inline bots). On success, if edited message is 
 * sent by the bot, the edited Message is returned, otherwise True is returned.
 */
//TODO function works, but return is not parsed correctly
struct EditMessageCaption(ChatId = long)
{
    static assert(isChatId!ChatId);
    enum callName = "editMessageCaption";
    alias retType = Message;

    ///Required if inline_message_id is not specified. 
    //Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    @optional ChatId chat_id;

    ///Required if inline_message_id is not specified. 
    //Unique identifier of the sent message
    @optional int message_id;

    ///Required if chat_id and message_id are not specified. 
    //Identifier of the inline message
    @optional string inline_message_id;

    ///New text of the message
    @optional string caption;

    ///A JSON-serialized object for an inline keyboard.
    @optional InlineKeyboardMarkup reply_markup;
}

//TODO function works, but return is not parsed correctly
struct EditMessageReplyMarkup(ChatId = long)
{
    static assert(isChatId!ChatId);
    enum callName = "editReplyMarkup";
    alias retType = Message;

    ///Required if inline_message_id is not specified. 
    //Unique identifier for the target chat or username of the target channel 
    //(in the format @channelusername)
    @optional ChatId chat_id;

    ///Required if inline_message_id is not specified. 
    //Unique identifier of the sent message
    @optional int message_id;

    ///Required if chat_id and message_id are not specified. 
    //Identifier of the inline message
    @optional string inline_message_id;

    ///A JSON-serialized object for an inline keyboard.
    @optional InlineKeyboardMarkup reply_markup;
}
