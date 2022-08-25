#!/usr/bin/env python3
from mygrains import testgrain


def init_grains(grains):
    """The core function that does everything"""

    grains["testgrain"] = testgrain.get_grains(grains)

    return grains


if __name__ == "__main__":
    import pprint as pp

    import salt.config
    import salt.loader

    __opts__ = salt.config.minion_config("/etc/salt/minion")
    __grains__ = salt.loader.grains(__opts__)

    pp.pprint(init_grains(__grains__))
