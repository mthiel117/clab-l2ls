# spine1
# Table of Contents

- [Management](#management)
  - [Management Interfaces](#management-interfaces)
  - [DNS Domain](#dns-domain)
  - [Name Servers](#name-servers)
  - [NTP](#ntp)
  - [Management API HTTP](#management-api-http)
- [Authentication](#authentication)
  - [Local Users](#local-users)
- [Monitoring](#monitoring)
- [MLAG](#mlag)
  - [MLAG Summary](#mlag-summary)
  - [MLAG Device Configuration](#mlag-device-configuration)
- [Spanning Tree](#spanning-tree)
  - [Spanning Tree Summary](#spanning-tree-summary)
  - [Spanning Tree Device Configuration](#spanning-tree-device-configuration)
- [Internal VLAN Allocation Policy](#internal-vlan-allocation-policy)
  - [Internal VLAN Allocation Policy Summary](#internal-vlan-allocation-policy-summary)
  - [Internal VLAN Allocation Policy Configuration](#internal-vlan-allocation-policy-configuration)
- [VLANs](#vlans)
  - [VLANs Summary](#vlans-summary)
  - [VLANs Device Configuration](#vlans-device-configuration)
- [Interfaces](#interfaces)
  - [Ethernet Interfaces](#ethernet-interfaces)
  - [Port-Channel Interfaces](#port-channel-interfaces)
  - [Loopback Interfaces](#loopback-interfaces)
  - [VLAN Interfaces](#vlan-interfaces)
- [Routing](#routing)
  - [Service Routing Protocols Model](#service-routing-protocols-model)
  - [Virtual Router MAC Address](#virtual-router-mac-address)
  - [IP Routing](#ip-routing)
  - [IPv6 Routing](#ipv6-routing)
  - [Static Routes](#static-routes)
- [Multicast](#multicast)
  - [IP IGMP Snooping](#ip-igmp-snooping)
- [Filters](#filters)
- [ACL](#acl)
- [VRF Instances](#vrf-instances)
  - [VRF Instances Summary](#vrf-instances-summary)
  - [VRF Instances Device Configuration](#vrf-instances-device-configuration)
- [Quality Of Service](#quality-of-service)

# Management

## Management Interfaces

### Management Interfaces Summary

#### IPv4

| Management Interface | description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management0 | oob_management | oob | MGMT | 172.100.100.101/24 | 172.100.100.1 |

#### IPv6

| Management Interface | description | Type | VRF | IPv6 Address | IPv6 Gateway |
| -------------------- | ----------- | ---- | --- | ------------ | ------------ |
| Management0 | oob_management | oob | MGMT | - | - |

### Management Interfaces Device Configuration

```eos
!
interface Management0
   description oob_management
   no shutdown
   vrf MGMT
   ip address 172.100.100.101/24
```

## DNS Domain

### DNS domain: example.com

### DNS Domain Device Configuration

```eos
dns domain example.com
!
```

## Name Servers

### Name Servers Summary

| Name Server | Source VRF |
| ----------- | ---------- |
| 8.8.8.8 | MGMT |

### Name Servers Device Configuration

```eos
ip name-server vrf MGMT 8.8.8.8
```

## NTP

### NTP Summary

#### NTP Servers

| Server | VRF | Preferred | Burst | iBurst | Version | Min Poll | Max Poll | Local-interface | Key |
| ------ | --- | --------- | ----- | ------ | ------- | -------- | -------- | --------------- | --- |
| time.google.com | MGMT | - | - | True | - | - | - | Management0 | - |

### NTP Device Configuration

```eos
!
ntp server vrf MGMT time.google.com iburst local-interface Management0
```

## Management API HTTP

### Management API HTTP Summary

| HTTP | HTTPS | Default Services |
| ---- | ----- | ---------------- |
| False | True | - |

### Management API VRF Access

| VRF Name | IPv4 ACL | IPv6 ACL |
| -------- | -------- | -------- |
| MGMT | - | - |

### Management API HTTP Configuration

```eos
!
management api http-commands
   protocol https
   no shutdown
   !
   vrf MGMT
      no shutdown
```

# Authentication

## Local Users

### Local Users Summary

| User | Privilege | Role | Disabled |
| ---- | --------- | ---- | -------- |
| admin | 15 | network-admin | False |

### Local Users Device Configuration

```eos
!
username admin privilege 15 role network-admin secret sha512 $6$zcVQubgL4InqCyPk$oRuQq7RH0qV0mBmZniUxeRFeVlIxyGbouUlnWI5grTPozQLZd84FGq2IWO0CyHSQQm2BQfz/qVaNP2XbXZZGO/
```

# Monitoring

# MLAG

## MLAG Summary

| Domain-id | Local-interface | Peer-address | Peer-link |
| --------- | --------------- | ------------ | --------- |
| SPINES | Vlan4094 | 10.0.0.1 | Port-Channel311 |

Dual primary detection is disabled.

## MLAG Device Configuration

```eos
!
mlag configuration
   domain-id SPINES
   local-interface Vlan4094
   peer-address 10.0.0.1
   peer-link Port-Channel311
   reload-delay mlag 300
   reload-delay non-mlag 330
```

# Spanning Tree

## Spanning Tree Summary

STP mode: **mstp**

### MSTP Instance and Priority

| Instance(s) | Priority |
| -------- | -------- |
| 0 | 4096 |

### Global Spanning-Tree Settings

- Spanning Tree disabled for VLANs: **4093-4094**

## Spanning Tree Device Configuration

```eos
!
spanning-tree mode mstp
no spanning-tree vlan-id 4093-4094
spanning-tree mst 0 priority 4096
```

# Internal VLAN Allocation Policy

## Internal VLAN Allocation Policy Summary

| Policy Allocation | Range Beginning | Range Ending |
| ------------------| --------------- | ------------ |
| ascending | 1006 | 1199 |

## Internal VLAN Allocation Policy Configuration

```eos
!
vlan internal order ascending range 1006 1199
```

# VLANs

## VLANs Summary

| VLAN ID | Name | Trunk Groups |
| ------- | ---- | ------------ |
| 10 | Ten | - |
| 20 | Twenty | - |
| 30 | Thirty | - |
| 4093 | LEAF_PEER_L3 | LEAF_PEER_L3 |
| 4094 | MLAG_PEER | MLAG |

## VLANs Device Configuration

```eos
!
vlan 10
   name Ten
!
vlan 20
   name Twenty
!
vlan 30
   name Thirty
!
vlan 4093
   name LEAF_PEER_L3
   trunk group LEAF_PEER_L3
!
vlan 4094
   name MLAG_PEER
   trunk group MLAG
```

# Interfaces

## Ethernet Interfaces

### Ethernet Interfaces Summary

#### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | Channel-Group |
| --------- | ----------- | ---- | ----- | ----------- | ----------- | ------------- |
| Ethernet1/1 | LEAF1_Ethernet53/1 | *trunk | *10,20,30 | *- | *- | 11 |
| Ethernet2/1 | LEAF2_Ethernet53/1 | *trunk | *10,20,30 | *- | *- | 11 |
| Ethernet3/1 | LEAF3_Ethernet53/1 | *trunk | *20 | *- | *- | 31 |
| Ethernet4/1 | LEAF4_Ethernet53/1 | *trunk | *20 | *- | *- | 31 |
| Ethernet5/1 | LEAF5_Ethernet29/1 | *trunk | *30 | *- | *- | 51 |
| Ethernet6/1 | LEAF6_Ethernet29/1 | *trunk | *30 | *- | *- | 51 |
| Ethernet31/1 | MLAG_PEER_spine2_Ethernet31/1 | *trunk | *2-4094 | *- | *['LEAF_PEER_L3', 'MLAG'] | 311 |
| Ethernet32/1 | MLAG_PEER_spine2_Ethernet32/1 | *trunk | *2-4094 | *- | *['LEAF_PEER_L3', 'MLAG'] | 311 |

*Inherited from Port-Channel Interface

### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1/1
   description LEAF1_Ethernet53/1
   no shutdown
   channel-group 11 mode active
!
interface Ethernet2/1
   description LEAF2_Ethernet53/1
   no shutdown
   channel-group 11 mode active
!
interface Ethernet3/1
   description LEAF3_Ethernet53/1
   no shutdown
   channel-group 31 mode active
!
interface Ethernet4/1
   description LEAF4_Ethernet53/1
   no shutdown
   channel-group 31 mode active
!
interface Ethernet5/1
   description LEAF5_Ethernet29/1
   no shutdown
   channel-group 51 mode active
!
interface Ethernet6/1
   description LEAF6_Ethernet29/1
   no shutdown
   channel-group 51 mode active
!
interface Ethernet31/1
   description MLAG_PEER_spine2_Ethernet31/1
   no shutdown
   channel-group 311 mode active
!
interface Ethernet32/1
   description MLAG_PEER_spine2_Ethernet32/1
   no shutdown
   channel-group 311 mode active
```

## Port-Channel Interfaces

### Port-Channel Interfaces Summary

#### L2

| Interface | Description | Type | Mode | VLANs | Native VLAN | Trunk Group | LACP Fallback Timeout | LACP Fallback Mode | MLAG ID | EVPN ESI |
| --------- | ----------- | ---- | ---- | ----- | ----------- | ------------| --------------------- | ------------------ | ------- | -------- |
| Port-Channel11 | RACK1_Po531 | switched | trunk | 10,20,30 | - | - | - | - | 11 | - |
| Port-Channel31 | RACK2_Po531 | switched | trunk | 20 | - | - | - | - | 31 | - |
| Port-Channel51 | RACK3_Po291 | switched | trunk | 30 | - | - | - | - | 51 | - |
| Port-Channel311 | MLAG_PEER_spine2_Po311 | switched | trunk | 2-4094 | - | ['LEAF_PEER_L3', 'MLAG'] | - | - | - | - |

### Port-Channel Interfaces Device Configuration

```eos
!
interface Port-Channel11
   description RACK1_Po531
   no shutdown
   switchport
   switchport trunk allowed vlan 10,20,30
   switchport mode trunk
   mlag 11
!
interface Port-Channel31
   description RACK2_Po531
   no shutdown
   switchport
   switchport trunk allowed vlan 20
   switchport mode trunk
   mlag 31
!
interface Port-Channel51
   description RACK3_Po291
   no shutdown
   switchport
   switchport trunk allowed vlan 30
   switchport mode trunk
   mlag 51
!
interface Port-Channel311
   description MLAG_PEER_spine2_Po311
   no shutdown
   switchport
   switchport trunk allowed vlan 2-4094
   switchport mode trunk
   switchport trunk group LEAF_PEER_L3
   switchport trunk group MLAG
```

## Loopback Interfaces

### Loopback Interfaces Summary

#### IPv4

| Interface | Description | VRF | IP Address |
| --------- | ----------- | --- | ---------- |
| Loopback0 | Router_ID | default | 1.1.1.1/32 |

#### IPv6

| Interface | Description | VRF | IPv6 Address |
| --------- | ----------- | --- | ------------ |
| Loopback0 | Router_ID | default | - |


### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description Router_ID
   no shutdown
   ip address 1.1.1.1/32
```

## VLAN Interfaces

### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
| Vlan10 | Ten | default | - | False |
| Vlan20 | Twenty | default | - | False |
| Vlan30 | Thirty | default | - | False |
| Vlan4093 | MLAG_PEER_L3_PEERING | default | 9000 | False |
| Vlan4094 | MLAG_PEER | default | 9000 | False |

#### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | VRRP | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ---- | ------ | ------- |
| Vlan10 |  default  |  10.10.10.2/24  |  -  |  10.10.10.1  |  -  |  -  |  -  |
| Vlan20 |  default  |  10.20.20.2/24  |  -  |  10.20.20.1  |  -  |  -  |  -  |
| Vlan30 |  default  |  10.30.30.2/24  |  -  |  10.30.30.1  |  -  |  -  |  -  |
| Vlan4093 |  default  |  10.1.1.0/31  |  -  |  -  |  -  |  -  |  -  |
| Vlan4094 |  default  |  10.0.0.0/31  |  -  |  -  |  -  |  -  |  -  |

### VLAN Interfaces Device Configuration

```eos
!
interface Vlan10
   description Ten
   no shutdown
   ip address 10.10.10.2/24
   ip virtual-router address 10.10.10.1
!
interface Vlan20
   description Twenty
   no shutdown
   ip address 10.20.20.2/24
   ip virtual-router address 10.20.20.1
!
interface Vlan30
   description Thirty
   no shutdown
   ip address 10.30.30.2/24
   ip virtual-router address 10.30.30.1
!
interface Vlan4093
   description MLAG_PEER_L3_PEERING
   no shutdown
   mtu 9000
   ip address 10.1.1.0/31
!
interface Vlan4094
   description MLAG_PEER
   no shutdown
   mtu 9000
   no autostate
   ip address 10.0.0.0/31
```

# Routing
## Service Routing Protocols Model

Multi agent routing protocol model enabled

```eos
!
service routing protocols model multi-agent
```

## Virtual Router MAC Address

### Virtual Router MAC Address Summary

#### Virtual Router MAC Address: aa:aa:bb:bb:cc:cc

### Virtual Router MAC Address Configuration

```eos
!
ip virtual-router mac-address aa:aa:bb:bb:cc:cc
```

## IP Routing

### IP Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | True |
| MGMT | false |

### IP Routing Device Configuration

```eos
!
ip routing
no ip routing vrf MGMT
```
## IPv6 Routing

### IPv6 Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | False |
| MGMT | false |

## Static Routes

### Static Routes Summary

| VRF | Destination Prefix | Next Hop IP             | Exit interface      | Administrative Distance       | Tag               | Route Name                    | Metric         |
| --- | ------------------ | ----------------------- | ------------------- | ----------------------------- | ----------------- | ----------------------------- | -------------- |
| MGMT | 0.0.0.0/0 | 172.100.100.1 | - | 1 | - | - | - |

### Static Routes Device Configuration

```eos
!
ip route vrf MGMT 0.0.0.0/0 172.100.100.1
```

# Multicast

## IP IGMP Snooping

### IP IGMP Snooping Summary

| IGMP Snooping | Fast Leave | Interface Restart Query | Proxy | Restart Query Interval | Robustness Variable |
| ------------- | ---------- | ----------------------- | ----- | ---------------------- | ------------------- |
| Enabled | - | - | - | - | - |

### IP IGMP Snooping Device Configuration

```eos
```

# Filters

# ACL

# VRF Instances

## VRF Instances Summary

| VRF Name | IP Routing |
| -------- | ---------- |
| MGMT | disabled |

## VRF Instances Device Configuration

```eos
!
vrf instance MGMT
```

# Quality Of Service
