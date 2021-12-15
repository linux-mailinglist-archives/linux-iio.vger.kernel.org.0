Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A93F475B92
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 16:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243798AbhLOPNr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 10:13:47 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:43551 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhLOPNq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 10:13:46 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 9CD0E200010;
        Wed, 15 Dec 2021 15:13:44 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 00/10] Light core IIO enhancements
Date:   Wed, 15 Dec 2021 16:13:34 +0100
Message-Id: <20211215151344.163036-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

As part of a previous discussion with Jonathan (I know, it was three
months ago, sorry for the delay :-$), it appeared necessary to do a
little bit of cleanup in the IIO core and at least provide a little bit
more documentation for developers diving into the IIO subsystem for the
first time. My first move was to write a blog post trying to explain
(from my point of view but with the review of Jonathan) what is
necessary to understand when writing and IIO kernel driver:
https://bootlin.com/blog/the-backbone-of-a-linux-industrial-i-o-driver/

Here is now the second halve of this work, with few things that I tried
to address.

* The currentmode indio_dev entry was misused by several device drivers,
  I tried to understand which ones were wrong (there are two still
  accessing this variable left, I decided not to touch them because I
  think it is legitimate) and I tried to find an alternative.

* Then, I tried to make new accesses to this variable harder in order to
  avoid future mistakes, by creating a couple of helpers and moving it
  to the opaque structure.

* I continued with the IIO modes which are completely
  undocumented. Following a few exchanges with Jonathan, I tried to take
  most of this discussion and put it into a kernel doc header.

* When doing the above task, I realized that there was a particular case
  handled for kfifo buffers which I tried to simplify, but if this is a
  mistake, I'll just drop the patch.

Hope this will help!

Cheers,
Miquèl

Miquel Raynal (10):
  iio: core: Fix the kernel doc regarding the currentmode iio_dev entry
  iio: core: Enhance the kernel doc of modes and currentmodes iio_dev
    entries
  iio: magnetometer: rm3100: Stop abusing the ->currentmode
  iio: adc: stm32-dfsdm: Avoid dereferencing ->currentmode
  iio: st_sensors: Use iio_device_claim/release_direct_mode() when
    relevant
  iio: core: Hide read accesses to iio_dev->currentmode
  iio: core: Hide write accesses to iio_dev->currentmode
  iio: core: Move iio_dev->currentmode to the opaque structure
  iio: core: Simplify the registration of kfifo buffers
  iio: core: Clarify the modes

 drivers/iio/accel/bmc150-accel-core.c         |  4 +-
 drivers/iio/accel/fxls8962af-core.c           |  1 -
 drivers/iio/accel/sca3000.c                   |  1 -
 drivers/iio/accel/ssp_accel_sensor.c          |  1 -
 drivers/iio/adc/at91-sama5d2_adc.c            |  4 +-
 drivers/iio/adc/ina2xx-adc.c                  |  1 -
 drivers/iio/adc/stm32-dfsdm-adc.c             |  5 +-
 drivers/iio/adc/ti_am335x_adc.c               |  4 +-
 drivers/iio/buffer/kfifo_buf.c                | 12 +---
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  3 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c    |  1 -
 .../iio/common/st_sensors/st_sensors_core.c   | 28 +++++----
 drivers/iio/gyro/ssp_gyro_sensor.c            |  1 -
 drivers/iio/health/max30100.c                 |  1 -
 drivers/iio/health/max30102.c                 |  1 -
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c |  1 -
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  |  1 -
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  1 -
 drivers/iio/industrialio-buffer.c             | 12 ++--
 drivers/iio/industrialio-core.c               | 13 +++++
 drivers/iio/industrialio-trigger.c            |  2 +-
 drivers/iio/light/apds9960.c                  |  1 -
 drivers/iio/magnetometer/rm3100-core.c        | 15 +----
 .../staging/iio/impedance-analyzer/ad5933.c   |  1 -
 include/linux/iio/iio-opaque.h                | 16 ++++++
 include/linux/iio/iio.h                       | 57 ++++++++++++++++---
 include/linux/iio/kfifo_buf.h                 |  5 +-
 27 files changed, 114 insertions(+), 79 deletions(-)

-- 
2.27.0

