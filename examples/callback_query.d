#!/usr/bin/env dub
/+ dub.json:
{
    "name": "callback_query_bot",
    "dependencies": {"telegram-d": {"path": ".."}},
}
+/

import telegram.api;
import std.stdio;
import std.conv;

///
// A simple bot that shows an inline keyboard with some buttons whenever someone talks to it
//

/**
 * Create the inline keyboard
 */
auto createKeyboard() {
    auto urlButton = InlineKeyboardButton();
    urlButton.url  =  "https://telegram.me";
    urlButton.text =  "Telegram site";

    auto cbButton = InlineKeyboardButton();
    cbButton.text = "callback";
    cbButton.callback_data = "some data";

    auto switchButton = InlineKeyboardButton();
    switchButton.text = "send to user..";
    switchButton.switch_inline_query = "Hi, I'm sending this through a  bot!";

    auto ikm = InlineKeyboardMarkup();
    ikm.inline_keyboard = 
    [ [urlButton],
      [cbButton, switchButton]
    ];
    return ikm;
}

void main(string[] args) {
    //boring / not relevant
    string apiToken = "";
    if (args.length != 2) {
       writeln("please pass your bot's API token as a command line argument");
       return;
    }
    apiToken = args[1]; //assumption: token is correct

    //set up the API in polling mode, using the default polling interval (5s)
    auto api = new TelegramApi(apiToken);

    while(true) {
        //Listen for updates. This method is blocking.
        auto updates = api.getUpdates();

        foreach(u ;updates) {
            //Not every Update provides a non-empty message field, so we have to check 
            //whether the message field contains text
            if(u.message.text.length > 0) {
                //Someone sent us a message!
                writeln(u.message.from.username ~ ": " ~u.message.text);

                //Let's reply by sending them an inline keyboard
                auto chatId = u.message.chat.id;
                auto reply = SendMessage!long(chatId);
                reply.text = "Here's a keyboard for you:";
                reply.reply_markup = createKeyboard();
                api.send(reply);
            } else if (u.callback_query.id.length > 0) {
                //Someone pressed a callback query button.. let's send a reply
                auto q = u.callback_query;
                writeln(q.from.username ~ " pressed a button with data: " ~ q.data);
                auto reply = SendMessage!long(q.message.chat.id);
                reply.text = "You pressed the callback button!";
                api.send(reply);
            }
        }
    }
}
