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

This project deploys and configures a **three-node Apache Hadoop cluster** using Vagrant, VirtualBox, and Ansible.

The cluster uses HDFS for distributed storage, YARN for resource management, and MapReduce configured to run on YARN. Vagrant provisions the virtual machines; a centralized Ansible playbook applies the configuration through reusable roles.

## Architecture

The cluster consists of three virtual machines:

| Node | IP Address | Responsibilities |
|---|---|---|
| `namenode` | `192.168.56.120` | HDFS NameNode, YARN ResourceManager |
| `datanode1` | `192.168.56.121` | HDFS DataNode, YARN NodeManager |
| `datanode2` | `192.168.56.122` | HDFS DataNode, YARN NodeManager |

### Infrastructure specifications

- 3 virtual machines
- 2 GB RAM and 2 CPU cores per machine
- Static private IP addresses
- VirtualBox provider
- `lubuntu-base` Vagrant box

## Technologies

| Technology | Purpose |
|---|---|
| Apache Hadoop 3.3.6 | Distributed computing framework |
| HDFS | Distributed file storage |
| YARN | Cluster resource management |
| MapReduce | Distributed data processing, configured to use YARN |
| Vagrant | Virtual machine provisioning |
| VirtualBox | Virtualization provider |
| Ansible | Configuration management and automation |
| OpenJDK 8 | Hadoop runtime; installed by the Ansible `java` role |
| Lubuntu | Guest operating system provided by the `lubuntu-base` box |

## Deployment workflow

The Vagrantfile creates the three VMs, but does **not** run Ansible provisioning itself. The Ansible playbook is in the `ansible/` directory and must be run separately.

The playbook waits for SSH connectivity, gathers facts, then runs these roles on the hosts in the `hadoop` inventory group:

| Role | Responsibilities |
|---|---|
| `java` | Installs OpenJDK 8. |
| `ssh` | Creates a key on the NameNode and authorizes it for the `oumayma` account on the cluster nodes, allowing passwordless SSH from the NameNode. |
| `hadoop` | Downloads and extracts Hadoop 3.3.6 on each inventory host, then configures Hadoop and the cluster hostnames. |
| `hdfs` | Formats the NameNode on first deployment and starts HDFS from the NameNode. |
| `yarn` | Starts the ResourceManager on the NameNode and NodeManagers on the DataNodes. |

## Installation and deployment

### Prerequisites

Install the following on the host machine:

- VirtualBox
- Vagrant
- Ansible
- An SSH client

The host must also have the network range used by the Vagrant private addresses available. The repository includes `lubuntu-base.box`; Vagrant must know the box under the name `lubuntu-base`.

### 1. Clone the repository

```bash
git clone https://github.com/OumaymaKhlif/Hadoop-Distributed-Cluster.git
cd Hadoop-Distributed-Cluster
```

### 2. Register the included Vagrant box (if it is not already registered)

```bash
vagrant box add lubuntu-base ./lubuntu-base.box
```

If Vagrant reports that the box is already registered, you can skip this step.

### 3. Check and update the Ansible inventory

Before running Ansible, open `ansible/inventory.ini`. Its SSH private-key paths are currently set to `/home/user/.ssh/hadoop/namenode_key`, `/home/user/.ssh/hadoop/datanode1_key`, and `/home/user/.ssh/hadoop/datanode2_key`. Replace these with the correct, existing private-key paths for your environment and ensure the keys provide SSH access to the Vagrant guests. The inventory connects as `vagrant`; the playbook's tasks that manage Hadoop services use the guest account `oumayma`.

### 4. Provision the virtual machines

From the repository root:

```bash
vagrant up
vagrant status
```

The Vagrantfile defines `namenode`, `datanode1`, and `datanode2` with the IP addresses listed above.

### 5. Run the Ansible playbook

Run Ansible from the `ansible/` directory so that its `ansible.cfg` and relative inventory settings are applied:

```bash
cd ansible
ansible-playbook -i inventory.ini playbook.yml
```

## Cluster verification

After the playbook completes, connect to the relevant VM, switch to the `oumayma` account, and load its shell environment before using Hadoop commands. For example:

```bash
vagrant ssh namenode
sudo -iu oumayma
source ~/.bashrc
```

### Check Java processes

Run `jps` on each VM. Expected Hadoop processes include:

- **NameNode:** `NameNode` and `ResourceManager`
- **DataNodes:** `DataNode` and `NodeManager`

### Verify HDFS

On the NameNode:

```bash
hdfs dfsadmin -report
```

This reports DataNode status and HDFS capacity information.

### Verify YARN

On the NameNode:

```bash
yarn node -list
```

This lists the registered NodeManagers.

## Hadoop web interfaces

| Component | URL |
|---|---|
| NameNode Web UI | http://192.168.56.120:9870 |
| ResourceManager Web UI | http://192.168.56.120:8088 |

## Key learning outcomes

- Designing and provisioning multi-node infrastructure with Vagrant.
- Applying Infrastructure as Code principles.
- Automating configuration with Ansible roles.
- Configuring passwordless SSH from the NameNode to cluster nodes.
- Deploying and managing HDFS and YARN services.
- Configuring MapReduce to use YARN.

## Author

**Oumayma Khlif**

Data Engineering Student
