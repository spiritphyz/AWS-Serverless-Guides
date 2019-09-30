# Requirements
  * **unzip** utility is installed
      * Ubuntu: `sudo apt-get install unzip`
      * macOS: `brew install unzip`
  * **jq** JSON utility is installed
      * Ubuntu: `sudo apt-get install jq`
      * macOS: `brew install jq`

# Install Terraform
  * Find latest Ubuntu version and install it
    ```bash
    TF_CURR_VER="$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M '.current_version')"
    TF_DL_LINK="$(echo \"https://releases.hashicorp.com/terraform/${TF_CURR_VER}/terraform_${TF_CURR_VER}_linux_amd64.zip\")"
    echo "${TF_DL_LINK}" | xargs curl -O
    unzip $(echo "terraform_${TF_CURR_VER}_linux_amd64.zip")
    sudo mv terraform /usr/local/bin/
    terraform -v # the version number installed should be listed
    ```
  * Find latest macOS version and install it
echo "https://releases.hashicorp.com/terraform/$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M '.current_version')/terraform_$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M '.current_version')_darwin_amd64.zip"


# Resources
  * https://github.com/hashicorp/terraform/issues/9803
