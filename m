Return-Path: <linux-iio+bounces-2404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AD7850A5C
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 17:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A181F21D42
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594DF5B669;
	Sun, 11 Feb 2024 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKNyV6oN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF332F3E
	for <linux-iio@vger.kernel.org>; Sun, 11 Feb 2024 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707670156; cv=none; b=M7jXu4bGz9bDRsrKbPN8C4tFSvGvgp2vdNKP7phTXrdlPszQvCgnmno95XJiLC0rQ8/X/OnNxoTybPa4rPXGsgjfJxvXP8lXg5L8lW4CYKFoL5jOwo4dUuZjY4lV5a1ztiZ/B39VgB/Yxgb8DDJRGJT6euhvrVp02zKcn5SCcZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707670156; c=relaxed/simple;
	bh=cibO25HNZiLkQ4xT5QSCAH64MH/3RLKpw7hbUHBGluA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=pjS2YVNCqvnmm4HTU6Pd4ND2PCbJBCmH4K3pTUMt8CL+5rdIFCxnwhQvoVnExxmb1UKqDgjcIbgX/D3dHfaRHDP+sjZfZ3jl9z74PUw2qSn1rt/7MonW1Yc9SGVOnWLSUYQM+PTmepo/BpWCNhQHPWaF2Z9cD1U8+Espk6B6NhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKNyV6oN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC37C433F1;
	Sun, 11 Feb 2024 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707670155;
	bh=cibO25HNZiLkQ4xT5QSCAH64MH/3RLKpw7hbUHBGluA=;
	h=Date:From:To:Subject:From;
	b=TKNyV6oNllclrnE/HRah70K2A4HuHtqFE2QNqB5trJLFMyiEXKtCC0tB/aMOXcyZm
	 41620vGw5oec2laa7YHLJiYHnu+QWLOrEQi3Qpocv79Nu+7Z3E6w9VPAcrGVivM09u
	 N9gRzI/czrM+KZAF11lpwMyAcWQmNOku+nPekZteZLVx2eyPH3vYDH5T7tUgWGkoDT
	 hkj3RfrIOO3SygReZ/aI5uitsjcgL8jiPaaM/dBaNeoa6+hu3HWOLCC/OKqcxIr7b0
	 VuLlHBW5WwbdoxkkUvMjj6U0V0QpMHKWZFlJHxxvezHvmHKCrNX1L46Gt2kGRSBroD
	 4OwTXTB/bZOVQ==
Date: Sun, 11 Feb 2024 16:49:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of fixes for the 6.8 cycle.
Message-ID: <20240211164905.32fb8438@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.8a

for you to fetch changes up to 78367c32bebfe833cd30c855755d863a4ff3fdee:

  iio: adc: ad4130: only set GPIO_CTRL if pin is unused (2024-02-10 16:52:39 +0000)

----------------------------------------------------------------
IIO: 1st set of fixes for the 6.8 cycle

Usual mixed bag of issues introduced this cycle and fixes for long term
issues that have been identified recently + one case where I messed up
a merge resolution and dropped the build file changes.

Most important is the userspace ABI fix for the iio_modifier enum
where we accidentally added new entries in the middle rather than at
the end.

IIO Core
 - Close a memory leak in an error path.
 - Move LIGHT_UVA and LIGHT_UVB definitions to end of the iio_modifier
   enum to avoid breaking older userspace. (not yet in a released kernel
   thankfully).

adi,adis
 - Fix a DMA buffer alignment issue that was missing in series that fixed
   these across IIO.

adi,ad-sigma-delta
 - Fix a DMA buffer alignment issue that was missing in series that fixed
   these across IIO.

adi,ad4130
 - Zero init remaining fields of clock init data.
 - Only set GPIO control bits on pins that aren't in use for anything else.

adi,ad5933
 - Fix an old bug due to type mismatch. This is a rare device so good to
   get some new test coverage.

adi,ad7091r
 - Use right variable for an error return code.

bosch,bma400
 - Add missing CONFIG_REGMAP_I2C dependency.

bosch,bmp280:
 - Add missing bmp085 ID to the SPI table to avoid mismatch with the
   of_device_id table.

hid-sensors:
 - Avoid returning an error for timestamp read back that succeeds.

pni,rm3100
 - Check value read from RM31000_REG_TMRC register is valid before using
   it. Hardening  to avoid a real world issue seen on some faulty hardware.

st,st-sensors
 - Fix a DMA buffer alignment issue that was missing in series that fixed
   these across IIO.

ti,hdc3020
 - Add missing Kconfig and Makefile entrees accidentally dropped when patches
   were applied.
 - Fix wrong temperature offset (negated)

----------------------------------------------------------------
Cosmin Tanislav (2):
      iio: adc: ad4130: zero-initialize clock init data
      iio: adc: ad4130: only set GPIO_CTRL if pin is unused

Dan Carpenter (1):
      iio: adc: ad7091r8: Fix error code in ad7091r8_gpio_setup()

David Schiller (1):
      staging: iio: ad5933: fix type mismatch regression

Dimitri Fedrau (1):
      iio: humidity: hdc3020: fix temperature offset

Dinghao Liu (1):
      iio: core: fix memleak in iio_device_register_sysfs

Javier Carrasco (1):
      iio: move LIGHT_UVA and LIGHT_UVB to the end of iio_modifier

Jonathan Cameron (1):
      iio: humidity: hdc3020: Add Makefile, Kconfig and MAINTAINERS entry

Mario Limonciello (1):
      iio: accel: bma400: Fix a compilation problem

Nuno Sa (3):
      iio: imu: adis: ensure proper DMA alignment
      iio: adc: ad_sigma_delta: ensure proper DMA alignment
      iio: commom: st_sensors: ensure proper DMA alignment

Randy Dunlap (1):
      iio: imu: bno055: serdev requires REGMAP

Sam Protsenko (1):
      iio: pressure: bmp280: Add missing bmp085 to SPI id table

Srinivas Pandruvada (1):
      iio: hid-sensor-als: Return 0 for HID_USAGE_SENSOR_TIME_TIMESTAMP

zhili.liu (1):
      iio: magnetometer: rm3100: add boundary check for the value read from RM3100_REG_TMRC

 MAINTAINERS                                     |  8 ++++++++
 drivers/iio/accel/Kconfig                       |  2 ++
 drivers/iio/adc/ad4130.c                        | 12 ++++++++----
 drivers/iio/adc/ad7091r8.c                      |  2 +-
 drivers/iio/humidity/Kconfig                    | 12 ++++++++++++
 drivers/iio/humidity/Makefile                   |  1 +
 drivers/iio/humidity/hdc3020.c                  |  2 +-
 drivers/iio/imu/bno055/Kconfig                  |  1 +
 drivers/iio/industrialio-core.c                 |  5 ++++-
 drivers/iio/light/hid-sensor-als.c              |  1 +
 drivers/iio/magnetometer/rm3100-core.c          | 10 ++++++++--
 drivers/iio/pressure/bmp280-spi.c               |  1 +
 drivers/staging/iio/impedance-analyzer/ad5933.c |  2 +-
 include/linux/iio/adc/ad_sigma_delta.h          |  4 +++-
 include/linux/iio/common/st_sensors.h           |  4 ++--
 include/linux/iio/imu/adis.h                    |  3 ++-
 include/uapi/linux/iio/types.h                  |  4 ++--
 17 files changed, 58 insertions(+), 16 deletions(-)

