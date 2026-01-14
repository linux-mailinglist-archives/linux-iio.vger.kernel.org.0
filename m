Return-Path: <linux-iio+bounces-27703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D215FD1D3D1
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03EC5300879D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CDE37F8B4;
	Wed, 14 Jan 2026 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU6kvEcK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158E36E493
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380590; cv=none; b=FlOg+pg3qY8/xwKaqWveD+Q+Fs/1uwtlyFteVI8P3n5cS6lCeyh6BV5lalmYB7u+Twq8EfJsyjYaO2SWE813mlwqq1Fo4oUHJSD1XFNhzADeUtrSOV6E3t6OMRAob4di4Spweri5KC2oE2/xlN/jOfLcQh5j5nZl3UPHXDT0UvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380590; c=relaxed/simple;
	bh=5QY+4cnI1kPX6DOw6uWveBsbg0atgoAQLjfQ23aLf8k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=XXJDPSo0CkBNQzgKo+wcHN4Co5gr+ACWVzJWocEtLiLElaX5QRcoo5uCGraHB7HyXHC6XDFohLNbzuz9dfUeBnz4We3YcSLtEFOaBviD52JVp4vMl02bPmpctp3FIKJl9HRgCdC3zurERK+Gwkp2iahPT25gP0bOQGj1Mqv28Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU6kvEcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F41C4CEF7;
	Wed, 14 Jan 2026 08:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768380589;
	bh=5QY+4cnI1kPX6DOw6uWveBsbg0atgoAQLjfQ23aLf8k=;
	h=Date:From:To:Subject:From;
	b=kU6kvEcKh+7CqUYPPZR91DHS1z92q0jbhuaCsXV9fp4mpFSAiC0wfIoX6CJt6KRam
	 Vc5Jhpw/s3Q+5DF4KWHSjXqwdLxVi5XCHmrSj9dM4xJbXAN2VhTTZ7roExok6deDoI
	 4vDoAcohbd1Yh0veq4tN4c56C5QNrzN5v0npS3PdtIFmCvERN19CgVCaCoda2xxJU2
	 8FeAMbW6Y4jlghM0veSWqkvFbIbyVu5GtiM2Lk6oMovqgn92kfVy5EOznBqESlidzf
	 O4NX+5MHrGCdYDNmQBMb0/H/T/W8+A6JcK9gaM25dO+qgCXBqQd97Pb8FJO8bNPVh6
	 hwoQP83EMhzNA==
Date: Wed, 14 Jan 2026 08:49:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: Fixes for 6.19 set 1
Message-ID: <20260114084945.1a7d67ba@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fi=
xes-for-6.19a

for you to fetch changes up to 978d28136c53df38f8f0b747191930e2f95e9084:

  iio: dac: ad3552r-hs: fix out-of-bound write in ad3552r_hs_write_data_sou=
rce (2026-01-11 13:25:15 +0000)

----------------------------------------------------------------
IIO: 1st set of fixes for the 6.19 cycle

The usual mixed bag of fixes for ancient problems plus some more
recent ones.

adi,ad7280a
- Check for errors from spi_setup().
adi,ad3552r
- Fix potential buffer overflow when setting to use the internal ramp.
adi,ax5695r
- Fill in the data for this device in the chip info table.
adi,ad7606
- Don't store a negative error in an unsigned int.
adi,ad9467
- Fix incorrect register mask value.
adi,adxl380
- Fix inverted condition for whether INT1 interrupt present in dt.
atmel,at91-sama5d2
- Cancel work on remove to avoid a potential use-after-free
invensense,icm45600
- Fix temperature scaling.
samsung,eynos_adc
- Use of_platform_depolulate() to correctly clear up such that child
  devices are created correctly if the driver is rebound.
sensiron,scd4x
- Fix incorrect endianness reported to user-space.
st,accel
- Fix gain reported for the iis329dq.
st,lsm6dsx
- Hide event related interfaces on parts that don't support events.
ti,pac1934
- Ensure output of clamp() is used rather than unclamped value.

----------------------------------------------------------------
Fiona Klute (1):
      iio: chemical: scd4x: fix reported channel endianness

Francesco Lavra (2):
      iio: imu: st_lsm6dsx: fix iio_chan_spec for sensors without event det=
ection
      iio: accel: adxl380: fix handling of unavailable "INT1" interrupt

Haotian Zhang (1):
      iio: adc: ad7606: Fix incorrect type for error return variable

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm45600: fix temperature offset reporting

Johan Hovold (1):
      iio: adc: exynos_adc: fix OF populate on driver rebind

K=C3=BCbrich, Andreas (1):
      iio: dac: ad5686: add AD5695R to ad5686_chip_info_tbl

Markus Koeniger (1):
      iio: accel: iis328dq: fix gain values

Miaoqian Lin (1):
      iio: dac: ad3552r-hs: fix out-of-bound write in ad3552r_hs_write_data=
_source

Pavel Zhigulin (1):
      iio: adc: ad7280a: handle spi_setup() errors in probe()

Pei Xiao (1):
      iio: adc: at91-sama5d2_adc: Fix potential use-after-free in sama5d2_a=
dc driver

Rasmus Villemoes (1):
      iio: core: add separate lockdep class for info_exist_lock

Thorsten Blum (1):
      iio: adc: pac1934: Fix clamped value in pac1934_reg_snapshot

Tomas Melin (1):
      iio: adc: ad9467: fix ad9434 vref mask

 drivers/iio/accel/adxl380.c                      |  6 +-
 drivers/iio/accel/st_accel_core.c                | 72 ++++++++++++++++++++=
+++-
 drivers/iio/adc/ad7280a.c                        |  4 +-
 drivers/iio/adc/ad7606_par.c                     |  3 +-
 drivers/iio/adc/ad9467.c                         |  2 +-
 drivers/iio/adc/at91-sama5d2_adc.c               |  1 +
 drivers/iio/adc/exynos_adc.c                     | 15 +----
 drivers/iio/adc/pac1934.c                        |  6 +-
 drivers/iio/chemical/scd4x.c                     |  6 +-
 drivers/iio/dac/ad3552r-hs.c                     |  5 +-
 drivers/iio/dac/ad5686.c                         |  6 ++
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c |  9 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c     | 15 +++--
 drivers/iio/industrialio-core.c                  |  4 +-
 include/linux/iio/iio-opaque.h                   |  2 +
 15 files changed, 120 insertions(+), 36 deletions(-)

