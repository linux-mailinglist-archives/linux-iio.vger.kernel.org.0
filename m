Return-Path: <linux-iio+bounces-3247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F29B86D3EA
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 21:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5E0285D59
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 20:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C023E13F420;
	Thu, 29 Feb 2024 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBHJE7Mh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8243313C9F7
	for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237236; cv=none; b=Y8H2x+kic3EwY04Gv+D77QsfIs6+RGKZd6O81RZaezTXtI6WREG6LAu9SjwMXRSms3cgb4zujn3uXyPxJgOboyoz0LtDAL7kgOe0X9zIb2eIA0+53dPK+rs5PMIM9Fw823RqgaLlIqUzA3T0yFNiXEB60Tc3zG5qNTWoKG2xkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237236; c=relaxed/simple;
	bh=KQfsGF1rw/mDQpvgD4eN8Tqj8FzA2KvKLHp0g53b8TM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=uBR3nDgslNQMl/uu8P0yET6OGKmPjduoA/o2603emwrbzpivtsXZMQMEeB4TuWS5yZqkHHXuoBQF19ksRtk/CxlV1gxNw11ax/5GDjXwQ+48D0jdDZ3S4Z2+VnjeMKzzagO0rovzaa18GzAU/4irTAvPv0iIH8G9XGsMYGXJb0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBHJE7Mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BDFC433F1;
	Thu, 29 Feb 2024 20:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709237236;
	bh=KQfsGF1rw/mDQpvgD4eN8Tqj8FzA2KvKLHp0g53b8TM=;
	h=Date:From:To:Subject:From;
	b=kBHJE7MhEY9dd2LXvL4vRPtbeqaReTwQ6w8zk+nhBKnPzukCrUABGNozNxQPK1j0H
	 FOaxwpdgl3nBHYCqBTqsH32PmYMzEZ6gm5hFPaEnIPQ+h0uS5ghaNqplxGFLBbg5xm
	 Cu9EJJ2myAhpkHm64SOrjNXvrK4/p540XnAHJx909tou5pak/h2aLO8lTuht8lx9kP
	 8yN5Aedx75NlSIjh4H5fo0gx/1hFI5Q1dfWHBAxMi5UD9Loz500lvro5YOW3R1SHrv
	 VnCgC99DEMVu7G85MrRv3KLIXDqXBArbV/smQe9O8PMCljuW56u5rf1LUWijuEuyc5
	 /f4IwufFRr1dw==
Date: Thu, 29 Feb 2024 20:07:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO fixes for 6.8 - second set.
Message-ID: <20240229200703.52697131@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit e20f378d993b1034eebe3ae78e67f3ed10e75356:

  nvmem: include bit index in cell sysfs file name (2024-02-14 16:28:16 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.8b

for you to fetch changes up to 11dadb631007324c7a8bcb2650eda88ed2b9eed0:

  iio: accel: adxl367: fix I2C FIFO data register (2024-02-25 14:31:14 +0000)

----------------------------------------------------------------
IIO: 2nd set of fixes for the 6.8 cycle.

Given this is very late these can wait for the 6.9 cycle if you would
prefer.

adi,adxl367
- Sleep for 15ms after reset to avoid reading before the device is awake.
- Fix FIFO register address.
asc,dlhl60d
- Avoid uninitialized data leak to user-space. Also suppress a false
  positive clang warning by refactoring a loop.
bosch,bmp280
- Fix missing extra byte in SPI reads from BMP38x and BMP390 parts
invensense,mpu6050
- Fix handing of empty FIFO which can happen due to a race condition.
- Make sure frequency can be updated more than once when the FIFO is not
  enabled.

----------------------------------------------------------------
Cosmin Tanislav (2):
      iio: accel: adxl367: fix DEVID read after reset
      iio: accel: adxl367: fix I2C FIFO data register

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_mpu6050: fix FIFO parsing when empty
      iio: imu: inv_mpu6050: fix frequency setting when chip is off

Kees Cook (1):
      iio: pressure: dlhl60d: Initialize empty DLH bytes

Vasileios Amoiridis (1):
      iio: pressure: Fixes BMP38x and BMP390 SPI support

 drivers/iio/accel/adxl367.c                   |  8 +++--
 drivers/iio/accel/adxl367_i2c.c               |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  2 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  5 +++
 drivers/iio/pressure/bmp280-spi.c             | 50 ++++++++++++++++++++++++++-
 drivers/iio/pressure/dlhl60d.c                |  7 ++--
 6 files changed, 66 insertions(+), 8 deletions(-)

