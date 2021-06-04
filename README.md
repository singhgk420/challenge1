Three Tier Architecture:-

A three-tier architecture is a software architecture pattern where the application is broken down into three logical tiers:
the presentation layer, the business logic layer and the data storage layer.This architecture is used in a client-server
application such as a web application that has the frontend, the backend and the database.
Amazon Web Service (AWS) is a cloud platform that provides different cloud computing services to their customers.

we shall be making use of the following AWS services to design and build a three-tier cloud infrastructure:
Elastic Compute Cloud(EC2)
Auto Scaling Group,
Virtual Private Cloud(VPC),
Elastic Load Balancer (ELB),
Security Groups and the Internet Gateway

Following steps have been followed while creating our infrastructre.
1)Setup the Virtual Private Cloud (VPC):
our VPC is Test-vpc with cidr 10.0.0.0/16

2. Setup the Internet Gateway: 
our Internet gateway is Test-IG attached to Test-vpc.

3. Create 4 Subnets: two public and two private
subnet1(10.0.1.0/24) and subnet2(10.0.2.0/16) are public subnet
subnet3(10.0.3.0/16) and subnet4(10.0.4.0/16) are private subnet

4. Create Two Route Tables:
private route table and public route table

5. Create the NAT Gateway:

6. Create Elastic Load Balancer:
From our architecture, our frontend tier can only accept traffic from the elastic load balancer
which connects directly with the internet gatewaywhile our backend tier will receive traffic
through the internal load balancer.
Configured the Load Balancer with a name.
internet facing for the load balancer that we will use to communicate 
with the frontend and internal for the one we will use for our backend.
For instance, we need to allow HTTP port 80 and/or HTTPS port 443 on our internet facing load balancer
For the internal load balancer, we only open the port that the backend runs on (eg: port3000)
then we configure our listeners. 1)front_end 2)back_end and then 
we need to configure our Target Group We have given the Target Group a name that will enable us to identify it.
1)frontend_tg 2)backend_tg

7. Auto Scaling Group: two asg will be created one for frontend and other for backend.


