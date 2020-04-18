## Prerequisites for creating Aurora DB
### Create a VPC and Subnets
You can only create an Amazon Aurora DB cluster in a Virtual Private Cloud (VPC) that spans two Availability Zones, and each zone must contain at least one subnet. You can create an Aurora DB cluster in the default VPC for your AWS account, or you can create a user-defined VPC.
## Aurora db 
The rds.tf provides example code for creating a aurora db cluster and instances.

### Prerequisites for creating Aurora DB
#### Create a VPC and Subnets
You can only create an Amazon Aurora DB cluster in a Virtual Private Cloud (VPC) that spans two Availability Zones, and each zone must contain at least one subnet. And the rds needs to be deployed to private subnet, so the instance won't be access externally. For this rds.tf, it is expecting vpc and subnet group from other module. VPC module will output vpc id and a subnet group which contains two private subnets.

We will create a VPC which spans two AZs and each AZ will have a subnet.
#### Create a VPC using console
This is an example of how to create vpc and subnets in aws console.

##### VPC Dashboard->Start VPC Wizard->VPC with a Single Public Subnet
##### Set the following rules
@@ -24,7 +28,7 @@ VPC Dashboard -> Subnets -> Create subnet
same way to create *gs-subnet-private-a(10.0.1.0/24)* and *gs-subnet-private-b(10.0.11.0/24)*
Note: make sure the 2nd subnet use the same route table as the first one.

### Create a Security Group and Add Inbound Rules
#### Create a Security Group and Add Inbound Rules
VPC Dashboard -> Security Groups -> Create Security Group
- Name tag: gs-securitygroup1
- Group name: gs-securitygroup1
@@ -35,7 +39,7 @@ VPC Dashboard -> Security Groups -> Create Security Group
All Trafffic, All Protocal, All Port range, source(0.0.0.0/0 only works for testing environment, in producation should only allow a public ip to access the db instance, use https://checkip.amazonaws.com to determine your public IP)


### Create a DB Subnet Group
#### Create a DB Subnet Group
The last thing that you need before you can create an Aurora DB cluster is a DB subnet group. Your DB subnet group identifies the subnets that your DB cluster uses from the VPC that you created in the previous steps. Your DB subnet group must include at least one subnet in at least two of the Availability Zones in the AWS Region where you want to deploy your DB cluster.

rds ->subnet groups -> Create DB Subnet group
@@ -45,7 +49,8 @@ rds ->subnet groups -> Create DB Subnet group

Choose *Add all the subnets related to this VPC*

## Creating a DB Cluster and Connecting to a Database on an Aurora MySQL DB Cluster
### Creating a DB Cluster and Connecting to a Database on an Aurora MySQL DB Cluster

Amazon RDS -> Databases ->  Create database 
- Engine type: Amazon Aurora
- Edition: Amazon Aurora with MySQL 5.6 compatibility
@@ -59,7 +64,7 @@ To connect to the DB instance as the master user, use the user name and password

Depending on the DB instance class and the amount of storage, it can take up to 20 minutes before the new DB cluster is available.

## Connect to an Instance in a DB Cluster
### Connect to an Instance in a DB Cluster
Choose *Databases* and then choose the DB cluster name to show its details. On the *Connectivity & security* tab, copy the value for the *Endpoint name* of the *Writer* endpoint. Also, note the *port number* for the endpoint.

Use the cluster endpoint to connect to the primary instance, and the master user name that you created previously. (You are prompted for a password.) If you supplied a port value other than 3306, use that for the -P parameter instead.