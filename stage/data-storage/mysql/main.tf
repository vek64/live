provider "aws" {
	region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "vadim-terraform-state"
    key    = "state/stage/data-stores/mysql/terraform.tfstate"
    region = "us-west-2"
  }
}

resource "aws_db_instance" "example" {
	engine = "mysql"
	allocated_storage = 12
	instance_class = "db.t2.micro"
	name = "example_database"
	username = "admin"
	password = "${var.db_vek_password}"
	
	skip_final_snapshot = true

}
