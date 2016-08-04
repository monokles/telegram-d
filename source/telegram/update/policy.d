/**
 * This module contains the TelegramD UpdatePolicy interface
 */
module telegram.update.policy;

import telegram.types.receive;

interface UpdatePolicy
{
    /**
     * Retrieve new updates from the Telegram servers.
     * Blocks until new updates are received.
     * Returns: An array of Updates since you last checked
     */
    Update[] getUpdates();
}
