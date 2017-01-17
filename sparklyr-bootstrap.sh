#!/bin/bash
#created by jordan.volz@cloudera.com
#Built for AWS AMI: ami-775e4f16 (RHEL 7.2)

#install R
sudo yum -y --exclude=kernel\* update
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y wget texlive texlive-epsf texinfo texinfo-tex libcurl-devel R

#install rstudio-server
wget https://download2.rstudio.org/rstudio-server-rhel-1.0.44-x86_64.rpm
sudo yum -y install --nogpgcheck rstudio-server-rhel-1.0.44-x86_64.rpm
sudo service rstudio-server start

#setup SPARK_HOME env variable
sudo useradd rsuser
sudo sh -c "echo 'rsuser:cloudera' | chpasswd"
sudo sh -c "echo 'SPARK_HOME=/opt/cloudera/parcels/CDH/lib/spark/' >> /usr/lib64/R/etc/Renviron"

echo "Installing R packages"
#install packages
# Rscript -e 'update.packages(ask = FALSE)'
for pkgname in sparklyr nycflights13
do
    sudo Rscript -e 'if(!require("'$pkgname'", character.only = TRUE, quietly = TRUE)) install.packages("'$pkgname'", dependencies = TRUE, repos="https://cran.r-project.org")'
done

exit 0
