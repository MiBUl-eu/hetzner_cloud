Ansible Role haproxy
=========

Install and configure HAProxy Loadbalancer

Requirements
------------

- When using SSL termination, the certificate and private key needs to be in one single pem file

Role Variables
--------------

The default values for the variables are set in `defaults/main.yml`:
```yml
# Configure stats in HAProxy?
haproxy_stats: yes # enable stats page
haproxy_stats_port: 8050 # stats port
haproxy_stats_bind_addr: "0.0.0.0" # bind stats ip on all interfaces

# Default settings for HAProxy.
haproxy_certdir: /etc/haproxy/certs # directory for tls certificates
haproxy_retries: 3 # number of retries to perform on a server after a connection failure
haproxy_timeout_http_request: 10s # maximum allowed time to wait for a complete HTTP request
haproxy_timeout_connect: 10s # maximum time to wait for a connection attempt to a server to succeed
haproxy_timeout_client: 1m # maximum inactivity time on the client side 
haproxy_timeout_server: 1m # maximum time for pending data staying into output buffer
haproxy_timeout_http_keep_alive: 10s # maximum allowed time to wait for a new HTTP request to appear
haproxy_timeout_check: 10s # additional check timeout, but only after a connection has been already established
haproxy_maxconn: 3000 # maximal number of concurrent connections that will be sent to this server
```

Dependencies
------------
- No Dependencies

Example Inventory
------------
```ini
[haproxy]
lbl-haproxy-01 ansible_host=10.199.34.117
lbl-haproxy-02 ansible_host=10.199.34.118
```
Example Playbook
----------------

```yml
---
# Gather facts for backend servers (i.e. vault servers)
# Only needed when haproxy_backends.servers variable is set to read hostvars (IP addresses) from inventory group members (i.e. servers: "{{ groups['vault'] }})" 
- hosts: vault
  become: yes
  gather_facts: yes
  vars:
    ansible_user: root

# Configure HAProxy with http and https frontend, httpcheck on backend servers
- hosts: haproxy
  become: yes
  gather_facts: yes
  vars:
    ansible_user: root
  roles:
    - role: haproxy
      haproxy_frontends:
        - name: http # frontend name
          address: "*" # bind address
          port: 80 # bind port
          mode: http # tcp or http load balancing
          ssl: no # optional: disable ssl when using http
          https_redirect: yes # optional: redirect http to https
          option: httplog # optional: frontend options i.e. tcplog or httplog(default)
        - name: https
          address: "*"
          port: 443
          mode: http
          ssl: yes # enable ssl termination with http mode
          default_backend: vault # optional: default backend
          acls: # optional: only with http mode: create haproxy acls/rules when using single interface/IP and multiple backends based on hostname/paths etc.
           - use_backend vault if { hdr_end(host) -i vault.example.com }
      haproxy_certs: # optional list with certificates that will be copied to load balancer
        - ./certs/vault.example.com.pem 
      haproxy_backend_default_balance: roundrobin # default backend balance mode. can be overwritten with haproxy_backends.balance
      haproxy_backends:
        - name: vault
          mode: http # tcp or http load balancing
          httpcheck: yes # only with http mode: http health check method uri and expect status codes
          http_check: # optional: http health check method uri and expect status codes
            send:
              method: GET
              uri: /v1/sys/health
            expect: status 200,429
          balance: roundrobin # backend balance mode
          servers: "{{ groups['vault'] }}" # ansible inventory group with backend servers or list of servers
          port: 8200 # optional: backend port when servers refer to inventory group. Not needed when using list of servers
          options: # check backend health options
            - check
            - ssl
            - verify
            - none
        - name: smtp
          mode: tcp # tcp or http load balancing
          httpcheck: no # only with http mode: http health check method uri and expect status codes
          additional_check: ssl-hello-chk # optional only when httpcheck is false: specify any additional check method (i.e. ssl-hello-chk, tcpka etc.) https://www.haproxy.com/documentation/hapee/latest/onepage/#option%20ssl-hello-chk
          balance: roundrobin
          # You can also refer to a list of servers.
          servers:
            - name: backend1
              address: "127.0.0.1"
              port: 25
            - name: backend2
              address: "127.0.0.2"
              port: 25
          port: 25
          options:
            - check
```

License
-------

GPLv3

Author Information
------------------

Oleg Franko
