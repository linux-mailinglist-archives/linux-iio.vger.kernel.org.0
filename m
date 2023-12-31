Return-Path: <linux-iio+bounces-1337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B70820C80
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 19:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70E51C20854
	for <lists+linux-iio@lfdr.de>; Sun, 31 Dec 2023 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D2653BE;
	Sun, 31 Dec 2023 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDj0QYLK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E89447
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D21C433C7;
	Sun, 31 Dec 2023 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047721;
	bh=zR+VSFGdd9JYGxdxdD1E6fApKrotKZfj0AwFiuKMmeE=;
	h=From:To:Cc:Subject:Date:From;
	b=iDj0QYLKNCyZW5NpnxZJHrxaXFisvXnSFMJWzvfmjY1G+f8Hka5R3YsUklJsMwxKO
	 nxBVIlxrbyR5V2ZgM5YRSsdu3aT5yI4Q09fbSu4FJ9TeloTZXTFm728sYLHR4TMWmS
	 8cGiDCmHyReZE2vjQSQX8gEv/JU/awHAnofT6f+GutartB1Zw3d7L4lS23/17Et7pu
	 fqw22ugZq+EN3G9kJjZSXHzZFrDaks9Urz0rMTheBRrBBaFIpuE4rJt0HC5FYADY5i
	 THn0KxsyNOPntWHe4+NM6avG3kojt8x9PCk/oOvK14vodu7fwzNi1XTXnQnoMfcWTE
	 ZsDecHiU3QtWw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/24] IIO: Clean up ACPI_PTR() usage.
Date: Sun, 31 Dec 2023 18:34:50 +0000
Message-ID: <20231231183514.566609-1-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Many of these patches touch ancient drivers so the authors have long
moved on to other things. As such I'd appreciate it if anyone has time
to take a look!

The initial part of this series deals with cases where unused variable
warnings are generated with !CONFIG_ACPI but they most date back long
enough to predate this being reported by lkp in general and the lkp folk
have gotten push back not to push out such reports due to the high level
of noise. I think some of these were reported to me directly on my
Huawei.com account but aren't on lore.kernel.org. If I can easily
track down appropriate closes tags I will add them when applying.

The last few patches are for drivers that did have the right protections
but where the usage was so trivial I'm not convinced they took the best
approach. In the interests of not leaving cases of what I consider an
undesirable pattern around for people to copy I have dropped the ACPI_PTR()
usage and config guards from those as well.

There are 3 remaining cases of ACPI_PTR() in IIO. In each of those there
is a significant chunk of ACPI specific handling so the relevant guards
are there anyway and the complexity is more easily justified. I have
not intent to touch those at this time.

Jonathan Cameron (24):
  iio: accel: da280: Stop using ACPI_PTR()
  iio: accel: kxcjk-1013: Move acpi_device_id table under ifdef
    CONFIG_ACPI
  iio: accel: mma9551: Drop ACPI_PTR() usage
  iio: accel: mma9553: Drop ACPI_PTR() usage
  iio: accel: mxc4005: Drop ACPI_PTR() usage
  iio: accel: mxc6255: Drop ACPI_PTR() usage
  iio: accel: stk8ba50: Drop ACPI_PTR() usage
  iio: accel: bmc150: Drop ACPI_PTR()
  iio: gyro: bmg160: Drop ACPI_PTR() usage
  iio: humidity: hts221: Drop ACPI_PTR() usage
  iio: imu: fxos8700: Drop ACPI_PTR() usage
  iio: imu: kmx61: Drop ACPI_PTR() usage
  iio: light: jsa1212: Drop ACPI_PTR() usage
  iio: light: ltr501: Drop ACPI_PTR() usage
  iio: light: rpr0521: Drop ACPI_PTR() usage
  iio: light: stk3310: Drop ACPI_PTR() usage
  iio: light: us5182d: Drop ACPI_PTR() usage
  iio: magnetometer: bmc150: Drop ACPI_PTR() usage
  iio: magnetometer: mmc35240: Drop ACPI_PTR() usage
  iio: potentiometer: max5487: Drop ACPI_PTR() usage
  iio: st_sensors: drop ACPI_PTR() and CONFIG_ACPI guards
  iio: pressure: hp206c: drop ACPI_PTR() and CONFIG_ACPI guards
  iio: light: max44000: drop ACPI_PTR() and CONFIG_ACPI guards
  iio: adc: ti-adc109s102: drop ACPI_PTR() and CONFIG_ACPI guards

 drivers/iio/accel/bmc150-accel-i2c.c       |  2 +-
 drivers/iio/accel/bmc150-accel-spi.c       |  3 +-
 drivers/iio/accel/da280.c                  |  2 +-
 drivers/iio/accel/kxcjk-1013.c             | 33 +++++++++++-----------
 drivers/iio/accel/mma9551.c                |  4 +--
 drivers/iio/accel/mma9553.c                |  4 +--
 drivers/iio/accel/mxc4005.c                |  4 +--
 drivers/iio/accel/mxc6255.c                |  4 +--
 drivers/iio/accel/st_accel_i2c.c           |  5 +---
 drivers/iio/accel/stk8ba50.c               |  4 +--
 drivers/iio/adc/ti-adc108s102.c            |  4 +--
 drivers/iio/gyro/bmg160_i2c.c              |  4 +--
 drivers/iio/humidity/hts221_i2c.c          |  4 +--
 drivers/iio/imu/fxos8700_i2c.c             |  3 +-
 drivers/iio/imu/fxos8700_spi.c             |  3 +-
 drivers/iio/imu/kmx61.c                    |  2 +-
 drivers/iio/light/jsa1212.c                |  4 +--
 drivers/iio/light/ltr501.c                 |  3 +-
 drivers/iio/light/max44000.c               |  6 ++--
 drivers/iio/light/rpr0521.c                |  4 +--
 drivers/iio/light/stk3310.c                |  4 +--
 drivers/iio/light/us5182d.c                |  4 +--
 drivers/iio/magnetometer/bmc150_magn_i2c.c |  3 +-
 drivers/iio/magnetometer/bmc150_magn_spi.c |  3 +-
 drivers/iio/magnetometer/mmc35240.c        |  4 +--
 drivers/iio/potentiometer/max5487.c        |  4 +--
 drivers/iio/pressure/hp206c.c              |  6 ++--
 drivers/iio/pressure/st_pressure_i2c.c     |  5 +---
 28 files changed, 60 insertions(+), 75 deletions(-)

-- 
2.43.0


