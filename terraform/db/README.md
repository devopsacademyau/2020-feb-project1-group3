##Prerequisites for creating Aurora DB
### Create a VPC and Subnets
You can only create an Amazon Aurora DB cluster in a Virtual Private Cloud (VPC) that spans two Availability Zones, and each zone must contain at least one subnet. You can create an Aurora DB cluster in the default VPC for your AWS account, or you can create a user-defined VPC.

We will create a VPC which spans two AZs and each AZ will have a subnet.
#### Create a VPC using console

##### VPC Dashboard->Start VPC Wizard->VPC with a Single Public Subnet
##### Set the following rules
- IP CIDR block: 10.0.0.0/16
- VPC name: gs-cluster-vpc
- Public subnet: 10.0.0.0/24
- Availability Zone: ap-southeast-2a
- Subnet name: gs-subnet-public-a
- Enable DNS hostnames: Yes
- Hardware tenancy: Default 
##### Add additional subnets
VPC Dashboard -> Subnets -> Create subnet
- name tag: gs-subnet-public-b
- VPC: gs-cluster-vpc
- Availability Zone: ap-southeast-2b
- CIDR block: 10.0.10.0/24

same way to create *gs-subnet-private-a(10.0.1.0/24)* and *gs-subnet-private-b(10.0.11.0/24)*
Note: make sure the 2nd subnet use the same route table as the first one.

### Create a Security Group and Add Inbound Rules
VPC Dashboard -> Security Groups -> Create Security Group
- Name tag: gs-securitygroup1
- Group name: gs-securitygroup1
- Description: Getting Started Security Group
- VPC: gs-cluster-vpc

#### Inbound rules
All Trafffic, All Protocal, All Port range, source(0.0.0.0/0 only works for testing environment, in producation should only allow a public ip to access the db instance, use https://checkip.amazonaws.com to determine your public IP)


### Create a DB Subnet Group
The last thing that you need before you can create an Aurora DB cluster is a DB subnet group. Your DB subnet group identifies the subnets that your DB cluster uses from the VPC that you created in the previous steps. Your DB subnet group must include at least one subnet in at least two of the Availability Zones in the AWS Region where you want to deploy your DB cluster.

rds ->subnet groups -> Create DB Subnet group
- Name:gs-subnetgroup
- Description: Getting Started Subnet Group
- VPC Id:gs-cluster-vpc

Choose *Add all the subnets related to this VPC*

## Creating a DB Cluster and Connecting to a Database on an Aurora MySQL DB Cluster
Amazon RDS -> Databases ->  Create database 
- Engine type: Amazon Aurora
- Edition: Amazon Aurora with MySQL 5.6 compatibility
- DB instance size:  Dev/Test
- DB cluster identifier: database-1
- Master username: admin
- Password: admin12345
- Create database

To connect to the DB instance as the master user, use the user name and password that appear.

Depending on the DB instance class and the amount of storage, it can take up to 20 minutes before the new DB cluster is available.

## Connect to an Instance in a DB Cluster
Choose *Databases* and then choose the DB cluster name to show its details. On the *Connectivity & security* tab, copy the value for the *Endpoint name* of the *Writer* endpoint. Also, note the *port number* for the endpoint.

Use the cluster endpoint to connect to the primary instance, and the master user name that you created previously. (You are prompted for a password.) If you supplied a port value other than 3306, use that for the -P parameter instead.
```
mysql -h <cluster endpoint> -P 3306 -u <mymasteruser> -p						
````





Reference （https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_GettingStartedAurora.CreatingConnecting.Aurora.html）

