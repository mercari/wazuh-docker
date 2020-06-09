#!/bin/bash
#
# Wazuh slack integration
#
# Slack integration into wazuh container.

WAZUH_INSTALL_PATH=/var/ossec

cat >> ${WAZUH_INSTALL_PATH}/etc/ossec.conf << 'EOF'

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
