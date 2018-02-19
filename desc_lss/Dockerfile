## build with
## docker build -t desc_lss .

FROM desc_lss_base

## Now the actual libraries that will change more often
WORKDIR /home/lss
USER lss
COPY install-software.sh .
COPY scripts/Makefile.CoLoRe .
COPY scripts/runCoLoRe .
RUN bash /home/lss/install-software.sh







