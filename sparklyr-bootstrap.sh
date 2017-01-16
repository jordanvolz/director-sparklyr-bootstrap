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

#install rstudio-server
wget https://download2.rstudio.org/rstudio-server-rhel-0.99.903-x86_64.rpm
sudo yum install -y --nogpgcheck rstudio-server-rhel-0.99.903-x86_64.rpm
sudo service rstudio-server start

#setup SPARK_HOME env variable
sudo useradd rsuser
sudo sh -c "echo 'rsuser:cloudera' | chpasswd"
sudo sh -c "echo 'SPARK_HOME=/opt/cloudera/parcels/CDH/lib/spark/' >> /usr/lib64/R/etc/Renviron"

#install packages
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("assertthat")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("R6")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("Rcpp")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("lazyeval")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("tibble")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("magrittr")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("DBI")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("BH")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("dplyr")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("curl")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("hms")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("yaml")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("readr")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("digest")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("config")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("rappdirs")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("rprojroot")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("withr")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("sparklyr")'
sudo Rscript -e 'options(repos="https://cran.r-project.org");install.packages("nycflights13")'

#exit
exit 0
