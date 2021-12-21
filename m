Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A7447C2CD
	for <lists+linux-iio@lfdr.de>; Tue, 21 Dec 2021 16:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbhLUP2C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 21 Dec 2021 10:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbhLUP2C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Dec 2021 10:28:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18804C061574
        for <linux-iio@vger.kernel.org>; Tue, 21 Dec 2021 07:28:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F16661658
        for <linux-iio@vger.kernel.org>; Tue, 21 Dec 2021 15:28:01 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 92455C36AEA;
        Tue, 21 Dec 2021 15:27:58 +0000 (UTC)
Date:   Tue, 21 Dec 2021 15:33:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of new device support, features and cleanup for IIO
 in the 5.17 cycle.
Message-ID: <20211221153333.0bfe8257@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.17a

for you to fetch changes up to c9791a94384af07592d29504004d2255dbaf8663:

  iio: adc: ti-adc081c: Partial revert of removal of ACPI IDs (2021-12-21 15:13:29 +0000)

----------------------------------------------------------------
1st set of IIO new device support, features and cleanup for 5.17

Includes some fixes that were either late breaking, low priority or
complex enough to not be good to rush in late in the cycle.

Tree rebased today to fix up some trivial issues + pull in a fix that
was previously on the fixes-togreg branch. Vast majority have been
in linux-next for some time now.

New device support
* adi,ad7293
  - New driver and bindings for this Power Amplifier drain current
    controller.  A complex device with various related monitoring functions.
* adi,ad75513R
  - New driver and bindings for this combined ADC and DAC device.
  - A few follow up fixes.
* adi,admv8818
  - New driver (and type) for this 2-18GHz filter device. Includes
    bindings and ABI documentation to allow clk_notifier based auto
    adjustment of the filters in appropriate applications.
* liteon,ltr501
  - Support for the ltr303.  ID and chip specific info table.
* xilinx,ams
  - New generic firmware function fwnode_iomap() as used in this driver.
  - New driver and bindings for this ADC and on-chip sensors as found
    in various Xilinx devices.

Core
* Introduced IIO_VAL_INT_64 which uses val and val2 in IIO callbacks to
  form a 64 bit integer when higher precision needed.
* Allow IIO_ENUM_AVAILABLE to be used with different shared values.
* Fix a long term issue with scheduling whilst atomic when iio_trig_poll()
  is called but no trigger consumers are actually enabled and hence the
  trigger may be reenabled from the interrupt handler.  Seen in the wild
  on the tsc2046.
* Mark iio_device_type const.
* buffer: Use a separate index variable to simplify code.
* buffer-dma: Clear out unused struct iio_buffer_block
* buffer-dmaengine: Switch to cheaper round_down() as power of 2 values.

Tests/tools
* format_value
  - Check against NULL returns from allocations in tests.
  - Add IIO_VAL_INT_64 test case.
* event_monitor
  - Flush the output after event to given more consistent latency
    when tool output piped to other programs.

Driver Features
* axp20x
  - Add support for NTC thermistor channel and document TS pin binding.
* arm,scmi
  - Add reading of raw channel values (using IIO_VAL_INT_64)
* liteon,ltr501
  - Add proximity-near-level support and dt-binding.

Tree wide cleanup
* Remove no-op trigger ops from multiple drivers.
* Stop using dev_get_drvdata() on the iio_dev->dev in various drivers
  and then stop assigning it to allow this to be used for other purposes.
  We can always get to the indio_dev using dev_to_iio_dev() which is
  a container_of() based approach. Also cleanup up some related unnecessary
  convoluted cases.
  - atmel,at91-sam5d2
  - nxp,imx7d
  - meas,ms5611
  - st,st_sensors
* Where available (or easy to introduce) use the scan_type.* values
  in place of a second copy for read_raw and similar paths.
  - adi,ad7266
  - bosch,bma220
  - fsl,mac3110
  - fsl,mma7455
  - fsl,mpl3115
  - kionix,kcjk-1013
  - sensortek,stk8ba50
  - sensortek,stk8312
  - ti,adc12138
  - ti,ads1015
  - vti,sca3000
  - xilinx,xadc-core
* Switch drives over to generic firmware properties including appropriate
  header changes to avoid including of.h
  - Various DACs had false CONFIG_OF dependencies.
  - dpot-dac
  - envelope-detector
  - adi,ad5755
  - adi,ad5758
  - capella,cm3605
  - maxim,max9611
  - microchip,mcp41010
  - microchip,mcp3911
  - ti,adc12138
