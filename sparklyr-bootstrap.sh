#!/bin/bash
#created by jordan.volz@cloudera.com
#Built for AWS AMI: ami-775e4f16 (RHEL 7.2)

#install R
yum -y --exclude=kernel\* update
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y wget
sudo yum install -y texlive
sudo rpm -Uvh http://mirror.centos.org/centos/7/os/x86_64/Packages/texlive-epsf-svn21461.2.7.4-38.el7.noarch.rpm
sudo yum install -y texlive-epsf
sudo rpm -Uvh http://mirror.centos.org/centos/7/os/x86_64/Packages/texinfo-5.1-4.el7.x86_64.rpm
sudo yum install -y texinfo
sudo rpm -Uvh http://mirror.centos.org/centos/7/os/x86_64/Packages/texinfo-tex-5.1-4.el7.x86_64.rpm
sudo yum install -y texinfo-tex
sudo yum install -y libcurl-devel
sudo yum install -y R
sudo yum install -y ruby

#install rstudio-server
wget https://download2.rstudio.org/rstudio-server-rhel-0.99.903-x86_64.rpm
sudo yum install -y --nogpgcheck rstudio-server-rhel-0.99.903-x86_64.rpm
sudo service rstudio-server start

#setup SPARK_HOME env variable
sudo useradd rsuser
sudo sh -c "echo 'rsuser:cloudera' | chpasswd"
sudo sh -c "echo 'SPARK_HOME=/opt/cloudera/parcels/CDH/lib/spark/' >> /usr/lib64/R/etc/Renviron"

#install packages
wget https://cran.r-project.org/src/contrib/
wget https://gist.githubusercontent.com/chezou/5d7d70b47ef45d8f72623263da246fda/raw/c1ea394da45020c8e565686242d732d79d7206d2/generate_package_list.rb
wget https://gist.githubusercontent.com/chezou/5d7d70b47ef45d8f72623263da246fda/raw/f075888723acb4238e74a8365e9884a75ead82d2/target_packages
cat index.html | ruby generate_package_list.rb > install_target_packages.sh
chmod +x install_target_packages.sh
./install_target_packages.sh

#exit
exit 0
