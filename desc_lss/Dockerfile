## build with
## docker build -t desc_lss .

FROM desc_lss_base

## Now the actual libraries that will change more often
WORKDIR /home/lss
COPY install-software.sh scripts/Makefile.CoLoRe scripts/runCoLoRe /home/lss/
USER root
RUN chown lss Makefile.CoLoRe runCoLoRe
USER lss
RUN bash /home/lss/install-software.sh
