provider "aws" {
	region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "vadim-terraform-state"
    key    = "state/prod/data-stores/mysql/terraform.tfstate"
    region = "us-west-2"
  }
}

resource "aws_db_instance" "example" {
	engine = "mysql"
	allocated_storage = 15
	instance_class = "db.t2.micro"
	name = "example_database"
	username = "admin"
	password = "${var.db_vek_password}"
	
	skip_final_snapshot = true

}
