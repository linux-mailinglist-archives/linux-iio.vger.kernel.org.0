Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96702C17C2
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 22:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbgKWVfW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 16:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbgKWVfW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Nov 2020 16:35:22 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11FBC206D4;
        Mon, 23 Nov 2020 21:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606167319;
        bh=Kn3uc7LoWML5DjA7s8N3MVdOUUBfbpsGlWJcl1ARkVU=;
        h=Date:From:To:Subject:From;
        b=vo/LhAAE/wJ7q59VPjLvRUx1LHwDof1VACZT11S2s6Bz+UG7hBpDD5ZSIzOhmvtoH
         jWwubeh9TN7LpKHGHmrqhQ1q8lp6e9rAyDy79w4hVMoepkggtkQhWJBU0Ndig61wm+
         eEtTP44qZ6Bwf5iBicQPu2/90X5lPL6eEzFV+Vvc=
Date:   Mon, 23 Nov 2020 21:35:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of new device support, cleanups and yaml
 conversions for the 5.11 cycle.
Message-ID: <20201123213515.7b772026@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 41f0666f0f60997dea10e716df728f330525052e:

  staging: rtl8188eu: Fix long lines (2020-10-09 15:10:47 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-5.11a

for you to fetch changes up to 16be06aa1a28b3bc967f0f32e7e4668889bd5131:

  dt-bindings:iio:adc:x-powers,axp209-adc: txt to yaml conversion (2020-11-=
23 20:35:15 +0000)

----------------------------------------------------------------
First set of new device support, features and cleanups for IIO in the 5.11 =
cycle

Usual mixed bag of new drivers / device support + cleanups etc with the
addition of a fairly big set of yaml conversions.

Txt to yaml format conversions.
In some cases dropped separate binding and moved to trivial devices (drop).

Listed by manufacturer
  - dht11 temperature(drop)
  - adi,ad2s90 adi,ad5272 adi,ad5592r adi,ad5758 adi,ad5933 adi,ad7303
    adi,adis16480 adi,adf4350
  - ams,as3935
  - asahi-kasei,ak8974
  - atmel,sama5d2-adc
  - avago,apds9300 avago,apds9960
  - bosch,bma180 bosch,bmc150_magn bosch,bme680 bosch,bmg180
  - brcm,iproc-static-adc
  - capella,cm36651
  - domintech,dmard06(drop)
  - fsl,mag3110 fsl,mma8452 fsl,vf610-dac
  - hoperf,hp03
  - honeywell,hmc5843
  - kionix,kxcjk1013
  - maxim,ds1803(drop) maxim,ds4424 maxim,max30100 maxim,max30102
    maxim,max31856 maxim,max31855k maxim,max44009
    maxim,max5481 maxim,max5821
  - meas,htu21(drop) meas,ms5367(drop) meas,ms5611 meas,tsys01(drop)
  - mediatek,mt2701-auxadc
  - melexis,mlx90614 melexis,mlx90632
  - memsic,mmc35240(drop)
  - microchip,mcp41010 microchip,mcp4131 microchip,mcp4725
  - murata,zap2326
  - nxp,fxas21002c nxp,lpc1850-dac
  - pni,rm3100
  - qcom,pm8018-adc qcom,spmi-iadc
  - renesas,isl29501 renesas,rcar-gyroadc
  - samsung,sensorhub-rinato
  - sensiron,sgp30
  - sentech,sx9500
  - sharp,gp2ap020a00f
  - st,hts221 st,lsm6dsx st,st-sensors(many!) st,uvis25 st,vcl53l0x st,vl61=
80
  - ti,adc084s021 ti,ads124s08
    ti,dac5571 ti,dac7311 ti,dac7512 ti,dac7612
    ti,hdc1000(drop) ti,palmas-gpadc ti,opt3001 ti,tmp07
  - upisemi,us51882
  - vishay,vcnl4035
  - x-powers,axp209

New device support
* adi,ad5685
  - Add support for AD5338R dual output 10-bit DAC
  - Add DT-binding doc.
* mediatek,mt6360
  - New driver for this SoC ADC with bindings and using new channel label
    support in the IIO core.
* st,lsm6dsx
  - Add support for LSM6DST

Core:
* Add "label" to device channels, provided via a new core callback. Includi=
ng
  DT docs for when that is the source, and ABI docs.
* Add devm_iio_triggered_buffer_setup_ext to take extra attributes.
* dmaengine, unwrap use of iio_buffer_set_attrs()
* Drop iio_buffer_set_attrs()
* Centralize ioctl call handling. Later fix to ensure -EINVAL returned if
  no handler has run.
* Fix an issue with IIO_VAL_FRACTIONAL and negative values - doesn't affect
  any known existing drivers, but will impact a future one.
* kernel-doc fix in trigger.h
* file-ops ordering cleanup

Features
* semtech,sx9310
  - Add control of hardware gain, proximity thresholds, hysteresis and
    debounce.
  - Increase what information on hardware configuration can be provided
    via DT.

Cleanup and minor features
* adi,ad5685
  - Add of_match_table
* adi,ad7292
  - Drop pointless spi_set_drvdata() call
* adi,ad7298
  - Drop platform data and tidy up external reference config.
* adi,ad7303
  - Drop platform data handling as unused.
* adi,ad7768
  - Add new label attribute for channels provided from dt.
* adi,ad7887
  - devm_ usage in probe simplifying remove and error handling.
* adi,adis16201
  - Drop pointless spi_set_drvdata() call
* adi,adis16209
  - Drop pointless spi_set_drvdata() call
* adi,adis16240
  - White space fixup
* adi,adxl372
  - use new devm_iio_triggered-buffer_setup_ext()
* amlogic,meson-saradc
  - Drop pointless semicolon.
* amstaos,tsl2563
  - Put back i2c_device_id table as needed for greybus probing.
* atmel,at91_adc
  - Use of_device_get_match_data() instead of open coding it.
  - Constify some driver data
  - Add KCONFIG dep on CONFIG_OF and drop of_match_ptr()
  - Drop platform data as mostly dead code.
  - Tidy up reference voltage logic
* atmel-sama5d2
  - Drop a pointless semicolon
  - Merge buffer and trigger init into a separate function
  - Use new devm_iio_triggered_buff_setup_ext()
* avago,apds9960
  - Drop a pointless semicolon
* bosch,bmc150
  - Drop a pointless semicolon
  - Use new iio_triggered_buffer_setup_ext()
* bosch,bmp280
  - Drop a pointless semicolon
* fsl,mma8452
  - Constification
* (google),cros_ec
  - Use new devm_iio_triggered_buffer_setup_ext()
* hid-sensors
  - Use new iio_triggered_buffer_setup_ext()
* ingenic,adc
  - Drop a pointless semicolon
* invensense,icm426xx
  - Fix MAINTAINERS entry missing :
* mediatek,mt6577_audxac
  - Add binding doc for mt8516 compatible with mt8173
* motorola,cpcap-adc
  - Fix an implicit fallthrough marking that clang needs to avoid warning.
* samsung,exynos-adc
  - Stop relying on users counter form input device in ISR.
* st,lsm6dsx
  - add vdd and vddio regulator control (including binding update)
* st,stm32-adc
  - Tidy up code for dma transfers.
  - Adapt clock duty cycle for proper functioning. Note no known problems
    with existing boards.
* st,vl53l0x-i2c
  - Put back i2c_device_id table as needed for greybus probing.
* vishay,vcnl4035
  - Put back i2c_device_id table as needed for greybus probing.

----------------------------------------------------------------
Alexandru Ardelean (23):
      iio: adc: at91_adc: use of_device_get_match_data() helper
      iio: adc: at91_adc: const-ify some driver data
      iio: adc: at91_adc: add Kconfig dep on the OF symbol and remove of_ma=
tch_ptr()
      iio: adc: at91_adc: remove platform data and move defs in driver file
      iio: adc: ad7887: invert/rework external ref logic
      iio: adc: ad7298: rework external ref setup & remove platform data
      iio: dac: ad7303: remove platform data header
      iio: core: centralize ioctl() calls to the main chardev
      iio: adc: ad7887: convert probe to device-managed functions
      iio: buffer: dmaengine: unwrap the use of iio_buffer_set_attrs()
      iio: adc: at91-sama5d2_adc: merge buffer & trigger init into a functi=
on
      iio: triggered-buffer: add {devm_}iio_triggered_buffer_setup_ext vari=
ants
      iio: accel: adxl372: use devm_iio_triggered_buffer_setup_ext()
      iio: accel: bmc150: use iio_triggered_buffer_setup_ext()
      iio: adc: at91-sama5d2_adc: use devm_iio_triggered_buffer_setup_ext()
      iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()
      iio: hid-sensors: use iio_triggered_buffer_setup_ext()
      iio: buffer: remove iio_buffer_set_attrs() helper
      iio: adc: ad7292: remove unneeded spi_set_drvdata()
      iio: accel: adis16201: remove unneeded spi_set_drvdata()
      iio: accel: adis16209: remove unneeded spi_set_drvdata()
      iio: core: organize buffer file-ops in the order defined in the struct
      iio: core: return -EINVAL when no ioctl handler has been run

Anand Ashok Dumbre (1):
      iio: core: Fix IIO_VAL_FRACTIONAL calculation for negative values

Cristian Pop (5):
      iio: core: Add optional symbolic label to a device channel
      iio:Documentation: Add documentation for label channel attribute
      iio: adc: ad7768-1: Add channel labels.
      dt-bindings:iio:adc:adi,ad7768-1: Add documentation for channel label
      dt-bindings:iio:adc:adc.txt: Add documentation for channel label attr=
ibute

Deepak R Varma (1):
      staging: iio: adis16240: add blank line before struct definition

Fabien Parent (1):
      dt-bindings: iio: adc: auxadc: add doc for MT8516 SoC

Fabrice Gasnier (1):
      iio: adc: stm32-adc: adapt clock duty cycle for proper operation

Gene Chen (3):
      dt-bindings: iio: adc: add bindings doc for MT6360 ADC
      Documentation: ABI: testing: mt6360: Add ADC sysfs guideline
      iio: adc: mt6360: Add ADC driver for MT6360

Gustavo A. R. Silva (1):
      iio: adc: cpcap: Fix fall-through warnings for Clang

Jonathan Cameron (64):
      dt-bindings: iio: adc: ti,adc084s021 yaml conversion
      dt-bindings:iio:humidity:hdc100x Drop separate doc + add to trivial-d=
evices
      dt-bindings:iio:humidity:htu21 Drop separate doc + add to trivial-dev=
ices
      dt-bindings:iio:humidity:st,hts221 yaml conversion.
      dt-bindings:iio:humidity:dht11 yaml conversion
      dt-bindings:iio:pressure:ms5637 Drop separate doc + add to trivial-de=
vices
      dt-bindings:iio:pressure:murata,zpa2326 yaml conversion
      dt-bindings:iio:pressure:meas,ms5611 yaml conversion.
      dt-bindings:iio:pressure:hoperf,hp03 yaml conversion
      dt-bindings:iio:proximity:semtech,sx9500 yaml conversion.
      dt-bindings:iio:proximity:st,vl53l0x yaml conversion
      dt-bindings:iio:proximity:ams,as3935 yaml conversion
      dt-bindings:iio:dac:ti,dac5571 yaml conversion.
      dt-bindings:iio:dac:ti,dac7311 yaml conversion
      dt-bindings:iio:dac:ti,dac7512 yaml conversion
      dt-bindings:iio:dac:ti,dac7612 yaml conversion
      dt-bindings:iio:dac:adi,ad7303 yaml conversion
      dt-bindings:iio:dac:maxim,ds4424 yaml conversion
      dt-bindings:iio:dac:fsl,vf610-dac yaml conversion
      dt-bindings:iio:dac:microchip,mcp4725 yaml conversion
      dt-bindings:iio:dac:maxim,max5821 yaml conversion
      dt-bindings:iio:dac:nxp,lpc1850-dac yaml conversion.
      dt-bindings:iio:dac:adi,ad5758 yaml conversion
      dt-bindings:iio:temperature:melexis,mlx90614 yaml conversion
      dt-bindings:iio:temperature:melexis,mlx90632 conversion to yaml
      dt-bindings:iio:temperature:meas,tsys01 move to trivial-devices.yaml
      dt-bindings:iio:temperature:maxim,max31856 yaml conversion.
      dt-bindings:iio:temperature:maxim_thermocouple.txt to maxim,max31855k=
.yaml
      dt-bindings:iio:temperature:ti,tmp07 yaml conversion
      dt-bindings:iio:chemical:sensirion,sgp30: Move to trivial-bindings.ya=
ml
      dt-bindings:iio:chemical:bosch,bme680: Move to trivial devices
      dt-bindings:iio:potentiometer:maxim,ds1803 move to trivial devices.
      dt-bindings:iio:potentiometer:maxim,max5481 move to trivial devices
      dt-bindings:iio:light:renesas,isl29501: Move to trivial devices.
      dt-bindings:iio:magnetometer:memsic,mmc35240: move to trivial-devices=
.yaml
      dt-bindings:iio:accel:domintech,dmard06: Move to trivial-devices.yaml
      dt-bindings:iio:resolver:adi,ad2s90: Conversion of binding to yaml.
      dt-bindings:iio:potentiometer:microchip,mcp4131 txt to yaml conversion
      dt-bindings:iio:potentiometer:adi,ad5272 yaml conversion
      dt-bindings:iio:potentiometer:microchip,mcp41010 txt to yaml conversi=
on
      dt-bindings:iio:impedance-analyzer:adi,ad5933 yaml conversion.
      dt-bindings:iio:samsung,sensorhub-rinato: yaml conversion
      dt-bindings:iio:health:maxim,max30100: txt to yaml conversion
      dt-bindings:iio:health:maxim,max30102: txt to yaml conversion
      dt-bindings:iio:imu:adi,adis16480: txt to yaml conversion
      dt-bindings:iio:imu:st,lsm6dsx: txt to yaml conversion
      dt-bindings:iio:light:avago,apds9300: txt to yaml conversion.
      dt-bindings:iio:light:avago,apds9960: txt to yaml conversion
      dt-bindings:iio:light:capella,cm36651: txt to yaml conversion.
      dt-bindings:iio:light:sharp,gp2ap020a00f: txt to yaml conversion.
      dt-bindings:iio:light:maxim,max44009: txt to yaml conversion.
      dt-bindings:iio:light:ti,opt3001: txt to yaml conversion
      dt-bindings:iio:light:upisemi,us51882: txt to yaml conversion.
      dt-bindings:iio:light:st,uvis25: txt to yaml conversion for this UV s=
ensor
      dt-bindings:iio:light:vishay,vcnl4035: txt to yaml conversion
      dt-bindings:iio:light:st,vl6180: txt to yaml format conversion.
      dt-bindings:iio:magnetometer:fsl,mag3110: txt to yaml conversion
      dt-bindings:iio:magnetometer:asahi-kasei,ak8974: txt to yaml format c=
onversion
      dt-bindings:iio:magnetometer:bosch,bmc150_magn: txt to yaml conversio=
n.
      dt-bindings:iio:magnetometer:honeywell,hmc5843: txt to yaml format co=
nversion
      dt-bindings:iio:magnetometer:pni,rm3100: txt to yaml conversion.
      dt-bindings:iio:adc:atmel,sama5d2-adc: txt to yaml conversion
      dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.
      dt-bindings:iio:adc:x-powers,axp209-adc: txt to yaml conversion

Jonathan Neusch=C3=A4fer (1):
      MAINTAINERS: Fix 'W:' prefix in Invensense IMU entry

Lorenzo Bianconi (2):
      iio: imu: st_lsm6dsx: add support to LSM6DST
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6dst device bindings

Mauro Carvalho Chehab (1):
      iio: fix a kernel-doc markup

Michael Auchter (3):
      iio: dac: ad5686: add support for AD5338R
      iio: dac: ad5686: add of_match_table
      dt-bindings: iio: dac: ad5686: add binding

Olivier Moysan (1):
      iio: adc: stm32-adc: dma transfers cleanup

Rikard Falkeborn (1):
      iio: accel: mma8452: Constify static struct attribute_group

Rui Miguel Silva (1):
      dt-bindings: fxas21002c: convert bindings to yaml

Stephen Boyd (6):
      iio: sx9310: Support hardware gain factor
      iio: sx9310: Support setting proximity thresholds
      iio: sx9310: Support setting hysteresis values
      iio: sx9310: Support setting debounce values
      dt-bindings: iio: sx9310: Add various settings as DT properties
      iio: sx9310: Set various settings from DT

Tom Rix (6):
      iio: light: apds9960: remove unneeded semicolon
      iio/adc: ingenic: remove unneeded semicolon
      iio: adc: at91-sama5d2_adc: remove unneeded semicolon
      iio: pressure: bmp280: remove unneeded semicolon
      iio: magnetometer: bmc150: remove unneeded semicolon
      iio: remove unneeded break

Vaishnav M A (3):
      iio: proximity: vl53l0x-i2c add i2c_device_id
      iio: light: vcnl4035 add i2c_device_id
      iio:light:tsl2563 use generic fw accessors

dmitry.torokhov@gmail.com (1):
      iio: adc: exynos: do not rely on 'users' counter in ISR

 Documentation/ABI/testing/sysfs-bus-iio            |  10 +
 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360 |  78 ++++
 .../devicetree/bindings/iio/accel/dmard06.txt      |  19 -
 Documentation/devicetree/bindings/iio/adc/adc.txt  |   6 +
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml  |  32 ++
 .../bindings/iio/adc/at91-sama5d2_adc.txt          |  50 --
 .../bindings/iio/adc/atmel,sama5d2-adc.yaml        | 101 ++++
 .../devicetree/bindings/iio/adc/axp20x_adc.txt     |  48 --
 .../bindings/iio/adc/mediatek,mt6360-adc.yaml      |  31 ++
 .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |   1 +
 .../bindings/iio/adc/renesas,gyroadc.txt           |  98 ----
 .../bindings/iio/adc/renesas,rcar-gyroadc.yaml     | 143 ++++++
 .../devicetree/bindings/iio/adc/ti,adc084s021.yaml |  58 +++
 .../devicetree/bindings/iio/adc/ti-adc084s021.txt  |  19 -
 .../bindings/iio/adc/x-powers,axp209-adc.yaml      |  67 +++
 .../devicetree/bindings/iio/chemical/bme680.txt    |  11 -
 .../bindings/iio/chemical/sensirion,sgp30.txt      |  15 -
 .../devicetree/bindings/iio/dac/ad5758.txt         |  83 ----
 .../devicetree/bindings/iio/dac/ad7303.txt         |  23 -
 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    |  57 +++
 .../devicetree/bindings/iio/dac/adi,ad5758.yaml    | 129 ++++++
 .../devicetree/bindings/iio/dac/adi,ad7303.yaml    |  50 ++
 .../devicetree/bindings/iio/dac/ds4424.txt         |  20 -
 .../devicetree/bindings/iio/dac/fsl,vf610-dac.yaml |  55 +++
 .../devicetree/bindings/iio/dac/lpc1850-dac.txt    |  19 -
 .../devicetree/bindings/iio/dac/max5821.txt        |  14 -
 .../devicetree/bindings/iio/dac/maxim,ds4424.yaml  |  45 ++
 .../devicetree/bindings/iio/dac/maxim,max5821.yaml |  44 ++
 .../devicetree/bindings/iio/dac/mcp4725.txt        |  35 --
 .../bindings/iio/dac/microchip,mcp4725.yaml        |  71 +++
 .../bindings/iio/dac/nxp,lpc1850-dac.yaml          |  58 +++
 .../devicetree/bindings/iio/dac/ti,dac5571.txt     |  24 -
 .../devicetree/bindings/iio/dac/ti,dac5571.yaml    |  52 +++
 .../devicetree/bindings/iio/dac/ti,dac7311.txt     |  23 -
 .../devicetree/bindings/iio/dac/ti,dac7311.yaml    |  49 ++
 .../devicetree/bindings/iio/dac/ti,dac7512.txt     |  20 -
 .../devicetree/bindings/iio/dac/ti,dac7512.yaml    |  42 ++
 .../devicetree/bindings/iio/dac/ti,dac7612.txt     |  28 --
 .../devicetree/bindings/iio/dac/ti,dac7612.yaml    |  53 +++
 .../devicetree/bindings/iio/dac/vf610-dac.txt      |  20 -
 .../bindings/iio/gyroscope/nxp,fxas21002c.txt      |  31 --
 .../bindings/iio/gyroscope/nxp,fxas21002c.yaml     |  95 ++++
 .../devicetree/bindings/iio/health/max30100.txt    |  28 --
 .../devicetree/bindings/iio/health/max30102.txt    |  33 --
 .../bindings/iio/health/maxim,max30100.yaml        |  52 +++
 .../bindings/iio/health/maxim,max30102.yaml        |  72 +++
 .../devicetree/bindings/iio/humidity/dht11.txt     |  14 -
 .../devicetree/bindings/iio/humidity/dht11.yaml    |  41 ++
 .../devicetree/bindings/iio/humidity/hdc100x.txt   |  17 -
 .../devicetree/bindings/iio/humidity/hts221.txt    |  30 --
 .../devicetree/bindings/iio/humidity/htu21.txt     |  13 -
 .../bindings/iio/humidity/st,hts221.yaml           |  52 +++
 .../bindings/iio/impedance-analyzer/ad5933.txt     |  26 --
 .../iio/impedance-analyzer/adi,ad5933.yaml         |  59 +++
 .../devicetree/bindings/iio/imu/adi,adis16480.txt  |  86 ----
 .../devicetree/bindings/iio/imu/adi,adis16480.yaml | 130 ++++++
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |  86 ++++
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |  48 --
 .../devicetree/bindings/iio/light/apds9300.txt     |  21 -
 .../devicetree/bindings/iio/light/apds9960.txt     |  21 -
 .../bindings/iio/light/avago,apds9300.yaml         |  44 ++
 .../bindings/iio/light/avago,apds9960.yaml         |  44 ++
 .../bindings/iio/light/capella,cm36651.yaml        |  48 ++
 .../devicetree/bindings/iio/light/cm36651.txt      |  26 --
 .../devicetree/bindings/iio/light/gp2ap020a00f.txt |  21 -
 .../devicetree/bindings/iio/light/max44009.txt     |  24 -
 .../bindings/iio/light/maxim,max44009.yaml         |  45 ++
 .../devicetree/bindings/iio/light/opt3001.txt      |  25 -
 .../bindings/iio/light/renesas,isl29501.txt        |  13 -
 .../bindings/iio/light/sharp,gp2ap020a00f.yaml     |  48 ++
 .../devicetree/bindings/iio/light/st,uvis25.yaml   |  42 ++
 .../devicetree/bindings/iio/light/st,vl6180.yaml   |  45 ++
 .../devicetree/bindings/iio/light/ti,opt3001.yaml  |  47 ++
 .../bindings/iio/light/upisemi,us5182.yaml         |  78 ++++
 .../devicetree/bindings/iio/light/us5182d.txt      |  45 --
 .../devicetree/bindings/iio/light/uvis25.txt       |  22 -
 .../devicetree/bindings/iio/light/vcnl4035.txt     |  18 -
 .../bindings/iio/light/vishay,vcnl4035.yaml        |  45 ++
 .../devicetree/bindings/iio/light/vl6180.txt       |  15 -
 .../bindings/iio/magnetometer/ak8974.txt           |  31 --
 .../iio/magnetometer/asahi-kasei,ak8974.yaml       |  57 +++
 .../bindings/iio/magnetometer/bmc150_magn.txt      |  25 -
 .../iio/magnetometer/bosch,bmc150_magn.yaml        |  55 +++
 .../bindings/iio/magnetometer/fsl,mag3110.yaml     |  48 ++
 .../bindings/iio/magnetometer/hmc5843.txt          |  21 -
 .../iio/magnetometer/honeywell,hmc5843.yaml        |  43 ++
 .../bindings/iio/magnetometer/mag3110.txt          |  27 --
 .../bindings/iio/magnetometer/mmc35240.txt         |  13 -
 .../bindings/iio/magnetometer/pni,rm3100.txt       |  20 -
 .../bindings/iio/magnetometer/pni,rm3100.yaml      |  42 ++
 .../bindings/iio/potentiometer/ad5272.txt          |  27 --
 .../bindings/iio/potentiometer/adi,ad5272.yaml     |  50 ++
 .../bindings/iio/potentiometer/ds1803.txt          |  21 -
 .../bindings/iio/potentiometer/max5481.txt         |  23 -
 .../bindings/iio/potentiometer/mcp41010.txt        |  28 --
 .../bindings/iio/potentiometer/mcp4131.txt         |  84 ----
 .../iio/potentiometer/microchip,mcp41010.yaml      |  48 ++
 .../iio/potentiometer/microchip,mcp4131.yaml       | 103 +++++
 .../bindings/iio/pressure/hoperf,hp03.yaml         |  47 ++
 .../devicetree/bindings/iio/pressure/hp03.txt      |  17 -
 .../bindings/iio/pressure/meas,ms5611.yaml         |  57 +++
 .../devicetree/bindings/iio/pressure/ms5611.txt    |  19 -
 .../devicetree/bindings/iio/pressure/ms5637.txt    |  17 -
 .../bindings/iio/pressure/murata,zpa2326.yaml      |  62 +++
 .../devicetree/bindings/iio/pressure/zpa2326.txt   |  29 --
 .../bindings/iio/proximity/ams,as3935.yaml         |  71 +++
 .../devicetree/bindings/iio/proximity/as3935.txt   |  34 --
 .../bindings/iio/proximity/semtech,sx9310.yaml     |  63 +++
 .../bindings/iio/proximity/semtech,sx9500.yaml     |  50 ++
 .../bindings/iio/proximity/st,vl53l0x.yaml         |  42 ++
 .../devicetree/bindings/iio/proximity/sx9500.txt   |  23 -
 .../devicetree/bindings/iio/proximity/vl53l0x.txt  |  18 -
 .../devicetree/bindings/iio/resolver/ad2s90.txt    |  31 --
 .../bindings/iio/resolver/adi,ad2s90.yaml          |  60 +++
 .../bindings/iio/samsung,sensorhub-rinato.yaml     |  72 +++
 .../devicetree/bindings/iio/sensorhub.txt          |  24 -
 .../bindings/iio/temperature/max31856.txt          |  24 -
 .../bindings/iio/temperature/maxim,max31855k.yaml  |  76 +++
 .../bindings/iio/temperature/maxim,max31856.yaml   |  54 +++
 .../iio/temperature/maxim_thermocouple.txt         |  24 -
 .../bindings/iio/temperature/melexis,mlx90614.yaml |  50 ++
 .../bindings/iio/temperature/melexis,mlx90632.yaml |  55 +++
 .../bindings/iio/temperature/mlx90614.txt          |  24 -
 .../bindings/iio/temperature/mlx90632.txt          |  28 --
 .../bindings/iio/temperature/ti,tmp007.yaml        |  57 +++
 .../devicetree/bindings/iio/temperature/tmp007.txt |  33 --
 .../devicetree/bindings/iio/temperature/tsys01.txt |  19 -
 .../devicetree/bindings/trivial-devices.yaml       |  54 +++
 MAINTAINERS                                        |   4 +-
 drivers/iio/accel/adis16201.c                      |   1 -
 drivers/iio/accel/adis16209.c                      |   1 -
 drivers/iio/accel/adxl372.c                        |  11 +-
 drivers/iio/accel/bmc150-accel-core.c              |  25 +-
 drivers/iio/accel/mma8452.c                        |   2 +-
 drivers/iio/adc/Kconfig                            |  13 +-
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7292.c                           |   2 -
 drivers/iio/adc/ad7298.c                           |  17 +-
 drivers/iio/adc/ad7768-1.c                         |  41 ++
 drivers/iio/adc/ad7887.c                           |  55 +--
 drivers/iio/adc/at91-sama5d2_adc.c                 |  84 ++--
 drivers/iio/adc/at91_adc.c                         |  73 ++-
 drivers/iio/adc/cpcap-adc.c                        |   1 +
 drivers/iio/adc/exynos_adc.c                       |   7 +-
 drivers/iio/adc/ingenic-adc.c                      |   2 +-
 drivers/iio/adc/meson_saradc.c                     |   2 -
 drivers/iio/adc/mt6360-adc.c                       | 372 +++++++++++++++
 drivers/iio/adc/stm32-adc-core.c                   |  21 +-
 drivers/iio/adc/stm32-adc.c                        |  29 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   3 +-
 drivers/iio/buffer/industrialio-triggered-buffer.c |  31 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  15 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  22 +-
 drivers/iio/dac/Kconfig                            |   7 +-
 drivers/iio/dac/ad5686.c                           |  13 +
 drivers/iio/dac/ad5686.h                           |   1 +
 drivers/iio/dac/ad5696-i2c.c                       |  20 +
 drivers/iio/dac/ad7303.c                           |   2 -
 drivers/iio/iio_core.h                             |  15 +-
 drivers/iio/imu/bmi160/bmi160_core.c               |   1 -
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |   4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 207 ++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   5 +
 drivers/iio/industrialio-buffer.c                  |  12 -
 drivers/iio/industrialio-core.c                    | 118 ++++-
 drivers/iio/industrialio-event.c                   |  28 +-
 drivers/iio/light/apds9960.c                       |   2 +-
 drivers/iio/light/tsl2563.c                        |  16 +-
 drivers/iio/light/vcnl4035.c                       |   7 +
 drivers/iio/magnetometer/bmc150_magn.c             |   2 +-
 drivers/iio/pressure/bmp280-regmap.c               |   4 +-
 drivers/iio/proximity/sx9310.c                     | 508 +++++++++++++++++=
+++-
 drivers/iio/proximity/vl53l0x-i2c.c                |   7 +
 drivers/staging/iio/accel/adis16240.c              |   1 +
 include/linux/iio/buffer.h                         |   3 -
 include/linux/iio/iio-opaque.h                     |   2 +
 include/linux/iio/iio.h                            |   6 +
 include/linux/iio/trigger.h                        |   2 +-
 include/linux/iio/triggered_buffer.h               |  23 +-
 include/linux/platform_data/ad7298.h               |  19 -
 include/linux/platform_data/ad7303.h               |  20 -
 include/linux/platform_data/ad7887.h               |   4 -
 include/linux/platform_data/at91_adc.h             |  49 --
 186 files changed, 5193 insertions(+), 2210 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mt6360
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/dmard06.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/at91-sama5d2_=
adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/atmel,sama5d2=
-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt63=
60-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,gyroa=
dc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rcar-=
gyroadc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc084s021=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc084s021=
.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/x-powers,axp2=
09-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.t=
xt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirio=
n,sgp30.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ad7303.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5686.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5758.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad7303.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ds4424.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/fsl,vf610-dac=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/lpc1850-dac.t=
xt
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/max5821.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/maxim,ds4424.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/maxim,max5821=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/mcp4725.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp=
4725.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/nxp,lpc1850-d=
ac.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac5571.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7512.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7512.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7612.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/vf610-dac.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxa=
s21002c.txt
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxa=
s21002c.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/health/max30100.t=
xt
 delete mode 100644 Documentation/devicetree/bindings/iio/health/max30102.t=
xt
 create mode 100644 Documentation/devicetree/bindings/iio/health/maxim,max3=
0100.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/health/maxim,max3=
0102.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/humidity/dht11.txt
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/dht11.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/humidity/hdc100x.=
txt
 delete mode 100644 Documentation/devicetree/bindings/iio/humidity/hts221.t=
xt
 delete mode 100644 Documentation/devicetree/bindings/iio/humidity/htu21.txt
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/st,hts22=
1.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/impedance-analyze=
r/ad5933.txt
 create mode 100644 Documentation/devicetree/bindings/iio/impedance-analyze=
r/adi,ad5933.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16480=
.txt
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16480=
.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/apds9300.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/apds9960.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9=
300.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9=
960.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/capella,cm3=
6651.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/cm36651.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap020a00=
f.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/max44009.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/maxim,max44=
009.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/opt3001.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/renesas,isl=
29501.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/sharp,gp2ap=
020a00f.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/st,uvis25.y=
aml
 create mode 100644 Documentation/devicetree/bindings/iio/light/st,vl6180.y=
aml
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt3001.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/upisemi,us5=
182.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/us5182d.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/uvis25.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,vcnl=
4035.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/vl6180.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak89=
74.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/asah=
i-kasei,ak8974.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/bmc1=
50_magn.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/bosc=
h,bmc150_magn.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/fsl,=
mag3110.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/hmc5=
843.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/hone=
ywell,hmc5843.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mag3=
110.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mmc3=
5240.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,=
rm3100.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,=
rm3100.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ad5=
272.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/adi=
,ad5272.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ds1=
803.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max=
5481.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp=
41010.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp=
4131.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mic=
rochip,mcp41010.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mic=
rochip,mcp4131.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/hoperf,h=
p03.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/pressure/hp03.txt
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/meas,ms5=
611.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5611.t=
xt
 delete mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5637.t=
xt
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/murata,z=
pa2326.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/pressure/zpa2326.=
txt
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/ams,as3=
935.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/proximity/as3935.=
txt
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech=
,sx9500.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/st,vl53=
l0x.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/proximity/sx9500.=
txt
 delete mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x=
.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.t=
xt
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/adi,ad2s=
90.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/samsung,sensorhub=
-rinato.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/sensorhub.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/temperature/max31=
856.txt
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim=
,max31855k.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim=
,max31856.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim=
_thermocouple.txt
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/melex=
is,mlx90614.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/melex=
is,mlx90632.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90=
614.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90=
632.txt
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tm=
p007.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/temperature/tmp00=
7.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/temperature/tsys0=
1.txt
 create mode 100644 drivers/iio/adc/mt6360-adc.c
 delete mode 100644 include/linux/platform_data/ad7298.h
 delete mode 100644 include/linux/platform_data/ad7303.h
 delete mode 100644 include/linux/platform_data/at91_adc.h
