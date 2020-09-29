Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6535A27D416
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 19:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgI2RCo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 13:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbgI2RCo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Sep 2020 13:02:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0233208FE;
        Tue, 29 Sep 2020 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601398963;
        bh=tMFhIRgF8WwdKFjDpsj+z1uk+eHos9b79R8pOvDMG28=;
        h=Date:From:To:Subject:From;
        b=d09UbMaGScLEOEi0IQTg90X3AFvZqkTEXQt/bOlCAgB+b9s9sERemQV8sZBk5G6Wa
         CKdtDGvN2DBLR7JUiY/TZkG51X2CqpleE3UqIVkB5W3EqvvNMOkVyEX16YnT+yrm86
         hef+4oweq9K4SJ7wkRn8UPyA8GQf30ZX/0S6S99I=
Date:   Tue, 29 Sep 2020 18:02:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] Third set of new device support, cleanups etc for IIO in the
 5.10 cycle.
Message-ID: <20200929180239.42ccd9bb@archlinux>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 69fea2b4e59c52844cf5196c9c81157792d194fb:

  staging: r8188eu: replace WIFI_REASON_CODE enum with native ieee80211_rea=
soncode (2020-09-22 09:51:28 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-5.10c

for you to fetch changes up to da4410d4078ba4ead9d6f1027d6db77c5a74ecee:

  iio: adc: gyroadc: fix leak of device node iterator (2020-09-29 17:50:51 =
+0100)

----------------------------------------------------------------
3rd set of new device support features and cleanup for IIO in the 5.10 cycl=
e.

A late set given it seems the 5.10 cycle is going to start a bit later
than expected and quite a bit came in.  Includes some late breaking
fixes that can wait for the merge window.

New device support
* ad9467
  - ad9434 support including dt bindings update
  - ad9265 support including dt bindings update

Yaml conversion
* amlogic,meson-saradc

Core rework (heading towards multiple buffer support)
* refactor iio_device_register_eventset
* Null-ify IIO device's event_interface during unregister.

Features
* ad7291
  - convert from platform_data to devicetree including bindings doc.
* core
  - Add titles to a few IIO config symbols to allow simpler out of tree
    building.  It does little harm so why not enable it.

Fixes
* ad7292
  - Fix missing of_node_put()
* at91-sama5d2
  - Fix a crash due to missordering of dma enabling as a result of recent
    IIO wide rework.
* gyro-adc
  - Fix missing of_node_put()
* ltc2983
  - Fix missing of_node_put()
* stm32-adc
  - Fix an issue with runtime autosuspend related to parent autosuspending.

Cleanups
* counter/ti-eqep
  - Tidy up a , instead of ;
* buffer-dmaengine
  - Drop the unmanaged allocator functions as no one is using them.
* at91-sama5d2
  - devm_platform_get_and_ioremap_resouce() replacing boilerplate.
* cros_ec
  - move the hw fifo attributes setup into the cros_ec core.
* gp2ap002
  - comment typo
* microchip-tcb-capture:
  - consitifcation
* ssp
  - Use PLATFORM_DEVID_NONE instead of -1 to convey true meaning.
* stm32-dfsdm
  - devm_platform_get_and_ioremap_resouce() replacing boilerplate.

----------------------------------------------------------------
Alexandru Ardelean (9):
      iio: event: use short-hand variable in iio_device_{un}register_events=
et functions
      iio: event: NULL-ify IIO device's event_interface ref during unregist=
er
      iio: buffer-dmaengine: remove non managed alloc/free
      iio: adc: ad9467: wrap a axi-adc chip-info into a ad9467_chip_info ty=
pe
      dt-bindings: iio: ad9467: add entries for for AD9434 & AD9265 ADCs
      iio: cros_ec: unify hw fifo attributes into the core file
      iio: dma-buffer: Kconfig: Provide titles for IIO DMA Kconfig symbols
      iio: Kconfig: Provide title for IIO_TRIGGERED_EVENT symbol
      iio: buffer: Kconfig: add title for IIO_TRIGGERED_BUFFER symbol

Eugen Hristev (1):
      iio: adc: at91-sama5d2_adc: fix DMA conversion crash

Fabrice Gasnier (1):
      iio: adc: stm32-adc: fix runtime autosuspend delay when slow polling

Jonathan Cameron (1):
      dt-bindings:iio:adc:amlogic,meson-saradc yaml conversion

Julia Lawall (1):
      counter: use semicolons rather than commas to separate statements

Krzysztof Kozlowski (1):
      iio: ssp: use PLATFORM_DEVID_NONE

Michael Auchter (2):
      iio: adc: ad7291: convert to device tree
      dt-bindings: iio: adc: ad7291: add binding

Michael Hennerich (2):
      iio: adc: ad9467: add support for AD9434 high-speed ADC
      iio: adc: ad9467: add support for AD9265 high-speed ADC

Nuno S=C3=A1 (2):
      iio: ltc2983: Fix of_node refcounting
      iio: ad7292: Fix of_node refcounting

Rikard Falkeborn (1):
      counter: microchip-tcb-capture: Constify mchp_tc_ops

Tobias Jordan (1):
      iio: adc: gyroadc: fix leak of device node iterator

Wang Qing (1):
      iio:light:gp2ap002 fix spelling typo in comments

Wang ShaoBo (2):
      iio: adc: at91-sama5d2_adc: Use devm_platform_get_and_ioremap_resourc=
e()
      iio: adc: stm32-dfsdm: Use devm_platform_get_and_ioremap_resource()

 .../devicetree/bindings/iio/adc/adi,ad7291.yaml    |  46 +++++++
 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |  15 ++-
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |  48 -------
 .../bindings/iio/adc/amlogic,meson-saradc.yaml     | 149 +++++++++++++++++=
++++
 drivers/counter/microchip-tcb-capture.c            |   2 +-
 drivers/counter/ti-eqep.c                          |   2 +-
 drivers/iio/Kconfig                                |   2 +-
 drivers/iio/accel/cros_ec_accel_legacy.c           |   2 +-
 drivers/iio/adc/ad7291.c                           |  35 +++--
 drivers/iio/adc/ad7292.c                           |   4 +-
 drivers/iio/adc/ad9467.c                           | 121 ++++++++++++-----
 drivers/iio/adc/at91-sama5d2_adc.c                 |  26 ++--
 drivers/iio/adc/rcar-gyroadc.c                     |  21 ++-
 drivers/iio/adc/stm32-adc-core.c                   |   9 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |  11 +-
 drivers/iio/buffer/Kconfig                         |  10 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   6 +-
 .../iio/common/cros_ec_sensors/cros_ec_lid_angle.c |   3 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   5 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  11 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c           |   3 +-
 drivers/iio/industrialio-event.c                   |  51 ++++---
 drivers/iio/light/cros_ec_light_prox.c             |   5 +-
 drivers/iio/light/gp2ap002.c                       |   2 +-
 drivers/iio/pressure/cros_ec_baro.c                |   5 +-
 drivers/iio/temperature/ltc2983.c                  |  19 ++-
 include/linux/iio/buffer-dmaengine.h               |   4 -
 include/linux/iio/common/cros_ec_sensors_core.h    |   4 +-
 include/linux/platform_data/ad7291.h               |  13 --
 29 files changed, 431 insertions(+), 203 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7291.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson=
-saradc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson=
-saradc.yaml
 delete mode 100644 include/linux/platform_data/ad7291.h
