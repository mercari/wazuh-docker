#!/bin/bash
# Copyright (C) 2020 k-oguma / ktykogm (License MIT)
#
# Ruleset configuration.

set -e

WAZUH_LOCAL_RULESET_CONF=/var/ossec/etc/rules/local_rules.xml

local_ruleset_conf(){
  # demo conf is backup
  if [ ! -f "${WAZUH_LOCAL_RULESET_CONF}.bak" ]; then
    mv ${WAZUH_LOCAL_RULESET_CONF}{,.bak}
  fi

  cat > $WAZUH_LOCAL_RULESET_CONF <<EOF
$LOCAL_RULES
EOF
}

if [ "x${LOCAL_RULES}" != "x" ];then local_ruleset_conf ;fi
