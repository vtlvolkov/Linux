#!/bin/sh
opkg list-upgradable | cut -f 1 -d ' ' | xargs opkg upgrade
