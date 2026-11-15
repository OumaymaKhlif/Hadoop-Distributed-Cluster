# Hadoop Distributed Cluster Deployment with Vagrant & Ansible

![Hadoop](https://img.shields.io/badge/Apache_Hadoop-3.3.6-FFCC00?logo=apachehadoop&logoColor=black)
![HDFS](https://img.shields.io/badge/HDFS-Distributed_Storage-66CCFF)
![YARN](https://img.shields.io/badge/YARN-Resource_Management-FF6D00)
![MapReduce](https://img.shields.io/badge/MapReduce-Processing-blue)
![Vagrant](https://img.shields.io/badge/Vagrant-IaC-1868F2?logo=vagrant)
![Ansible](https://img.shields.io/badge/Ansible-Automation-EE0000?logo=ansible)
![VirtualBox](https://img.shields.io/badge/VirtualBox-Virtualization-183A61?logo=virtualbox)
![Java](https://img.shields.io/badge/Java-8-orange?logo=openjdk)
![Linux](https://img.shields.io/badge/Linux-Lubuntu-FCC624?logo=linux)

## Overview

This project focuses on deploying and configuring a distributed Apache Hadoop cluster using **Vagrant and Ansible**.

The infrastructure consists of three virtual machines configured to implement Hadoop's core components: HDFS for distributed storage, YARN for resource management, and MapReduce for distributed data processing.

The deployment is automated using Infrastructure as Code (IaC) and configuration management principles.

## Architecture

The cluster consists of three virtual machines:

| Node | IP Address | Responsibilities |
|---|---|---|
| NameNode | 192.168.56.120 | HDFS NameNode, YARN ResourceManager |
| DataNode 1 | 192.168.56.121 | HDFS DataNode, YARN NodeManager |
| DataNode 2 | 192.168.56.122 | HDFS DataNode, YARN NodeManager |

**Infrastructure specifications:**
- 3 Virtual Machines
- 2 GB RAM per machine
- 2 CPU cores per machine
- VirtualBox virtualization
- Ubuntu-based Lubuntu environment

## Technologies

- **Apache Hadoop 3.3.6:** Distributed computing framework.
- **HDFS:** Distributed storage across DataNodes.
- **YARN:** Cluster resource and job management.
- **MapReduce:** Distributed data processing.
- **Vagrant:** Automated virtual machine provisioning.
- **Ansible:** Automated configuration and deployment.
- **VirtualBox:** Virtualization provider.
- **Java 8:** Java runtime environment required by Hadoop.

## Project Structure

```text
hadoop-cluster/
│
├── Vagrantfile
│
├── ansible/
│   ├── inventory/
│   │   └── hosts
│   │
│   ├── playbooks/
│   │   ├── install-hadoop.yml
│   │   ├── configure-hadoop.yml
│   │   ├── start-hdfs.yml
│   │   └── start-yarn.yml
│   │
│   ├── templates/
│   │   ├── core-site.xml
│   │   ├── hdfs-site.xml
│   │   ├── mapred-site.xml
│   │   ├── yarn-site.xml
│   │   └── hadoop-env.sh
│   │
│   └── ansible.cfg
│
└── README.md
```

*Note: Adapt the structure to match your actual repository.*

## Deployment Workflow

### 1. Infrastructure Provisioning — Vagrant

Vagrant provisions three virtual machines using VirtualBox.

Each machine receives:
- A hostname.
- A static private IP address.
- Allocated CPU and memory resources.

### 2. Configuration Management — Ansible

Ansible automates the Hadoop installation and configuration across all nodes.

Main tasks:

- Check whether Hadoop is already installed.
- Download and extract Hadoop 3.3.6.
- Configure Java and Hadoop environment variables.
- Deploy Hadoop configuration files.
- Configure cluster hostnames and network resolution.
- Define DataNodes in the `workers` file.
- Configure NameNode and DataNode roles.

### 3. HDFS Deployment

HDFS provides distributed storage through:

- **NameNode:** Manages filesystem metadata and namespace.
- **DataNodes:** Store and manage distributed data blocks.

### 4. YARN Deployment

YARN manages cluster resources and application execution.

- **ResourceManager:** Coordinates resource allocation across the cluster.
- **NodeManagers:** Manage resources and containers on worker nodes.

### 5. MapReduce Processing

MapReduce executes distributed processing jobs using YARN.

The cluster can distribute data processing tasks across multiple worker nodes.

## Installation & Execution

### Prerequisites

- VirtualBox
- Vagrant
- Ansible
- Linux environment or WSL

### Start the infrastructure

```bash
vagrant up
```

### Verify virtual machines

```bash
vagrant status
```

### Execute Ansible playbooks

```bash
ansible-playbook -i inventory/hosts playbooks/install-hadoop.yml
```

```bash
ansible-playbook -i inventory/hosts playbooks/configure-hadoop.yml
```

```bash
ansible-playbook -i inventory/hosts playbooks/start-hdfs.yml
```

```bash
ansible-playbook -i inventory/hosts playbooks/start-yarn.yml
```

*Adapt playbook names and paths to your actual Ansible project.*

## Cluster Verification

### Verify Java processes

```bash
jps
```

Expected processes:

**NameNode:**
- NameNode
- ResourceManager

**DataNodes:**
- DataNode
- NodeManager

### Verify HDFS

```bash
hdfs dfsadmin -report
```

### Verify YARN

```bash
yarn node -list
```

### Access Hadoop Web Interfaces

| Component | URL |
|---|---|
| NameNode UI | http://192.168.56.120:9870 |
| ResourceManager UI | http://192.168.56.120:8088 |

## Key Learning Outcomes

- Building distributed infrastructure using Vagrant.
- Automating infrastructure configuration with Ansible.
- Deploying a multi-node Hadoop cluster.
- Understanding HDFS architecture and distributed storage.
- Managing cluster resources with YARN.
- Understanding distributed processing with MapReduce.
- Applying Infrastructure as Code (IaC) principles.

## Author

**Oumayma Khlif**

Data Engineering Student | Big Data | DataOps | DevOps

