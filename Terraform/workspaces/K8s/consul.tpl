global:
  enabled: false
  image: "consul:${consul_version}"
  datacenter: kandula
  gossipEncryption:
    secretName: ${cluster_id}-hcp
    secretKey: gossipEncryptionKey
client:
  enabled: true
  # Set this to true to expose the Consul clients using the Kubernetes node
  # IPs. If false, the pod IPs must be routable from the external servers.
  exposeGossipPorts: true
  # Consul Cluster Outside K8S leader IP
  join:
    - "provider=aws tag_key=service_role tag_value=service_discovery region=us-east-1"
  grpc: true
  # nodeMeta:
  #   pod-name: ${HOSTNAME}
  #   host-ip: ${HOST_IP}

syncCatalog:
  enabled: true
  k8sAllowNamespaces: ["*"]
  k8sDenyNamespaces: []

connectInject:
  transparentProxy:
    defaultEnabled: true
  enabled: true
  default: true