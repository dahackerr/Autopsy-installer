#!/usr/bin/perl


=begin comment
This script will contain the commands to install the Autopsy dependencies and Autopsy itself
If you want to find more information about this repository,  visit https://github.com/salomondeep/Autopsy-installer
Author: Marin Grabovschi    https://github.com/salomondeep
Autopsy: https://www.sleuthkit.org/autopsy/

=cut

#---------------------- VARIABLE DECLARATION ------------------------------------------------------------------

#To not show any warnings during the lsb_release output, install the lsb_core first
my $lsb_core_command = "sudo apt-get install lsb-core";
# my $releaseOS = "lsb_release -a | grep Description | cut -d'\t' -f2";
my $username = "whoami";
my $update = "sudo apt-get update";
my $upgrade = "sudo apt-get upgrade";
my $install_unzip_command = "sudo apt-get install unzip";
my $install_git_command = "sudo apt-get install git";
my $install_curl_command = "sudo apt-get install curl";
my $install_testdisk_command = "sudo apt-get install testdisk";
my $install_gcc_command = "sudo apt-get install build-essential aptitude libstdc++6 gcc";

my $java_installer_script = "git clone https://github.com/chrishantha/install-java.git";
my $check_unzip = "(dpkg-query -W -f='\${Status}' unzip 2>/dev/null | grep -c \"ok installed\")";
my $check_java = "(dpkg-query -W -f='\${Status}' java 2>/dev/null | grep -c \"ok installed\")";
my $check_git = "(dpkg-query -W -f='\${Status}' git 2>/dev/null | grep -c \"ok installed\")";
my $check_curl = "(dpkg-query -W -f='\${Status}' curl 2>/dev/null | grep -c \"ok installed\")";
my $check_testdisk = "(dpkg-query -W -f='\${Status}' testdisk 2>/dev/null | grep -c \"ok installed\")";
my $find_jdk = "find /home -name \"jdk*.tar.gz\" -size +20M | tr -d '\r\n'";
#----------------------------------------------------------------------------------------


# my $update_output = system($update);
# my $upgrade_output = system($upgrade);


# #---------------------- CHECK REQUIRED PACKAGES ------------------------------------------------------------------

# my $check_unzip_output = `$check_unzip`;
# if ($check_unzip_output == 0) {
#     system($install_unzip_command);
# }else{
#     print "unzip is installed";
# }

# my $check_curl_output = `$check_curl`;
# if ($check_curl_output == 0) {
#     system($install_curl_command);
# }else{
#     print "curl is installed";
# }

# my $check_git_output = `$check_git`;
# if ($check_git_output == 0) {
#     system($install_git_command);
# }else{
#     print "git is installed";
# }

# system($install_gcc_command);

# my $check_testdisk_output = `$check_testdisk`;
# if ($check_testdisk_output == 0) {
#     system($install_testdisk_command)
# }else{
#     print "testdisk is installed";
# }

my $check_java_output = `$check_java`; print $check_java_output;
if ($check_java_output == 0){
    #install here java
    system($java_installer_script); #works

    #step 1 -> find where is jdk and store its path
    my $find_jdk_output = `$find_jdk`; #print $find_jdk_output; #works

    #step 2 -> copy the jdk to the directory of the 
    my $aux = "cp ". $find_jdk_output ." ./install-java"; #works
    system($aux);

    #step 3 -> move to the directory and execute the shell script #works
    my $execute_script = "cd install-java/ && ./install-java.sh -f jdk-8u212-linux-x64.tar.gz && source ~/.bashrc && echo \$JAVA_HOME";
    system($execute_script);

} else{
    print "java is installed";
}

#----------------------------------------------------------------------------------------



exit();