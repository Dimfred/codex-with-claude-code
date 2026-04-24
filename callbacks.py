from litellm.integrations.custom_logger import CustomLogger


class StripSystemMessages(CustomLogger):
    """Strip system messages for ChatGPT Codex which doesn't support them."""

    async def async_pre_call_hook(self, user_api_key_dict, cache, data, call_type):
        # Strip system messages from messages list
        if "messages" in data:
            data["messages"] = [
                m for m in data["messages"] if m.get("role") != "system"
            ]
        # Remove top-level system field (Anthropic format)
        if "system" in data:
            del data["system"]

        return data


strip_system_messages = StripSystemMessages()
