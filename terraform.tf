terraform{
	backend "s3"{
		bucket="terraform-state-aditya004"
		key="terraform.tfstate"
		region="us-east-1"
		dynamodb_table="terraform-state-lock"
		encrypt=true
	}
}
