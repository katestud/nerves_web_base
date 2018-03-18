# Nerves Web Base

This is a base application for nerves projects. It includes:
* `nerves_firmware_http` so firmware can be updated and pushed over http
* Multi-cast logging so logs can be broadcast over the network and viewed with `cell watch`
* A Phoenix web server backend to provide API endpoints to retrieve data from the raspberry pi

The project was heavily inspired by the [hello_network](https://github.com/nerves-project/nerves_examples/tree/master/hello_network) nerves example and features described in [this talk](https://github.com/ghitchens/elixirdaze_2017_demo).

This application also follows the [Poncho Project](http://embedded-elixir.com/post/2017-05-19-poncho-projects/) structure.

## Setup

``` bash
cd nerves_web_base
export MIX_TARGET=rpi3
export NERVES_NETWORK_PSK=PASSKEY
export NERVES_NETWORK_SSID=SSID
mix deps.get
mix firmware
mix firmware.burn
```

The device can be discovered on the network using the [Cell Tool](https://github.com/ghitchens/cell-tool). Run `cell watch` to discover and view logs from the RPi.


Once the device is on the network,
```
mix firmware.push [DEVICE_IP_ADDRESS] --target rpi3
```

Use `curl "http://[DEVICE_IP_ADDRESS]:8988/firmware"` to get status and info from the RPi.

Phoenix web server is accessible from http://[DEVICE_IP_ADDRESS] at port 80.
