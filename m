Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E96377656
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhEILhw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhEILhw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:37:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1436D6128C;
        Sun,  9 May 2021 11:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560209;
        bh=j/a2wAjca7dxbhO5oHDV7SJyIaJeWkntnWO5c+zq6ME=;
        h=From:To:Cc:Subject:Date:From;
        b=b2ba7bQvIMdXJLmLRbAAwGVBLk5O9pWAjVPMkKKrwuZSRc4Rz1TTDcRMiIClg/LFS
         PogQOl78bDkmiM610xA93grKLzKnTaWwgM8KlnCRnVfQwoK8Q4r+baKojQ/drJkWub
         KChCQNKGoQnEiE1+X4RXh6qG6u4euLbVrwD6L/ePraoFDJ7IrdhOQ7XW2CpuKYpHmT
         i7TUe4MOoUObrISQR+0LRc5qTHcx7txxNHLov/jutef5D4yw2NScRKeldcnmuCck34
         ZzIok0HjSvDsGOPVsKzaqlrBkDZvy8exF6wkiE6VlreicDklpP81Ueqx62lEbGpegU
         uZKLGfix1YPsQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Brian Masney <masneyb@onstation.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        jic23@kernel.org
Subject: [RESEND PATCH 00/28] IIO: Runtime PM related cleanups.
Date:   Sun,  9 May 2021 12:33:26 +0100
Message-Id: <20210509113354.660190-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Resend because I managed to misstype kernel.org in the first set of
email addresses. Sorry all who hence get this twice.

Two basic types of tidying up in here.
1) Cases where pm_runtime_put_noidle() is called in remove() path
   but not matched with any form of get
2) Using pm_runtime_resume_and_get() to either replace existing error
   handling or to introduce it where errors were previously ignored.

Note the unbalanced put is not a bug as such, because the runtime pm core
protects against the reference count going negative.  However, it is
a bad pattern to have copied into new drivers (as it confuses me)
so I'd like to clear it out.

Inspired by Mauro's work on similar issues in media and Julia's
coccicheck script.

There will be at least one more set of these once this first set
have flushed out any mistakes I may have made.

I checked my assumptions around the excess pm_runtime_put_noidle
calls in QEMU but may well be missing something even so.

Cc: Andreas Klinger <ak@it-klinger.de>
Cc: Brian Masney <masneyb@onstation.org>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: Parthiban Nallathambi <pn@denx.de>
Cc: Rui Miguel Silva <rui.silva@linaro.org>
Cc: Sean Nyekjaer <sean@geanix.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org

Jonathan Cameron (28):
  iio: gyro: fxa210002c: Balance runtime pm + use
    pm_runtime_resume_and_get().
  iio: light: isl29028: Balance runtime pm + use
    pm_runtime_resume_and_get()
  iio: light: tsl2583: Balance runtime pm + use
    pm_runtime_resume_and_get()
  iio: accel: bmc150-accel: Balanced runtime pm + use
    pm_runtime_resume_and_get()
  iio: accel: mma8452: Balance runtime pm + use
    pm_runtime_resume_and_get()
  iio: accel: mma9551/3: Balance untime pm + use
    pm_runtime_resume_and_get()
  iio: accel: kxcjk-1013: Balance runtime pm + use
    pm_runtime_resume_and_get()
  iio: hid: trigger: Balance runtime pm + use
    pm_runtime_resume_and_get()
  iio: imu: kmx61: Balance runtime pm + use pm_runtime_resume_and_get()
  iio: light: rpr0521: Balance runtime pm + use
    pm_runtime_resume_and_get()
  iio: magn: bmc150: Balance runtime pm + use
    pm_runtime_resume_and_get()
  iio: accel: bmi088: Balance runtime pm + use
    pm_runtime_resume_and_get()
  iio: imu: mpu6050: Use pm_runtime_resume_and_get() to replace open
    coding.
  iio: adc: stm32-adc: Use pm_runtime_resume_and_get() to replace open
    coding.
  iio: adc: stm32-dfsdm: Use pm_runtime_resume_and_get() to replace open
    coding.
  iio: dac: stm32-dac: Use pm_runtime_resume_and_get() to replace open
    coding.
  iio: adc: ads1015: Use pm_runtime_resume_and_get() to replace open
    coding.
  iio: chemical: atlas-sensor: Use pm_runtime_resume_and_get() to
    replace open coding.
  iio: light: pa12203001: Use pm_runtime_resume_and_get() to replace
    open coding.
  iio: light: us5182: Use pm_runtime_resume_and_get() to replace open
    coding.
  iio: light: vcnl4000: Use pm_runtime_resume_and_get() to replace open
    coding.
  iio: light: vcnl4035: Use pm_runtime_resume_and_get() to replace open
    coding.
  iio: pressure: zpa2326: fix potential extra call of runtime suspend.
  iio: temp: mlx90614: Handle failure in pm_runtime_resume_and_get()
  iio: proximity: srf04: Use pm_runtime_resume_and_get() and handle
    error
  iio: prox: pulsed-light-v2: Switch pm_runtime_resume_and_get()
  iio: pressure: icp10100: Use pm_runtime_resume_and_get() + handle
    errors
  iio: adc: rcar-gyroadc: Use pm_runtime_resume_and_get() and check in
    probe()

 drivers/iio/accel/bmc150-accel-core.c         |  6 +----
 drivers/iio/accel/bmi088-accel-core.c         | 26 ++++++++++++++-----
 drivers/iio/accel/kxcjk-1013.c                |  5 +---
 drivers/iio/accel/mma8452.c                   |  5 +---
 drivers/iio/accel/mma9551.c                   |  1 -
 drivers/iio/accel/mma9551_core.c              |  4 +--
 drivers/iio/accel/mma9553.c                   |  1 -
 drivers/iio/adc/rcar-gyroadc.c                | 15 +++++------
 drivers/iio/adc/stm32-adc.c                   | 24 ++++++-----------
 drivers/iio/adc/stm32-dfsdm-core.c            |  6 ++---
 drivers/iio/adc/ti-ads1015.c                  |  4 +--
 drivers/iio/chemical/atlas-sensor.c           | 12 +++------
 .../common/hid-sensors/hid-sensor-trigger.c   |  8 ++----
 drivers/iio/dac/stm32-dac.c                   |  3 +--
 drivers/iio/gyro/fxas21002c_core.c            | 11 +-------
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 18 +++++--------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  6 ++---
 drivers/iio/imu/kmx61.c                       |  5 +---
 drivers/iio/light/isl29028.c                  |  5 +---
 drivers/iio/light/pa12203001.c                |  4 +--
 drivers/iio/light/rpr0521.c                   |  7 +----
 drivers/iio/light/tsl2583.c                   | 13 +++++-----
 drivers/iio/light/us5182d.c                   |  4 +--
 drivers/iio/light/vcnl4000.c                  |  4 +--
 drivers/iio/light/vcnl4035.c                  |  4 +--
 drivers/iio/magnetometer/bmc150_magn.c        | 10 +++----
 drivers/iio/pressure/icp10100.c               |  4 ++-
 drivers/iio/pressure/zpa2326.c                |  6 ++---
 .../iio/proximity/pulsedlight-lidar-lite-v2.c |  4 ++-
 drivers/iio/proximity/srf04.c                 |  8 +++---
 drivers/iio/temperature/mlx90614.c            | 25 ++++++++++++++----
 31 files changed, 109 insertions(+), 149 deletions(-)

-- 
2.31.1

