FROM desc_lss_base

## clean up to make a smaller container
USER root
RUN apt-get autoremove -y git emacs-nox screen && apt-get clean all
RUN rm -rf /home/lss/src
USER lss





