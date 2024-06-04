Return-Path: <linux-iio+bounces-5781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161D08FBC11
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 21:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C809E283CAF
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 19:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D6714AD0E;
	Tue,  4 Jun 2024 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUOV71Ok"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1751494CA
	for <linux-iio@vger.kernel.org>; Tue,  4 Jun 2024 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528003; cv=none; b=JY0OjrUJK0ZK8yTtZ1TXD8Gix5saUG/AJhjztK+P7w0T4+NrL1+8l6TPjLCP8miO+az82lf3oqacSmRdWHY1KLSduINNXozcK8HNDiPuYO4jEfl01EkP4e9UujwN9VmxIEQ4DmXTfbvtiznG8ScT6eM/VNI1Sc3auSKW/vLOrx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528003; c=relaxed/simple;
	bh=C9kEb1TPI4R3mK1DcQwaYPt6mmoh48mhQb1l08tizi0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=EZZWhWGHHVAMPp1e16M67n1C4VskOTtNOlQVmigbdWXUcBuG7cDWRDF9Yk+zhp/cjDkn5UM6Y6ehnX4LUbm4Yo5iXhFcuFm9un78zF6bErrvLgpPQXD2Z0blVjZ2fPrjsioVdIIawUxj21HIQ+mGvM0TzL7cMPr0cAb17j01c+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUOV71Ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3941C2BBFC;
	Tue,  4 Jun 2024 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717528003;
	bh=C9kEb1TPI4R3mK1DcQwaYPt6mmoh48mhQb1l08tizi0=;
	h=Date:From:To:Subject:From;
	b=IUOV71OkidJlK7cQ9J9BQ8WCbtJpOFiCONcRVnWTNC0vFMr04sJajeHVPmo/W6EFy
	 fEixfm0TM3uFXsRID3vwHfLSkrkJ2BJgoCCJk/NGBr9xk/LSK/uLh8SNuX7ViJjHct
	 k599DQMhDzhq/qrXszTzIInbwsk6akPVeTy/NiFmZFBBfKOL7CBMvmSTWD9/QbEotP
	 1H2MrY2yUx43ZejAbuV1HHdaYf1jb4NdnI8ZDIBvaZY0LJZmJSoNh2rkzziSUATGtc
	 vSLa+nFs1042Hcoe31VEqwW3IK79dS01sLusNP+1Bnzwh0mfGqib7RLs7KWKF2Fa30
	 2qIzGQDjrzFZA==
Date: Tue, 4 Jun 2024 20:06:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: First round fixes for IIO in the 6.10 cycle
Message-ID: <20240604200632.6af3f262@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.10a

for you to fetch changes up to 78f0dfa64cbd05f381849377a32e0a2f1afe9215:

  iio: inkern: fix channel read regression (2024-06-03 20:29:31 +0100)

----------------------------------------------------------------
1st set of IIO fixes for the 6.10 cycle.

The usual mixed bag of old and new driver bugs plus one core issue that
highlighted we have some documentation issues that we need to fix
as a follow up action.

core in kernel interface
- Wrong return value documentation didn't help with an error in
  a cleanup. Result is that thermal is failing to read the temperature.

adi,ad3552r
- Fix DT binding output range sign error.
adi,ad5592r
- Wrong scaling on temperature channel.
adi,ad7173
- Driver assumed all supported devices had input buffers. Make sure not to
  enable them on the ad7176-2 which doesn't.
- Add some missing device names for recently added models.
- Drop an unneeded zero index on the single temperature channel.
- Clear buffered capture specific control bit when returning to on
  demand sampling which otherwise no longer works.
- Make sampling frequency per channel rather than just setting it for the
  first channel.
adi,ad9467
- Capital S for sign of channel whereas ABI is lowercase.
bosch,bmi323
- Make sure to release the trigger even on error paths in the trigger
  handler as otherwise there is no path to recover.
bosch,bmp280
- Avoid an overflow in calculating the temperature.
invensense,timestamp helper
- Fix case where ODR is being switched to the existing ODR an update that
  never finishes.
- Fix an issue with the timestamp being updated whilst still handling
  previous interrupt (icm42600 and mpu6050)
invensense,icm42600
- Don't update the watermark parameters twice.
melexis,mlx90635
- Fix variable returned as error code.

----------------------------------------------------------------
Adam Rizkalla (1):
      iio: pressure: bmp280: Fix BMP580 temperature reading

Angelo Dureghello (1):
      dt-bindings: iio: dac: fix ad354xr output range

David Lechner (1):
      iio: adc: ad9467: fix scan type sign

Dumitru Ceclan (5):
      iio: adc: ad7173: fix buffers enablement for ad7176-2
      iio: adc: ad7173: Add ad7173_device_info names
      iio: adc: ad7173: Remove index from temp channel
      iio: adc: ad7173: Clear append status bit
      iio: adc: ad7173: Fix sampling frequency setting

Harshit Mogalapalli (1):
      iio: temperature: mlx90635: Fix ERR_PTR dereference in mlx90635_probe()

Jean-Baptiste Maneyrol (4):
      iio: invensense: fix odr switching to same value
      iio: imu: inv_icm42600: stabilized timestamp in interrupt
      iio: imu: inv_icm42600: delete unneeded update watermark call
      iio: imu: inv_mpu6050: stabilized timestamping in interrupt

Johan Hovold (1):
      iio: inkern: fix channel read regression

Marc Ferland (1):
      iio: dac: ad5592r: fix temperature channel scaling value

Vasileios Amoiridis (1):
      iio: imu: bmi323: Fix trigger notification in case of error

 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |  2 +-
 drivers/iio/adc/ad7173.c                           | 37 +++++++++++-----------
 drivers/iio/adc/ad9467.c                           |  4 +--
 .../iio/common/inv_sensors/inv_sensors_timestamp.c |  6 +++-
 drivers/iio/dac/ad5592r-base.c                     |  2 +-
 drivers/iio/imu/bmi323/bmi323_core.c               |  5 +--
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  4 ---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 19 +++++++++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |  2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  4 ---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  4 +--
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  1 +
 drivers/iio/inkern.c                               |  2 +-
 drivers/iio/pressure/bmp280-core.c                 | 10 +++---
 drivers/iio/temperature/mlx90635.c                 |  6 ++--
 16 files changed, 63 insertions(+), 46 deletions(-)

