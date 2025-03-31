Return-Path: <linux-iio+bounces-17430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7D8A76574
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC761889889
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD841E32A0;
	Mon, 31 Mar 2025 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpDU8zSt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A3339A1
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423215; cv=none; b=jg6aHha2oMbGIdUHUKw7DrtX6F24BgfPBbWdOopqgFHANBULLDrCreFsN0buW03EMq/BZ3Quwh20WTpBMqvjGjU8VI2d7lz7/X4jGZRayQIGqMJprpC3ucPtLmY/VGpwvrIi+SRKCmbWaJfbRIZwEVC//ymvF3iPPTciCs8pnxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423215; c=relaxed/simple;
	bh=PMRMMg8RfE9LIo68boB8QSf19AxDyq6Dj1zcXWSR+Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4YSnGBLVXAbBjl7WGdg//SeEdVowWQY+RtEXFduW9A36aJlKwiWnfr4/I2PLtnUrqFVVsBtMrEVzXjXpnJCbAY0JMmRHf7cAevWwwPM5urx8S4Xs8ziDDZiZn3xK7FhjEBgYXr+BBA+PKsOMDaXMOjr5ZLvzp4xAr3p9Vf9ev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpDU8zSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4ABC4CEE3;
	Mon, 31 Mar 2025 12:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423215;
	bh=PMRMMg8RfE9LIo68boB8QSf19AxDyq6Dj1zcXWSR+Pg=;
	h=From:To:Cc:Subject:Date:From;
	b=LpDU8zStIPcGgy1PMrjp+vc3LUpnioCQutg6IddMZczQNVTnShDF/xBT2DIH7s6Tz
	 8zArYrtqCMsiTJehRfM3BawWZeezsFHhqRI67xlUQI9KAadykDouHXYU2nb+yxKQJf
	 IXlBu2B13+EDucO/rLMTLRj6dedUAq+kCgh+/aNkDfxwSp9rQO9vv6xngyvuXBy2Rv
	 3nxdaIBBU2mMD9vslIUUSVXkbYlmjL5XhS7KU/ZaqLAxHXsBDloqPNEEc7jJVRQhLy
	 bH1o7n2pA/QpKi6xujkExJaGa0Nx7jDbDNUJs3Hfoy3M7QTjw8JaFl2AwnuDbvHnDG
	 4tB4CxtAVthhg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/37] IIO: Sparse friendly claim of direct mode (the rest)
Date: Mon, 31 Mar 2025 13:12:40 +0100
Message-ID: <20250331121317.1694135-1-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Firstly, sorry for the huge patch set!

I've run out of signficiant groups to break the remaining patches up into.
Rather than have lots of small series of 5-10 patches, lets just have one
mega one. Feel free to review a subset! I'll nibble away at this as reviews
come in and post a v2 later in the cycle with whatever remains unreviewed
if that is necessary.

Note that a number of the drivers touched in this series have no
obvious active maintainer, so it would be much appreciated if anyone
has time to take a look!

This is effectively part 5 of what will probably be around 5 series
focused on moving from iio_device_claim/release_direct_mode() to
iio_device_claim/release_direct(). The new form is more consistent
with conditional locking semantics and sparse markings have been
added that let us detect miss-balance between claim and release.

More details can be found in the cover letter of the first series:
https://lore.kernel.org/all/20250209180624.701140-1-jic23@kernel.org/

This series focuses on all the remaining drivers.
The final patch removes the old infrastructure.

Jonathan Cameron (37):
  iio: addac: ad74115: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: chemical: ccs811: Factor out handling of read of IIO_INFO_RAW to
    simplify error paths.
  iio: chemical: ccs811: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: chemical: atlas-sensor: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: chemical: scd4x: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: common: scmi: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: common: st_sensors: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: gyro: adxrs290: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: health: max30102: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: humidity: hdc100x: Use guard(mutex) to simplify code flow
  iio: humidity: hdc100x: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: humidity: hdc2010: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: humidity: hts211: Factor out everything under direct mode claim
    into helper functions.
  iio: humidity: hts211: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: imu: inv_icm42600: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: imu: inv_mpu6050: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: imu: smi240: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: imu: st_lsm6dsx: Factor out parts of st_lsm6dsx_shub_write_raw()
    to allow direct returns
  iio: imu: st_lsm6dsx: Switch to sparse friendly claim/release_direct()
  iio: imu: st_lsm6dsx: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: magnetometer: mag3110: Factor out core of read/write_raw() and
    use guard() to simplify code flow.
  iio: magnetometer: mag3110: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: magnetometer: rm3100: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: pressure: dlhl60d: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: pressure: icp10100: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: pressure: mpl3115: factor out core of IIO_INFO_RAW read to
    simplify code flow
  iio: pressure: mpl3115: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: pressure: ms5611: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: pressure: rohm-bm1390: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: pressure: zpa2326: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: proximity: hx9023s: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: proximity: pulsed-light: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: proximity: sx9500: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: temp: maxim_thermocouple: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: temp: maxim_thermocouple: Drop unused mutex.h include.
  staging: iio: ad5933: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: Adjust internals of handling of direct mode claiming to suit new
    API.

 drivers/iio/addac/ad74115.c                   |   7 +-
 drivers/iio/chemical/atlas-sensor.c           |   7 +-
 drivers/iio/chemical/ccs811.c                 |  79 ++++-----
 drivers/iio/chemical/scd4x.c                  |   7 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c    |   7 +-
 .../iio/common/st_sensors/st_sensors_core.c   |   7 +-
 drivers/iio/gyro/adxrs290.c                   |  14 +-
 drivers/iio/health/max30102.c                 |   4 +-
 drivers/iio/humidity/hdc100x.c                |  68 +++-----
 drivers/iio/humidity/hdc2010.c                |  14 +-
 drivers/iio/humidity/hts221_core.c            |  91 +++++-----
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c |  21 +--
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  |  21 +--
 .../iio/imu/inv_icm42600/inv_icm42600_temp.c  |   7 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  14 +-
 drivers/iio/imu/smi240.c                      |   7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  16 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  73 ++++----
 drivers/iio/industrialio-core.c               |  28 +--
 drivers/iio/magnetometer/mag3110.c            | 161 +++++++++---------
 drivers/iio/magnetometer/rm3100-core.c        |   7 +-
 drivers/iio/pressure/dlhl60d.c                |   7 +-
 drivers/iio/pressure/icp10100.c               |  15 +-
 drivers/iio/pressure/mpl3115.c                |  97 ++++++-----
 drivers/iio/pressure/ms5611_core.c            |   8 +-
 drivers/iio/pressure/rohm-bm1390.c            |   7 +-
 drivers/iio/pressure/zpa2326.c                |  15 +-
 drivers/iio/proximity/hx9023s.c               |   7 +-
 .../iio/proximity/pulsedlight-lidar-lite-v2.c |   4 +-
 drivers/iio/proximity/sx9500.c                |   7 +-
 drivers/iio/temperature/maxim_thermocouple.c  |  30 ++--
 .../staging/iio/impedance-analyzer/ad5933.c   |  38 +++--
 include/linux/iio/iio.h                       |  10 +-
 33 files changed, 428 insertions(+), 477 deletions(-)

-- 
2.48.1


