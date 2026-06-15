resource "aws_s3_bucket" "s3-bucket"{
	bucket="terraform-state-aditya004"
}

resource "aws_dynamodb_table" "dynamodb-table"{
	name="terraform-state-lock"
	hash_key="LockID"
	billing_mode="PAY_PER_REQUEST"
	attribute{
		name="LockID"
		type="S"
	}
}
module "network"{
	source="./modules/network"
	vpc_cidr="10.0.0.0/16"
	public_subnet_1_cidr="10.0.1.0/24"
	public_subnet_2_cidr="10.0.2.0/24"
	az_1="us-east-1a"
	az_2="us-east-1b"
}
module "compute"{
	source="./modules/compute"
	vpc_id=module.network.vpc_id
	subnet_id=module.network.public_subnet_ids[0]
}
module "database"{
	source="./modules/database"
	subnet_ids=module.network.public_subnet_ids
	db_name="appdb"
	db_username="admin"
	db_password="password123"
}
