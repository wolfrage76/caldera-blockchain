from typing import KeysView, Generator

SERVICES_FOR_GROUP = {
    "all": "caldera_harvester caldera_timelord_launcher caldera_timelord caldera_farmer caldera_full_node caldera_wallet".split(),  # noqa
    "node": "caldera_full_node".split(),
    "harvester": "caldera_harvester".split(),
    "farmer": "caldera_harvester caldera_farmer caldera_full_node caldera_wallet".split(),
    "farmer-no-wallet": "caldera_harvester caldera_farmer caldera_full_node".split(),
    "farmer-only": "caldera_farmer".split(),
    "timelord": "caldera_timelord_launcher caldera_timelord caldera_full_node".split(),
    "timelord-only": "caldera_timelord".split(),
    "timelord-launcher-only": "caldera_timelord_launcher".split(),
    "wallet": "caldera_wallet caldera_full_node".split(),
    "wallet-only": "caldera_wallet".split(),
    "introducer": "caldera_introducer".split(),
    "simulator": "caldera_full_node_simulator".split(),
}


def all_groups() -> KeysView[str]:
    return SERVICES_FOR_GROUP.keys()


def services_for_groups(groups) -> Generator[str, None, None]:
    for group in groups:
        for service in SERVICES_FOR_GROUP[group]:
            yield service


def validate_service(service: str) -> bool:
    return any(service in _ for _ in SERVICES_FOR_GROUP.values())
