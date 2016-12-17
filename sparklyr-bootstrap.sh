#!/bin/bash
#created by jordan.volz@cloudera.com
#Built for AWS AMI: ami-775e4f16 (RHEL 7.2)

#install R
yum -y --exclude=kernel\* update
sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm
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

#install rstudio-server
wget https://download2.rstudio.org/rstudio-server-rhel-0.99.903-x86_64.rpm
sudo yum install -y --nogpgcheck rstudio-server-rhel-0.99.903-x86_64.rpm
sudo service rstudio-server start

#setup SPARK_HOME env variable
sudo useradd rsuser
sudo sh -c "echo 'rsuser:cloudera' | chpasswd"
sudo sh -c "echo 'SPARK_HOME=/opt/cloudera/parcels/CDH/lib/spark/' >> /usr/lib64/R/etc/Renviron"

echo "Installing R packages"
#install packages
# Rscript -e 'update.packages(ask = FALSE)'
for pkgname in yaml assertthat R6 Rcpp lazyeval tibble magrittr DBI BH dplyr curl hms readr digest config rappdirs rprojroot withr sparklyr nycflights13
do
    Rscript -e 'if(!require("'$pkgname'", character.only = TRUE, quietly = TRUE)) install.packages("'$pkgname'", dependencies = TRUE, repos="https://cran.r-project.org")'
done

exit 0
