Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EABCF11638C
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2019 20:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfLHTNk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Dec 2019 14:13:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfLHTNj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Dec 2019 14:13:39 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6E9620663;
        Sun,  8 Dec 2019 19:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575832419;
        bh=jHc1nI1iOaPcGgvytdGwPsmSNhVbVe1hFvBy0E8vKMs=;
        h=Date:From:To:Subject:From;
        b=HK16xstI+aaaZNHosNjEOt+4m/86QVLiNyhbhH13JS9+oidExH0GV0DnTA3mNrCvL
         riJRKlo8rpQOI7CpKfXygC5Y3jpRsiaKS0zGwBN93TZjGUmj9f9bnQKCb8CRIZpu1O
         lk/DjoVtm61hFh5Ig6yJRkx6o9RslX7ElO+p0OrQ=
Date:   Sun, 8 Dec 2019 19:13:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO fixes for the 5.5 cycle.
Message-ID: <20191208191334.614889c6@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 2611045e3555cd0d75837ae69ffd70ef51e28bf7:

  staging: vchiq: Refactor indentation in vchiq_platform_conn_state_changed() (2019-11-15 14:14:55 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.5a

for you to fetch changes up to 9fd229c478fbf77c41c8528aa757ef14210365f6:

  iio: adc: max9611: Fix too short conversion time delay (2019-12-08 18:10:30 +0000)

----------------------------------------------------------------
First set of fixes for IIO in the 5.5 cycle.

Mixture of old things people have just hit, and a few late breaking
issues with things that went in during the merge window.

Being sent promptly to resolve potential DT breakage causing
issues for binding test builds.

* ad7606
  - Avoid reading extra data from the device over what was intended.
* ad7124
  - Enable the internal reference when in use.
* ad7292
  - Fix up license for newly added binding.  Better to not have this go
    out in a release with more limited header than intended.
  - Fix a constraint on number of channels.
* ad7949
  - Fix an issue which can result in readouts being from the wrong channel.
* hdc100x
  - Fix wrong ABI usage (units) for relative humidity channel.
* intel mrfld
  - Allocate right amount of private data (currently allocating too much).
* ltc2983
  - Avoid a potential issue with machine endianness and wrong length device
    tree read.
* max1027
  - Clean up leak of an iio_trigger on probe failure.
* max9611
  - Ensure we sleep long enough to successfully initialize the sensor.
* mpu6050
  - Fix wrong ABI usage (units) for temperature channel.
* st_accel
  - Fix an unused variable warning.
* st_lsm6dsx
  - Fix decimation factor issue that can lead to missaligned datasets
    (and hence garbage)
  - Fix an issue with how we track enabled fifo channels.
  - Avoid powering off the device if wake up events are enabled.

----------------------------------------------------------------
Andrea Merello (1):
      iio: ad7949: fix channels mixups

Beniamin Bia (1):
      iio: adc: ad7606: fix reading unnecessary data from device

Chris Lesiak (1):
      iio: humidity: hdc100x: fix IIO_HUMIDITYRELATIVE channel reporting

Chuhong Yuan (1):
      iio: adc: max1027: fix not unregistered iio trigger

Colin Ian King (1):
      iio: temperature: ltc2983: fix u32 read into a unsigned long long

Dan Carpenter (1):
      iio: adc: intel_mrfld_adc: Allocating too much data in probe()

Geert Uytterhoeven (1):
      iio: adc: max9611: Fix too short conversion time delay

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_mpu6050: fix temperature reporting using bad unit

Lorenzo Bianconi (3):
      iio: imu: st_lsm6dsx: fix decimation factor estimation
      iio: imu: st_lsm6dsx: track hw FIFO buffering with fifo_mask
      iio: imu: st_lsm6dsx: do not power-off accel if events are enabled

Marcelo Schmitt (2):
      dt-bindings: iio: adc: ad7292: Update SPDX identifier
      dt-bindings: iio: adc: ad7292: fix constraint over channel quantity

Mircea Caprioru (1):
      iio: adc: ad7124: Enable internal reference

YueHaibing (1):
      iio: st_accel: Fix unused variable warning

 .../devicetree/bindings/iio/adc/adi,ad7292.yaml    |  5 ++-
 drivers/iio/accel/st_accel_core.c                  |  8 +++-
 drivers/iio/adc/ad7124.c                           |  7 ++-
 drivers/iio/adc/ad7606.c                           |  2 +-
 drivers/iio/adc/ad7949.c                           | 22 +++++++---
 drivers/iio/adc/intel_mrfld_adc.c                  |  2 +-
 drivers/iio/adc/max1027.c                          |  8 +++-
 drivers/iio/adc/max9611.c                          | 16 ++++---
 drivers/iio/humidity/hdc100x.c                     |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 23 +++++-----
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          | 16 +++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |  6 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     | 50 ++++++++++++++--------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 34 ++++++++++++---
 drivers/iio/temperature/ltc2983.c                  |  6 ++-
 15 files changed, 142 insertions(+), 65 deletions(-)
