# CLAB_FABRIC

# Table of Contents

- [Fabric Switches and Management IP](#fabric-switches-and-management-ip)
  - [Fabric Switches with inband Management IP](#fabric-switches-with-inband-management-ip)
- [Fabric Topology](#fabric-topology)
- [Fabric IP Allocation](#fabric-ip-allocation)
  - [Fabric Point-To-Point Links](#fabric-point-to-point-links)
  - [Point-To-Point Links Node Allocation](#point-to-point-links-node-allocation)
  - [Loopback Interfaces (BGP EVPN Peering)](#loopback-interfaces-bgp-evpn-peering)
  - [Loopback0 Interfaces Node Allocation](#loopback0-interfaces-node-allocation)
  - [VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)](#vtep-loopback-vxlan-tunnel-source-interfaces-vteps-only)
  - [VTEP Loopback Node allocation](#vtep-loopback-node-allocation)

# Fabric Switches and Management IP

| POD | Type | Node | Management IP | Platform | Provisioned in CloudVision |
| --- | ---- | ---- | ------------- | -------- | -------------------------- |
| CLAB_FABRIC | leaf | leaf1 | 172.100.100.103/24 | vEOS | Provisioned |
| CLAB_FABRIC | leaf | leaf2 | 172.100.100.104/24 | vEOS | Provisioned |
| CLAB_FABRIC | leaf | leaf3 | 172.100.100.105/24 | vEOS | Provisioned |
| CLAB_FABRIC | leaf | leaf4 | 172.100.100.106/24 | vEOS | Provisioned |
| CLAB_FABRIC | leaf | leaf5 | 172.100.100.107/24 | vEOS | Provisioned |
| CLAB_FABRIC | leaf | leaf6 | 172.100.100.108/24 | vEOS | Provisioned |
| CLAB_FABRIC | l3spine | spine1 | 172.100.100.101/24 | vEOS | Provisioned |
| CLAB_FABRIC | l3spine | spine2 | 172.100.100.102/24 | vEOS | Provisioned |

> Provision status is based on Ansible inventory declaration and do not represent real status from CloudVision.

## Fabric Switches with inband Management IP
| POD | Type | Node | Management IP | Inband Interface |
| --- | ---- | ---- | ------------- | ---------------- |

# Fabric Topology

| Type | Node | Node Interface | Peer Type | Peer Node | Peer Interface |
| ---- | ---- | -------------- | --------- | ----------| -------------- |
| leaf | leaf1 | Ethernet53/1 | l3spine | spine1 | Ethernet1/1 |
| leaf | leaf1 | Ethernet54/1 | l3spine | spine2 | Ethernet1/1 |
| leaf | leaf1 | Ethernet55/1 | mlag_peer | leaf2 | Ethernet55/1 |
| leaf | leaf1 | Ethernet56/1 | mlag_peer | leaf2 | Ethernet56/1 |
| leaf | leaf2 | Ethernet53/1 | l3spine | spine1 | Ethernet2/1 |
| leaf | leaf2 | Ethernet54/1 | l3spine | spine2 | Ethernet2/1 |
| leaf | leaf3 | Ethernet53/1 | l3spine | spine1 | Ethernet3/1 |
| leaf | leaf3 | Ethernet54/1 | l3spine | spine2 | Ethernet3/1 |
| leaf | leaf3 | Ethernet55/1 | mlag_peer | leaf4 | Ethernet55/1 |
| leaf | leaf3 | Ethernet56/1 | mlag_peer | leaf4 | Ethernet56/1 |
| leaf | leaf4 | Ethernet53/1 | l3spine | spine1 | Ethernet4/1 |
| leaf | leaf4 | Ethernet54/1 | l3spine | spine2 | Ethernet4/1 |
| leaf | leaf5 | Ethernet29/1 | l3spine | spine1 | Ethernet5/1 |
| leaf | leaf5 | Ethernet30/1 | l3spine | spine2 | Ethernet5/1 |
| leaf | leaf5 | Ethernet31/1 | mlag_peer | leaf6 | Ethernet31/1 |
| leaf | leaf5 | Ethernet32/1 | mlag_peer | leaf6 | Ethernet32/1 |
| leaf | leaf6 | Ethernet29/1 | l3spine | spine1 | Ethernet6/1 |
| leaf | leaf6 | Ethernet30/1 | l3spine | spine2 | Ethernet6/1 |
| l3spine | spine1 | Ethernet31/1 | mlag_peer | spine2 | Ethernet31/1 |
| l3spine | spine1 | Ethernet32/1 | mlag_peer | spine2 | Ethernet32/1 |

# Fabric IP Allocation

## Fabric Point-To-Point Links

| Uplink IPv4 Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ---------------- | ------------------- | ------------------ | ------------------ |

## Point-To-Point Links Node Allocation

| Node | Node Interface | Node IP Address | Peer Node | Peer Interface | Peer IP Address |
| ---- | -------------- | --------------- | --------- | -------------- | --------------- |

## Loopback Interfaces (BGP EVPN Peering)

| Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------- | ------------------- | ------------------ | ------------------ |
| 1.1.1.0/24 | 256 | 2 | 0.79 % |

## Loopback0 Interfaces Node Allocation

| POD | Node | Loopback0 |
| --- | ---- | --------- |
| CLAB_FABRIC | spine1 | 1.1.1.1/32 |
| CLAB_FABRIC | spine2 | 1.1.1.2/32 |

## VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)

| VTEP Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| --------------------- | ------------------- | ------------------ | ------------------ |

## VTEP Loopback Node allocation

| POD | Node | Loopback1 |
| --- | ---- | --------- |
