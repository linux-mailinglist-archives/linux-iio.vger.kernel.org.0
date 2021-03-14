Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996D733A568
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 16:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhCNPV4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 11:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233103AbhCNPVY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 11:21:24 -0400
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2663864EC6;
        Sun, 14 Mar 2021 15:21:24 +0000 (UTC)
Date:   Sun, 14 Mar 2021 15:21:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO and counter fixes for 5.12, set 1
Message-ID: <20210314152120.5bc6503c@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit a1bfb0ccf94dc79223d0db0d50237d3b3898f0b2:

  Merge tag 'iio-fixes-for-5.11a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2021-01-15 08:16:35 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.12a

for you to fetch changes up to 6dbbbe4cfd398704b72b21c1d4a5d3807e909d60:

  iio: gyro: mpu3050: Fix error handling in mpu3050_trigger_handler (2021-03-06 17:15:13 +0000)

----------------------------------------------------------------
First set of IIO and counter fixes for the 5.12 cycle

adi,ad7949
* Fix a wrong bitmask that could lead to an undefined bit being included.
adi,adi-axi-adc
* Add missing Kconfig dependencies
adi,adis16400
* Wrong error code handling in adis16400 that could lead to failed probe.
hid-sensor-humidity, temperature
* Fix alignment and space for timestamp channel.
hid-sensor-prox
* Fix an issue with handling of exponent on the channel scaling.
invensense,mpu3050
* Fix a hole in error handling.
qcom,spi-vadc
* Correct scaling
st,ab8500-adc
* Fix wrong scaling (by factor of 1000)
st,stm32-adc
* Add missing HAS_IOMEM dependency
st,stm32-timer-cnt
* Report count when running off internal clock
* Fix issue with not checking ceiling before trying to write to hardware
* Ensure driver doesn't have stashed state which doesn't match hardware by
  rereading from hardware in a slow path.

----------------------------------------------------------------
Alexandru Ardelean (1):
      iio: adc: adi-axi-adc: add proper Kconfig dependencies

Dan Carpenter (1):
      iio: adis16400: Fix an error code in adis16400_initial_setup()

Dinghao Liu (1):
      iio: gyro: mpu3050: Fix error handling in mpu3050_trigger_handler

Fabrice Gasnier (2):
      counter: stm32-timer-cnt: fix ceiling write max value
      counter: stm32-timer-cnt: fix ceiling miss-alignment with reload register

Jonathan Albrieux (1):
      iio:adc:qcom-spmi-vadc: add default scale to LR_MUX2_BAT_ID channel

Jonathan Cameron (1):
      iio:adc:stm32-adc: Add HAS_IOMEM dependency

Linus Walleij (1):
      iio: adc: ab8500-gpadc: Fix off by 10 to 3

Wilfried Wessner (1):
      iio: adc: ad7949: fix wrong ADC result due to incorrect bit mask

William Breathitt Gray (1):
      counter: stm32-timer-cnt: Report count function when SLAVE_MODE_DISABLED

Ye Xiang (3):
      iio: hid-sensor-prox: Fix scale not correct issue
      iio: hid-sensor-humidity: Fix alignment issue of timestamp channel
      iio: hid-sensor-temperature: Fix issues of timestamp channel

 drivers/counter/stm32-timer-cnt.c                | 55 ++++++++++++++----------
 drivers/iio/adc/Kconfig                          |  3 ++
 drivers/iio/adc/ab8500-gpadc.c                   |  2 +-
 drivers/iio/adc/ad7949.c                         |  2 +-
 drivers/iio/adc/qcom-spmi-vadc.c                 |  2 +-
 drivers/iio/gyro/mpu3050-core.c                  |  2 +
 drivers/iio/humidity/hid-sensor-humidity.c       | 12 +++---
 drivers/iio/imu/adis16400.c                      |  3 +-
 drivers/iio/light/hid-sensor-prox.c              | 13 +++++-
 drivers/iio/temperature/hid-sensor-temperature.c | 14 +++---
 10 files changed, 68 insertions(+), 40 deletions(-)
