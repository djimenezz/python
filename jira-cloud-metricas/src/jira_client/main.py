"""Entry point for the first Jira client experiment."""

from __future__ import annotations

from .config import get_config


def main() -> None:
    """Load the Jira configuration and print a simple status message."""

    config = get_config()
    if not (config.base_url and config.email and config.api_token):
        print("Jira configuration is incomplete. Please update your .env file.")
        return

    print("Jira configuration loaded successfully for user:", config.email)


if __name__ == "__main__":
    main()
