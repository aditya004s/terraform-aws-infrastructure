# AWS Infrastructure Provisioning with Terraform

## 1. Project Overview

In this project, I used Terraform to provision a complete AWS environment.

The goal was to automate the creation of AWS resources instead of manually configuring them through the AWS Console. The infrastructure was built using reusable Terraform modules and includes networking, compute, database and remote state management components.

The deployed infrastructure consists of:

* AWS VPC
* Public Subnets
* Internet Gateway
* Route Tables
* Security Groups
* EC2 Instance
* RDS Database
* S3 Backend for Terraform State
* DynamoDB State Locking

The EC2 instance hosts a simple HTML webpage that is automatically deployed using User Data during instance launch.


## 2. Project Highlights

* Provisioned AWS infrastructure using Terraform
* Created reusable Terraform modules
* Configured remote state storage using Amazon S3
* Implemented state locking using DynamoDB
* Deployed an EC2 web server using User Data
* Created an RDS database inside a subnet


## 3. Infrastructure Components

### a) Amazon S3

Used as a remote backend to store the Terraform state file.

### b) Amazon DynamoDB

Used for Terraform state locking to prevent simultaneous modifications to the state file.

### c) Amazon VPC

Provides an isolated virtual network for all deployed resources.

### d) Public Subnet

Hosts the EC2 web server and allows internet access.

### e) Internet Gateway

Allows communication between the public subnet and the internet.

### f) Route Table

Routes outbound traffic from the public subnet through the Internet Gateway.

### g) Security Group

Controls inbound and outbound traffic for EC2.

### h) EC2 Instance

Hosts a simple HTML webpage deployed automatically using User Data.

### i) DB Subnet Group

Defines the subnet locations where the RDS instance can be deployed.

### j) Amazon RDS

Provides a managed relational database service.


## 4. Why I Used Terraform

Terraform was chosen because it allows infrastructure to be defined in code and deployed in a repeatable way.


## 5. Remote State Management

Instead of storing the Terraform state file locally, I configured a remote backend using Amazon S3.

To prevent multiple Terraform operations from modifying the same state file at the same time, DynamoDB was configured for state locking.


## 6. Terraform Module Structure

The project was organized using custom Terraform modules to keep the code clean and reusable.

Modules created:

* Network Module
* Compute Module
* Database Module

The root configuration calls these modules and passes the required input variables.

This approach makes the infrastructure easier to maintain and allows the same modules to be reused for different environments.


## 7. Security Considerations

The following security practices were followed during implementation:

* Security group rules are restricted to required ports only
* AWS credentials are not hardcoded in Terraform files
* Remote state can be encrypted using S3


## 8. Cost Optimization

To avoid unnecessary AWS charges:

* Resources were deployed only for testing purposes
* Infrastructure was removed using `terraform destroy` after validation
* Lightweight EC2 instance types were used
* Single-AZ RDS deployment was used for the learning environment


## 9. Limitations

Current limitations of the project include:

* Single EC2 instance deployment
* No load balancer
* Single-AZ database deployment

These limitations were acceptable because the main goal of the project was to learn and demonstrate Infrastructure as Code using Terraform.


## 10. Future Enhancements

Possible future improvements include:

* Application Load Balancer (ALB)
* Auto Scaling Groups
* Multi-AZ RDS deployment


## 11. Cleanup

To remove all AWS resources and avoid additional costs:

```bash
terraform destroy
```

All resources were successfully destroyed.
