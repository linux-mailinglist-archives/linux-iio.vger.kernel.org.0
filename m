Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C677E34A5E4
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 11:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhCZKzG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 26 Mar 2021 06:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhCZKye (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 26 Mar 2021 06:54:34 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E64261A0D;
        Fri, 26 Mar 2021 10:54:32 +0000 (UTC)
Date:   Fri, 26 Mar 2021 10:54:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        Ye Xiang <xiang.ye@intel.com>
Subject: Re: [PULL] 1st set of IIO and counter new device support and core
 changes for the 5.13 cycle.
Message-ID: <20210326105436.44e9d3de@jic23-huawei>
In-Reply-To: <20210326104656.5d7689cb@jic23-huawei>
References: <20210326104656.5d7689cb@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Mar 2021 10:46:56 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> The following changes since commit c972c2d821ca3eda001a20dbe2ca0b4718838caf:
> 
>   staging: unisys: visornic: Fix repeated words in comments (2021-03-10 09:25:33 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.13a
> 
> for you to fetch changes up to 1b33dfa5d5f165782a1cb18ba1350a42d5d7a579:
> 
>   Merge remote-tracking branch 'local/ib-iio-scmi-5.12-rc2-take3' into togreg (2021-03-26 10:23:46 +0000)

Hi Greg,

There is a conflict merging this into staging/staging-next that needs
manual resolution.  It is is in hid-sensor-prox.c and resolution I would
recommend is to drop the block that is in staging-next.

@@ -220,29 +225,6 @@ static int prox_parse_report(struct platform_device *pdev,
        dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr.index,
                        st->prox_attr.report_id);
 
-       /* Set Sensitivity field ids, when there is no individual modifier */
-       if (st->common_attributes.sensitivity.index < 0) {
-               sensor_hub_input_get_attribute_info(hsdev,
-                       HID_FEATURE_REPORT, usage_id,
-                       HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-                       HID_USAGE_SENSOR_DATA_PRESENCE,
-                       &st->common_attributes.sensitivity);
-               dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
-                       st->common_attributes.sensitivity.index,
-                       st->common_attributes.sensitivity.report_id);
-       }
-       if (st->common_attributes.sensitivity.index < 0)
-               sensor_hub_input_get_attribute_info(hsdev,
-                       HID_FEATURE_REPORT, usage_id,
-                       HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
-                       HID_USAGE_SENSOR_HUMAN_PRESENCE,
-                       &st->common_attributes.sensitivity);
-
-       st->scale_precision = hid_sensor_format_scale(
-                               hsdev->usage,
-                               &st->prox_attr,
-                               &st->scale_pre_decml, &st->scale_post_decml);
-
        return ret;
 }

Ye Xiang, if that looks wrong to you let us know.

Thanks,

Jonathan


