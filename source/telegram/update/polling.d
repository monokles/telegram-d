/**
 * Module that contains the TelegramD PollingUpdatePolicy class
 */
module telegram.update.polling;

import std.stdio;
import std.datetime;
import core.thread;

import vibe.http.client;
import vibe.data.json;

import telegram.update.policy;
import telegram.types;

class PollingUpdatePolicy : UpdatePolicy
{
    private:
        enum callName = "getUpdates";
        string callUrl;
        Duration updateInterval;
        Thread listener;
        void delegate(scope Update[]) updateCB;
        bool stopping;
        int offset;


        Update[] parseUpdateResponse(Json json)
        {
            try
            {

                auto qr = deserializeJson!(QueryResponse!(Update[]))(json);
                if(qr.ok && qr.result.length > 0)
                {
                    return qr.result;
                } else {
                    return null;
                }
                
            }
            catch(Exception e)
            {
                writeln("[parseUpdateResponse] Exception:\n" ~ e.msg);
                writeln("[parseUpdateResponse] JSON:\n" ~ json.toString);
            }

            assert(0);
        }

        void checkUpdate()
        {
            do
            {
                try
                {
                    requestHTTP(callUrl, 
                            (scope req) {
                                req.method = HTTPMethod.POST;
                                req.writeJsonBody(["offset": offset]);
                            },
                            (scope res) {
                                if(res.statusCode == 200){
                                    auto upds = parseUpdateResponse(res.readJson);
                                    if(upds)
                                    {
                                        offset = upds[$-1].update_id + 1;
                                        updateCB(upds);
                                    }
                                }
                            });
                }
                catch(Exception e)
                {
                    writeln("[PollingUpdatePolicy] Exception:\n" ~ e.msg);
                }

                Thread.sleep(updateInterval);
            } while(!stopping);
            
        }

    public:
        this(string baseUrl, int updateInterval)
        {
            this.callUrl = baseUrl ~ callName;
            this.updateInterval = seconds(updateInterval);
        }

        /**
         * Start listening for updates.
         *
         * Params:
         *      onUpdate = delegate function to deal with all incoming Update objects
         */
        void startListening(void delegate(scope Update[]) onUpdate)
        {
            updateCB = onUpdate;
            stopping = false;

            listener = new Thread(&checkUpdate);
            listener.start();
        }

        /**
         * Stop listening for updates
         */
        void stopListening()
        {
            stopping = true;
        }
    
}
