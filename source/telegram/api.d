/**
 * telegram API module
 */
module telegram.api;

import std.stdio;
import std.string;
import std.datetime;

public import telegram.types.receive;
public import telegram.types.send;

import telegram.update.policy;
import telegram.update.polling;

import vibe.data.json;
import vibe.http.client;

/**
 * This class provides bindings for the telegram API
 */
class TelegramApi
{

    private:
        enum baseUrl = "https://api.telegram.org/bot%s/";

        string url;
        string apiKey;
        string botName;

        UpdatePolicy updater;


    public:

        /**
         * Create a TelegramApi instance with the long polling update policy.
         *
         * Params:
         *      apiKey          = Telegram API key for this bot
         *      pollInterval    = The interval in for update checks.
         *                        Has to be greater than or equal to 0.
         */
        this(string apiKey, Duration pollInterval = seconds(5))
            in{
                assert(pollInterval >= Duration.zero);
            }
        body {
            this.apiKey = apiKey;
            this.botName = botName;

            this.url = baseUrl.format(apiKey);
            auto updater = new PollingUpdatePolicy(url, pollInterval);
            this.updater = updater;
        }

        /**
         * Create a TelegramApi instance with the webHooks update policy.
         *
         * Params:
         *      apiKey      = Telegram API key for this bot
         *      bindAddr    = Network address on which to bind the webHook listener
         *      port        = TCP port to use for the webHook listener
         *      certPath    = Path to the SSL certificate to use for this bot
         */
        this(string apiKey, string bindAddr, ushort port, string certPath)
        {
            //TODO
        }


        /**
         * Retrieve new updates from the Telegram servers.
         * Blocks until new updates are received.
         * Returns: An array of Update structs containing all new updates.
         */
        Update[] getUpdates()
        {
            return updater.getUpdates();
        }

        /**
         * Sends the contents of sendStruct to the Telegram servers.
         *
         * Params:
         *      sendData  =   The struct to be sent. Has to be one of the structs
         *                      defined in telegram.types.send
         * Returns: a QueryResponse!Message, which contains either error information,
         * or a Message struct with representing the message you sent. 
         */
        QueryResponse!Message send(T)(T sendData)
        {
            QueryResponse!Message qr;
            requestHTTP(url ~ sendData.callName,
                    (scope req) {
                        req.method = HTTPMethod.POST;
                        req.writeJsonBody = sendData;
                    }, (scope res) {
                        qr = deserializeJson!(QueryResponse!Message)(res.readJson);
                    });
            return qr;
        }

}
