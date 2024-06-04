Return-Path: <linux-iio+bounces-5780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 653898FBC0A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 21:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75E3281165
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 19:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943CB14A62F;
	Tue,  4 Jun 2024 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqhfKdKX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539761494CA
	for <linux-iio@vger.kernel.org>; Tue,  4 Jun 2024 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527871; cv=none; b=qdgLWNj3/RxxyhpCD4uR6o23DiEgudE29tOKie4qrxQb4wyIRgEfVb2FUeA2ytlevSif1/If953xcCyPwiAmN6nTVk3i/Ipay8N/J/JX/g9TUTordsi/WqZj7MXOpkjcbsa5R4B+VgDu2SpCL7HbqV9qYQkQ6PUS++OLYkh0PTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527871; c=relaxed/simple;
	bh=C9kEb1TPI4R3mK1DcQwaYPt6mmoh48mhQb1l08tizi0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=iBQMlCE8yEUGJqNG/9uMyoVuQ+hAadwFoIy9smQ8OxygAiMmR7cSkG/nnb1Us+8eU2rWwzbc3ZBknY1zeob4XWI5HKkMYLH0cWi+t364u9jYyjMJEmin7fTdEN9KORfKsvWG1rsbtPVw54C7LGb6VA43BmOGhRrYK54Njz3z44Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqhfKdKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3641C2BBFC;
	Tue,  4 Jun 2024 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717527871;
	bh=C9kEb1TPI4R3mK1DcQwaYPt6mmoh48mhQb1l08tizi0=;
	h=Date:From:To:Subject:From;
	b=iqhfKdKXAT0ILu08sgCjyDlcGZrgguwj3aktXBEC1DCtQr4kg5f+xkkjH76B97N82
	 tdPJB+EjTBZYvc89zKcGhWZaKmA/37IRb9doNM9kCC89tL/CdFVx8I30Lg/quAlJpx
	 RL8dcVSsuNsD5s3YqGdAxxaYl+ngJUqY9kilF+QPV7rP7PsjrtMZ/eKVnFXts+Gxdd
	 9qJ4wenAkWmguYXN5zyI+i+b+N2c+SZIm5FRztkgtWKLjY8gGjsB3xsahsi4pfInN0
	 7Q/TefhzfdNV+uMrdhvKAVfxfK3YJAwqq03Gc2x3Ro/6NQjp9z4fGRLTknPoOsc4Fr
	 xjIqsIVj6LRMw==
Date: Tue, 4 Jun 2024 20:04:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL]
Message-ID: <20240604200421.2d084308@jic23-huawei>
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

