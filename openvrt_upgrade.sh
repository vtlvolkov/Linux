#!/bin/sh
opkg update
opkg list-upgradable | cut -f 1 -d ' ' | xargs --no-run-if-empty opkg upgrade
