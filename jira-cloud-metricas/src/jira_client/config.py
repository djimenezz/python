"""Configuration helpers for the Jira client."""

from __future__ import annotations

import os
from dataclasses import dataclass
from pathlib import Path

from dotenv import load_dotenv

# Load environment variables from a local .env file if it exists.
_ENV_PATH = Path(__file__).resolve().parents[2] / ".env"
if _ENV_PATH.exists():
    load_dotenv(dotenv_path=_ENV_PATH)
else:
    # Fallback to default behaviour (load from the environment only)
    load_dotenv()


@dataclass
class JiraConfig:
    """Holds the configuration values required by the Jira client."""

    base_url: str
    email: str
    api_token: str


def get_config() -> JiraConfig:
    """Build a :class:`JiraConfig` instance from environment variables."""

    return JiraConfig(
        base_url=os.getenv("JIRA_BASE_URL", ""),
        email=os.getenv("JIRA_EMAIL", ""),
        api_token=os.getenv("JIRA_API_TOKEN", ""),
    )
