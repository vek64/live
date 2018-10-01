provider "aws" {
	region = "us-east-1"
}


terraform {
  backend "s3" {
    bucket = "vadim-terraform-state"
    key    = "state/prod/services/webserver-cluster/terraform.tfstate}"
    region = "us-west-2"
  }
}


module "webserver-cluster" {
    source    = "../../../../modules/services/webserver-cluster"

    cluster_name	= "webserver-prod"
    db_remote_state_bucket = "vadim-terraform-state"
    db_remote_state_key = "state/prod/data-stores/mysql/terraform.tfstate"

    server_text = "New server STAGE"

    instance_type = "t2.micro"
    ami = "ami-059eeca93cf09eebd"
    
    min_size		= 2
    max_size		= 9
    enable_autoscaling = true
}
