#!/bin/bash
#
# Wazuh slack integration
#
# Slack integration into wazuh container.

WAZUH_INSTALL_PATH=/var/ossec

slack_integration_conf(){
  if [ "x$SLACK_ALERT_LEVEL" = "x" ];then SLACK_ALERT_LEVEL=10 ;fi

  CHK_EXISTS=$(perl -ne '/Integration with (Slack)/ and print $1' ${WAZUH_INSTALL_PATH}/etc/ossec.conf)
  if [ "$CHK_EXISTS" != "Slack"  ]; then
    cat >> ${WAZUH_INSTALL_PATH}/etc/ossec.conf <<EOF

<!-- Integration with Slack -->
<ossec_config>
  <integration>
    <name>slack</name>
    <hook_url>${SLACK_WEBHOOK_URL}</hook_url>
    <level>${SLACK_ALERT_LEVEL}</level>
    <alert_format>json</alert_format>
  </integration>
</ossec_config>
EOF
  else
    update_slack_conf
  fi
}

update_slack_conf(){
  CHK_HOOK_URL=$(grep "$SLACK_WEBHOOK_URL" ${WAZUH_INSTALL_PATH}/etc/ossec.conf)
  if [ "x$CHK_HOOK_URL" = "x" ]; then
    perl -pi -e "s@<hook_url>(.*)</hook_url>@<hook_url>${SLACK_WEBHOOK_URL}</hook_url>@" ${WAZUH_INSTALL_PATH}/etc/ossec.conf
  fi

  CHK_ALERT_LEVEL=$(grep "<level>${SLACK_ALERT_LEVEL}</level>" ${WAZUH_INSTALL_PATH}/etc/ossec.conf)
  if [ "x$CHK_ALERT_LEVEL" = "x" ]; then
    perl -pi -e "s@<level>(.*)</level>@<level>${SLACK_ALERT_LEVEL}</level>@" ${WAZUH_INSTALL_PATH}/etc/ossec.conf
  fi
}

if [ "x${SLACK_WEBHOOK_URL}" != "x" ];then slack_integration_conf ;fi