* Trivial clang warning fixes for W=1 warnings.

Driver specific cleanup and minor fixes
* adi,ad7606
  - Comment fixes.
* ams,ad3935
  - Drop pointless cast to the same type.
* atmel,at91-sama5d2
  - Fix wrong cast of iio_dev->dev to platform_device that happened to
    be harmless.
* fsl,mma7660
  - Stop i2c remove() function returning an error code. Part of a rework
    to eventually stop returning anything from these.
* fsl,mma8452
  - Use correct type for local irqreturn_t.
* nxp,imx8mq
  - Maintainer email address update.
* nxp,lpc18xx_adc
  - Ensure clk_prepare_enable() called before clk_get_rate().
  - Switch of.h for mod_devicetable.h to reflect no of specific functions,
    just the id table.
* renesas,rzg2l
  - Drop a dev_err() that just duplicates error printed in platform_get_irq()
* sgx,vz89x
  - Drop pointless cast.
* st,lsm6dsx
  - Make it possible to disable the sensorhub from DT to avoid a corner
    case where the address of a slave device many be accidentally modified.
* st,stm32-adc
  - Stop leaking an of_node in an error path.
* st,stmp2
   - Avoid wrong sized type for bit field which could result in
     over-reading (harmless). Precursor to enabling -Warray-bounds.
* ti,adc081c
  - Put back some ACPI support for non standards compliant ADC081C
    ID because it is known to be in the wild on some Aaeon boards.
* ti,ads8688
  - Cleanup redundant local ret variable assignment.
* ti,ina2xx-adc
  - Use helper macro kthread_run() to replace some boilerplate.
  - Avoid double reference counting.
  - Drop pointless cast.
* xilinx,xadc
  - Make the IRQ optional as not always wired to the host system.

----------------------------------------------------------------
Anand Ashok Dumbre (4):
      device property: Add fwnode_iomap()
      iio: adc: Add Xilinx AMS driver
      dt-bindings: iio: adc: Add Xilinx AMS binding documentation
      MAINTAINERS: Add maintainer for xilinx-ams

Andriy Tryshnivskyy (4):
      iio: core: Introduce IIO_VAL_INT_64.
      iio/scmi: Add reading "raw" attribute.
      iio: test: Add check against NULL for buffer in tests.
      iio: test: Add test for IIO_VAL_INT_64.

André Gustavo Nakagomi Lopez (1):
      iio: adc: lpc18xx_adc: Reorder clk_get_rate() function call

Andy Shevchenko (1):
      iio: buffer: Use dedicated variable in iio_buffers_alloc_sysfs_and_mask()

Antoniu Miclaus (7):
      iio: expose shared parameter in IIO_ENUM_AVAILABLE
      iio:dac:ad7293: add support for AD7293
      dt-bindings:iio:dac: add ad7293 doc
      iio: add filter subfolder
      iio:filter:admv8818: add support for ADMV8818
      dt-bindings:iio:filter: add admv8818 doc
      iio:filter:admv8818: Add sysfs ABI documentation

Cai Huoqing (3):
      iio: adc: ina2xx: Make use of the helper macro kthread_run()
      iio: adc: ina2xx: Avoid double reference counting from get_task_struct/put_task_struct()
      MAINTAINERS: Update i.MX 8QXP ADC info

Cosmin Tanislav (3):
      iio: add addac subdirectory
      dt-bindings: iio: add AD74413R
      iio: addac: add AD74413R driver

Dan Carpenter (1):
      iio: addac: ad74413r: fix off by one in ad74413r_parse_channel_config()

Evgeny Boger (2):
      iio:adc:axp20x: add support for NTC thermistor
      dt-bindings: iio: adc: document TS voltage in AXP PMICs

Gwendal Grignou (12):
      iio: bma220: Use scan_type when processing raw data
      iio: kxcjk-1013: Use scan_type when processing raw data
      iio: mma7455: Use scan_type when processing raw data
      iio: sca3000: Use scan_type when processing raw data
      iio: stk8312: Use scan_type when processing raw data
      iio: stk8ba50: Use scan_type when processing raw data
      iio: ad7266: Use scan_type when processing raw data
      iio: ti-adc12138: Use scan_type when processing raw data
      iio: mag3110: Use scan_type when processing raw data
      iio: ti-ads1015: Remove shift variable ads1015_read_raw
      iio: xilinx-xadc-core: Use local variable in xadc_read_raw
      iio: mpl3115: Use scan_type.shift and realbit in mpl3115_read_raw

