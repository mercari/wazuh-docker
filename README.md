# Wazuh containers for Docker

[![Slack](https://img.shields.io/badge/slack-join-blue.svg)](https://wazuh.com/community/join-us-on-slack/)
[![Email](https://img.shields.io/badge/email-join-blue.svg)](https://groups.google.com/forum/#!forum/wazuh)
[![Documentation](https://img.shields.io/badge/docs-view-green.svg)](https://documentation.wazuh.com)
[![Documentation](https://img.shields.io/badge/web-view-green.svg)](https://wazuh.com)
![wazuh-docker-ci](https://github.com/k-oguma/wazuh-docker/workflows/wazuh-docker-ci/badge.svg?branch=master)

In this repository you will find the containers to run:

* wazuh: It runs the Wazuh manager, Wazuh API and Filebeat (for integration with Elastic Stack)
* wazuh-kibana: Provides a web user interface to browse through alerts data. It includes Wazuh plugin for Kibana, that allows you to visualize agents configuration and status.
* wazuh-nginx: Proxies the Kibana container, adding HTTPS (via self-signed SSL certificate) and [Basic authentication](https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication#Basic_authentication_scheme).
* wazuh-elasticsearch: An Elasticsearch container (working as a single-node cluster) using Elastic Stack Docker images. **Be aware to increase the `vm.max_map_count` setting, as it's detailed in the [Wazuh documentation](https://documentation.wazuh.com/current/docker/wazuh-container.html#increase-max-map-count-on-your-host-linux).**

In addition, a docker-compose file is provided to launch the containers mentioned above.

* Elasticsearch cluster. In the Elasticsearch Dockerfile we can visualize variables to configure an Elasticsearch Cluster. These variables are used in the file *config_cluster.sh* to set them in the *elasticsearch.yml* configuration file. You can see the meaning of the node variables [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html) and other cluster settings [here](https://github.com/elastic/elasticsearch/blob/master/distribution/src/config/elasticsearch.yml).


## Original repository

[wazuh/wazuh-docker](https://github.com/wazuh/wazuh-docker)


## About Mercari's fork

### What's this

The repository is a fork of [wazuh/wazuh-docker](https://github.com/wazuh/wazuh-docker) that is modified to meet Mercari's needs.

### About additional features

We have a general-purpose for this repository. It will probably work in your environment, but we do not guarantee or compensate for it.

### Contribute

We think it's better to send a pull request to the original repository, unless it concerns only our this fork repo.

[wazuh/wazuh-docker](https://github.com/wazuh/wazuh-docker)
`Wazuh Docker Copyright (C) 2020 Wazuh Inc. (License GPLv2)`
