
# # Arguments in the terraform is use to provide the perameter and it's value while creating the resource.
# # Attribute in the terraform is used to get the output value from a specific perameter. 

output "security-group-values" {
  value = aws_security_group.sydney-tf-sg1.id
}

output "key-name" {
  value = aws_key_pair.sydney-key.key_name #Now we want the output of key pair name for which we get the attribute from the terraform documentation "key_name"
}

output "instance-ip" {
  value = aws_instance.first-instance-tf.public_ip # This give's us the public up address for the created instance, but we directly don't write the key-pair name because if we change the name we need to manually update the key-pair name every time.
}

output "instance-id" {
  value = aws_instance.first-instance-tf.id
}