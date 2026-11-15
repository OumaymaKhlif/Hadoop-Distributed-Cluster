# Hadoop Distributed Cluster Deployment with Vagrant & Ansible

![Hadoop](https://img.shields.io/badge/Apache_Hadoop-3.3.6-FFCC00?logo=apachehadoop&logoColor=black)
![HDFS](https://img.shields.io/badge/HDFS-Distributed_Storage-66CCFF)
![YARN](https://img.shields.io/badge/YARN-Resource_Management-FF6D00)
![MapReduce](https://img.shields.io/badge/MapReduce-Distributed_Processing-blue)
![Vagrant](https://img.shields.io/badge/Vagrant-Infrastructure_as_Code-1868F2?logo=vagrant)
![Ansible](https://img.shields.io/badge/Ansible-Automation-EE0000?logo=ansible)
![VirtualBox](https://img.shields.io/badge/VirtualBox-Virtualization-183A61?logo=virtualbox)
![Java](https://img.shields.io/badge/Java-8-orange?logo=openjdk)
![Linux](https://img.shields.io/badge/Linux-Lubuntu-FCC624?logo=linux)

## Overview

This project focuses on deploying and configuring a **three-node Apache Hadoop cluster** using Vagrant, VirtualBox, and Ansible.

The infrastructure integrates HDFS for distributed storage, YARN for resource management, and MapReduce for distributed data processing.

The entire deployment process is automated through a centralized Ansible playbook organized into reusable roles, following Infrastructure as Code (IaC) and Configuration Management principles.

## Architecture

The cluster consists of three virtual machines:

| Node | IP Address | Responsibilities |
|---|---|---|
| NameNode | 192.168.56.120 | HDFS NameNode, YARN ResourceManager |
| DataNode 1 | 192.168.56.121 | HDFS DataNode, YARN NodeManager |
| DataNode 2 | 192.168.56.122 | HDFS DataNode, YARN NodeManager |

### Infrastructure Specifications

- 3 Virtual Machines
- 2 GB RAM per machine
- 2 CPU cores per machine
- Static private IP addresses
- VirtualBox virtualization
- Lubuntu-based environment

## Technologies Used

| Technology | Purpose |
|---|---|
| Apache Hadoop 3.3.6 | Distributed computing framework |
| HDFS | Distributed file storage |
| YARN | Cluster resource management |
| MapReduce | Distributed data processing |
| Vagrant | Virtual machine provisioning |
| VirtualBox | Virtualization provider |
| Ansible | Configuration management and automation |
| Java 8 | Hadoop runtime environment |
| Linux | Operating system |

## Deployment Workflow

The cluster deployment is fully automated using Vagrant and Ansible.

### 1. Infrastructure Provisioning — Vagrant

Vagrant provisions three virtual machines using VirtualBox.

Each machine is configured with:
- A unique hostname.
- A static private IP address.
- 2 GB of RAM.
- 2 CPU cores.

### 2. Configuration Management — Ansible

A centralized playbook (`playbook.yml`) orchestrates the deployment across all machines defined in `inventory.ini`.

Before executing the deployment, Ansible:
- Waits for SSH connectivity.
- Collects system information using Ansible Facts.
- Executes the required installation and configuration roles.

### 3. Automated Deployment Roles

The deployment is organized into five reusable Ansible roles:

| Role | Responsibilities |
|---|---|
| **java** | Installs Java 8, required by Hadoop. |
| **ssh** | Configures passwordless SSH communication between cluster nodes. |
| **hadoop** | Downloads, extracts, distributes and configures Hadoop 3.3.6. |
| **hdfs** | Initializes HDFS during the first deployment and starts the NameNode and DataNodes. |
| **yarn** | Starts the ResourceManager and NodeManagers. |

### 4. HDFS — Distributed Storage

HDFS provides distributed and fault-tolerant storage across the cluster.

- **NameNode:** Manages filesystem metadata and namespace.
- **DataNodes:** Store and manage distributed data blocks.

### 5. YARN — Resource Management

YARN manages cluster resources and coordinates distributed application execution.

- **ResourceManager:** Coordinates resource allocation across the cluster.
- **NodeManagers:** Manage containers and resources on worker nodes.

### 6. MapReduce — Distributed Processing

MapReduce enables parallel processing of large datasets across the cluster.

It relies on YARN for resource allocation and application execution.

## Installation & Deployment

### Prerequisites

Make sure the following tools are installed:

- VirtualBox
- Vagrant
- Ansible
- SSH client

### Step 1 — Clone the Repository

```bash
git clone https://github.com/USERNAME/hadoop-distributed-cluster.git
```

```bash
cd hadoop-distributed-cluster
```

### Step 2 — Provision Virtual Machines

```bash
vagrant up
```

This command creates and starts the three virtual machines.

### Step 3 — Verify Infrastructure

```bash
vagrant status
```

### Step 4 — Execute the Ansible Playbook

```bash
ansible-playbook -i inventory.ini playbook.yml
```

This command automatically executes all five roles across the Hadoop cluster.

## Cluster Verification

After deployment, verify that all Hadoop services are running.

### 1. Check Java Processes

Execute on each machine:

```bash
jps
```

Expected processes:

**NameNode:**
- NameNode
- ResourceManager

**DataNode 1 and DataNode 2:**
- DataNode
- NodeManager

### 2. Verify HDFS

```bash
hdfs dfsadmin -report
```

This command displays the DataNodes status, storage capacity, and HDFS cluster information.

### 3. Verify YARN

```bash
yarn node -list
```

This command displays the registered NodeManagers.

## Hadoop Web Interfaces

The Hadoop web interfaces provide monitoring and cluster administration.

| Component | URL |
|---|---|
| NameNode Web UI | http://192.168.56.120:9870 |
| ResourceManager Web UI | http://192.168.56.120:8088 |

## Key Learning Outcomes

- Designing and provisioning multi-node infrastructure using Vagrant.
- Applying Infrastructure as Code (IaC) principles.
- Automating configuration management with Ansible roles.
- Configuring passwordless SSH communication.
- Deploying and managing a distributed Hadoop cluster.
- Understanding HDFS architecture and distributed storage.
- Managing cluster resources using YARN.
- Understanding MapReduce execution and distributed processing.
- Automating infrastructure deployment and service initialization.

## Author

**Oumayma Khlif**

Data Engineering Student

