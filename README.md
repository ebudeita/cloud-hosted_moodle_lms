# Cloud-hosted Moodle LMS on AWS
I designed and deployed a cloud-hosted Moodle Learning Management System (LMS) on AWS using Terraform. The project demonstrates how an educational institution or training organization can host an online learning platform in the cloud while separating the application and database layers and applying secure AWS networking practices.
Moodle runs on an Amazon EC2 instance using Ubuntu Linux, Apache, and PHP, while course, user, and application data are stored in an Amazon RDS MySQL database. The supporting AWS infrastructure—including the VPC, public and private subnets, route tables, Internet Gateway, security groups, EC2 instance, and RDS resources—was provisioned using Terraform.

After deployment, I configured Moodle and created a sample **Introduction to Freelancing** course to demonstrate the LMS from infrastructure provisioning through to the end-user learning experience.

---

## Project Objectives

The primary goals of this project were to:

* Deploy a real-world education application on AWS.
* Use Terraform to provision infrastructure as code.
* Separate the application and database tiers using public and private subnets.
* Restrict database access to the Moodle web server.
* Gain hands-on experience deploying and troubleshooting applications on Linux.
* Demonstrate how cloud infrastructure supports an operational Learning Management System.
* Build a repeatable environment that can be deployed and destroyed when required to control cloud costs.

---

## Architecture

The environment is deployed inside an AWS VPC with both public and private subnets across two Availability Zones.

The Moodle application runs on an Amazon EC2 instance located in a public subnet. The EC2 instance uses Ubuntu Linux with Apache and PHP to serve the Moodle application.

Amazon RDS for MySQL provides the database layer and is deployed within private database subnets, preventing direct public access.

Users access Moodle over HTTP through the Internet Gateway. When Moodle requires application data, the EC2 instance communicates with Amazon RDS over MySQL port 3306.

Security groups control communication between the different components. HTTP traffic is permitted to the web server, SSH administration is restricted to an authorized IP address, and the RDS security group accepts MySQL traffic only from the EC2 web server security group.

---

## AWS Services & Technologies

**Cloud Infrastructure**

* Amazon EC2
* Amazon RDS for MySQL
* Amazon VPC
* Public and Private Subnets
* Internet Gateway
* Route Tables
* Security Groups
* Amazon EBS
* IAM

**Infrastructure & Administration**

* Terraform
* Linux / Ubuntu
* Bash
* SSH
* Git

**Application Stack**

* Moodle LMS
* Apache HTTP Server
* PHP
* MySQL

---

## Infrastructure as Code

Rather than manually creating the AWS environment through the AWS Management Console, I used **Terraform** to provision the infrastructure.

The Terraform configuration creates and manages resources including:

* VPC
* Public and private subnets
* Internet Gateway
* Route tables
* Security groups
* EC2 instance
* RDS MySQL database
* DB subnet group
* IAM resources
* Supporting networking components

This makes the environment **repeatable, reusable, and easier to deploy or tear down** when it is no longer required.

---

## Application Deployment

After Terraform provisioned the infrastructure, the EC2 instance was configured to host Moodle.

The deployment process included:

1. Launching an Ubuntu EC2 instance.
2. Installing Apache, PHP, Git, and required PHP extensions.
3. Downloading the Moodle application from its Git repository.
4. Creating and configuring the Moodle data directory.
5. Configuring file permissions.
6. Configuring the Apache virtual host.
7. Connecting Moodle to the RDS MySQL database.
8. Completing the Moodle web installation.
9. Configuring the LMS environment.
10. Creating a sample **Introduction to Freelancing** course to validate the deployment.

---

## Security Implementation

Security was incorporated into the architecture by separating the application and database layers.

The Amazon RDS database is located within private subnets and is not publicly accessible. Its security group permits MySQL traffic on port 3306 only from the security group associated with the Moodle EC2 instance.

The EC2 security group allows HTTP traffic for application access while SSH administration is restricted to an authorized IP address.

This approach reduces unnecessary exposure of the database while allowing the web application to communicate with it securely.

---

## Troubleshooting & Challenges

One of the most valuable parts of this project was troubleshooting the deployment when the Moodle application initially failed to load.

