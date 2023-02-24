resource "null_resource" "null_name" {
    depends_on = [
      module.ec2_bastion,
      module.ec2_private,
      module.ec2_bastion
    ]
  #connection block for provisioners to connect to EC2
  connection {
    type = "ssh"
    host = aws_eip.bastioneip.public_ip
    user = "ec2-user"
    password = ""
    private_key = file("clouddirty.pem")

  }

  provisioner "file" {
    source      = "clouddirty.pem"
    destination = "/tmp/clouddirty.pem"
  }
  # Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/clouddirty.pem"
    ]
  }  
#   # local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
#   provisioner "local-exec" {
#     command = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
#     working_dir = "local-exec-output-files/"
#     #on_failure = continue
#   }
# ## Local Exec Provisioner:  local-exec provisioner (Destroy-Time Provisioner - Triggered during deletion of Resource)
#   provisioner "local-exec" {
#     command = "echo Destroy time prov `date` >> destroy-time-prov.txt"
#     working_dir = "local-exec-output-files/"
#     when = destroy
#     #on_failure = continue
#   }    
}