Jonathan Cameron (28):
      iio: trigger: Fix a scheduling whilst atomic issue seen on tsc2046
      iio:dac:ad5755: Switch to generic firmware properties and drop pdata
      iio:dac:ad5758: Drop unused of specific headers.
      iio:dac:dpot-dac: Swap of.h for mod_devicetable.h
      iio:dac:lpc18xx_dac: Swap from of* to mod_devicetable.h
      iio:pot:mcp41010: Switch to generic firmware properties.
      iio:light:cm3605: Switch to generic firmware properties.
      iio:adc:max9611: Switch to generic firmware properties.
      iio:adc:mcp3911: Switch to generic firmware properties.
      iio:adc:ti-adc12138: Switch to generic firmware properties and drop of_match_ptr
      iio:adc:envelope-detector: Switch from of headers to mod_devicetable.h
      iio:adc:ti-ads124s08: Drop dependency on OF.
      iio:adc/dac:Kconfig: Update to drop OF dependencies.
      dt-bindings: iio: dac: adi,ad5755: drop unrelated included.
      iio:accel:bma180: Suppress clang W=1 warning about pointer to enum conversion.
      iio:adc:ina2xx-adc: Suppress clang W=1 warning about pointer to enum conversion.
      iio:adc:rcar: Suppress clang W=1 warning about pointer to enum conversion.
      iio:adc:ti-ads1015: Suppress clang W=1 warning about pointer to enum conversion.
      iio:amplifiers:hmc425a: Suppress clang W=1 warning about pointer to enum conversion.
      iio:dac:mcp4725: Suppress clang W=1 warning about pointer to enum conversion.
      iio:imu:inv_icm42600: Suppress clang W=1 warning about pointer to enum conversion.
      iio:imu:inv_mpu6050: Suppress clang W=1 warning about pointer to enum conversion.
      iio:magn:ak8975: Suppress clang W=1 warning about pointer to enum conversion.
      iio:dummy: Drop set but unused variable len.
      iio:accel:bmc150: Mark structure __maybe_unused as only needed with for pm ops.
      iio:accel:kxcjk-1013: Mark struct __maybe_unused to avoid warning.
      iio:addac:ad74413r: Fix uninitialized ret in a path that won't be hit.
      iio: adc: ti-adc081c: Partial revert of removal of ACPI IDs

Kees Cook (1):
      iio: stmpe-adc: Use correctly sized arguments for bit field

Lars-Peter Clausen (21):
      iio: xilinx-xadc: Make IRQ optional
      iio: st-sensors: Use dev_to_iio_dev() in sysfs callbacks
      iio: imx7d_adc: Don't pass IIO device to imx7d_adc_{enable,disable}()
      iio: ms5611: Simplify IO callback parameters
      iio: Mark iio_device_type as const
      iio: interrupt-trigger: Remove no-op trigger ops
      iio: sysfs-trigger: Remove no-op trigger ops
      iio: ad_sigma_delta: Remove no-op trigger ops
      iio: afe4403: Remove no-op trigger ops
      iio: afe4404: Remove no-op trigger ops
      iio: as3935: Remove no-op trigger ops
      iio: atlas-sensor: Remove no-op trigger ops
      iio: gp2ap020a00f: Remove no-op trigger ops
      iio: lmp91000: Remove no-op trigger ops
      iio: mma8452: Use correct type for return variable in IRQ handler
      iio: at91-sama5d2: Fix incorrect cast to platform_device
      iio: at91-sama5d2: Use dev_to_iio_dev() in sysfs callbacks
      iio: iio_device_alloc(): Remove unnecessary self drvdata
      iio: as3935: Remove unnecessary cast
      iio: in2xx-adc: Remove unnecessary cast
      iio: vz89x: Remove unnecessary cast

Lorenzo Bianconi (2):
      iio: imu: st_lsm6dsx: add dts property to disable sensor-hub
      Documentation: dt: iio: st_lsm6dsx: add disable-sensor-hub property

Maslov Dmitry (1):
      iio: light: ltr501: Added ltr303 driver support

Mihail Chindris (2):
      dt-bindings: iio: dac: Add adi,ad3552r.yaml
      drivers:iio:dac: Add AD3552R driver support

Minghao Chi (1):
      iio:adc:ti-ads8688:: remove redundant ret variable

Nikita Travkin (2):
      dt-bindings: iio: light: ltr501: Add proximity-near-level
      iio: ltr501: Export near level property for proximity sensor

Paul Cercueil (2):
      iio: buffer-dma: Remove unused iio_buffer_block struct
      iio: buffer-dma: Use round_down() instead of rounddown()

