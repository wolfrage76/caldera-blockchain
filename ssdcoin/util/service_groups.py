from typing import KeysView, Generator

SERVICES_FOR_GROUP = {
    "all": "ssdcoin_harvester ssdcoin_timelord_launcher ssdcoin_timelord ssdcoin_farmer ssdcoin_full_node ssdcoin_wallet".split(),
    "node": "ssdcoin_full_node".split(),
    "harvester": "ssdcoin_harvester".split(),
    "farmer": "ssdcoin_harvester ssdcoin_farmer ssdcoin_full_node ssdcoin_wallet".split(),
    "farmer-no-wallet": "ssdcoin_harvester ssdcoin_farmer ssdcoin_full_node".split(),
    "farmer-only": "ssdcoin_farmer".split(),
    "timelord": "ssdcoin_timelord_launcher ssdcoin_timelord ssdcoin_full_node".split(),
    "timelord-only": "ssdcoin_timelord".split(),
    "timelord-launcher-only": "ssdcoin_timelord_launcher".split(),
    "wallet": "ssdcoin_wallet ssdcoin_full_node".split(),
    "wallet-only": "ssdcoin_wallet".split(),
    "introducer": "ssdcoin_introducer".split(),
    "simulator": "ssdcoin_full_node_simulator".split(),
}


def all_groups() -> KeysView[str]:
    return SERVICES_FOR_GROUP.keys()


def services_for_groups(groups) -> Generator[str, None, None]:
    for group in groups:
        for service in SERVICES_FOR_GROUP[group]:
            yield service


def validate_service(service: str) -> bool:
    return any(service in _ for _ in SERVICES_FOR_GROUP.values())
