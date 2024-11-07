Return-Path: <linux-iio+bounces-11999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 209909C0DDA
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 19:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526D11C230A9
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 18:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD3A21642A;
	Thu,  7 Nov 2024 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmNyziiJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053B215F6E
	for <linux-iio@vger.kernel.org>; Thu,  7 Nov 2024 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004324; cv=none; b=s58v8Ar/Wg4VGyS/rvvDeg7NnEwEjbqLsjF9pFErZELtSf0mQzi9z7nkVO2HHHfWHyJr9y//UTw8lIFhTDV9TeftlVIGIMEB6rJN27AdFCOEFuFMMk08RMaPeCguiFgnCBx2aJ0pGc9TPax7LkygdxZfkYBFUUBZ0VWnYHmq4d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004324; c=relaxed/simple;
	bh=E8ApkeDVtabRALE2bboEAIVUpkKMkKWj7iHIPCbkGfI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=jZHEWjz0yGCD4DQ7dxmgabGxWeODUJeEvlsEAKk6gjC8KE2PlyfFeNAB2p22oBvBus6e++D248eKbexj8BsM1e4z77jKqVE0tQ0vJyN/jUfUYrBPFAy7SF2xABM8vrH1o/Oi7qdQNoFs2A55taUHGa1XCHShzLIC6cmY7mCwBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmNyziiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336D1C4CECC;
	Thu,  7 Nov 2024 18:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731004324;
	bh=E8ApkeDVtabRALE2bboEAIVUpkKMkKWj7iHIPCbkGfI=;
	h=Date:From:To:Subject:From;
	b=qmNyziiJtmUknBR5r5CVMOVXAU8FHn4weuvYGYO31+eoX7BwJZlbW5Qd2hKk75NgY
	 7TGv+QlDelumUJx2EFaIHbVtenA2UsIJM+2eDI90lRlF9n8yUOkWrWSqmVe0fQmB3G
	 XWuV/ntuGU4zqgqIbmpm8RCsnkOFZzxFxAKUv7C023rai7HgqWBeuKlBloGSXS6JhH
	 eE10TY+lZLo1PZwTLON01sP46Ti9d4tHji+f2/wdjHpS3tYnesbFNuZZjF+RJ+oFBf
	 vOrdEyrTS+R6auR68TIZHszcS6CNppzi3a1sgSOdK8HJB2B2FkR151kbZslB/2torE
	 ulYtNzImX7+dA==
Date: Thu, 7 Nov 2024 18:31:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 3rd set of fixes for the 6.12 cycle.
Message-ID: <20241107183156.12299e63@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit d0bc3b92fb9b2c3c981984d52fffe8cca77165dc:

  Merge tag 'iio-fixes-for-6.12b' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2024-10-29 04:10:12 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.12c

for you to fetch changes up to 3993ca4add248f0f853f54f9273a7de850639f33:

  iio: Fix fwnode_handle in __fwnode_iio_channel_get_by_name() (2024-11-02 15:18:52 +0000)

----------------------------------------------------------------
IIO: 3rd set of fixes for the 6.12 cycle

Usual mixed bag of new issues from this cycle and ancient bugs
recently noticed.

core
- Fix wrong fwnode handle if __fwnode_iio_channel_get_by_name()
  looks at parents of the provider node.
core,backend
- Fix a wrong pointer error check.
gts library
- Fix plausible corner case where the value returned was not set.
- Avoid near infinite loop if the size of the table is 0.
  (neither are an issue for current drivers).
adi,ad4000
- Fix reading of unsigned channels that were returning garbage.
adi,ad7780
- Prevent a division by zero.
adi,ad7923
- Fix buffer overflows in arrays that were not resized when devices
  with more channels were added to the driver.
adi,adxl380
- Check only for negative error codes rather than including the
  positive channel read values in an error check.
invense,common
- Fix an issue where changing the sampling rate to another value and
  back again whilst the FIFO was off would not update things correctly.
kionix,kx022a
- Fix failure to sign extend value read from device.

----------------------------------------------------------------
Antoniu Miclaus (1):
      iio: accel: adxl380: fix raw sample read

David Lechner (1):
      iio: adc: ad4000: fix reading unsigned data

Jean-Baptiste Maneyrol (1):
      iio: invensense: fix multiple odr switch when FIFO is off

Matti Vaittinen (1):
      iio: accel: kx022a: Fix raw read format

Nuno Sa (1):
      iio: adc: ad7923: Fix buffer overflow for tx_buf and ring_xfer

Yang Yingliang (1):
      iio: backend: fix wrong pointer passed to IS_ERR()

Zicheng Qu (4):
      ad7780: fix division by zero in ad7780_write_raw()
      iio: gts: Fix uninitialized symbol 'ret'
      iio: gts: fix infinite loop for gain_to_scaletables()
      iio: Fix fwnode_handle in __fwnode_iio_channel_get_by_name()

 drivers/iio/accel/adxl380.c                            | 2 +-
 drivers/iio/accel/kionix-kx022a.c                      | 2 +-
 drivers/iio/adc/ad4000.c                               | 2 ++
 drivers/iio/adc/ad7780.c                               | 2 +-
 drivers/iio/adc/ad7923.c                               | 4 ++--
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c      | 2 --
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c       | 3 ---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c          | 1 -
 drivers/iio/industrialio-backend.c                     | 4 ++--
 drivers/iio/industrialio-gts-helper.c                  | 4 ++--
 drivers/iio/inkern.c                                   | 2 +-
 12 files changed, 16 insertions(+), 16 deletions(-)

