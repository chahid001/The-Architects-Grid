# 🚀 VPC Architecture’s Grid Project 🌐
This project demonstrates a **highly available, scalable VPC architecture** using **AWS** and **Terraform**. The architecture consists of multiple VPCs with both public and private subnets, an autoscaling group, and a bastion host for secure access. A **load balancer** distributes traffic across the app servers, ensuring reliability and availability.

---

## 📜 Architecture Overview
![archi](https://github.com/chahid001/The-Architects-Grid/blob/main/assets/aws-archi.png)
### 🛠️ Components:
- **2 VPCs**: 
  - VPC 1: `192.168.0.0/16` (contains the bastion host)
  - VPC 2: `172.28.0.0/16` (contains public and private subnets)
- **Subnets**: 
  - VPC 1: Public subnet with an elastic IP
  - VPC 2: 3 public subnets (A, B, C) and 2 private subnets (A, B)
- **Internet Gateways (IGWs)**: One per VPC for internet access
- **NAT Gateway**: Provides internet access for private subnets
- **Transit Gateway**: Enables routing between VPC 1 and VPC 2
- **Bastion Host**: EC2 instance in VPC 1 for secure access via SSH
- **Launch Template**: EC2 instances created with a golden AMI, Apache server, and CloudWatch agent preconfigured
- **Application Load Balancer (ALB)**: Distributes traffic across the instances in private subnets (zones A and B)
- **Auto Scaling Group**: Ensures dynamic scaling of the instances

---

## 🔍 Key Concepts

- **Golden AMI**: Preconfigured AMI with Apache, CloudWatch Agent, and additional configurations, enabling streamlined scaling.
- **Transit Gateway**: A service that connects VPCs to a centralized gateway, enabling seamless cross-VPC communication.
- **NAT Gateway**: Allows private instances to access the internet while keeping them secure from inbound traffic.
- **Bastion Host**: A public EC2 instance used to securely access private instances in the VPC.

---

## 📁 Variable Definitions (variables.tf)

```hcl
variable "ANS" {
  default = <YOUR ASN>
}

variable "ami-bastion" {
    default = <YOUR BASTION AMI ID>
}

variable "key-name" {
    default = <KEY PAIR NAME>
}

variable "golden-ami" {
    default = <YOUR GOLDEN AMI ID>
}

variable "app-vm-role" {
   default = <YOUR ROLE NAME>
}
```
---

## ⚙️ Deployment Steps
### **Manual Steps**:

1. **Create Golden AMI**:
   - Install **Apache**, **Git**, and **CloudWatch Agent** on a base EC2 instance.
   - Push custom **memory metrics** to **CloudWatch**.

```json
    {
        "metrics":{
           "metrics_collected":{
              "mem":{
                 "measurement":[
                    "mem_used_percent"
                 ],
                 "metrics_collection_interval":60
              }
           },
           "append_dimensions": {
             "InstanceId": "${aws:InstanceId}"
           }
        }
    }
``` 
  - Copy the metrics file to :
        ```bash
                /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
        ``` 
   - Save this as an **AMI** to be used for auto-scaling instances.
   
3. **S3 Bucket**:
   - Create an **S3 bucket** and upload the app (`index.html`).

### **Terraform Steps**:

1. Clone the repository and initialize Terraform:
   ```bash
   git clone https://github.com/your-repo/vpc-architecture-grid.git
   cd Terraform
   terraform init
   ```
2. Plan and apply Terraform configuration:
   ```bash
   terraform plan
   terraform apply
   ```
3. Once deployed, SSH into the **bastion host** using the public IP for testing:
   ```bash
   ssh -i ~/.ssh/your-key.pem ec2-user@<bastion-public-ip>
   ```
4. Access your app through the **Load Balancer DNS name** in a browser.

---

## 🚀 Features:

- **Highly available architecture** across multiple availability zones
- **Dynamic scaling** with **autoscaling groups**
- **Secure communication** between VPCs with a **Transit Gateway**
- **Load balancer** for traffic distribution
- **Bastion Host** for secure SSH access to private subnets

---

## 📋 Future Improvements:

- Implement HTTPS with an SSL certificate on the load balancer
- Add more robust logging and monitoring with CloudWatch
- Enable autoscaling policies based on CPU and memory utilization

---

## 📝 Conclusion:

This project demonstrates a complete end-to-end architecture with **high availability**, **security**, and **scalability** in mind. By utilizing **Terraform**, this deployment is fully automated and ready to handle traffic dynamically. 🎉
