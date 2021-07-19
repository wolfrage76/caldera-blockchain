import os
from pathlib import Path

DEFAULT_ROOT_PATH = Path(os.path.expanduser(os.getenv("SSDCOIN_ROOT", "~/.ssdcoin/mainnet"))).resolve()
