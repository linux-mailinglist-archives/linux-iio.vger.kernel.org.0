Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC484A7282
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 15:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiBBOCL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 09:02:11 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:52503 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiBBOCK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 09:02:10 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 95CA9200010;
        Wed,  2 Feb 2022 14:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643810529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XT2yXScjF+TdX6tS7FnGG5ieuHrEO/BJ/KLLpXdWdOw=;
        b=S3grmL3vQ8KKzLVxBqxxfH2CMqrisojfyl2pRMqcLzPvCH6ylDWoj07lLE5pn1tVJD7NST
        Gz51Xuj/W9KcWWzelqv80u6LRuAopUgn3BY0PJcqrmYQu2NRlnIedtuc+QBfap5KZHJEXS
        884zF4ISan28td6Ai4bG12b2MM6hVRfHOP5WsWscdvRh4gQ7nSi/WnM+hzmcC/ofnoqV1S
        wuHapKUcMX8tffombVlLi02YwT9uLWo2C69UA3kqtfkV0e5W9qYnHk6k68dn6q2LSTId+U
        XG0WsfxI7l9gdNpUGVLUVPDSuUglePAogITOqVf+nFmPBGIQha3p6lXdCMYApA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 00/12] Miscellaneous IIO core enhancements
Date:   Wed,  2 Feb 2022 15:01:56 +0100
Message-Id: <20220202140208.391394-1-miquel.raynal@bootlin.com>
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
  avoid future mistakes, by creating a helper to read it from outside the
  core and moving it to the opaque structure.

* I continued with the IIO modes which are completely
  undocumented. Following a few exchanges with Jonathan, I tried to take
  most of this discussion and put it into a kernel doc header.

* When doing the above task, I realized that there was a particular case
  handled for kfifo buffers which I tried to simplify, but if this is a
  mistake, I'll just drop the patch.

Hope this will help!

Cheers,
Miquèl

Changes in v2:
* Added Alexandru Reviewed-by when relevant.
* Indicated that "modes" is a bitmask as suggested.
* Added a mention in the "modes" kdoc about the function that could
  alter its content in the core.
* Added more driver maintainers in Cc.
* Avoided deleting the INDIO_BUFFER_TRIGGERED mode from kfifos.
* Dropped entirely the currentmode setter helper.
* Avoided using the currentmode getter from places where we have access
  to the opaque structure (ie. from the core itself).
* Added a patch to move the iio_buffer_enabled() definition in the core
  as it cannot be inlined anymore.
* Dropped completely the use of the mlock lock form the st-sensor
  drivers by inserting an additional local lock when this was
  needed. Hopefully I didn't fail that, this will need testing.
* Reworded the modes kdoc as advised by Jonathan.

Miquel Raynal (12):
  iio: core: Enhance the kernel doc of modes and currentmodes iio_dev
    entries
  iio: magnetometer: rm3100: Stop abusing the ->currentmode
  iio: adc: stm32-dfsdm: Avoid dereferencing ->currentmode
  iio: st_sensors: Drop the protection on _avail functions
  iio: st_sensors: Add a local lock for protecting odr
  iio: st_sensors: Stop abusing mlock to ensure internal coherency
  iio: st_sensors: Use iio_device_claim/release_direct_mode() when
    relevant
  iio: Un-inline iio_buffer_enabled()
  iio: core: Hide read accesses to iio_dev->currentmode
  iio: core: Move the currentmode entry to the opaque structure
  iio: core: Simplify the registration of kfifo buffers
  iio: core: Clarify the modes

 drivers/iio/accel/bmc150-accel-core.c         |  4 +-
 drivers/iio/accel/fxls8962af-core.c           |  1 -
 drivers/iio/accel/sca3000.c                   |  1 -
 drivers/iio/accel/ssp_accel_sensor.c          |  1 -
 drivers/iio/accel/st_accel_core.c             |  5 +-
 drivers/iio/adc/at91-sama5d2_adc.c            |  4 +-
 drivers/iio/adc/ina2xx-adc.c                  |  1 -
 drivers/iio/adc/stm32-dfsdm-adc.c             |  5 +-
 drivers/iio/adc/ti_am335x_adc.c               |  4 +-
 drivers/iio/buffer/kfifo_buf.c                | 10 +--
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  3 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c    |  1 -
 .../iio/common/st_sensors/st_sensors_core.c   | 60 +++++++++--------
 drivers/iio/gyro/ssp_gyro_sensor.c            |  1 -
 drivers/iio/gyro/st_gyro_core.c               |  5 +-
 drivers/iio/health/max30100.c                 |  1 -
 drivers/iio/health/max30102.c                 |  1 -
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c |  1 -
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  |  1 -
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  1 -
 drivers/iio/industrialio-buffer.c             | 12 ++--
 drivers/iio/industrialio-core.c               | 27 ++++++++
 drivers/iio/industrialio-trigger.c            |  2 +-
 drivers/iio/light/apds9960.c                  |  1 -
 drivers/iio/magnetometer/rm3100-core.c        | 15 +----
 drivers/iio/magnetometer/st_magn_core.c       |  5 +-
 drivers/iio/pressure/st_pressure_core.c       |  8 +--
 .../staging/iio/impedance-analyzer/ad5933.c   |  1 -
 include/linux/iio/common/st_sensors.h         |  3 +
 include/linux/iio/iio-opaque.h                |  4 ++
 include/linux/iio/iio.h                       | 67 +++++++++++++++----
 include/linux/iio/kfifo_buf.h                 |  5 +-
 32 files changed, 149 insertions(+), 112 deletions(-)

-- 
2.27.0

