#!/usr/bin/env dub
/+ dub.json:
{
    "name": "basic_bot",
    "dependencies": {"telegram-d": {"path": ".."}},
}
+/

import telegram.api;
import std.stdio;
import std.conv;

///
//A simple bot that obtains its own user name, then replies with a simple message to
// each message sent to it.
//
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

    //First, let's figure out what the name of this bot is.
    string me = "Unknown bot";

    auto r = api.send(GetMe());
    //Check that the request was succesful
    if(r.ok) {
        //From the bot API docs we know that getMe returns a User object, 
        //so result is of type User
        me = r.result.username;
    } else {
        writeln("ERROR: Something went wrong while calling GetMe!");
        writeln(r.error_code.to!string ~ ": " ~ r.description);
    }
    
    while(true) {

        //Listen for updates. This method is blocking.
        auto updates = api.getUpdates();

        foreach(u ;updates) {
            //Not every Update provides a non-empty message field, so we have to check 
            //whether the message field contains text
            if(u.message.text.length > 0) {
                //Someone sent us a message!
                writeln(u.message.from.username ~ ": " ~u.message.text);

                //Let's reply
                auto chatId = u.message.chat.id;
                auto reply = SendMessage!long(chatId);
                reply.text = "Hello " ~ u.message.from.username ~ ", " 
                    ~ "I am " ~ me ~ "!";
                auto response = api.send(reply);

            } else if (u.edited_message.text.length > 0) {
                //Someone edited a message..
                auto m = u.edited_message;
                writeln(m.from.username ~ ": (EDIT) " ~ m.text);
            }

            //Other possible fields in Update:
            //1. callback_query (covered in a different example)
            //2. inline_query (not implemented yet)
            //3. chosen_inline_result (not implemented yet)

        }
    }
}
