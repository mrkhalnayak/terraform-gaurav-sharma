
# if this file name have terraform.tfvars then it wont ask and command extension while executing but if we have change the file name then we need to give the specific #
# file name while executing and then only if will be executing. like below. #
# < terraform plan -var-file=development.tfvars > if the file name is not terraform.tfvars then we need to use < -var-file=filename > where the variable has been kept #

age = 27
username = "Shriyanshu Dwivedi"