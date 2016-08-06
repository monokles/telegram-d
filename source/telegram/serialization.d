module telegram.serialization;

import telegram.types;

/**
 * A struct representing a serialization Policy, to handle the fact that
 * the edit* group of API methods have multiple return types (Message, and boolean)
 * 
 * This policy takes the boolean value and simply generates an empty Message struct.
 * Thus, when an edit has failed it can be seen by the fact that the returned Message all its init values.
 * In addition, Telegram will return with a HTTPStatus 400 anyway, and the "ok" boolean will be false.
 * So, it is actually much nicer to check if the ok field in the returned QueryResponse is true, 
 * as you should be doing anyway!
 *
 * See: https://core.telegram.org/bots/api#updating-messages
 */
struct MessagePol
{
    Message toRepresentation(Message m)
    {
        return m;
    }

    Message fromRepresentation(bool b)
    {
        return Message();
    }
}
