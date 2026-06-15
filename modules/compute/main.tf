resource "aws_security_group" "web_sg"{
	name="web-security-group"
	vpc_id=var.vpc_id
	ingress{
		description="SSH Access"
		from_port=22
		to_port=22
		protocol="tcp"
		cidr_blocks=["0.0.0.0/0"]
	}
	ingress{
		description="HTTP Access"
		from_port=80
		to_port=80
		protocol="tcp"
		cidr_blocks=["0.0.0.0/0"]
	}
	egress{
		from_port=0
		to_port=0
		protocol="-1"
		cidr_blocks=["0.0.0.0/0"]
	}
	tags={
		Name="web-sg"
	}
}
resource "aws_instance" "web"{
	ami="ami-0c02fb55956c7d316"
	instance_type="t3.micro"
	subnet_id=var.subnet_id
	vpc_security_group_ids=[aws_security_group.web_sg.id]
	user_data=<<-EOF
		#!/bin/bash
		yum update -y
		yum install -y httpd
		systemctl start httpd
		systemctl enable httpd
		cat <<HTML > /var/www/html/index.html
		<!DOCTYPE html>
		<html lang="en">
		<head>
  			<meta charset="UTF-8">
  			<meta name="viewport" content="width=device-width, initial-scale=1.0">
  			<title>Terraform AWS Infrastructure</title>
  			<style>
    				body {
      					font-family: Arial, Helvetica, sans-serif;
      					background-color: #0f1117;
      					color: #e2e8f0;
      					margin: 0;
      					padding: 0;
    				}

    				.container {
      					max-width: 800px;
      					margin: 80px auto;
      					background: #1a1d27;
      					border: 1px solid #2d3148;
      					padding: 50px 40px;
      					border-radius: 10px;
      					text-align: center;
    				}

    				.status {
      					display: inline-block;
      					padding: 6px 16px;
      					background: #0f2d1a;
      					border: 1px solid #166534;
      					border-radius: 20px;
      					color: #4ade80;
      					font-size: 0.8rem;
      					letter-spacing: 0.08em;
      					margin-bottom: 30px;
    				}

    				h1 {
      					font-size: 2rem;
      					color: #f1f5f9;
      					margin: 0 0 10px;
    				}

    				h2 {
      					font-weight: normal;
      					font-size: 1rem;
      					color: #64748b;
      					margin: 0 0 30px;
    				}

    				.tags {
      					display: flex;
      					justify-content: center;
      					flex-wrap: wrap;
      					gap: 10px;
      					margin-bottom: 30px;
    				}

    				.tag {
      					padding: 5px 14px;
      					background: #1e2240;
      					border: 1px solid #3b4170;
      					border-radius: 6px;
      					font-size: 0.85rem;
      					color: #a5b4fc;
    				}

    				p {
      					color: #94a3b8;
      					line-height: 1.7;
      					max-width: 500px;
      					margin: 0 auto;
    				}

    				p strong {
      					color: #c7d2fe;
    				}
  			</style>
		</head>
		<body>
  			<div class="container">

    			<div class="status">&#x25CF; All systems operational</div>

    			<h1>Infrastructure Deployed</h1>
    			<h2>Provisioned with Terraform on AWS</h2>

    			<div class="tags">
      				<span class="tag">VPC</span>
      				<span class="tag">EC2</span>
      				<span class="tag">RDS</span>
      				<span class="tag">S3 Remote State</span>
      				<span class="tag">DynamoDB State Locking</span>
    			</div>

    			<p>
      				This environment was provisioned using <strong>Terraform</strong>,
      				where AWS services like VPC, EC2, RDS, S3 and DynamoDB have been used.
    			</p>

  			</div>
		</body>
		</html>
		HTML
		EOF
	tags={
		Name="terraform-web-instance"
	}
}