Uwe Kleine-König (1):
      iio: accel: mma7660: Warn about failure to put device in stand-by in .remove()

Wan Jiabing (1):
      iio: adc: stm32-adc: Fix of_node_put() issue in stm32-adc

Xiang wangx (1):
      iio: adc: ad7606: Fix syntax errors in comments

Xu Wang (1):
      iio: adc: rzg2l_adc: Remove unnecessary print function dev_err()

Zach DeCook (1):
      iio: event_monitor: Flush output on event

 .../ABI/testing/sysfs-bus-iio-filter-admv8818      |   16 +
 .../bindings/iio/adc/x-powers,axp209-adc.yaml      |    3 +
 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml          |  227 +++
 .../bindings/iio/addac/adi,ad74413r.yaml           |  158 +++
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |  217 +++
 .../devicetree/bindings/iio/dac/adi,ad5755.yaml    |    1 -
 .../devicetree/bindings/iio/dac/adi,ad7293.yaml    |   61 +
 .../bindings/iio/filter/adi,admv8818.yaml          |   66 +
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    7 +
 .../bindings/iio/light/liteon,ltr501.yaml          |    7 +
 MAINTAINERS                                        |   20 +-
 drivers/base/property.c                            |   16 +
 drivers/iio/Kconfig                                |    2 +
 drivers/iio/Makefile                               |    2 +
 drivers/iio/accel/bma180.c                         |    4 +-
 drivers/iio/accel/bma220_spi.c                     |    6 +-
 drivers/iio/accel/bmc150-accel-core.c              |    2 +-
 drivers/iio/accel/kxcjk-1013.c                     |    5 +-
 drivers/iio/accel/mma7455_core.c                   |    3 +-
 drivers/iio/accel/mma7660.c                        |    8 +-
 drivers/iio/accel/mma8452.c                        |    2 +-
 drivers/iio/accel/mma9553.c                        |    2 +-
 drivers/iio/accel/sca3000.c                        |   17 +-
 drivers/iio/accel/stk8312.c                        |    2 +-
 drivers/iio/accel/stk8ba50.c                       |    3 +-
 drivers/iio/adc/Kconfig                            |   21 +-
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7192.c                           |    3 +-
 drivers/iio/adc/ad7266.c                           |    3 +-
 drivers/iio/adc/ad7606.h                           |    2 +-
 drivers/iio/adc/ad_sigma_delta.c                   |    4 -
 drivers/iio/adc/at91-sama5d2_adc.c                 |   38 +-
 drivers/iio/adc/axp20x_adc.c                       |   45 +-
 drivers/iio/adc/envelope-detector.c                |    3 +-
 drivers/iio/adc/hi8435.c                           |    2 +-
 drivers/iio/adc/imx7d_adc.c                        |    5 +-
 drivers/iio/adc/ina2xx-adc.c                       |   15 +-
 drivers/iio/adc/lpc18xx_adc.c                      |    6 +-
 drivers/iio/adc/max9611.c                          |   20 +-
 drivers/iio/adc/mcp3911.c                          |    9 +-
 drivers/iio/adc/rcar-gyroadc.c                     |    3 +-
 drivers/iio/adc/rzg2l_adc.c                        |    4 +-
 drivers/iio/adc/stm32-adc.c                        |    3 +-
 drivers/iio/adc/stmpe-adc.c                        |    5 +-
 drivers/iio/adc/ti-adc081c.c                       |   22 +-
 drivers/iio/adc/ti-adc12138.c                      |   14 +-
 drivers/iio/adc/ti-ads1015.c                       |   10 +-
 drivers/iio/adc/ti-ads124s08.c                     |    3 +-
 drivers/iio/adc/ti-ads8688.c                       |    4 +-
 drivers/iio/adc/xilinx-ams.c                       | 1451 +++++++++++++++++++
 drivers/iio/adc/xilinx-xadc-core.c                 |   64 +-
 drivers/iio/addac/Kconfig                          |   20 +
 drivers/iio/addac/Makefile                         |    7 +
 drivers/iio/addac/ad74413r.c                       | 1475 ++++++++++++++++++++
 drivers/iio/amplifiers/hmc425a.c                   |    2 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |    2 +-
 drivers/iio/chemical/atlas-sensor.c                |    4 -
 drivers/iio/chemical/vz89x.c                       |    2 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c         |   57 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |    4 +-
 drivers/iio/dac/Kconfig                            |   22 +-
 drivers/iio/dac/Makefile                           |    2 +
 drivers/iio/dac/ad3552r.c                          | 1138 +++++++++++++++
 drivers/iio/dac/ad5064.c                           |    4 +-
 drivers/iio/dac/ad5380.c                           |    2 +-
 drivers/iio/dac/ad5446.c                           |    2 +-
 drivers/iio/dac/ad5504.c                           |    2 +-
 drivers/iio/dac/ad5624r_spi.c                      |    2 +-
 drivers/iio/dac/ad5686.c                           |    2 +-
 drivers/iio/dac/ad5755.c                           |  152 +-
 drivers/iio/dac/ad5758.c                           |    3 +-
 drivers/iio/dac/ad5766.c                           |   13 +-
 drivers/iio/dac/ad5791.c                           |    2 +-
 drivers/iio/dac/ad7293.c                           |  934 +++++++++++++
 drivers/iio/dac/dpot-dac.c                         |    2 +-
 drivers/iio/dac/lpc18xx_dac.c                      |    3 +-
 drivers/iio/dac/max5821.c                          |    2 +-
 drivers/iio/dac/mcp4725.c                          |   10 +-
 drivers/iio/dac/stm32-dac.c                        |    2 +-
 drivers/iio/dac/ti-dac082s085.c                    |    2 +-
 drivers/iio/dac/ti-dac5571.c                       |    2 +-
 drivers/iio/dac/ti-dac7311.c                       |    2 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c        |    2 -
 drivers/iio/filter/Kconfig                         |   18 +
 drivers/iio/filter/Makefile                        |    7 +
 drivers/iio/filter/admv8818.c                      |  665 +++++++++
 drivers/iio/health/afe4403.c                       |    5 -
 drivers/iio/health/afe4404.c                       |    5 -
 drivers/iio/iio_core.h                             |    2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |    2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |    2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |    4 +-
 drivers/iio/industrialio-buffer.c                  |   20 +-
 drivers/iio/industrialio-core.c                    |    6 +-
 drivers/iio/industrialio-trigger.c                 |   36 +-
 drivers/iio/light/cm3605.c                         |    6 +-
 drivers/iio/light/gp2ap020a00f.c                   |    5 -
 drivers/iio/light/ltr501.c                         |   42 +-
 drivers/iio/magnetometer/ak8975.c                  |    2 +-
 drivers/iio/magnetometer/hmc5843_core.c            |    4 +-
 drivers/iio/magnetometer/mag3110.c                 |    6 +-
 drivers/iio/potentiometer/mcp41010.c               |    6 +-
 drivers/iio/potentiostat/lmp91000.c                |    4 -
 drivers/iio/pressure/mpl3115.c                     |   16 +-
 drivers/iio/pressure/ms5611.h                      |    6 +-
 drivers/iio/pressure/ms5611_core.c                 |    7 +-
 drivers/iio/pressure/ms5611_i2c.c                  |   11 +-
 drivers/iio/pressure/ms5611_spi.c                  |   17 +-
 drivers/iio/proximity/as3935.c                     |    6 +-
 drivers/iio/test/iio-test-format.c                 |  123 +-
 drivers/iio/trigger/iio-trig-interrupt.c           |    4 -
 drivers/iio/trigger/iio-trig-sysfs.c               |    4 -
 drivers/iio/trigger/stm32-timer-trigger.c          |    4 +-
 include/dt-bindings/iio/addac/adi,ad74413r.h       |   21 +
 include/linux/iio/buffer-dma.h                     |    5 -
 include/linux/iio/iio.h                            |    5 +-
 include/linux/iio/trigger.h                        |    2 +
 include/linux/iio/types.h                          |    1 +
 include/linux/platform_data/ad5755.h               |  102 --
 include/linux/property.h                           |    2 +
 tools/iio/iio_event_monitor.c                      |    1 +
 123 files changed, 7226 insertions(+), 459 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
 create mode 100644 drivers/iio/adc/xilinx-ams.c
 create mode 100644 drivers/iio/addac/Kconfig
 create mode 100644 drivers/iio/addac/Makefile
 create mode 100644 drivers/iio/addac/ad74413r.c
 create mode 100644 drivers/iio/dac/ad3552r.c
 create mode 100644 drivers/iio/dac/ad7293.c
 create mode 100644 drivers/iio/filter/Kconfig
 create mode 100644 drivers/iio/filter/Makefile
 create mode 100644 drivers/iio/filter/admv8818.c
 create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h
 delete mode 100644 include/linux/platform_data/ad5755.h