Although Terraform successfully created the AWS infrastructure, the application installation did not complete correctly. I connected to the EC2 instance using SSH and investigated the deployment by checking the status of Apache, verifying the Moodle installation directory, reviewing `cloud-init` and user-data logs, and checking installed PHP packages.

The logs revealed that the EC2 user-data script had failed during package installation, preventing the remaining Moodle configuration steps from executing. I identified the problematic package, modified the user-data script, and redeployed the infrastructure.

I also encountered connectivity issues caused by changes to the IP address used for restricted SSH access. I reviewed and corrected the relevant security-group configuration before continuing troubleshooting.

After correcting the deployment script and networking configuration, `cloud-init` completed successfully, Apache started correctly, Moodle was installed, and the application became accessible through the EC2 public address.

This troubleshooting process gave me practical experience moving through multiple layers of a cloud application—from AWS networking and security groups to EC2, Linux services, application dependencies, logs, and application configuration.

---

## Lessons Learned

This project reinforced several important cloud engineering concepts.

**Infrastructure deployment and application deployment are different layers.** A successful `terraform apply` confirms that the infrastructure was provisioned, but it does not necessarily mean that the application running on that infrastructure deployed successfully.

**Logs are essential for troubleshooting.** Reviewing `cloud-init` and user-data logs allowed me to identify exactly where the automated installation failed rather than repeatedly recreating resources without understanding the underlying problem.

**Networking should be investigated systematically.** When the application was unreachable, I learned to work through the connection path—including public IP addressing, security groups, ports, Internet Gateway connectivity, and the application service itself.

**Automation must account for operating-system and package compatibility.** A dependency that is unavailable or has changed in a newer Ubuntu release can cause an entire automated deployment script to stop.

**Security groups can be used to control communication between application tiers.** Rather than exposing MySQL publicly, the RDS security group trusts only the web server security group on port 3306.

**Infrastructure as Code makes experimentation much easier.** Because the infrastructure was defined in Terraform, I could destroy the environment to avoid unnecessary AWS charges and recreate it when I was ready to continue working.

Most importantly, the project strengthened my troubleshooting mindset. Instead of treating deployment errors as failures, I learned to use logs, service status commands, networking tests, and incremental validation to isolate and resolve problems.

---

## Final Result

The final deployment produced a functioning Moodle Learning Management System hosted on AWS.

To demonstrate the complete solution, I created an **Introduction to Freelancing** course inside Moodle, showing that the infrastructure successfully supports a real educational workload rather than simply displaying a test webpage.

The project connects my previous experience in education and learning platforms with my developing cloud engineering skills and demonstrates how AWS infrastructure can be used to support modern online learning environments.

---

## Future Improvements

A future production-oriented version of the architecture could include:

* HTTPS using AWS Certificate Manager
* Application Load Balancer
* Auto Scaling for the Moodle web tier
* Amazon Route 53 for custom DNS
* Amazon S3 for appropriate application assets and backups
* Amazon CloudWatch monitoring, logs, and alarms
* Automated backups and disaster-recovery planning
* AWS Secrets Manager or Systems Manager Parameter Store for secret management
* CI/CD integration
* Additional hardening and least-privilege IAM controls
* Multi-AZ RDS deployment for increased availability

These enhancements would evolve the current portfolio environment into a more highly available, secure, observable, and production-oriented architecture.

---

## Key Skills Demonstrated

**AWS:** EC2, RDS, VPC, IAM, EBS, Security Groups, Subnets, Internet Gateway, Route Tables

**Infrastructure as Code:** Terraform

**Operating Systems:** Linux / Ubuntu

**Web Technologies:** Apache, PHP, Moodle

**Database:** MySQL / Amazon RDS

**Cloud Networking:** VPC design, public/private subnet architecture, security-group communication, ports and routing

**Administration & Troubleshooting:** SSH, Linux commands, `systemctl`, cloud-init logs, application logs, connectivity testing, dependency troubleshooting

**Education Technology:** Learning Management Systems, Moodle administration, online course deployment

---

## Demo Video

**Watch the full project walkthrough:**
(https://youtu.be/djsLvj-M31E)

The demo covers the architecture, Terraform deployment, AWS resources, Moodle configuration, database connectivity, and the completed Introduction to Freelancing course.
