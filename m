Return-Path: <linux-iio+bounces-13505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD9C9F2548
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615A7188544C
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2AE1B218C;
	Sun, 15 Dec 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI8Gj6dq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1938B13C8FF
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287371; cv=none; b=k+49mxbQFTFWN/kRxH+wpyxsWtM0Z6bSDHvqeAs2gyT5ZATfURpiU8AsKnLZC82SajNt6FOb2gBSdo9FSXQt+T5nguDO3su7C/DK+2NoWyfwUx6HaqYPLtsF5u980+bJzIjbw3ck43VdGsyr4Js+3jmJ9omFVcGZp8rC5J/50Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287371; c=relaxed/simple;
	bh=xLlqXWajPFrxJ38MNxYJb6tpdceD3ntlJr296ixvjt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDsJSKiJl08Kwj3iDi8Wmt2jKfo2sghcL3kKYPxBZy/EjARzBWbKhs1/sJkG9O2nnMaxjoIJ5H6GtgUKRoB7Xiy9/rMZTh4XRRgbsnTWgqumvzZfNQHGmIzJ7ckendSPqNy0lNiWT/BkQxyyfGd5kC50vKcPIhhH5GMCLAcXp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI8Gj6dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CA7C4CECE;
	Sun, 15 Dec 2024 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287370;
	bh=xLlqXWajPFrxJ38MNxYJb6tpdceD3ntlJr296ixvjt8=;
	h=From:To:Cc:Subject:Date:From;
	b=uI8Gj6dqUQW0Kn6IYcuU3LaGLrGyLUJtQ/eSEIxL3tpFgUab72vCqnM6SBRtdgtIA
	 AH4ZrVnx/LZtwskAOFEttuqgLh7NbpZydCNxW+GQE6S+sZXGDT+4ANa7eSHrJ6iGtY
	 j0xVKTNsCZuuti2ByhPo7uuJjFQXuqKkAhb1GGX8VbUvHVnq1VZg+H6IMyFCIsrxgL
	 aF/DgLkCaHxLtWP9ya6tEqKfuZXrKGIBltSggphjZsYtU6mVEAoS/aWuJ8My3uusZl
	 +FeF1InytyENKPAi0dsIBGPlLrcOqhr0xQEvT9J/kN/f5DAihvywhyfepRyQCWMypC
	 FOS4HTBA1Zfhg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/20] IIO: Tidying up timestamp alignment markings.
Date: Sun, 15 Dec 2024 18:28:51 +0000
Message-ID: <20241215182912.481706-1-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I haven't +CC everyone relevant as that would be too long a list
and these are mostly entirely mechanical changes that just need
someone to sanity check I didn't do anything stupid.

This combines several related types of change:

- Some 'fixes'. These aren't actual bugs but more places where
  the code relies on factors it shouldn't such as what architecture
  the driver is running on, or padding of the wrong element happening
  to always make enough room.
- Now we have aligned_s64, use that to replace all the remaining
  s64 timestamp __aligned(8) instances in IIO.
  This is both cleaner and hopefully less prone to confusing static
  analysis tools.
- Change the timestamp type in iio_push_to_buffers_with_timestamp() to s64.
  This is an entirely in kernel interface. It's data is pushed to user space
  in many case but by a rather indirect route, so I think it is more
  appropriate to switch this to s64 which is the type of almost all the
  values passed into it. Note a follow up series may tidy up some
  local variables that are of the int64_t type.
- Change the few int64_t timestamp __aligned(8) cases to aligned_s64.
  This is mostly a consistency thing to avoid confusion if a new author
  is trying to figure out what types they should use.  Better to have
  one answer than a mixture.

There is one other IIO driver hiding over in media that will be modified
by a separate patch because I want to add some more info to that and
a more specific CC list.

