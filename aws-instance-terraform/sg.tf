
# # creating Security group. 

# security group is mutable, means we can change the ingress and egress values. Not the name and other things. 

resource "aws_security_group" "sydney-tf-sg1" {
  name        = "sydney-tf-sg"
  description = "Allows TLS inbound traffic"

  # # like this below ingress section we can create multiple ingres rules to open multiple port for inbound. But if we create multiple ingress rule for multiple inbound port. 
  # # So it will make problem for us only because the code will be getting bigger and bigger.

  # # So for ignoring this repeatation of ingress we use the dynamic blocks. 

  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      description = "This is ingress rule for sydney-tf-sg"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  # Basically we use dynamic block when we have multiple value's for specific block. So rather creating multiple block for different values we can use dynamic block for thoes values. 
  # This above used dynamic block removes the repetative things, like erliear we were creating the different-different ingres block for opening the inbound rules for each port.
  # like below. But we just need to create the above used dynamic block to do same work with different-different variable values. 

  #   ingress {      # # Ingress (Basically we update the inbound rules here in ingress.)
  #     description  = "This is ingress rule for sydney-tf-sg"
  #     from_port    = 22
  #     to_port      = 22
  #     protocol     = "tcp"
  #     cidr_blocks   = ["0.0.0.0/0"]

  # Like this above ingress block we could have created multiple block for the different port, but if we have used the dynamic block, so don't need to create block for each port no. 

  egress { # Egress is an out bound rule, which we use to access the internet, or any-other port which we wanted to connect it. 
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 protocol that mean's it's open for all the protocol
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "sydney-terraform-sg"
  }
}