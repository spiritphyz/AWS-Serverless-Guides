# Setting up AWS CLI tools
Manage AWS services through terminal utilities.

## Install Python 3 with Homebrew
MacOS Homebrew installs `pip3` for you along with Python 3.

```sh
brew install python
```

## Install AWS CLI
The `--upgrade` option tells pip3 to upgrade any requirements that are already installed. The `--user` option tells pip3 to install the program to a subdirectory in your user directory to avoid modifying libraries used by your operating system.

```sh
pip3 install awscli --upgrade --user
```

## Add AWS to your path
On macOS, edit the `.bash_profile` file in your home directory (`/Users/yourusername/.bash_profile`).
  1. If you don't have a PATH variable set already, then add:
      * `export PATH=/Users/yourusername/Library/Python/3.7/bin`
  2. If you already have a PATH set, append it to the existing variable:
      * `export PATH=/usr/local/bin:$PATH:/Users/yourusername/Library/Python/3.7/bin`
  3. Save your changes to `.bash_profile` and exit
  4. Reload the environment variables
      * `source ~/.bash_profile`

Check to see if the AWS tools are available everywhere:
```sh
aws --version
```

# Resources
  * https://docs.python-guide.org/starting/install3/osx/
  * https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
  * https://docs.aws.amazon.com/cli/latest/userguide/install-macos.html

