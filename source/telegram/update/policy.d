/**
 * This module contains the TelegramD UpdatePolicy interface
 */
module telegram.update.policy;

import telegram.types;

interface UpdatePolicy
{
    /**
     * Starts the update-checking process.
     *
     * Whenever updates are received from the telegram servers, onUpdate is called.
     */
    void startListening(void delegate(scope Update[]) onUpdate);

    /**
     * Stops the update-checking process.
     */
    void stopListening();
}
