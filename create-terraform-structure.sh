#!/bin/bash

# Contact: Adey Merrett
# Version 0.1

set -e
# set -ex Terminate on error and output each command

if [ $# -eq 0 ]; then
  echo "Usage: $0 (projectName)"
  echo "No argument supplied."
  exit 1
fi

PROJECT_NAME="$1"

echo 
echo "Creating terraform project structure for: ${PROJECT_NAME}"
echo

# terraform_fnames will create <environment>.tf, <environment>.tfvars, and
# SYMLINKS to the global variables.tf and initialize.tf
# If you change these, change the logic in the inner for loop

declare -a terraform_fnames=('.tf' '.tfvars' 'outputs.tf' 'SYMLINKS')

declare -a main_folders=('dev' 'staging' 'production' 'modules')

declare -a sub_folders=('iam' 's3' 'services/frontend' 'services/backend' 'data-storage' 'vpc')

# Easily defined core folders and files

  mkdir -p ${PROJECT_NAME}/global/{s3,iam}
  mkdir -p ${PROJECT_NAME}/mgmt/{vpc,services,ci,bastion-host}

  touch "${PROJECT_NAME}/variables.tf"
  touch "${PROJECT_NAME}/initialize.tf"

  for main_f in ${main_folders[@]}; do

  # Setup files within each environment folder
		    
    mkdir "${PROJECT_NAME}/${main_f}"

    for fnames_t in ${terraform_fnames[@]}; do
			      
      if [ "$fnames_t" == "outputs.tf" ]; then

	touch "${PROJECT_NAME}/${main_f}/outputs.tf"

      elif [ "$fnames_t" == "SYMLINKS" ]; then
	# Create links to the variables and inital settings that are common to all environments

	ln -s ${PROJECT_NAME}/variables.tf  ${PROJECT_NAME}/${main_f}/variables.tf
	ln -s ${PROJECT_NAME}/initialize.tf  ${PROJECT_NAME}/${main_f}/initialize.tf
      else
        touch "${PROJECT_NAME}/${main_f}/${main_f}${fnames_t}"
      fi
						        
     done # fnames_t

     # setup sub folders in each environment

     for sub_f in ${sub_folders[@]}; do
       mkdir -p "${PROJECT_NAME}/${main_f}/${sub_f}"
     done

done # main_f

echo "Created all files and folders."
echo

# Ensure only owner and group have correct permissions

chmod -R o-rwx "${PROJECT_NAME}"

echo "Permissions have been set to only owner and group."
echo
