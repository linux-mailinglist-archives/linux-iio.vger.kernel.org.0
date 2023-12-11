Return-Path: <linux-iio+bounces-845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B73B80DAF2
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 20:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F681C21487
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785BE52F92;
	Mon, 11 Dec 2023 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2Icw/RF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541351C37
	for <linux-iio@vger.kernel.org>; Mon, 11 Dec 2023 19:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE309C433C8;
	Mon, 11 Dec 2023 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702323320;
	bh=mZBtU9HwPGSsdDO7b9wIwPoV8j03fi3HUxHv/vw62vU=;
	h=Date:From:To:Subject:From;
	b=f2Icw/RFwHfUocYqrEoS6DnwH/nXMrqb0cbO2pvpAOi/KEY8Tqruu72qV0EPUBKdF
	 NlmVQeZgVZI3J/6F/iTGteOGXwRx0ZYZ+Yw0YlZSgMvnxGvNxtTnxPBgqmgY6BB0E5
	 v/3mCAc6voKHurGwM+NrT41dIqDgmducIcc02su4QpWRQGBsZq2u31u7i57DsnBKtg
	 InmJRdrmMlzUaskT9HxsxkbSFfZZVsxZWL/YBa6HZXLpzCXPtcEfVKzFmb7gt4m9dU
	 cQMiSbGqgihv/4vsBB4eqSDMoEFFHcabU/ppkgkFWLPaGk2uMYOi4zFG1Jg74BZ+CV
	 oQKKchY1WRbiQ==
Date: Mon, 11 Dec 2023 19:35:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO fixes for 6.7
Message-ID: <20231211193516.2a884b3f@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.7a

for you to fetch changes up to 408d4b33c2440600418a1eb9c89eaa27cf5867ad:

  iio: adc: MCP3564: fix hardware identification logic (2023-12-04 13:54:10 +0000)

----------------------------------------------------------------
First set of IIO fixes for the 6.7 cycle.

Usual mixed bunch of driver bugs.  The core bug probably isn't hit
with upstream drivers, but good to get fix in place anyway.

iio-core
- Fix potential freeing of wrong iio buffer when multiple buffers used.
adi,adis16475
- Add missing spi_device_id table need for module auto-loading
- Fix untended BIT(BIT()) due to wrong macro definitions.
amlogic,meson
- Add a chip specific config for AXG soc familly which needs
  a vref_select to work.
freescale,mp6050
- Fix eating of error code on failure to read from sensor.
kionixq,kx022a
- Fix scaling to comply with ABI (m/s^2 rather than micro m/s^2)
measspec,ms_sensors
- Fix wrong conversion times due to strange value mapping.
microchip,mcp3564
- Fix previously impossible to fail check on limits.
- Fix identification logic.
nxp,imx93
- Add missing channels for i.mx95.
ti,am335x
- Fix handling of error for tiadc_request_dma().
ti,tmag5273
- Fix incorrect temperature offset.

----------------------------------------------------------------
David Lechner (1):
      iio: triggered-buffer: prevent possible freeing of wrong buffer

George Stark (1):
      iio: adc: meson: add separate config for axg SoC family

Haibo Chen (1):
      iio: adc: imx93: add four channels for imx93 adc

Javier Carrasco (3):
      iio: common: ms_sensors: ms_sensors_i2c: fix humidity conversion time table
      iio: tmag5273: fix temperature offset
      iio: adc: MCP3564: fix calib_bias and calib_scale range checks

Marius Cristea (1):
      iio: adc: MCP3564: fix hardware identification logic

Matti Vaittinen (1):
      iio: kx022a: Fix acceleration value scaling

Nuno Sa (2):
      iio: imu: adis16475: add spi_device_id table
      iio: imu: adis16475: use bit numbers in assign_bit()

Su Hui (1):
      iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_raw

Wadim Egorov (1):
      iio: adc: ti_am335x_adc: Fix return value check of tiadc_request_dma()

 drivers/iio/accel/kionix-kx022a.c                  |  37 +++++--
 drivers/iio/adc/imx93_adc.c                        |   4 +
 drivers/iio/adc/mcp3564.c                          |   8 +-
 drivers/iio/adc/meson_saradc.c                     |  16 ++-
 drivers/iio/adc/ti_am335x_adc.c                    |   4 +-
 drivers/iio/buffer/industrialio-triggered-buffer.c |  10 ++
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |   4 +-
 drivers/iio/imu/adis16475.c                        | 121 +++++++++++++--------
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   4 +-
 drivers/iio/magnetometer/tmag5273.c                |   2 +-
 10 files changed, 141 insertions(+), 69 deletions(-)

