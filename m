Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BBD4379B0
	for <lists+linux-iio@lfdr.de>; Fri, 22 Oct 2021 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhJVPSe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 22 Oct 2021 11:18:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4022 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhJVPSd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Oct 2021 11:18:33 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HbSXL5YRdz67bb0;
        Fri, 22 Oct 2021 23:13:06 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Fri, 22 Oct 2021 17:16:13 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 16:16:13 +0100
Date:   Fri, 22 Oct 2021 16:16:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>
Subject: [PULL] 2nd set of IIO new device support, features, cleanup for
 5.16
Message-ID: <20211022161612.000026f6@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 8135cc5b270b3f224615bdee8bd7d66afee87991:

  MAINTAINERS: Update the entry for MHI bus (2021-10-19 15:49:14 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.16b

for you to fetch changes up to 77af145dc7eadcb78d38912b67d6a68050d21a9b:

  dt-bindings: iio: frequency: add adrf6780 doc (2021-10-21 21:00:59 +0100)

----------------------------------------------------------------
2nd set of IIO new driver, cleanups and features for the 5.16 cycle

New device support
* adrf6780 microwave upconverter.
  - New driver for this interesting device including bindings.

Features
* lite-on ltr501
  - Add dt-bindings including vendor ID and of_device_id table.
  - Add regulator support.
* sensiron,scd4x
  - Add reporting of channel scale.

Cleanups including fixes for things in this cycle
* Tree wide: Another set of dev_err_probe() introductions to reduce
  noise in logs when deferred probing is needed and provide more debug
  info. Devices included this time:
  - amlogic,meson_saradc
  - capella,cm3605
  - fsl,imx7d
  - maxim,max1118
  - maxim,max1241
  - nxp,lpc18xx
  - qcom,pm8xxxx-xoadc
  - rockchip,saradc
  - sharp,gp2ap002
  - sterricson,ab8500
  - ti,ads7950
* core - iio:buffer
  - Fix a path where a ret value is not intialized.
* channel-mux
  - Add support to mux core subsystem for a settling delay and use
    it in the iio-channel-mux driver.
  - Fix a few dt binding warnings.
* nxp,lpc18xx
  - Convert to devm_ functions for all of probe and drop remove()
* st,lsm6dsx
  - Suppress a warning due to lack of handling of an enum *_MAX entry
    that is just there to get the size.
* st,stm32-adc
  - Add generic channel binding, deprecating the old approach.
  - Add nvmem support to get calibration data for the vrefint channel and
    use it to perform such calibration.
  - Add a binding for sample-time to the generic channel description as it
    can be per channel.
* ti,adc128s052
  - Use devm_ managed functions and drop remove()
* vti,sca3000
  - Use sign_extend32() rather than opencoding.
* xilinx,xadc
  - Drop irq field from state structure as now just used in probe.

----------------------------------------------------------------
André Gustavo Nakagomi Lopez (1):
      iio: adc: lpc18xx_adc: Convert probe to device managed version

Antoniu Miclaus (2):
      iio: frequency: adrf6780: add support for ADRF6780
      dt-bindings: iio: frequency: add adrf6780 doc

Cai Huoqing (11):
      iio: adc: ab8500-gpadc: Make use of the helper function dev_err_probe()
      iio: adc: imx7d_adc: Make use of the helper function dev_err_probe()
      iio: adc: lpc18xx_adc: Make use of the helper function dev_err_probe()
      iio: adc: max1118: Make use of the helper function dev_err_probe()
      iio: adc: max1241: Make use of the helper function dev_err_probe()
      iio: adc: meson_saradc: Make use of the helper function dev_err_probe()
      iio: adc: qcom-pm8xxx-xoadc: Make use of the helper function dev_err_probe()
      iio: adc: rockchip_saradc: Make use of the helper function dev_err_probe()
      iio: adc: ti-ads7950: Make use of the helper function dev_err_probe()
      iio: light: cm3605: Make use of the helper function dev_err_probe()
      iio: light: gp2ap002: Make use of the helper function dev_err_probe()

Christophe JAILLET (1):
      iio: adc: adc128s052: Simplify adc128_probe()

Colin Ian King (1):
      iio: buffer: Fix uninitialized variable ret

Jonathan Cameron (1):
      iio: accel: sca3000: Use sign_extend32() instead of opencoding sign extension.

Lars-Peter Clausen (1):
      iio: xilinx-xadc: Remove `irq` field from state struct

Nikita Travkin (4):
      dt-bindings: vendor-prefixes: Document liteon vendor prefix
      dt-bindings: iio: light: Document ltr501 light sensor bindings
      iio: light: ltr501: Add rudimentary regulator support
      iio: light: ltr501: Add of_device_id table

Olivier Moysan (7):
      dt-bindings: iio: stm32-adc: add generic channel binding
      dt-bindings: iio: stm32-adc: add nvmem support for vrefint internal channel
      iio: adc: stm32-adc: split channel init into several routines
      iio: adc: stm32-adc: add support of generic channels binding
      iio: adc: stm32-adc: add support of internal channels
      iio: adc: stm32-adc: add vrefint calibration support
      iio: adc: stm32-adc: use generic binding for sample-time

Peter Rosin (2):
      dt-bindings: iio: io-channel-mux: add optional #io-channel-cells
      dt-bindings: iio: io-channel-mux: allow duplicate channel, labels

Roan van Dijk (1):
      iio: chemical: scd4x: Add a scale for the co2 concentration reading

Teng Qi (1):
      iio: imu: st_lsm6dsx: Avoid potential array overflow in st_lsm6dsx_set_odr()

Vincent Whitchurch (3):
      mux: add support for delay after muxing
      dt-bindings: iio: io-channel-mux: Add property for settle time
      iio: multiplexer: iio-mux: Support settle-time-us property

 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 108 ++++-
 .../bindings/iio/frequency/adi,adrf6780.yaml       | 131 +++++
 .../bindings/iio/light/liteon,ltr501.yaml          |  51 ++
 .../bindings/iio/multiplexer/io-channel-mux.yaml   |  13 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/iio/accel/sca3000.c                        |   3 +-
 drivers/iio/adc/ab8500-gpadc.c                     |  22 +-
 drivers/iio/adc/imx7d_adc.c                        |  18 +-
 drivers/iio/adc/lpc18xx_adc.c                      |  75 ++-
 drivers/iio/adc/max1118.c                          |   7 +-
 drivers/iio/adc/max1241.c                          |  17 +-
 drivers/iio/adc/meson_saradc.c                     |  39 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |   9 +-
 drivers/iio/adc/rockchip_saradc.c                  |  27 +-
 drivers/iio/adc/stm32-adc-core.c                   |   1 +
 drivers/iio/adc/stm32-adc-core.h                   |  10 +
 drivers/iio/adc/stm32-adc.c                        | 422 +++++++++++++++--
 drivers/iio/adc/ti-adc128s052.c                    |  33 +-
 drivers/iio/adc/ti-ads7950.c                       |   4 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |   5 +-
 drivers/iio/adc/xilinx-xadc.h                      |   1 -
 drivers/iio/chemical/scd4x.c                       |   9 +-
 drivers/iio/frequency/Kconfig                      |  12 +
 drivers/iio/frequency/Makefile                     |   1 +
 drivers/iio/frequency/adrf6780.c                   | 527 +++++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   6 +-
 drivers/iio/industrialio-buffer.c                  |   2 +-
 drivers/iio/light/cm3605.c                         |  29 +-
 drivers/iio/light/gp2ap002.c                       |  24 +-
 drivers/iio/light/ltr501.c                         |  37 ++
 drivers/iio/multiplexer/iio-mux.c                  |   7 +-
 drivers/mux/core.c                                 |  38 +-
 include/linux/mux/consumer.h                       |  23 +-
 include/linux/mux/driver.h                         |   4 +
 34 files changed, 1467 insertions(+), 250 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
 create mode 100644 drivers/iio/frequency/adrf6780.c
