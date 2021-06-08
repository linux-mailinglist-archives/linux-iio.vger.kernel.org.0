Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66E539FC90
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jun 2021 18:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhFHQc7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 8 Jun 2021 12:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231384AbhFHQc7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Jun 2021 12:32:59 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A38756128A;
        Tue,  8 Jun 2021 16:31:05 +0000 (UTC)
Date:   Tue, 8 Jun 2021 17:32:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO new device support, features and cleanups for
 5.14
Message-ID: <20210608173258.5d648bec@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit d8218b0de51f36f01ed67731ccf174059a33bb1e:

  Merge 5.13-rc2 into staging-next (2021-05-17 09:47:44 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.14a

for you to fetch changes up to 41340965b4f8055f975f73e1e3d23eff8038f013:

  Merge branch 'ib-iio-i2c-5.13rc1' into togreg Adds a stub needed to resolve a build conflict for the fxls8962af driver. (2021-06-07 09:20:02 +0100)

----------------------------------------------------------------
1st set of new IIO/counter device support, features and cleanup for 5.14

There are a couple of large cleanup sets in here alongside a number of new
drivers.

Note an immutable branch merged to add a stub for i2c_verify_client()
as needed to avoid a build issue in the fxls8962af driver as a result of a
workaround for a device errata that only applies when i2c interface is used.

Counters
========

New device support
* intel,quadrature encoder peripheral found on Elkhart Lake platforms.
  - New driver.

IIO
===

New device support
* amstaos,tsl2591 ambient light sensor.
  - New driver + bindings
  - Follow up fix to ensure some local variables are suitable for error
    handling.
* fsl,fxls8962af + fsl,fxls8964af accelerometers
  - New driver + bindings
  - Includes an errata work around that cause a build bot failure fixed
    by adding a stub to i2c.
* kionix,kxcjk-1013
  - Add support for KX023-1025 device.  Mostly a different register map
    that needed to be supported.
* murata,sca3300 accelerometer
  - New driver + bindings
* st,lsm9ds0 IMU
  - Rework of st,sensors driver to cleanly support this new glue driver
    that enables the two parts of the LSM9DS0.
* ti,tsc2046 touchscreen controller ADC.
  - New driver. Intent here is to use this with existing IIO consumer
    drivers such as resistive-adc-touch.
  - Follow up fix to avoid an issue with unsigned subtraction in error
    check.
* ti,tmp117 digital temperature sensor
  - New driver + bindings

Features
* adi,ad5755
  - Add missing dt-binding doc
* adi,ad7298
  - Add ACPI ID used on Intel Galileo Gen 1 boards.
  - Add missing dt-binding doc
* adi,ad7476
  - Add missing dt-binding doc
* adi,ad7746
  - Add missing dt-binding doc for this driver that will hopefully move out
    of staging shortly. Update staging driver to use the binding instead of
    platform data.
* adi,adis16201 + adis16209
  - Add missing dt-binding doc
* adi,adis16480
  - Support burst mode for adis16495 and adis16497 parts.
* bosch,bma220
  - Add missing dt-binding doc
* fsl,mma7455
  - Add missing dt-binding doc
* iio-rescale
  - Support handling of processed channels from provider.  Some ADCs
    require (typically non linear) calibration functions to be applied,
    and so provide only IIO_CHAN_INFO_PROCESSED read back. They can be
    used as providers to the iio-rescale driver which needs to handle them
    somewhat differently from IIO_CHAN_INFO_RAW
* sensiron,sps30
  - Support the serial interface.  Note this required significant
    refactoring of existing driver.
* st,st-sensors
  - Add mount matrix support for normal dt-binding whilst continuing to
    support the odd ACPI approach for accelerometers.
* ti,dac082s085 + similar
  - Add missing dt-binding doc
* trivial-devices - add entries for
  - memsic,mx4005, memsic,mx6255 and memsic,mxc6655
  - sensortek,stk8312 and sensortek,stk8ba50

Cleanup / minor fixes
* core
  - Use devm_add_action_or_reset() to replace boilerplate in several
    driver and core IIO devm_* functions.
  - Fix an error path issue introduced by above, that could return an
    error pointer rather than the expected null from dev_iio_device_alloc()
  - Move more IIO internals related fields from struct iio_dev to
    struct iio_dev_opaque.
  - Drop unused final update of in_loc in demux setup.
* Docs
  - Move some docs from driver specific to core dos to avoid replication
    of names which the documentation builder does not allow.
    Note this means adding a few device specific notes to the general docs
    to cover the more unusual uses of the ABI.
  - ABI: Move old buffer/* and scan_elements/* docs to obsolete as now we
    have the bufferX/* variant.  Not we are not getting rid of these
    interfaces, just encouraging new code to use the new interface.
* IIO wide:
  - Tidy up new cases of dev.parent etc being set in drivers as the core
    now does it.
  - Fix more cases of possible miss-aligned buffers when passed to
    iio_push_to_buffers_with_timestamp().  Note we only have one known
    instance of anyone seeing this bug actually happening, so this has been
    a low priority cleanup effort for several cycles.
  - sysfs_emit() used in more drivers.
  - Runtime pm tidy up and use of pm_runtime_resume_and_get()
  - Buffer alignment fixes as iio_push_to_buffers_with_timestamp requires
    that the timestamp when inserted by naturally aligned + consumers can
    assume that all fields are naturally aligned. Part of a long running
    effort, with at least 2 more series to come tackling additional
    variants.
  - Stop specifying "mount-matrix" property name in every lookup of the
    mount matrix from firmware by hard coding it in the core.
* adi,ad7476
  - Handle the variety of different regulators used by the parts supported
    by this driver (came up in dt-binding review)
* adi,ad7746
  - Trivial drop of if (ret) return ret; return 0; pattern
  - Tidy up comments
  - Pull capdac setup out to own function.
* adi,ad7766
  - Trivial drop of if (ret) return ret; return 0; pattern
* adi,adis
  - Avoid returning error codes in interrupt handlers.
  - Handle a failure in spi_write in the trigger handler.
  - Rework to add updating of device page after changing it.
  - Don't push data to IIO buffers when read failed.
  - Add configuration of burst max speed to core avoid handling this in
    each driver.
  - Use the adis_dev_lock() helper in adis16260 and adis16136 drivers.
  - Excessive includes cleanup via include-what-you-use static checker
    after zero day highlighted that these needed updating.
* afe
  - Amend binding to add #io-channel-cells, thus allowing this IIO
    consumer to also be an IIO provider.
* aosong,am2315
  - Drop ACPI id. Unlikely this one is in the wild and it isn't valid
    ACPI naming.
* bosch,bma180
  - Adding missing bandwidth settings (500, 1000 Hz)
* bosch,bme680
  - Drop ACPI id. Unlikely this one is in the wild and it isn't valid
    ACPI naming.
* ep93xx_adc,
  - Drop a redundant error print.
* maxim,max118
  - Convert remainder of probe() to devm_ managed functions.
  - Avoid some repeated jumping back and forth between iio_dev and
    spi structures.
* maxim,max11100
  - Use get_unaligned_be16() instead of open coding.
  - Convert remainder of probe() to devm_ managed functions.
* samsung,exynos_adc
  - Unused error value dropped.
* sensiron,sgp30
  - Drop use of %hx in favor of %x and letting the normal type conversion
    work.
* sensortek,stk8312
  - Add lowercase device id and note uppercase version deprecated.
  - Drop ACPI id. Unlikely this one is in the wild and it isn't valid
    ACPI naming.
* sprx,sc72xx_adc
  - add MODULE_DEVICE_TABLE
* st,lsm6dsx
  - Fix docs of valid ODRs
* st,sensors
  - dt-binding rework.  Two efforts on this crossed in a previous cycle
    so this update cherry picks the best of the two yaml conversions.
  - Don't copy the channel spec array as now ext_info is no longer modified.
* st,stm32-adc
  - tidy up some docs that were marked as kernel-doc but aren't.
* ti,adc081c, ti,adc0832, ti,adc108s102 and ti,adc161s626
  - Convert remainder of probe() functions to devm_ managed functions
    to simplify error handing and remove paths.

----------------------------------------------------------------
Andy Shevchenko (9):
      iio: adc: ad7298: Enable on Intel Galileo Gen 1
      iio: accel: st_accel: Move platform data from header to C file
      iio: gyro: st_gyro: Move platform data from header to C file
      iio: magnetometer: st_magn: Provide default platform data
      iio: st_sensors: Call st_sensors_power_enable() from bus drivers
      iio: st_sensors: Make accel, gyro, magn and pressure probe shared
      iio: st_sensors: Add lsm9ds0 IMU support
      dt-bindings: iio: st,st-sensors: Add LSM9DS0 compatible string
      iio: Drop Duplicated "mount-matrix" parameter

Chunyan Zhang (1):
      iio: adc: Add missing MODULE_DEVICE_TABLE

Dan Carpenter (4):
      iio: core: Fix an error pointer vs NULL bug in devm_iio_device_alloc()
      iio: light: tsl2591: fix some signedness bugs
      iio: light: tsl2591: delete a stray tab
      iio: adc: tsc2046: fix a warning message in tsc2046_adc_update_scan_mode()

Guenter Roeck (4):
      iio: am2315: Remove acpi_device_id table
      iio:accel:stk8312: Remove acpi_device_id table
      iio: bme680_spi: Remove acpi_device_id table
      iio: bme680_i2c: Remove acpi_device_id table

Jarkko Nikula (1):
      counter: Add support for Intel Quadrature Encoder Peripheral

Jiapeng Chong (1):
      iio: buffer: Remove redundant assignment to in_loc

Joe Sandom (2):
      iio: light: Added AMS tsl2591 driver implementation
      dt-bindings: iio: light: Added AMS tsl2591 device tree binding

Jonathan Cameron (89):
      dt-bindings:iio:accel:adis16201 and adis16209 bindings
      dt-bindings:iio:accel:bosch,bma220 device tree binding documentation
      dt-bindings:iio:accel:fsl,mma7455 binding doc
      dt-bindings:trivial-devices: Add memsic,mxc4005/mxc6255/mxc6655 entries
      dt-bindings:trivial-devices: Add sensortek,stk8312 and sensortek,s8ba50
      dt-bindings:iio:adc:adi,ad7298 document bindings
      iio:accel:stk8312: Add lowercase i2c device id
      dt-bindings:iio:dac:ti,dac082s085 yaml conversion
      iio:adc:ad7476: Handle the different regulators used by various parts.
      dt-bindings:iio:adc:adi,ad7476: Add missing binding document
      iio:ABI docs: Fix up duplicate *_calibbias_* documentation for icm42600
      iio:ABI docs: Drop device specific docs for _powerdown for the adf4371
      iio:ABI docs: Fix issue around repeated definition of out_currentY_raw
      iio:ABI docs: Move specific description of out_altvoltageX_frequency to main docs.
      iio: adc: stm32-adc: Fix docs wrongly marked as kernel-doc
      iio: accel: bmi088: Drop manual assignment of iio_dev.dev.parent
      iio: dac: ad5766: Drop duplicate setting of iio_dev.dev.parent and of_node
      iio: adc: mp2629: Drop duplicate setting iio_dev.dev.parent
      iio: adc: mt6360: Drop duplicate setting of iio_dev.dev.parent
      iio: adc: ti-ads131e08: Drop duplicate setting of iio_dev.dev.parent
      iio: humidity: hdc2010: Drop duplicate setting of iio_dev.dev.parent
      iio: position: hid-sensor-custom-intel-hinge: Drop duplicate parent setting.
      iio: common: scmi_sensors: Drop duplicate setting of iio_dev.dev.parent
      iio: core: move @id from struct iio_dev to struct iio_dev_opaque
      iio: avoid shadowing of variable name in to_iio_dev_opaque()
      iio: core: move @driver_module from struct iio_dev to struct iio_dev_opaque
      iio: core: move @trig_readonly from struct iio_dev to struct iio_dev_opaque
      iio: core: move @scan_index_timestamp to struct iio_dev_opaque
      iio: core: move @info_exist_lock to struct iio_dev_opaque
      iio: core: move @chrdev from struct iio_dev to struct iio_dev_opaque
      iio: core: move @flags from struct iio_dev to struct iio_dev_opaque
      iio: core: move @clock_id from struct iio_dev to struct iio_dev_opaque
      dt-bindings:iio:dac:ad5755: txt to yaml format conversion.
      iio: gyro: fxa21002c: Balance runtime pm + use pm_runtime_resume_and_get().
      iio: light: isl29028: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: light: tsl2583: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: accel: bmc150-accel: Balanced runtime pm + use pm_runtime_resume_and_get()
      iio: accel: mma9551/3: Balance untime pm + use pm_runtime_resume_and_get()
      iio: accel: kxcjk-1013: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: imu: kmx61: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: adc: stm32-adc: Use pm_runtime_resume_and_get() to replace open coding.
      iio: adc: stm32-dfsdm: Use pm_runtime_resume_and_get() to replace open coding.
      iio: dac: stm32-dac: Use pm_runtime_resume_and_get() to replace open coding.
      iio: light: us5182: Use pm_runtime_resume_and_get() to replace open coding.
      iio: temp: mlx90614: Handle failure in pm_runtime_resume_and_get()
      iio: adc: rcar-gyroadc: Use pm_runtime_resume_and_get() and check in probe()
      iio: proximity: srf04: Use pm_runtime_resume_and_get() and handle error
      iio: light: vcnl4000: Use pm_runtime_resume_and_get() to replace open coding.
      iio: light: vcnl4035: Use pm_runtime_resume_and_get() to replace open coding.
      iio: accel: bmi088: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: magn: bmc150: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: light: rpr0521: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: accel: mma8452: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: accel: bma180: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: bma220: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: hid: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: kxcjk-1013: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: mxc4005: Fix overread of data and alignment issue.
      iio: accel: stk8312: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: stk8ba50: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: ti-ads1015: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: vf610: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: gyro: bmg160: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: humidity: am2315: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: prox: srf08: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: prox: pulsed-light: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: prox: as3935: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: magn: hmc5843: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: magn: bmc150: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: light: isl29125: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: light: tcs3414: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: light: tcs3472: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: chemical: atlas: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: cros_ec_sensors: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
      iio: potentiostat: lmp91000: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
      iio: light: pa12203001: Use pm_runtime_resume_and_get() to replace open coding.
      iio: hid: trigger: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: chemical: sgp30: Drop use of %hx in format string.
      iio: adc: max11100: Use get_unaligned_be16() rather than opencoding.
      iio: adc: max11100: Use devm_ functions for rest of probe()
      iio: adc: max1118: Use devm_ managed functions for all of probe
      iio: adc: max1118: Avoid jumping back and forth between spi and iio structures
      iio: adc: ti-adc081c: Use devm managed functions for all of probe()
      iio: adc: ti-adc0832: Use devm managed functions for all of probe()
      iio: adc: ti-adc108s102: Use devm managed functions for all of probe()
      iio: adc: ti-adc161s626: Use devm managed functions for all of probe.
      iio: adis: Cleanout unused headers
      i2c: core: Add stub for i2c_verify_client() if !CONFIG_I2C
      Merge branch 'ib-iio-i2c-5.13rc1' into togreg Adds a stub needed to resolve a build conflict for the fxls8962af driver.

Krzysztof Kozlowski (2):
      iio: adc: exynos: drop unneeded variable assignment
      dt-bindings: iio: afe: current-sense-shunt: add io-channel-cells

Linus Walleij (7):
      iio: st-sensors: Update ST Sensor bindings
      iio: afe: iio-rescale: Support processed channels
      iio: st_sensors: Create extended attr macro
      iio: accel: st_sensors: Support generic mounting matrix
      iio: accel: st_sensors: Stop copying channels
      iio: magnetometer: st_magn: Support mount matrix
      iio: gyro: st_gyro: Support mount matrix

Lucas Stankus (5):
      dt-bindings: staging: iio: cdc: ad7746: add binding documentation for AD7746
      staging: iio: cdc: ad7746: use dt for capacitive channel setup.
      staging: iio: cdc: ad7746: remove ordinary comments
      staging: iio: cdc: ad7746: clean up probe return
      staging: iio: cdc: ad7746: extract capac setup to own function

Mauro Carvalho Chehab (1):
      iio: Documentation: move incompatible ABI to obsolete

Nuno Sa (10):
      iio: adis_buffer: do not return ints in irq handlers
      iio: adis16400: do not return ints in irq handlers
      iio: adis_buffer: check return value on page change
      iio: adis16475: do not return ints in irq handlers
      iio: adis_buffer: update device page after changing it
      iio: adis_buffer: don't push data to buffers on failure
      iio: adis: add burst_max_speed_hz variable
      iio: adis16475: do not directly change spi 'max_speed_hz'
      iio: adis16400: do not directly change spi 'max_speed_hz'
      iio: adis16480: support burst read function

Nuno Sá (2):
      iio: adis16260: make use of adis lock helpers
      iio: adis16136: make use of adis lock helpers

Oleksij Rempel (3):
      dt-bindings:iio:adc: add generic settling-time-us and oversampling-ratio channel properties
      dt-bindings:iio:adc: add documentation for TI TSC2046 controller
      iio: adc: add ADC driver for the TI TSC2046 controller

Puranjay Mohan (2):
      dt-bindings: iio: temperature: Add DT bindings for TMP117
      iio: temperature: add driver support for ti tmp117

Sean Nyekjaer (7):
      iio: imu: st_lsm6dsx: correct ODR in header
      iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers
      dt-bindings: iio: accel: fxls8962af: add bindings
      iio: accel: fxls8962af: add set/get of samplerate
      iio: accel: fxls8962af: add interrupt support
      iio: accel: fxls8962af: add hw buffered sampling
      iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads

Stephan Gerhold (4):
      dt-bindings: iio: kionix,kxcjk1013: Document kionix,kx023-1025
      iio: accel: kxcjk-1013: Refactor configuration registers into struct
      iio: accel: kxcjk-1013: Add support for KX023-1025
      iio: accel: bma180: Add missing 500 Hz / 1000 Hz bandwidth

Tang Bin (2):
      iio:adc:ad7766: Fix unnecessary check in ad7766_probe()
      staging: iio: cdc: ad7746: Remove unnecessary assignment in ad7746_probe()

Tian Tao (3):
      iio:chemical:sps30: Convert sysfs sprintf/snprintf family to sysfs_emit
      iio: light: Convert sysfs sprintf/snprintf family to sysfs_emit
      iio: trigger: stm32-timer: Convert sysfs sprintf/snprintf family to sysfs_emit

Tomas Melin (2):
      dt-bindings: iio: accel: Add SCA3300 documentation
      iio: accel: Add driver for Murata SCA3300 accelerometer

Tomasz Duszynski (3):
      iio: sps30: separate core and interface specific code
      iio: sps30: add support for serial interface
      dt-bindings: iio: chemical: sps30: update binding with serial example

Yicong Yang (7):
      iio: adc: adi-axi-adc: simplify devm_adi_axi_adc_conv_register()
      iio: buffer-dmaengine: simplify __devm_iio_dmaengine_buffer_free()
      iio: hw_consumer: simplify devm_iio_hw_consumer_alloc()
      iio: triggered-buffer: simplify devm_iio_triggered_buffer_setup_ext()
      iio: core: simplify some devm functions
      iio: trigger: simplify __devm_iio_trigger_register
      iio: inkern: simplify some devm functions

Zhen Lei (1):
      iio: ep93xx: Remove redundant error printing in ep93xx_adc_probe()

 Documentation/ABI/obsolete/sysfs-bus-iio           |  182 +++
 Documentation/ABI/testing/sysfs-bus-counter        |    9 +
 Documentation/ABI/testing/sysfs-bus-iio            |  125 +-
 .../ABI/testing/sysfs-bus-iio-frequency-adf4371    |   33 -
 .../ABI/testing/sysfs-bus-iio-health-afe440x       |   10 +-
 Documentation/ABI/testing/sysfs-bus-iio-icm42600   |   20 -
 .../ABI/testing/sysfs-bus-iio-light-lm3533-als     |   11 +-
 .../bindings/iio/accel/adi,adis16201.yaml          |   55 +
 .../bindings/iio/accel/bosch,bma220.yaml           |   50 +
 .../devicetree/bindings/iio/accel/fsl,mma7455.yaml |   82 ++
 .../bindings/iio/accel/kionix,kxcjk1013.yaml       |    1 +
 .../bindings/iio/accel/murata,sca3300.yaml         |   44 +
 .../bindings/iio/accel/nxp,fxls8962af.yaml         |   80 ++
 Documentation/devicetree/bindings/iio/adc/adc.yaml |   12 +
 .../devicetree/bindings/iio/adc/adi,ad7298.yaml    |   48 +
 .../devicetree/bindings/iio/adc/adi,ad7476.yaml    |  174 +++
 .../devicetree/bindings/iio/adc/ti,tsc2046.yaml    |  115 ++
 .../bindings/iio/afe/current-sense-shunt.yaml      |    4 +
 .../devicetree/bindings/iio/cdc/adi,ad7746.yaml    |   77 ++
 .../bindings/iio/chemical/sensirion,sps30.yaml     |    7 +-
 .../devicetree/bindings/iio/dac/ad5755.txt         |  124 --
 .../devicetree/bindings/iio/dac/adi,ad5755.yaml    |  169 +++
 .../devicetree/bindings/iio/dac/ti,dac082s085.yaml |   72 ++
 .../devicetree/bindings/iio/dac/ti-dac082s085.txt  |   34 -
 .../bindings/iio/light/amstaos,tsl2591.yaml        |   50 +
 .../devicetree/bindings/iio/st,st-sensors.yaml     |  262 +++--
 .../bindings/iio/temperature/ti,tmp117.yaml        |   41 +
 .../devicetree/bindings/trivial-devices.yaml       |   10 +
 MAINTAINERS                                        |   22 +
 drivers/counter/Kconfig                            |   10 +
 drivers/counter/Makefile                           |    1 +
 drivers/counter/intel-qep.c                        |  546 +++++++++
 drivers/iio/accel/Kconfig                          |   40 +
 drivers/iio/accel/Makefile                         |    4 +
 drivers/iio/accel/adis16201.c                      |    3 -
 drivers/iio/accel/adis16209.c                      |    3 -
 drivers/iio/accel/adxl372.c                        |    4 +-
 drivers/iio/accel/bma180.c                         |   17 +-
 drivers/iio/accel/bma220_spi.c                     |   10 +-
 drivers/iio/accel/bma400_core.c                    |    2 +-
 drivers/iio/accel/bmc150-accel-core.c              |   13 +-
 drivers/iio/accel/bmi088-accel-core.c              |   27 +-
 drivers/iio/accel/fxls8962af-core.c                |  968 ++++++++++++++++
 drivers/iio/accel/fxls8962af-i2c.c                 |   57 +
 drivers/iio/accel/fxls8962af-spi.c                 |   57 +
 drivers/iio/accel/fxls8962af.h                     |   22 +
 drivers/iio/accel/hid-sensor-accel-3d.c            |   13 +-
 drivers/iio/accel/kxcjk-1013.c                     |  253 +++-
 drivers/iio/accel/kxsd9.c                          |    2 +-
 drivers/iio/accel/mma8452.c                        |    7 +-
 drivers/iio/accel/mma9551.c                        |    1 -
 drivers/iio/accel/mma9551_core.c                   |    4 +-
 drivers/iio/accel/mma9553.c                        |    1 -
 drivers/iio/accel/mxc4005.c                        |   12 +-
 drivers/iio/accel/sca3300.c                        |  472 ++++++++
 drivers/iio/accel/st_accel.h                       |   12 -
 drivers/iio/accel/st_accel_core.c                  |  230 ++--
 drivers/iio/accel/st_accel_i2c.c                   |   17 +-
 drivers/iio/accel/st_accel_spi.c                   |   17 +-
 drivers/iio/accel/stk8312.c                        |   27 +-
 drivers/iio/accel/stk8ba50.c                       |   19 +-
 drivers/iio/adc/Kconfig                            |   12 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7298.c                           |    8 +
 drivers/iio/adc/ad7476.c                           |  118 +-
 drivers/iio/adc/ad7606.c                           |    3 +-
 drivers/iio/adc/ad7766.c                           |    8 +-
 drivers/iio/adc/ad7768-1.c                         |    3 +-
 drivers/iio/adc/ad_sigma_delta.c                   |    2 +-
 drivers/iio/adc/adi-axi-adc.c                      |   24 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |    2 +-
 drivers/iio/adc/at91_adc.c                         |    4 +-
 drivers/iio/adc/dln2-adc.c                         |    3 +-
 drivers/iio/adc/ep93xx_adc.c                       |    4 +-
 drivers/iio/adc/exynos_adc.c                       |    2 +-
 drivers/iio/adc/ina2xx-adc.c                       |    3 +-
 drivers/iio/adc/max11100.c                         |   34 +-
 drivers/iio/adc/max1118.c                          |   68 +-
 drivers/iio/adc/mp2629_adc.c                       |    1 -
 drivers/iio/adc/mt6360-adc.c                       |    1 -
 drivers/iio/adc/mxs-lradc-adc.c                    |    2 +-
 drivers/iio/adc/rcar-gyroadc.c                     |   15 +-
 drivers/iio/adc/sc27xx_adc.c                       |    1 +
 drivers/iio/adc/stm32-adc.c                        |   28 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |    6 +-
 drivers/iio/adc/ti-adc081c.c                       |   43 +-
 drivers/iio/adc/ti-adc0832.c                       |   39 +-
 drivers/iio/adc/ti-adc108s102.c                    |   45 +-
 drivers/iio/adc/ti-adc161s626.c                    |   51 +-
 drivers/iio/adc/ti-ads1015.c                       |   12 +-
 drivers/iio/adc/ti-ads131e08.c                     |    3 +-
 drivers/iio/adc/ti-tsc2046.c                       |  714 ++++++++++++
 drivers/iio/adc/vf610_adc.c                        |   10 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |    2 +-
 drivers/iio/afe/iio-rescale.c                      |   41 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   22 +-
 drivers/iio/buffer/industrialio-hw-consumer.c      |   25 +-
 drivers/iio/buffer/industrialio-triggered-buffer.c |   23 +-
 drivers/iio/chemical/Kconfig                       |   27 +-
 drivers/iio/chemical/Makefile                      |    2 +
 drivers/iio/chemical/atlas-sensor.c                |    6 +-
 drivers/iio/chemical/bme680_i2c.c                  |    8 -
 drivers/iio/chemical/bme680_spi.c                  |    8 -
 drivers/iio/chemical/ccs811.c                      |    2 +-
 drivers/iio/chemical/scd30_core.c                  |    3 +-
 drivers/iio/chemical/sgp30.c                       |    2 +-
 drivers/iio/chemical/sps30.c                       |  275 +----
 drivers/iio/chemical/sps30.h                       |   35 +
 drivers/iio/chemical/sps30_i2c.c                   |  258 +++++
 drivers/iio/chemical/sps30_serial.c                |  431 +++++++
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   10 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c         |    1 -
 drivers/iio/dac/ad5766.c                           |    2 -
 drivers/iio/dac/stm32-dac.c                        |    3 +-
 drivers/iio/gyro/adis16136.c                       |   20 +-
 drivers/iio/gyro/adis16260.c                       |    9 +-
 drivers/iio/gyro/adxrs290.c                        |    2 +-
 drivers/iio/gyro/bmg160_core.c                     |   17 +-
 drivers/iio/gyro/fxas21002c_core.c                 |   13 +-
 drivers/iio/gyro/itg3200_buffer.c                  |    2 +-
 drivers/iio/gyro/itg3200_core.c                    |    3 +-
 drivers/iio/gyro/mpu3050-core.c                    |    4 +-
 drivers/iio/gyro/st_gyro.h                         |   12 -
 drivers/iio/gyro/st_gyro_core.c                    |   53 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |   17 +-
 drivers/iio/gyro/st_gyro_spi.c                     |   17 +-
 drivers/iio/health/afe4403.c                       |    2 +-
 drivers/iio/health/afe4404.c                       |    2 +-
 drivers/iio/humidity/am2315.c                      |   25 +-
 drivers/iio/humidity/hdc2010.c                     |    1 -
 drivers/iio/imu/Kconfig                            |    1 +
 drivers/iio/imu/Makefile                           |    1 +
 drivers/iio/imu/adis.c                             |    4 -
 drivers/iio/imu/adis16400.c                        |   25 +-
 drivers/iio/imu/adis16460.c                        |    1 -
 drivers/iio/imu/adis16475.c                        |   10 +-
 drivers/iio/imu/adis16480.c                        |  164 ++-
 drivers/iio/imu/adis_buffer.c                      |   27 +-
 drivers/iio/imu/adis_trigger.c                     |    3 +-
 drivers/iio/imu/bmi160/bmi160_core.c               |    6 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |    2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    3 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |    2 +-
 drivers/iio/imu/kmx61.c                            |    7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |    8 +-
 drivers/iio/imu/st_lsm9ds0/Kconfig                 |   28 +
 drivers/iio/imu/st_lsm9ds0/Makefile                |    5 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h            |   23 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |  163 +++
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |   84 ++
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |   83 ++
 drivers/iio/industrialio-buffer.c                  |   13 +-
 drivers/iio/industrialio-core.c                    |  126 +-
 drivers/iio/industrialio-trigger.c                 |   37 +-
 drivers/iio/industrialio-triggered-event.c         |    2 +-
 drivers/iio/inkern.c                               |  107 +-
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/acpi-als.c                       |    3 +-
 drivers/iio/light/isl29028.c                       |    5 +-
 drivers/iio/light/isl29125.c                       |   10 +-
 drivers/iio/light/pa12203001.c                     |    4 +-
 drivers/iio/light/rpr0521.c                        |    9 +-
 drivers/iio/light/si1145.c                         |    2 +-
 drivers/iio/light/tcs3414.c                        |   10 +-
 drivers/iio/light/tcs3472.c                        |   10 +-
 drivers/iio/light/tsl2583.c                        |   13 +-
 drivers/iio/light/tsl2591.c                        | 1225 ++++++++++++++++++++
 drivers/iio/light/us5182d.c                        |    4 +-
 drivers/iio/light/vcnl4000.c                       |    7 +-
 drivers/iio/light/vcnl4035.c                       |    6 +-
 drivers/iio/light/veml6030.c                       |    2 +-
 drivers/iio/magnetometer/ak8974.c                  |    3 +-
 drivers/iio/magnetometer/ak8975.c                  |    2 +-
 drivers/iio/magnetometer/bmc150_magn.c             |   26 +-
 drivers/iio/magnetometer/hmc5843.h                 |    8 +-
 drivers/iio/magnetometer/hmc5843_core.c            |    7 +-
 drivers/iio/magnetometer/rm3100-core.c             |    2 +-
 drivers/iio/magnetometer/st_magn.h                 |    4 -
 drivers/iio/magnetometer/st_magn_core.c            |  181 ++-
 drivers/iio/magnetometer/st_magn_i2c.c             |   14 +-
 drivers/iio/magnetometer/st_magn_spi.c             |   14 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |    2 +-
 .../iio/position/hid-sensor-custom-intel-hinge.c   |    1 -
 drivers/iio/potentiostat/lmp91000.c                |    7 +-
 drivers/iio/pressure/st_pressure.h                 |    4 -
 drivers/iio/pressure/st_pressure_core.c            |   15 +-
 drivers/iio/pressure/st_pressure_i2c.c             |   17 +-
 drivers/iio/pressure/st_pressure_spi.c             |   17 +-
 drivers/iio/pressure/zpa2326.c                     |    3 +-
 drivers/iio/proximity/as3935.c                     |   13 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   10 +-
 drivers/iio/proximity/srf04.c                      |    8 +-
 drivers/iio/proximity/srf08.c                      |   14 +-
 drivers/iio/proximity/sx9310.c                     |    2 +-
 drivers/iio/proximity/sx9500.c                     |    2 +-
 drivers/iio/temperature/Kconfig                    |   10 +
 drivers/iio/temperature/Makefile                   |    1 +
 drivers/iio/temperature/mlx90614.c                 |   25 +-
 drivers/iio/temperature/tmp117.c                   |  185 +++
 drivers/iio/trigger/stm32-timer-trigger.c          |    2 +-
 drivers/staging/iio/accel/adis16203.c              |    6 -
 drivers/staging/iio/accel/adis16240.c              |    6 -
 drivers/staging/iio/cdc/ad7746.c                   |  114 +-
 drivers/staging/iio/cdc/ad7746.h                   |   28 -
 include/linux/i2c.h                                |    8 +-
 include/linux/iio/common/cros_ec_sensors_core.h    |    2 +-
 include/linux/iio/common/st_sensors.h              |   36 +-
 include/linux/iio/iio-opaque.h                     |   22 +-
 include/linux/iio/iio.h                            |   32 +-
 include/linux/iio/imu/adis.h                       |    2 +
 include/linux/platform_data/st_sensors_pdata.h     |    3 +-
 212 files changed, 8761 insertions(+), 1803 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-bus-iio
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-icm42600
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7298.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ad5755.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
 create mode 100644 drivers/counter/intel-qep.c
 create mode 100644 drivers/iio/accel/fxls8962af-core.c
 create mode 100644 drivers/iio/accel/fxls8962af-i2c.c
 create mode 100644 drivers/iio/accel/fxls8962af-spi.c
 create mode 100644 drivers/iio/accel/fxls8962af.h
 create mode 100644 drivers/iio/accel/sca3300.c
 create mode 100644 drivers/iio/adc/ti-tsc2046.c
 create mode 100644 drivers/iio/chemical/sps30.h
 create mode 100644 drivers/iio/chemical/sps30_i2c.c
 create mode 100644 drivers/iio/chemical/sps30_serial.c
 create mode 100644 drivers/iio/imu/st_lsm9ds0/Kconfig
 create mode 100644 drivers/iio/imu/st_lsm9ds0/Makefile
 create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
 create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
 create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
 create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
 create mode 100644 drivers/iio/light/tsl2591.c
 create mode 100644 drivers/iio/temperature/tmp117.c
 delete mode 100644 drivers/staging/iio/cdc/ad7746.h
