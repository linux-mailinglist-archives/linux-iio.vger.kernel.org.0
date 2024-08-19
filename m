Return-Path: <linux-iio+bounces-8620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C2C95748E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 21:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C33F284D1B
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 19:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340DC1D54CD;
	Mon, 19 Aug 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUekGNbj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6687179206
	for <linux-iio@vger.kernel.org>; Mon, 19 Aug 2024 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096261; cv=none; b=i4tGQkPLfXhxutrmr6wdNL9Dtr6/8BmNK4ZEJkv+7CHhxGvAyTJ6VuLD3MFvN1aMHgMIK7YFrQTtcraxWEKXPaRxd/TPypAx1xPlTEFzAKU6RRPEb2MaUNET8Uo1JK7LCDXpK3xgZfow/mBBrHJ739/nF3B7VhZAafVQdn28rEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096261; c=relaxed/simple;
	bh=HoehkUHDho654PbNnHLPpeIkHhMyYzmj1emIGzI1Oho=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=W58e590dmTaICP+pDKYoi6s8DQtH2ZQ3BDT21rBGwycFUEY+IkfUzQ2R3CqQ8SusoxCipNI2W3kxYv/k+IU/bZUCqhMTnhmq+bsof3R6kk6T3FHkdZBFvo2aN4ECIzxiPPX7H8rZ9PxEpYjZe3tg70ISISbJhMl5/hhxEX0lhmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUekGNbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F310C32782;
	Mon, 19 Aug 2024 19:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096260;
	bh=HoehkUHDho654PbNnHLPpeIkHhMyYzmj1emIGzI1Oho=;
	h=Date:From:To:Subject:From;
	b=XUekGNbj0BLz/nM7xCDxF8EqSUvNhAMF/V+rxNPzeM3FGref0AWAZDbJinEZFMSJ5
	 45QCOb0eKA0MHXarLZO0wgtCXypDPlg2KhUyHQb1zwBy+0STmTDhmBmPYDpe+fvVqd
	 PR65vApd5wNWlLcq0kp7SyXmKmb9VCbs/HNAi/cOogQxeevO+QRCb6CdNf3NdwACpN
	 MbHj8ZTDY484H0e/7R6puJyIzvZU3x0Yck5P4KLyGDG3iIIAkezsOd52E12aj5pVww
	 Dlr0LZluUrSCjSi9aKnSFqtcJMi+f0gfMY5m6TzDSgv3oYJIV20gzzSlnvdcypb2Ue
	 I6TGWtcSnPnMA==
Date: Mon, 19 Aug 2024 20:37:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of fixes for 6.11
Message-ID: <20240819203734.0866fd2c@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.11a

for you to fetch changes up to 0a3b517c8089aa4cf339f41460d542c681409386:

  iio: imu: inv_mpu6050: fix interrupt status read for old buggy chips (2024-08-17 15:31:41 +0100)

----------------------------------------------------------------
IIO: 1st set of fixes for 6.11

The usual mixed bag of new issues and ancient ones.
The fact so many are ADI is probably due to an uptick in upstreaming
effort from Analog + Baylibre  meaning existing code is getting more eyes
on it. Hence it's a good sign not a reflection of inherent high bug
incidence!

Core and helper related
-----------------------

in kernel interfaces
- Fix missing application of scale to the integer part of
  IIO_INT_PLUS_XXX value pairs when using the
  iio_convert_raw_to_processed*() helper.
buffer-dmaengine
- Make sure to release DMA channel in error path.

Driver related
--------------

adi,ad-sigma-delta library
- Check irq-flags for the correct irq if multiple are provided.
adi,ad7124
- Wait after reset before reading the chip ID register.
- Compare only the relevant field when looking for an existing
  config to reuse for a new channel.
- Fix an off by one in which channel config is being filled from
  firmware.
adi,ad7173
- Fix missing vendor prefix in compatible strings.
- Fix wrong info for GPIO related bit positions for ad4114,ad4115 and ad4116.
adi,ad7606
- Drop incorrect check on frstdata when in serial mode, it only applies to
  parallel mode.
adi,ad9834
- Check userspace input for frequency parameter to avoid div by zero.
invensense,mpu6050
- Avoid reading interrupt status on some older chips as it seems there
  is a hardware problem that surfaces as a result of adding wake on
  motion support to the driver (which these chips don't support).
ti,ads1119
- Fix incorrect IRQ flag (new driver so no firmware compatibility regression
  issues with fixing this now).

----------------------------------------------------------------
Aleksandr Mishin (1):
      staging: iio: frequency: ad9834: Validate frequency parameter value

David Lechner (1):
      iio: buffer-dmaengine: fix releasing dma channel on error

Dumitru Ceclan (5):
      iio: adc: ad7173: Fix incorrect compatible string
      iio: adc: ad7124: fix chip ID mismatch
      iio: adc: ad7124: fix config comparison
      iio: adc: ad7124: fix DT configuration parsing
      iio: adc: ad7173: fix GPIO device info

Francesco Dolcini (1):
      iio: adc: ads1119: Fix IRQ flags

Guillaume Stols (1):
      iio: adc: ad7606: remove frstdata check for serial mode

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_mpu6050: fix interrupt status read for old buggy chips

Matteo Martelli (1):
      iio: fix scale application in iio_convert_raw_to_processed_unlocked

Nuno Sa (1):
      iio: adc: ad_sigma_delta: fix irq_flags on irq request

 drivers/iio/adc/ad7124.c                           | 30 ++++++++------
 drivers/iio/adc/ad7173.c                           | 13 +++---
 drivers/iio/adc/ad7606.c                           | 28 +------------
 drivers/iio/adc/ad7606.h                           |  2 +
 drivers/iio/adc/ad7606_par.c                       | 48 ++++++++++++++++++++--
 drivers/iio/adc/ad_sigma_delta.c                   |  2 +-
 drivers/iio/adc/ti-ads1119.c                       |  2 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      | 13 +++++-
 drivers/iio/inkern.c                               |  8 ++--
 drivers/staging/iio/frequency/ad9834.c             |  2 +-
 11 files changed, 92 insertions(+), 60 deletions(-)

