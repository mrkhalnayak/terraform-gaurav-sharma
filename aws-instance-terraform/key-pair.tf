# ### here we are gona update the resource information and code.

# #creating the ssh-key.

resource "aws_key_pair" "sydney-key" {
  key_name   = "sydney-key-tf"
  public_key = file("${path.module}/id_rsa.pub")
  # here we can copy the public key which we have created through ssh-key or we can use the file-function which read the public key directly from there it'self.
}