Jonathan Cameron (20):
  iio: adc: ad7944: Fix sign and use aligned_s64 for timestamp.
  io: adc: ina2xx-adc: Fix sign and use aligned_s64 for timestamp.
  iio: temperature: tmp006: Use aligned_s64 instead of open coding
    alignment.
  iio: resolver: ad2s1210: Use aligned_s64 instead of open coding
    alignment.
  iio: proximity: Use aligned_s64 instead of open coding alignment.
  iio: pressure: Use aligned_s64 instead of open coding alignment.
  iio: magnetometer: Use aligned_s64 instead of open coding alignment.
  iio: light: Use aligned_s64 instead of open coding alignment.
  iio: imu: Use aligned_s64 instead of open coding alignment.
  iio: humidity: Use aligned_s64 instead of open coding alignment.
  iio: gyro: Use aligned_s64 instead of open coding alignment.
  iio: chemical: Use aligned_s64 instead of open coding alignment.
  iio: adc: Use aligned_s64 instead of open coding alignment.
  iio: accel: bma220: Use aligned_s64 instead of open coding alignment.
  iio: buffer: Make timestamp s64 in
    iio_push_to_buffers_with_timestamp()
  iio: adc: ti-lmp92064: Switch timestamp type from int64_t __aligned(8)
    to aligned_s64
  iio: chemical: scd4x: witch timestamp type from int64_t __aligned(8)
    to aligned_s64
  iio: imu: inv_icm42600: witch timestamp type from int64_t __aligned(8)
    to aligned_s64
  iio: adc: mt6360: Correct marking of timestamp alignment.
  iio: adc: rockchip: correct alignment of timestamp

 drivers/iio/accel/bma220_spi.c                    | 2 +-
 drivers/iio/adc/ad4000.c                          | 2 +-
 drivers/iio/adc/ad7944.c                          | 2 +-
 drivers/iio/adc/ina2xx-adc.c                      | 2 +-
 drivers/iio/adc/max1118.c                         | 2 +-
 drivers/iio/adc/max11410.c                        | 2 +-
 drivers/iio/adc/mcp3911.c                         | 2 +-
 drivers/iio/adc/mt6360-adc.c                      | 4 ++--
 drivers/iio/adc/pac1921.c                         | 2 +-
 drivers/iio/adc/rockchip_saradc.c                 | 2 +-
 drivers/iio/adc/rtq6056.c                         | 2 +-
 drivers/iio/adc/ti-adc081c.c                      | 2 +-
 drivers/iio/adc/ti-adc084s021.c                   | 2 +-
 drivers/iio/adc/ti-ads1015.c                      | 2 +-
 drivers/iio/adc/ti-ads1119.c                      | 2 +-
 drivers/iio/adc/ti-ads131e08.c                    | 2 +-
 drivers/iio/adc/ti-lmp92064.c                     | 2 +-
 drivers/iio/adc/ti-tsc2046.c                      | 2 +-
 drivers/iio/adc/vf610_adc.c                       | 2 +-
 drivers/iio/chemical/ccs811.c                     | 2 +-
 drivers/iio/chemical/ens160_core.c                | 2 +-
 drivers/iio/chemical/scd30_core.c                 | 2 +-
 drivers/iio/chemical/scd4x.c                      | 2 +-
 drivers/iio/gyro/adxrs290.c                       | 2 +-
 drivers/iio/gyro/bmg160_core.c                    | 2 +-
 drivers/iio/gyro/itg3200_buffer.c                 | 2 +-
 drivers/iio/gyro/mpu3050-core.c                   | 2 +-
 drivers/iio/humidity/am2315.c                     | 2 +-
 drivers/iio/humidity/hdc100x.c                    | 2 +-
 drivers/iio/humidity/hts221.h                     | 2 +-
 drivers/iio/imu/bmi323/bmi323_core.c              | 2 +-
 drivers/iio/imu/bno055/bno055.c                   | 2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 2 +-
 drivers/iio/light/adjd_s311.c                     | 2 +-
 drivers/iio/light/as73211.c                       | 2 +-
 drivers/iio/light/bh1745.c                        | 2 +-
 drivers/iio/light/isl29125.c                      | 2 +-
 drivers/iio/light/ltr501.c                        | 2 +-
 drivers/iio/light/max44000.c                      | 2 +-
 drivers/iio/light/rohm-bu27034.c                  | 2 +-
 drivers/iio/light/rpr0521.c                       | 2 +-
 drivers/iio/light/st_uvis25.h                     | 2 +-
 drivers/iio/light/tcs3414.c                       | 2 +-
 drivers/iio/light/tcs3472.c                       | 2 +-
 drivers/iio/magnetometer/af8133j.c                | 2 +-
 drivers/iio/magnetometer/ak8974.c                 | 2 +-
 drivers/iio/magnetometer/ak8975.c                 | 2 +-
 drivers/iio/magnetometer/bmc150_magn.c            | 2 +-
 drivers/iio/magnetometer/hmc5843.h                | 2 +-
 drivers/iio/magnetometer/mag3110.c                | 2 +-
 drivers/iio/magnetometer/yamaha-yas530.c          | 2 +-
 drivers/iio/pressure/hsc030pa.h                   | 2 +-
 drivers/iio/pressure/ms5611_core.c                | 2 +-
 drivers/iio/pressure/rohm-bm1390.c                | 2 +-
 drivers/iio/proximity/as3935.c                    | 2 +-
 drivers/iio/proximity/hx9023s.c                   | 2 +-
 drivers/iio/proximity/mb1232.c                    | 2 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 2 +-
 drivers/iio/proximity/srf08.c                     | 2 +-
 drivers/iio/proximity/sx_common.h                 | 2 +-
 drivers/iio/resolver/ad2s1210.c                   | 2 +-
 drivers/iio/temperature/tmp006.c                  | 2 +-
 include/linux/iio/buffer.h                        | 6 +++---
 64 files changed, 67 insertions(+), 67 deletions(-)

-- 
2.47.1


