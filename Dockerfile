FROM stevenpollack/docker-rserve
MAINTAINER chuck.Richmond@paccar.com
ARG hostname
ENV http_proxy "http://${hostname:-itdrenlpp16059}.na.paccar.com:3128"
ENV https_proxy "http://${hostname:-itdrenlpp16059}.na.paccar.com:3128"
# RUN echo ServerName $hostname >> /etc/apache2/apache2.conf;

RUN echo http_proxy

RUN useradd -d /home/ocpu -m -s /bin/bash ocpu

# This was taken from the jrowen/dcaret image
# using that then installing ocpu pulled more dependencies
# than we need for this image.
# also there were some irritating dependencies.
# RUN apt-get update \
#   && apt-get install -y --no-install-recommends \
#   python-software-properties \
#   ed \
#   less \
#   locales \
#   vim-tiny \
#   wget \
#   ca-certificates \
#   && add-apt-repository -y "ppa:marutter/rrutter" \
#   && add-apt-repository -y "ppa:marutter/c2d4u" \
#   && apt-get update
#
# # make some useful symlinks that are expected to exist
# RUN cd /usr/local/bin \
# && ln -s easy_install-3.4 easy_install \
# && ln -s idle3 idle \
# && ln -s pydoc3 pydoc \
# && ln -s python3 python \
# && ln -s python3-config python-config
#
## Now install R and littler, and create a link for littler in /usr/local/bin
## Also set a default CRAN repo, and make sure littler knows about it too
## Note 1: we need wget here as the build env is too old to work with libcurl
## Note 2: r-cran-docopt is not currently in c2d4u so we install from source
# RUN apt-get update  && \
#     apt-get install -y --force-yes --no-install-recommends \
#     r-cran-littler \
#     r-base \
#     r-base-dev \
#     r-recommended \
#     r-cran-stringr

RUN echo 'options(repos = c(CRAN = "https://cran.rstudio.com/"), download.file.method = "wget")' >> /etc/R/Rprofile.site \
  # && ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
  # && ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
  # && ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
  # && ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
  && install.r docopt \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN echo https_proxy=$https_proxy >> /etc/R/Renviron.site;\
     echo http_proxy=$https_proxy >> /etc/R/Renviron.site;

# These are libraries that the current paccar DataScience
# distros rely on
RUN install2.r -l /usr/lib/R/library \
    tm \
    SnowballC \
    plyr \
    dplyr \
    caret \
    xgboost \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
COPY SystemID/warcatsystemID_0.1.3.tar.gz /usr/src/paccar/git/warcat/
RUN chmod 777 /usr/src/paccar/git/warcat/
RUN ls -l -r /usr/src/paccar/git/warcat/
RUN  install2.r  -l /usr/lib/R/library "/usr/src/paccar/git/warcat/warcatsystemID_0.1.3.tar.gz"

EXPOSE 6311
