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


    public:
        this(string baseUrl, Duration updateInterval)
        {
            this.callUrl = baseUrl ~ callName;
            this.updateInterval = updateInterval;
        }

        /**
         * Request new updates
         * Returns: An array of Updates since you last checked
         */
        Update[] getUpdates()
        {
            Update[] updates = null;
            try
            {
                while(!updates)
                {
                    //This is synchronous
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
                                    updates = upds;
                                }
                            }
                            });
                    
                    Thread.sleep(updateInterval);
                }
            }
            catch(Exception e)
            {
                writeln("[PollingUpdatePolicy] Exception:\n" ~ e.msg);
            }

            return updates;
        }
}
