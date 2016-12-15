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

#install packages
wget https://cran.r-project.org/src/contrib/sparklyr_0.4.tar.gz
wget https://cran.r-project.org/src/contrib/dplyr_0.5.0.tar.gz
wget https://cran.r-project.org/src/contrib/nycflights13_0.2.0.tar.gz
wget https://cran.r-project.org/src/contrib/assertthat_0.1.tar.gz
wget https://cran.r-project.org/src/contrib/R6_2.2.0.tar.gz
wget https://cran.r-project.org/src/contrib/Rcpp_0.12.7.tar.gz
wget https://cran.r-project.org/src/contrib/tibble_1.2.tar.gz
wget https://cran.r-project.org/src/contrib/magrittr_1.5.tar.gz
wget https://cran.r-project.org/src/contrib/lazyeval_0.2.0.tar.gz
wget https://cran.r-project.org/src/contrib/DBI_0.5-1.tar.gz
wget https://cran.r-project.org/src/contrib/BH_1.60.0-2.tar.gz
wget https://cran.r-project.org/src/contrib/readr_1.0.0.tar.gz
wget https://cran.r-project.org/src/contrib/digest_0.6.10.tar.gz
wget https://cran.r-project.org/src/contrib/config_0.2.tar.gz
wget https://cran.r-project.org/src/contrib/rappdirs_0.3.1.tar.gz
wget https://cran.r-project.org/src/contrib/rprojroot_1.0-2.tar.gz
wget https://cran.r-project.org/src/contrib/withr_1.0.2.tar.gz
wget https://cran.r-project.org/src/contrib/curl_2.1.tar.gz
wget https://cran.r-project.org/src/contrib/hms_0.2.tar.gz
wget https://cran.r-project.org/src/contrib/yaml_2.1.13.tar.gz
sudo R CMD INSTALL assertthat_0.1.tar.gz
sudo R CMD INSTALL R6_2.2.0.tar.gz
sudo R CMD INSTALL Rcpp_0.12.7.tar.gz
sudo R CMD INSTALL lazyeval_0.2.0.tar.gz
sudo R CMD INSTALL tibble_1.2.tar.gz
sudo R CMD INSTALL magrittr_1.5.tar.gz
sudo R CMD INSTALL DBI_0.5-1.tar.gz
sudo R CMD INSTALL BH_1.60.0-2.tar.gz
sudo R CMD INSTALL dplyr_0.5.0.tar.gz
sudo R CMD INSTALL curl_2.1.tar.gz
sudo R CMD INSTALL hms_0.2.tar.gz
sudo R CMD INSTALL yaml_2.1.13.tar.gz
sudo R CMD INSTALL readr_1.0.0.tar.gz
sudo R CMD INSTALL digest_0.6.10.tar.gz
sudo R CMD INSTALL config_0.2.tar.gz
sudo R CMD INSTALL rappdirs_0.3.1.tar.gz
sudo R CMD INSTALL rprojroot_1.0-2.tar.gz
sudo R CMD INSTALL withr_1.0.2.tar.gz
sudo R CMD INSTALL sparklyr_0.4.tar.gz
sudo R CMD INSTALL nycflights13_0.2.0.tar.gz

#exit
exit 0
