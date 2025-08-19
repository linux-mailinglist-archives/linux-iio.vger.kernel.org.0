Return-Path: <linux-iio+bounces-23002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D24AB2CB4A
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 19:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85433B49E2
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 17:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D14230DEAD;
	Tue, 19 Aug 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieB4k9Cp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9572E2297
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625212; cv=none; b=mDV19wgjR36pB18g5fXTt+qqCWTTFe6fPxuew1trvDFGnWK3CiXyimlcvsa4/9ykWmNalYwezXwkb8dXBGsHmLdEtlZ3G2yVDd77yNoRk7Ft761pMfSYTIBVWOxOqVGbHI08lCNs71St2AvfwUGVM3Plnk9epvYlP+0YoY5pfBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625212; c=relaxed/simple;
	bh=BAqRdHNrTfdNVrqcdVyA+LO5n2MJDiMaJKjgQ6KsFuc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=e86yTsgInS+fxcbP9g4T5nBbI0MPb0FU0w4ZgamVcEMXGevrDNVNFnBU3sVRgYd2g0wCTDC+MyfKud6AT92VDUbuJ1LcNyDXGs+05PzCdypl72aqqXrPholmfPRpSWw/lR6py5fw38LB9M/p6nBTI3znR8HsGNJKFWCwxukfZFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieB4k9Cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F67C4CEF1;
	Tue, 19 Aug 2025 17:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755625211;
	bh=BAqRdHNrTfdNVrqcdVyA+LO5n2MJDiMaJKjgQ6KsFuc=;
	h=Date:From:To:Subject:From;
	b=ieB4k9Cpk4bXrsje0+iRpxwqQLAtcpOdbdnmKa9SkrIoS+DNcZHwHaDd8W22aOzmU
	 BMYHIMWAnRP2L1vmjYz5q+boN/c/z862GpnRTUcj77Ty/Jr331e2fIN3uxpUVoiHoR
	 bN66jvXc3fscjmHsuQaMcMO6jp7/6nib+6NxLgryuuBHPGpW73WW4Zf4vWBfh1sB2T
	 c16ehrC74SwyGVo6wBzzCK0KZtCY2t2POaJuISScC6aIXYsJmMFL0gTNuQhJ2tyZTy
	 dU8WCb1qmJIVRMYXMVzNhIATwG4lrT7cNLSscN4pW4h3KVijMyYlMe/KJuzklHxJkv
	 a1FW09vJfC/wQ==
Date: Tue, 19 Aug 2025 18:40:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of fixes for 6.17
Message-ID: <20250819184005.301b9cf5@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.17a

for you to fetch changes up to 43c0f6456f801181a80b73d95def0e0fd134e1cc:

  iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe() (2025-08-18 19:22:18 +0100)

----------------------------------------------------------------
IIO: 1st set of fixes for 6.17

Usual mixed bunch of ancient issues and relatively new ones.

adi,ad7124
- Fix channel lookup to use chan->address for indexing array.
adi,ad7173
- Stop accidentally enabling more configs than supported at one time.
adi,ad7380
- Fill in missing max_conversion_rate_hz for adaq4381-4
ams,as73211
- Fix uninitialized holes in scan data exposed to userspace.
bosch,bmp280
- Check for error when requesting optional GPIO rather than simply assuming
  success or a NULL return when no GPIO provided.
invensense,icm42600
- Change error code returned to -EBUSY on a temperature read with neither
  accelerometer nor gyroscope in use.  Reduces chance of misinterpretation
  by userspace.
kionix,sca3300
- Fix uninitialized holes in scan data exposed to userspace.
maxim,thermocouple
- Use a DMA-safe buffer for spi_read().
renesas,isl29501
- Fix ordering issue for big endian systems
renesas,rsg2l
- Fix an underflow issue around suspend/resume.
- Make sure driver data is in place before enabling runtime PM that uses
  it.
rohm,bd79124
- Add missing GPIOLIB dependency.  May rework in future to allow this to be
  optional in future but for now this is the least invasive build fix.

----------------------------------------------------------------
Claudiu Beznea (2):
      iio: adc: rzg2l: Cleanup suspend/resume path
      iio: adc: rzg2l_adc: Set driver data before enabling runtime PM

David Lechner (6):
      iio: accel: sca3300: fix uninitialized iio scan data
      iio: proximity: isl29501: fix buffered read on big-endian systems
      iio: adc: ad7173: prevent scan if too many setups requested
      iio: temperature: maxim_thermocouple: use DMA-safe buffer for spi_read()
      iio: adc: ad7124: fix channel lookup in syscalib functions
      iio: adc: ad7380: fix missing max_conversion_rate_hz on adaq4381-4

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: change invalid data error to -EBUSY

Jonathan Cameron (1):
      iio: light: as73211: Ensure buffer holes are zeroed

Matti Vaittinen (1):
      iio: adc: bd79124: Add GPIOLIB dependency

Salah Triki (1):
      iio: pressure: bmp280: Use IS_ERR() in bmp280_common_probe()

 drivers/iio/accel/sca3300.c                      |  2 +-
 drivers/iio/adc/Kconfig                          |  2 +-
 drivers/iio/adc/ad7124.c                         | 14 ++--
 drivers/iio/adc/ad7173.c                         | 87 ++++++++++++++++++++----
 drivers/iio/adc/ad7380.c                         |  1 +
 drivers/iio/adc/rzg2l_adc.c                      | 33 +++------
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c |  6 +-
 drivers/iio/light/as73211.c                      |  2 +-
 drivers/iio/pressure/bmp280-core.c               |  9 +--
 drivers/iio/proximity/isl29501.c                 | 16 +++--
 drivers/iio/temperature/maxim_thermocouple.c     | 26 ++++---
 11 files changed, 133 insertions(+), 65 deletions(-)