> 
> ----------------------------------------------------------------
> 1st set of IIO/counter device support, features and cleanup in the 5.13 cycle
> 
> Big set in here from Alexandru Ardelean enabling multiple buffer support.
> This includes providing a new directory per buffer that combines
> what was previously in buffer/ and scan_elements/. Old interfaces still
> in place for compatiblity.
> 
> Note immuatable branch for scmi patches to allow for some significant
> rework going on in that subsystem.  Merge required updating to reflect
> some changes in IIO.
> 
> Late rebase to fix some wrong fixes tags due to some earlier rebases
> made necessary by messing up the immutable branch.
> 
> IIO New Device Support
> * adi,ad5686
>   - Add info to support AD5673R and AD5677R
> * bosch,bmi088
>   - New driver supporting this accelerometer + gyroscope
> * cros_ec_mkbp
>   - New driver for this proximity sensor that exposes a 'front'
>     sensor. Very simple switch like device, but driver allows it
>     to share interface with more sophisticated proximity sensors.
> * iio_scmi
>   - New driver to support ARM SCMI protocol to expose underlying
>     accelerometers and gyroscopes via this firmware interface.
> * st,st_magn
>   - Add ID for IISMDC magnetometer.
> * ti,ads131e0
>   - New driver supporting ads131e04, ads131e06 and ads131e08 24 bit ADCs
> 
> Counter New Device Support
> * IRQ or GPIO based counter
>   - New driver for a conceptually simple counter that uses interrupts
>     to perform the count.
> 
> Features
> * core
>   - Dual buffer supprt including:
>      Various helpers to centralize handling of bufferer related elements.
>      Document existing and new IOCTLs
>      Register the IIO chrdev only if it can actually be used for anything.
>      Rework attribute group creation in the core (lots of patches)
>      Merge buffer/ and scan_elements/ entries into one list + maintain
>      backwards compatible set.
>      Introduce the internal logic and IOCTL to allow multiple buffers
>      + access to an anon FD per buffer to actually read from it.
>      Tidy up tools/iio/iio_generic_buffer and switch to new interfaces.
>      Update ABI docs.
>      A few follow up fixes, unsuprising as this was a huge bit of rework.
>   - Move common case setting of trig->parent to the core.
>   - Provide an iio_read_channel_processed_scale() to avoid loss of
>     precision from iio_read_channel_processed() then applying integer
>     scale. Use it in ntc_thermistor driver in hwmon.
>   - Allow drivers to specify labels from elsewhere than DT. Use it for
>     bmc150 and kxcjk-1013 labels related to position on 2 in one tablets.
>   - Document label usage for proximity and accelerometer sensors.
>   - Some local variable renames for consistency
> tools
>   - Add -a parameter to iio_event_monitor to allow autoenabling of events.
> * acpi_als
>   - Add trigger support for devices that don't support notification method.
> * adi,ad7124
>   - Allow more than 8 channels.  This is a complex little device, but is
>     capable of supporting up to 16 channels if the share certain
>     configuration settings.
> * hrtimer-trigger
>   - Support sampling frequency below 1Hz.
> * mediatek,mt8195-auxadc
>   - Add compatible to binding docs (always also includes mt8173)
> * st,stm32-adc
>   - Enable timetamps when not using DMA.
> * vishay,vcnl3020
>   - Sampling frequency control.
> 
> Cleanup and minor fixes:
> * treewide
>   - Use some getter and setter functions instead of opencoding.
>   - Set of fixes for pointless casts in various drivers.
>   - Avoid wrong kernel-doc marking on comment blocks.
>   - Fix various other minor kernel-doc issues shown by W=1
> * core
>   - Use a signed temporary for IIO_VAL_FRACTIONAL_LOG2 to avoid odd casts.
>   - Fix IIO_VAL_FRACTIONAL_LOG2 for values between -1.0 and 0.0
>   - Add unit tests for iio_format_value()
> * docs
>   - Fix formatting/typos in iio_configfs.rst and buffers.rst
>   - Add documentation of index in buffers.rst
>   - Fix scan element description
>   - Avoid some issues with HTML generation from ABI docs by moving
>     duplicated defintions to more generic files.
>   - Drop reference to long dead mailing list.
> * 104-quad
>   - Remove left over deprecated IIO counter ABI.
> * adi,adi-axi-adc
>   - Fix wrong bit of docs.
> * adi,ad5791
>   - Typos
> * adi,ad9834
>    - Switch to device managed functions in probe.
> * adi,adis*
>   - Add and use helpers for locking to reduced duplication.
> * adi,adis16480
>   - Fix calculation of sampling frequency when using pulse per second input.
> * adi,adis16475
>   - Calculate the IMU scaled internal sampling rate and runtime depending
>     on sysfs based configuration rather than getting from DT. Drop now
>     unnecessary property from DT bindings doc.
> * cros_ec
>    - Fix result of a series of recent changes that means extended buffer
>      attributes turn up in the wrong place. Too complex to revert the
>      various patches unfortunately so this is a bit messy.
> * fsl,mma3452
>   - Indentation cleanup.
> * hid-sensors
>   - Size of storage needs to increase for some parts when using quaternions.
>   - Move the get sensistivity attribute to hid-sensors-common to reduce
>     duplication.  Enable it for more device types.
>   - Correctly handle relative sensitivity if reported that way including
>     documenting the new ABI.
> * maxim,max517
>   - Use device managed functions in probe.
> * mediatek,mt6360-adc
>   - Use asm/unaligned.h instead of directly including
>     unaligned/be_byteshift.h
> * novuton,npcm-adc
>   - Local lock instead of missusing mlock.
> * semtech,sx9500
>   - Typos
> * st,sensor
>   - typo fix
> * st,spear-adc
>   - Local lock instead of missusing mlock.
> * st,stm32-adc
>   - Long standing HAS_IOMEM dependency fix.
> * st,stm32-counter
>   - Remove left over deprecated IIO counter ABI.
> * ti,palmas-adc
>   - Local lock instead of missusing mlock.
> * ti,tmp007
>   - Switch to device managed functions in probe.
> 
> Other
> * MAINTAINERS
>   - Move Peter Meerwald-Stadler to Credits at his request
> 
> ----------------------------------------------------------------
> Ahmad Fatoum (2):
>       iio: st_sensors: fix typo in comment
>       iio: adc: stm32-adc: enable timestamping for non-DMA usage
> 
> Alexandru Ardelean (30):
>       iio: kfifo: add devm_iio_kfifo_buffer_setup() helper
>       iio: make use of devm_iio_kfifo_buffer_setup() helper
>       iio: accel: sca3000: use devm_iio_kfifo_buffer_setup() helper
>       iio: kfifo: un-export devm_iio_kfifo_allocate() function
>       iio: buffer-dma,adi-axi-adc: introduce devm_iio_dmaengine_buffer_setup()
>       docs: ioctl-number.rst: reserve IIO subsystem ioctl() space
>       iio: core: register chardev only if needed
>       iio: core-trigger: make iio_device_register_trigger_consumer() an int return
>       iio: core: rework iio device group creation
>       iio: buffer: group attr count and attr alloc
>       iio: core: merge buffer/ & scan_elements/ attributes
>       iio: add reference to iio buffer on iio_dev_attr
>       iio: buffer: wrap all buffer attributes into iio_dev_attr
>       iio: buffer: dmaengine: obtain buffer object from attribute
>       iio: core: wrap iio device & buffer into struct for character devices
>       iio: buffer: move __iio_buffer_free_sysfs_and_mask() before alloc
>       iio: dummy: iio_simple_dummy_buffer: use triggered buffer core calls
>       iio: buffer: introduce support for attaching more IIO buffers
>       iio: buffer: add ioctl() to support opening extra buffers for IIO device
>       iio: core: rename 'dev' -> 'indio_dev' in iio_device_alloc()
>       tools: iio: make iioutils_get_type() private in iio_utils
>       tools: iio: privatize globals and functions in iio_generic_buffer.c file
>       tools: iio: convert iio_generic_buffer to use new IIO buffer API
>       iio: Documentation: update definitions for bufferY and scan_elements
>       iio: adc: adi-axi-adc: fix typo in doc-string
>       iio: kfifo: mask flags without zero-check in devm_iio_kfifo_buffer_setup()
>       iio: buffer: fix use-after-free for attached_buffers array
>       iio: temperature: tmp007: use device-managed functions in probe
>       staging: iio: ad9834: convert to device-managed functions in probe
>       iio: kfifo: add devm_iio_triggered_buffer_setup_ext variant
> 
> Alexandru Tachici (1):
>       iio: adc: ad7124: allow more than 8 channels
> 
> Andy Shevchenko (4):
>       iio: chemical: bmp680: Drop unneeded explicit castings
>       iio: imu: fxos8700: Drop unneeded explicit castings
>       iio: imu: st_lsm6dsx: Drop unneeded explicit castings
>       iio: light: gp2ap002: Drop unneeded explicit casting
> 
> Baruch Siach (1):
>       staging: iio: remove mention of defunct list
> 
> Bhaskar Chowdhury (1):
>       iio: proximity: sx9500: Fix a spelling postive to positive
> 
> Fabrice Gasnier (1):
>       counter: stm32-lptimer-cnt: remove iio counter abi
> 
> Guoqing Chi (1):
>       iio: adc: ad7292: Modify the bool initialization assignment
> 
> Gwendal Grignou (14):
>       iio: hrtimer: Allow sub Hz granularity
>       iio: Remove kernel-doc keyword in file header comment
>       iio: set default trig->dev.parent
>       iio: fix devm_iio_trigger_alloc with parent.cocci
>       iio: adis_trigger: Remove code to set trigger parent
>       iio: gp2ap020a00f: Remove code to set trigger parent
>       iio: lmp91000: Remove code to set trigger parent
>       iio: chemical: atlas: Remove code to set trigger parent
>       iio: as3935: Remove code to set trigger parent
>       iio: xilinx-xadc: Remove code to set trigger parent
>       iio: cros: unify hw fifo attributes without API changes
>       iio: acpi_als: Add timestamp channel
>       iio: acpi_als: Add local variable dev in probe
>       iio: acpi_als: Add trigger support
> 
> Hans de Goede (5):
>       iio: core: Allow drivers to specify a label without it coming from of
>       iio: accel: bmc150: Set label based on accel-location on 2-accel yoga-style 2-in-1s
>       iio: accel: kxcjk-1013: Set label based on accel-location on 2-accel yoga-style 2-in-1s
>       iio: documentation: Document proximity sensor label use
>       iio: documentation: Document accelerometer label use
> 
> Ivan Mikhaylov (1):
>       iio: proximity: vcnl3020: add proximity rate
> 
> Jonathan Cameron (13):
>       iio:adc:stm32-adc: Add HAS_IOMEM dependency
>       iio:ABI docs: Combine sysfs-bus-iio-humidity-hdc2010/hdc100x into one file
>       iio:ABI docs: Combine the two instances of docs for sensor_sensitivity
>       iio: pressure: zpa2326: kernel-doc fixes
>       iio: adc: ti-adc084s021: kernel-doc fixes, missing function names
>       iio: dac: ad5770r: kernel-doc fix case of letter R wrong in structure name
>       iio: dac: ad5504: fix wrong part number in kernel-doc structure name.
>       iio: adc: cpcap-adc: kernel-doc fix - that should be _ in structure name
>       iio: adc: adi-axi-adc: Drop false marking for kernel-doc
>       iio: accel: sca3000: kernel-doc fixes. Missing - and wrong function names.
>       iio: buffer: kfifo_buf: kernel-doc, typo in function name.
>       iio:cros_ec_sensors: Fix a wrong function name in kernel doc.
>       Merge remote-tracking branch 'local/ib-iio-scmi-5.12-rc2-take3' into togreg
> 
> Julia Lawall (1):
>       iio: use getter/setter functions
> 
> Jyoti Bhayana (1):
>       iio/scmi: Adding support for IIO SCMI Based Sensors
> 
> LI Qingwu (2):
>       dt-bindings: iio: st,st-sensors add IIS2MDC.
>       iio:magnetometer: Add Support for ST IIS2MDC
> 
> Lars-Peter Clausen (3):
>       iio: iio_format_value(): Use signed temporary for IIO_VAL_FRACTIONAL_LOG2
>       iio: iio_format_value(): Fix IIO_VAL_FRACTIONAL_LOG2 values between -1.0 and 0.0
>       iio: Add basic unit test for iio_format_value()
> 
> Linus Walleij (4):
>       iio: adc: mt6360: Include right header
>       iio: Provide iio_read_channel_processed_scale() API
>       hwmon: (ntc_thermistor): try reading processed
>       iio: event_monitor: Enable events before monitoring
> 
> Luca Ceresoli (5):
>       docs: iio: fix example formatting
>       docs: iio: fix directory naming
>       docs: iio: document the 'index' attribute too
>       docs: iio: fix bullet list formatting
>       docs: iio: mark "repeat" sysfs attribute as optional
> 
> Mike Looijmans (2):
>       dt-bindings: iio: accel: Add bmi088 accelerometer bindings
>       iio: accel: Add support for the Bosch-Sensortec BMI088
> 
> Mircea Caprioru (1):
>       iio: dac: ad5686: Add support for AD5673R/AD5677R
> 
> Mugilraj Dhavachelvan (2):
>       iio:dac:max517.c: Use devm_iio_device_register()
>       staging: iio: ad9832: kernel-doc fixes
> 
> Nuno Sa (3):
>       iio: adis16480: fix pps mode sampling frequency math
>       iio: adis16475: improve sync scale mode handling
>       iio: adis: add helpers for locking
> 
> Nuno Sá (1):
>       dt-bindings: adis16475: remove property
> 
> Oleksij Rempel (2):
>       dt-bindings: counter: add interrupt-counter binding
>       counter: add IRQ or GPIO based counter
> 
> Peter Meerwald-Stadler (1):
>       MAINTAINERS: iio: move Peter Meerwald-Stadler to CREDITS
> 
> Sean Nyekjaer (1):
>       iio: accel: mma8452: fix indentation
> 
> Seiya Wang (1):
>       dt-bindings: iio: adc: Add compatible for Mediatek MT8195
> 
> Sergiu Cuciurean (3):
>       iio: adc: spear_adc: Replace indio_dev->mlock with own device lock
>       iio: adc: palmas_gpadc: Replace indio_dev->mlock with own device lock
>       iio: adc: npcm_adc: Replace indio_dev->mlock with own device lock
> 
> Stephen Boyd (3):
>       platform/chrome: cros_ec: Add SW_FRONT_PROXIMITY MKBP define
>       dt-bindings: iio: Add cros ec proximity yaml doc
>       iio: proximity: Add a ChromeOS EC MKBP proximity driver
> 
> Tomislav Denis (2):
>       iio: adc: Add driver for Texas Instruments ADS131E0x ADC family
>       bindings: iio: adc: Add documentation for ADS131E0x ADC driver
> 
> William Breathitt Gray (1):
>       counter: 104-quad-8: Remove IIO counter ABI
> 
> Ye Xiang (6):
>       iio: hid-sensor-rotation: Fix quaternion data not correct
>       iio: hid-sensors: Move get sensitivity attribute to hid-sensor-common
>       hid-sensors: Add more data fields for sensitivity checking
>       iio: Add relative sensitivity support
>       iio: hid-sensor-als: Add relative hysteresis support
>       iio: Add relative hysteresis in ABI documentation
> 
> zuoqilin (1):
>       iio:adc:dac:ad5791 typo fix of regster
> 
>  CREDITS                                            |   8 +
>  Documentation/ABI/testing/sysfs-bus-iio            | 140 +++
>  .../ABI/testing/sysfs-bus-iio-counter-104-quad-8   | 133 ---
>  .../ABI/testing/sysfs-bus-iio-distance-srf08       |   8 -
>  ...iio-humidity-hdc2010 => sysfs-bus-iio-humidity} |   3 +-
>  .../ABI/testing/sysfs-bus-iio-humidity-hdc100x     |   9 -
>  .../ABI/testing/sysfs-bus-iio-lptimer-stm32        |  62 --
>  Documentation/ABI/testing/sysfs-bus-iio-proximity  |  14 +
>  .../ABI/testing/sysfs-bus-iio-proximity-as3935     |   9 -
>  .../bindings/counter/interrupt-counter.yaml        |  62 ++
>  .../bindings/iio/accel/bosch,bmi088.yaml           |  68 ++
>  .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |   1 +
>  .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  | 181 ++++
>  .../devicetree/bindings/iio/imu/adi,adis16475.yaml |   9 -
>  .../proximity/google,cros-ec-mkbp-proximity.yaml   |  37 +
>  .../devicetree/bindings/iio/st,st-sensors.yaml     |   1 +
>  .../devicetree/bindings/mfd/google,cros-ec.yaml    |   7 +
>  Documentation/driver-api/driver-model/devres.rst   |   3 +-
>  Documentation/driver-api/iio/buffers.rst           |  15 +-
>  Documentation/iio/iio_configfs.rst                 |   3 +-
>  Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
>  MAINTAINERS                                        |  22 +-
>  drivers/counter/104-quad-8.c                       | 653 ++------------
>  drivers/counter/Kconfig                            |  14 +-
>  drivers/counter/Makefile                           |   1 +
>  drivers/counter/interrupt-cnt.c                    | 244 ++++++
>  drivers/counter/stm32-lptimer-cnt.c                | 297 +------
>  drivers/firmware/arm_scmi/driver.c                 |   2 +-
>  drivers/hwmon/ntc_thermistor.c                     |  27 +-
>  drivers/iio/Kconfig                                |   1 +
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/accel/Kconfig                          |  18 +
>  drivers/iio/accel/Makefile                         |   2 +
>  drivers/iio/accel/adxl372.c                        |   2 -
>  drivers/iio/accel/bma180.c                         |   3 +-
>  drivers/iio/accel/bma220_spi.c                     |   2 +-
>  drivers/iio/accel/bmc150-accel-core.c              |  19 +-
>  drivers/iio/accel/bmi088-accel-core.c              | 567 ++++++++++++
>  drivers/iio/accel/bmi088-accel-spi.c               |  83 ++
>  drivers/iio/accel/bmi088-accel.h                   |  18 +
>  drivers/iio/accel/cros_ec_accel_legacy.c           |   2 +-
>  drivers/iio/accel/da280.c                          |   2 +-
>  drivers/iio/accel/da311.c                          |   2 +-
>  drivers/iio/accel/dmard10.c                        |   2 +-
>  drivers/iio/accel/hid-sensor-accel-3d.c            |  23 +-
>  drivers/iio/accel/kxcjk-1013.c                     |  16 +-
>  drivers/iio/accel/mc3230.c                         |   2 +-
>  drivers/iio/accel/mma7660.c                        |   2 +-
>  drivers/iio/accel/mma8452.c                        |  47 +-
>  drivers/iio/accel/mxc4005.c                        |   1 -
>  drivers/iio/accel/sca3000.c                        |  27 +-
>  drivers/iio/accel/ssp_accel_sensor.c               |  14 +-
>  drivers/iio/accel/stk8312.c                        |   3 +-
>  drivers/iio/accel/stk8ba50.c                       |   3 +-
>  drivers/iio/adc/Kconfig                            |  13 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/ad7124.c                           | 459 ++++++----
>  drivers/iio/adc/ad7292.c                           |   2 +-
>  drivers/iio/adc/ad7606.c                           |   1 -
>  drivers/iio/adc/ad7766.c                           |   1 -
>  drivers/iio/adc/ad7768-1.c                         |   1 -
>  drivers/iio/adc/ad_sigma_delta.c                   |   6 +-
>  drivers/iio/adc/adi-axi-adc.c                      |  14 +-
>  drivers/iio/adc/at91_adc.c                         |   3 +-
>  drivers/iio/adc/cpcap-adc.c                        |   2 +-
>  drivers/iio/adc/ina2xx-adc.c                       |  14 +-
>  drivers/iio/adc/max1027.c                          |   1 -
>  drivers/iio/adc/mt6360-adc.c                       |   3 +-
>  drivers/iio/adc/npcm_adc.c                         |  15 +-
>  drivers/iio/adc/palmas_gpadc.c                     |  18 +-
>  drivers/iio/adc/spear_adc.c                        |  20 +-
>  drivers/iio/adc/stm32-adc.c                        |  39 +-
>  drivers/iio/adc/ti-adc084s021.c                    |   6 +-
>  drivers/iio/adc/ti-ads131e08.c                     | 948 +++++++++++++++++++++
>  drivers/iio/adc/ti_am335x_adc.c                    |  18 +-
>  drivers/iio/adc/xilinx-xadc-core.c                 |   1 -
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  35 +-
>  drivers/iio/buffer/industrialio-triggered-buffer.c |  10 +-
>  drivers/iio/buffer/kfifo_buf.c                     |  45 +-
>  drivers/iio/chemical/atlas-sensor.c                |   1 -
>  drivers/iio/chemical/bme680_i2c.c                  |   3 +-
>  drivers/iio/chemical/bme680_spi.c                  |   3 +-
>  drivers/iio/chemical/ccs811.c                      |   1 -
>  drivers/iio/chemical/scd30_core.c                  |   1 -
>  drivers/iio/chemical/scd30_serial.c                |   2 +-
>  drivers/iio/common/Kconfig                         |   1 +
>  drivers/iio/common/Makefile                        |   1 +
>  .../iio/common/cros_ec_sensors/cros_ec_lid_angle.c |   3 +-
>  .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   3 +-
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  33 +-
>  .../iio/common/hid-sensors/hid-sensor-attributes.c |  83 +-
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    |   4 +-
>  drivers/iio/common/scmi_sensors/Kconfig            |  18 +
>  drivers/iio/common/scmi_sensors/Makefile           |   5 +
>  drivers/iio/common/scmi_sensors/scmi_iio.c         | 672 +++++++++++++++
>  drivers/iio/common/st_sensors/st_sensors_buffer.c  |   2 +-
>  drivers/iio/common/st_sensors/st_sensors_trigger.c |   4 +-
>  drivers/iio/dac/Kconfig                            |   5 +-
>  drivers/iio/dac/ad5504.c                           |   2 +-
>  drivers/iio/dac/ad5686.c                           |  12 +
>  drivers/iio/dac/ad5686.h                           |   2 +
>  drivers/iio/dac/ad5696-i2c.c                       |   6 +-
>  drivers/iio/dac/ad5770r.c                          |   2 +-
>  drivers/iio/dac/ad5791.c                           |   2 +-
>  drivers/iio/dac/max517.c                           |  10 +-
>  drivers/iio/dummy/iio_simple_dummy_buffer.c        |  68 +-
>  drivers/iio/gyro/adxrs290.c                        |   1 -
>  drivers/iio/gyro/bmg160_core.c                     |   2 -
>  drivers/iio/gyro/fxas21002c_core.c                 |   1 -
>  drivers/iio/gyro/hid-sensor-gyro-3d.c              |  19 +-
>  drivers/iio/gyro/itg3200_buffer.c                  |   3 +-
>  drivers/iio/gyro/ssp_gyro_sensor.c                 |  14 +-
>  drivers/iio/health/afe4403.c                       |   1 -
>  drivers/iio/health/afe4404.c                       |   1 -
>  drivers/iio/health/max30100.c                      |  16 +-
>  drivers/iio/health/max30102.c                      |  16 +-
>  drivers/iio/humidity/am2315.c                      |   2 +-
>  drivers/iio/humidity/hid-sensor-humidity.c         |  16 +-
>  drivers/iio/humidity/hts221_buffer.c               |   1 -
>  drivers/iio/iio_core.h                             |  32 +-
>  drivers/iio/iio_core_trigger.h                     |   4 +-
>  drivers/iio/imu/adis16400.c                        |  22 +-
>  drivers/iio/imu/adis16475.c                        | 118 ++-
>  drivers/iio/imu/adis16480.c                        | 133 ++-
>  drivers/iio/imu/adis_trigger.c                     |  10 +-
>  drivers/iio/imu/fxos8700_i2c.c                     |   3 +-
>  drivers/iio/imu/fxos8700_spi.c                     |   3 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  14 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  13 +-
>  drivers/iio/imu/kmx61.c                            |   1 -
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  15 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   3 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c        |   3 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   3 +-
>  drivers/iio/industrialio-buffer.c                  | 496 ++++++++---
>  drivers/iio/industrialio-core.c                    | 132 ++-
>  drivers/iio/industrialio-event.c                   |   6 +-
>  drivers/iio/industrialio-trigger.c                 |  40 +-
>  drivers/iio/inkern.c                               |  16 +-
>  drivers/iio/light/acpi-als.c                       | 117 ++-
>  drivers/iio/light/apds9960.c                       |  16 +-
>  drivers/iio/light/cros_ec_light_prox.c             |   3 +-
>  drivers/iio/light/gp2ap002.c                       |   3 +-
>  drivers/iio/light/gp2ap020a00f.c                   |   1 -
>  drivers/iio/light/hid-sensor-als.c                 |  34 +-
>  drivers/iio/light/hid-sensor-prox.c                |  27 +-
>  drivers/iio/light/opt3001.c                        |   2 +-
>  drivers/iio/light/rpr0521.c                        |   1 -
>  drivers/iio/light/si1145.c                         |   1 -
>  drivers/iio/light/st_uvis25_core.c                 |   1 -
>  drivers/iio/light/stk3310.c                        |   2 +-
>  drivers/iio/light/vcnl4000.c                       |   1 -
>  drivers/iio/light/vcnl4035.c                       |   1 -
>  drivers/iio/magnetometer/bmc150_magn.c             |   1 -
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c      |  32 +-
>  drivers/iio/magnetometer/rm3100-core.c             |   1 -
>  drivers/iio/magnetometer/st_magn.h                 |   1 +
>  drivers/iio/magnetometer/st_magn_core.c            |   1 +
>  drivers/iio/magnetometer/st_magn_i2c.c             |   5 +
>  drivers/iio/magnetometer/st_magn_spi.c             |   5 +
>  drivers/iio/orientation/hid-sensor-incl-3d.c       |  20 +-
>  drivers/iio/orientation/hid-sensor-rotation.c      |  37 +-
>  .../iio/position/hid-sensor-custom-intel-hinge.c   |  20 +-
>  drivers/iio/potentiometer/max5481.c                |   4 +-
>  drivers/iio/potentiometer/max5487.c                |   4 +-
>  drivers/iio/potentiostat/lmp91000.c                |   3 +-
>  drivers/iio/pressure/cros_ec_baro.c                |   3 +-
>  drivers/iio/pressure/hid-sensor-press.c            |  20 +-
>  drivers/iio/pressure/zpa2326.c                     |   5 +-
>  drivers/iio/proximity/Kconfig                      |  11 +
>  drivers/iio/proximity/Makefile                     |   1 +
>  drivers/iio/proximity/as3935.c                     |   1 -
>  drivers/iio/proximity/cros_ec_mkbp_proximity.c     | 271 ++++++
>  drivers/iio/proximity/sx9310.c                     |   1 -
>  drivers/iio/proximity/sx9500.c                     |   3 +-
>  drivers/iio/proximity/vcnl3020.c                   |  97 ++-
>  drivers/iio/temperature/hid-sensor-temperature.c   |  16 +-
>  drivers/iio/temperature/tmp007.c                   |  36 +-
>  drivers/iio/test/Kconfig                           |   9 +
>  drivers/iio/test/Makefile                          |   7 +
>  drivers/iio/test/iio-test-format.c                 | 198 +++++
>  drivers/iio/trigger/iio-trig-hrtimer.c             |  37 +-
>  drivers/iio/trigger/iio-trig-interrupt.c           |   2 +-
>  drivers/iio/trigger/iio-trig-loop.c                |   2 +-
>  drivers/iio/trigger/iio-trig-sysfs.c               |   3 +-
>  drivers/rtc/rtc-hid-sensor-time.c                  |   4 +-
>  drivers/staging/iio/TODO                           |   4 -
>  drivers/staging/iio/frequency/ad9832.c             |   4 +-
>  drivers/staging/iio/frequency/ad9834.c             |  67 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c    |  23 +-
>  include/linux/hid-sensor-hub.h                     |   9 +-
>  include/linux/hid-sensor-ids.h                     |   1 +
>  include/linux/iio/adc/adi-axi-adc.h                |   2 +-
>  include/linux/iio/buffer-dmaengine.h               |   7 +-
>  include/linux/iio/buffer.h                         |   4 +-
>  include/linux/iio/buffer_impl.h                    |  21 +-
>  include/linux/iio/common/cros_ec_sensors_core.h    |   3 +-
>  include/linux/iio/consumer.h                       |  15 +
>  include/linux/iio/iio-opaque.h                     |  14 +
>  include/linux/iio/iio.h                            |   7 +-
>  include/linux/iio/imu/adis.h                       |  10 +
>  include/linux/iio/kfifo_buf.h                      |  11 +-
>  include/linux/iio/sysfs.h                          |   3 +
>  include/linux/iio/trigger.h                        |   3 +-
>  include/linux/iio/types.h                          |   1 +
>  include/linux/platform_data/cros_ec_commands.h     |   1 +
>  include/uapi/linux/iio/buffer.h                    |  10 +
>  tools/iio/Makefile                                 |   1 +
>  tools/iio/iio_event_monitor.c                      |  69 +-
>  tools/iio/iio_generic_buffer.c                     | 153 +++-
>  tools/iio/iio_utils.c                              |  18 +-
>  tools/iio/iio_utils.h                              |   9 +-
>  212 files changed, 5950 insertions(+), 2272 deletions(-)
>  delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
>  rename Documentation/ABI/testing/{sysfs-bus-iio-humidity-hdc2010 => sysfs-bus-iio-humidity} (79%)
>  delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
>  delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32
>  create mode 100644 Documentation/devicetree/bindings/counter/interrupt-counter.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
>  create mode 100644 drivers/counter/interrupt-cnt.c
>  create mode 100644 drivers/iio/accel/bmi088-accel-core.c
>  create mode 100644 drivers/iio/accel/bmi088-accel-spi.c
>  create mode 100644 drivers/iio/accel/bmi088-accel.h
>  create mode 100644 drivers/iio/adc/ti-ads131e08.c
>  create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
>  create mode 100644 drivers/iio/common/scmi_sensors/Makefile
>  create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c
>  create mode 100644 drivers/iio/proximity/cros_ec_mkbp_proximity.c
>  create mode 100644 drivers/iio/test/Kconfig
>  create mode 100644 drivers/iio/test/Makefile
>  create mode 100644 drivers/iio/test/iio-test-format.c
>  create mode 100644 include/uapi/linux/iio/buffer.h

