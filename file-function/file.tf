
### Here we can see that we are using the function "path.module" which basically prints module's directroy

output "printfile" {
  value = file ("${path.module}/file.txt") #along with the module directory we can print the avaliable files and directy also by adding file and directroy name into "/<file/directiiory>name"
}

# Now here above we have add the "path module and file name inside the file functon which print the path module, file name and file's content also.
# file() - this a file function.
# ${path.module} - which print's the module directory 
# /file.txt - file which carries the content.

# Now if we thing we just want to print the file content by using the file-function so why we use the ${path.module}, 
# because if we don't print the module directory first it will not be able to understand that where the "/file.txt" has kept.

# File function only work's for the file content not for the directory, so if we want to print the directory, so we just need to use the "${path.module}/<directory-name>"