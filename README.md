## Building

Use:

```
cd desc_lss_base
docker build -t desc_lss_base .
cd desc_lss
docker build -t desc_lss_base .
```


## Example run

```
docker run --user 1000 desc_lss /home/lss/CoLoRe/runCoLoRe param.cfg
```

