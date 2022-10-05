# Terraform OCI Always Free Kubernetes Environment
---
This project will make use of the always free compute facilities provided by OCI to create a simple Kubernetes cluster.
This architecture is based on the article found [here](https://medium.com/geekculture/how-to-create-an-always-free-k8s-cluster-in-oracle-cloud-60be3b107c44)

---

**Note:** In the original blog no mention is made of the restriction of 200GB of block storage in the OCI always-free tier.  Boot Volumes in OCI cannot be set smaller than their image size, for Ubuntu this is 47GB, therefore we are limited to 4 compute instances.

* All compute instances have been hosted in the public subnet, however we create both a public and private subnet.  
* Feel free to modify the project to distribute compute between both subnets, some manual configuration will be required on the private instances as the associated ansible scripts only access instances with public IPs at present.
* To make best use of the limited resources available to us K3S has been used to implement our kubernetes cluster, this is the same implementation used by Rancher Desktop.

## Remote State
This project is configured to make use of the remote state configured in the project **remote-state-infra**  please run this project first.

## Prerequisites
* Oracle Cloud Account [link](https://signup.cloud.oracle.com/?language=en&sourceType=:ow:o:p:feb:0916FreePageBannerButton&intcmp=:ow:o:p:feb:0916FreePageBannerButton) 
* Local Terraform install [readme](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* Local ansible install [readme](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* Oracle cloud CLI (used by terraform provider for authentication) [readme](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm) 
* Bash shell

## How to run this project
After running the **remote-state-infra** project perform the following:
1. `terraform init`  
Initialise terraform modules and plugins.
2. `terraform plan`  
Check terraform will create the resources we want.  
3. `terraform apply`  
Apply the terraform and create our environment.
4. `cd scripts`  
Change to scripts directory.
5. `./update-hosts.sh`  
Add entries to /etc/hosts, we can then ssh to our servers using their hostnames.
6. `create-private-ssh-key.sh`  
Writes the private ssh key generate by terraform to *~/.oci/oci_api_key.pem*.
7. `create-inventory.sh`  
Writes inventory.yaml to ansible directory.
8. `create-kubernetes-hosts.sh`   
Generates a temp file of private IPs of compute instances for use by ansible.
9. `echo -E "[defaults]\n host_key_checking = False" > ~/.ansible.cfg`  
Prevent the ssh warning when connecting to a new host in ansible.
10. `cd ../ansible`  
Change to ansible directory.
11. `ansible-playbook -i inventory.yaml kubernetes-setup-playbook.yaml`  
Run the ansible playbook to configure k3s on the compute nodes.
<br/>

### Why Oracle Cloud?  

<img src="./resources/images/confused.png" width="200" align="left"> Oracle cloud offer a very generous alway-free tier offering that will never expire.  As such it presents a great opportunity to develop sandpit environments without risk of running up a large credit card bill when a typical free trial might expire.  Details of what is included in the Oracle Cloud always-free offering can be found [here](https://www.oracle.com/uk/cloud/free/#always-free)

New customers can benefit from 30 days of free access to Oracle Kubernetes Engine and $300 credit to build an OCI managed cluster, but this will incur costs once the trial period expires.

To create a new Oracle Cloud account please follow this [link](https://signup.cloud.oracle.com/?language=en&sourceType=:ow:o:p:feb:0916FreePageBannerButton&intcmp=:ow:o:p:feb:0916FreePageBannerButton) 

<a href="https://www.flaticon.com/free-icons/question" title="question icons">Question icons created by Freepik - Flaticon</a>
