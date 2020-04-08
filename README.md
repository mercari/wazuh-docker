# Wazuh containers for Docker

[![Slack](https://img.shields.io/badge/slack-join-blue.svg)](https://wazuh.com/community/join-us-on-slack/)
[![Email](https://img.shields.io/badge/email-join-blue.svg)](https://groups.google.com/forum/#!forum/wazuh)
[![Documentation](https://img.shields.io/badge/docs-view-green.svg)](https://documentation.wazuh.com)
[![Documentation](https://img.shields.io/badge/web-view-green.svg)](https://wazuh.com)

In this repository you will find the containers to run:

* wazuh: It runs the Wazuh manager, Wazuh API and Filebeat (for integration with Elastic Stack)
* wazuh-kibana: Provides a web user interface to browse through alerts data. It includes Wazuh plugin for Kibana, that allows you to visualize agents configuration and status.
* nginx: Proxies the Kibana container, adding HTTPS (via your [own certificate or self-signed](nginx_conf/README.md)) and [Basic authentication](https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication#Basic_authentication_scheme). **It is required to set up SSL certificate before deploying**
* wazuh-elasticsearch: An Elasticsearch container (working as a single-node cluster) using Elastic Stack Docker images. **Be aware to increase the `vm.max_map_count` setting, as it's detailed in the [Wazuh documentation](https://documentation.wazuh.com/current/docker/wazuh-container.html#increase-max-map-count-on-your-host-linux).**

In addition, a docker-compose file is provided to launch the containers mentioned above.

* Elasticsearch cluster. In the Elasticsearch Dockerfile we can visualize variables to configure an Elasticsearch Cluster. These variables are used in the file *config_cluster.sh* to set them in the *elasticsearch.yml* configuration file. You can see the meaning of the node variables [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html) and other cluster settings [here](https://github.com/elastic/elasticsearch/blob/master/distribution/src/config/elasticsearch.yml).

## Documentation

* [Wazuh full documentation](http://documentation.wazuh.com)
* [Wazuh documentation for Docker](https://documentation.wazuh.com/current/docker/index.html)
* [Docker hub](https://hub.docker.com/u/wazuh)


### Setup SSL certificate and Basic Authentication

Before starting the environment it is required to provide an SSL certificate (or just generate one self-signed) and setup the basic auth.

Documentation on how to provide these two can be found at [nginx_conf/README.md](nginx_conf/README.md).


## Environment Variables

Default values are included when available.

### Wazuh
```
API_USER="foo"			# Wazuh API username
API_PASS="bar"			# Wazuh API password
```

### Elasticsearch
```
ELASTIC_CLUSTER="false"					# Setup a cluster
CLUSTER_NAME="wazuh"					# Cluster name
CLUSTER_NODE_MASTER="false"				# Set node as master
CLUSTER_NODE_DATA="true"				# Store data on this node
CLUSTER_NODE_INGEST="true"				# Setup as ingest node
CLUSTER_NODE_NAME="wazuh-elasticsearch"			# Name for this node
CLUSTER_MASTER_NODE_NAME="master-node"			# Name of the master node
CLUSTER_MEMORY_LOCK="true"				# Set Elasticsearch memory lock
CLUSTER_DISCOVERY_SERVICE="wazuh-elasticsearch"		# Set discovery service
CLUSTER_NUMBER_OF_MASTERS="2"				# Nomber of masters on the cluster
CLUSTER_MAX_NODES="1"					# Max number of nodes on the cluster
CLUSTER_DELAYED_TIMEOUT="1m"				# Set delayed timeout
CLUSTER_INITIAL_MASTER_NODES="wazuh-elasticsearch"	# Elastic bootstrap node
```

### Kibana
```
PATTERN=""			#
CHECKS_PATTERN=""		#
CHECKS_TEMPLATE=""		#
CHECKS_API=""			#
CHECKS_SETUP=""			#
EXTENSIONS_PCI=""		#
EXTENSIONS_GDPR=""		#
EXTENSIONS_AUDIT=""		#
EXTENSIONS_OSCAP=""		#
EXTENSIONS_CISCAT=""		#
EXTENSIONS_AWS=""		#
EXTENSIONS_VIRUSTOTAL=""	#
EXTENSIONS_OSQUERY=""		#
APP_TIMEOUT=""			#
WAZUH_SHARDS=""			#
WAZUH_REPLICAS=""		#
WAZUH_VERSION_SHARDS=""		#
WAZUH_VERSION_REPLICAS=""	#
IP_SELECTOR=""			#
IP_IGNORE=""			#
XPACK_RBAC_ENABLED=""		#
WAZUH_MONITORING_ENABLED=""	#
WAZUH_MONITORING_FREQUENCY=""	#
WAZUH_MONITORING_SHARDS=""	#
WAZUH_MONITORING_REPLICAS=""	#
ADMIN_PRIVILEGES=""		#
```

## Directory structure

    wazuh-docker
    ├── CHANGELOG.md
    ├── docker-compose.yml
    ├── elasticsearch
    │   ├── config
    │   │   ├── config_cluster.sh
    │   │   ├── configure_s3.sh
    │   │   ├── entrypoint.sh
    │   │   └── load_settings.sh
    │   └── Dockerfile
    ├── kibana
    │   ├── config
    │   │   ├── entrypoint.sh
    │   │   ├── kibana_settings.sh
    │   │   ├── wazuh_app_config.sh
    │   │   ├── welcome_wazuh.sh
    │   │   └── xpack_config.sh
    │   └── Dockerfile
    ├── LICENSE
    ├── nginx_conf
    │   ├── kibana-web.conf
    │   ├── README.md
    │   └── ssl
    │       └── generate-self-signed-cert.sh
    ├── README.md
    ├── VERSION
    └── wazuh
        ├── config
        │   ├── data_dirs.env
        │   ├── etc
        │   │   ├── cont-init.d
        │   │   │   ├── 0-wazuh-init
        │   │   │   ├── 1-config-filebeat
        │   │   │   └── 2-manager
        │   │   └── services.d
        │   │       ├── api
        │   │       └── filebeat
        │   ├── filebeat.yml
        │   ├── permanent_data.env
        │   ├── permanent_data.sh
        │   └── wazuh.repo
        └── Dockerfile


## Branches

* `stable` branch on correspond to the latest Wazuh-Docker stable version.
* `master` branch contains the latest code, be aware of possible bugs on this branch.
* `Wazuh.Version_ElasticStack.Version` (for example 3.10.2_7.5.0) branch. This branch contains the current release referenced in Docker Hub. The container images are installed under the current version of this branch.

## Credits and Thank you

These Docker containers are based on:

*  "deviantony" dockerfiles which can be found at [https://github.com/deviantony/docker-elk](https://github.com/deviantony/docker-elk)
*  "xetus-oss" dockerfiles, which can be found at [https://github.com/xetus-oss/docker-ossec-server](https://github.com/xetus-oss/docker-ossec-server)

We thank you them and everyone else who has contributed to this project.

## License and copyright

Wazuh Docker Copyright (C) 2019 Wazuh Inc. (License GPLv2)

## Web references

[Wazuh website](http://wazuh.com)
