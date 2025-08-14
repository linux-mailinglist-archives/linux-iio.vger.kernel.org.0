Return-Path: <linux-iio+bounces-22720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E9CB2600A
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 11:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF21A2399E
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 09:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED632FC88B;
	Thu, 14 Aug 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1M5L1Rl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ECD2E8E1A;
	Thu, 14 Aug 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161844; cv=none; b=ifQvcw/8F8cZ5gHjNtHMrhZ9g3lybbrLwQl0xQCFCI909O7l7IlsGG3P/+5+0N4T3NqNne3T451P40lfIUX2NS3Qx8OmyZVFkX00c/P+1R3+/bM10F7S42mkP4OIb0RhKVc7igVANWB3YfcWtpc3AK8R+Ad5PkxlseTDGYQfU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161844; c=relaxed/simple;
	bh=Hb3GQT7RM484Hhe4IsbAEUh4pInqFElRKBofBQsMNaU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gxpgTnDYkgjFD4uBeKEdS8eIP3qOSf008eOndhfeRXitdlNndZyAkfJ1f5v1BaOeslrv/8w433SLPzSrA8Hv2tXSXA+2MxnJF1tDTpE4xOYF39T1wuDBfryZQktF3LTZ4v5VCClrXf/BgdU9RH4rxlskpZ23jW4Ot/DdI6z5nm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1M5L1Rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03ECFC4CEED;
	Thu, 14 Aug 2025 08:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755161844;
	bh=Hb3GQT7RM484Hhe4IsbAEUh4pInqFElRKBofBQsMNaU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=q1M5L1Rl9aP/Gaa0NAVxb9uEdiAVTL26Y2PBsMUnMvGcQKqtHtG0lFjiLqyy6L7QB
	 vL5KUIOJMhBn3zMoBftahBWWQbGvL4sOTjff7FljrvHEpeZncHP6kmA3rv82ubijV3
	 E7PUhn5r+YKExmJ05K3zDt4PdwyjpYYKgJWjjkedsHGxPuzHcXmux97Nc9rYpBABnv
	 6TbYDd9uShtiTJYd4JQiOurv0V5xOTOCVG0gdFAkW05FO2Q7cgUE2XuFMIdrxyaJ8Z
	 YQW62wWetO5Azv6hEbT6FhiX4wCDJqCeVmUhNKE3PEf8xQxNZ4ZVpVlSI2UusdA4UP
	 G7iaDyDk9xloQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88E0CA0ED1;
	Thu, 14 Aug 2025 08:57:23 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Subject: [PATCH v4 0/9] iio: imu: new inv_icm45600 driver
Date: Thu, 14 Aug 2025 08:57:14 +0000
Message-Id: <20250814-add_newport_driver-v4-0-4464b6600972@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOqknWgC/33NQQrCMBCF4atI1kZmxiZtXXkPkdImUw1iK0mJS
 undTbtRQVz+D+abUQT2joPYrUbhObrg+i5Ftl4Jc667E0tnUwsCUpAhytraquP7rfdDZb2L7KW
 i0rSqyZHrQqTDm+fWPRb0cEx9dmHo/XP5EXFe/3IRJUhUUBBqaADL/WAvG9NfxYxFegM5wk+AE
 tC0ubYFZsQtfQPbTyD/CWwTYDSUJQMZpT+AaZpedMP2zTQBAAA=
X-Change-ID: 20250411-add_newport_driver-529cf5b71ea8
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755161842; l=5665;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=Hb3GQT7RM484Hhe4IsbAEUh4pInqFElRKBofBQsMNaU=;
 b=G9d2+kE1NstKzluSFNrswItyJYPG/nXXlDWZgeck8s4e0kkfxaloRdb7ZoiiLtcv5Ioh1hMOa
 i8TLaUisaMxAe7Y3kPzc+UzCsFu7QKCViSR2PkO3UW5Cy2/sB037nRU
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

This series add a new driver for managing InvenSense ICM-456xx 6-axis IMUs.
This next generation of chips includes new generations of 3-axis gyroscope
and 3-axis accelerometer, support of I3C in addition to I2C and SPI, and
intelligent MotionTracking features like pedometer, tilt detection, and
tap detection.

This series is delivering a driver supporting gyroscope, accelerometer and
temperature data, with polling and buffering using hwfifo and watermark,
on I2C, SPI and I3C busses.

Gyroscope and accelerometer sensors are completely independent and can have
different ODRs. Since there is only a single FIFO a specific value is used to
mark invalid data. For keeping the device standard we are de-multiplexing data
from the FIFO to 2 IIO devices with 2 buffers, 1 for the accelerometer and 1
for the gyroscope. This architecture also enables to easily turn each sensor
on/off without impacting the other. The device interrupt is used to read the
FIFO and launch parsing of accelerometer and gyroscope data. This driver
relies on the common Invensense timestamping mechanism to handle correctly
FIFO watermark and dynamic changes of settings.

The structure of the driver is quite similar to the inv_icm42600 driver,
however there are significant reasons for adding a different driver for
inv_icm45600, such as:
- A completely different register map.
- Different FIFO management, based on number of samples instead of bytes.
- Different indirect register access mechanism.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
Changes in v4:
- Introduce gyro and accel in different patches.
- Move IRQ probe to next patch.
- Allocate fifo memory instead of static definition.
- Rework VDDIO management to avoid underflow.
- Rework suspend/resume using force suspend/resume API.
- Use helper min, clamp and sizeof instead of custom implementation.
- Re-scoping some variables, using reverse xmas tree for declarations.
- Fix formatting: end of list, end of file, spaces, alignments.
- Use dev_err_probe for I3C errors.
- Factorizing default config code.
- Link to v3: https://lore.kernel.org/r/20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com

Changes in v3:
- Macros renamed and added to the patch using it.
- Using unsigned for sensor configuration parameters.
- Using sizeof instead of raw values.
- Using fsleep instead of usleep.
- Simplified dt-bindings examples, setting supplies as mandatory
- Fix bad or useless casts.
- Partially aligned power management following 20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com
- Fix "uninitialized symbols" warnings.
- Link to v2: https://lore.kernel.org/r/20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com

Changes in v2:
- Reworked patches order and content to ease review and make sure everything compiles
- Reworked gyro and accel FSR as 2D arrays
- Moved temperature processed sensor to core module
- Use latest API to claim/release device
- Implemented chip_info structure instead of relying on an enum
- Removed power-mode ABI, only relying on ODR to switch power_mode
- Reworked regulator control to use devm_ API where relevant
- Reworked inv_icm45600_state.buffer as a union to avoid casts, using getter/setter instead of memcpy
- Fixed dt-binding error and moved patch at the beginning of the patch-set
- Reworked macros to use FIELD_PREP inline instead of inside the header
- Fixed comment's grammar
- Removed extra blank lines
- Reordered part numbers alphanumerically
- Removed useless default/error fallbacks
- Typed accel, gyro and timestamp data when parsing FIFO
- Fixed I2C module return code
- Use Linux types instead of C standard
- Reviewed headers inclusion to remove useless #include and to add missing ones
- Link to v1: https://lore.kernel.org/r/20250411-add_newport_driver-v1-0-15082160b019@tdk.com

---
Remi Buisson (9):
      dt-bindings: iio: imu: Add inv_icm45600
      iio: imu: inv_icm45600: add new inv_icm45600 driver
      iio: imu: inv_icm45600: add buffer support in iio devices
      iio: imu: inv_icm45600: add IMU IIO gyroscope device
      iio: imu: inv_icm45600: add IMU IIO accelerometer device
      iio: imu: inv_icm45600: add I2C driver for inv_icm45600 driver
      iio: imu: inv_icm45600: add SPI driver for inv_icm45600 driver
      iio: imu: inv_icm45600: add I3C driver for inv_icm45600 driver
      MAINTAINERS: add entry for inv_icm45600 6-axis imu sensor

 .../bindings/iio/imu/invensense,icm45600.yaml      |  97 ++
 MAINTAINERS                                        |   8 +
 drivers/iio/imu/Kconfig                            |   1 +
 drivers/iio/imu/Makefile                           |   1 +
 drivers/iio/imu/inv_icm45600/Kconfig               |  70 ++
 drivers/iio/imu/inv_icm45600/Makefile              |  16 +
 drivers/iio/imu/inv_icm45600/inv_icm45600.h        | 380 ++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c  | 781 +++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 572 ++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h | 101 +++
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 976 +++++++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c   | 792 +++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c    |  98 +++
 drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c    |  77 ++
 drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c    | 106 +++
 15 files changed, 4076 insertions(+)
---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250411-add_newport_driver-529cf5b71ea8

Best regards,
-- 
Remi Buisson <remi.buisson@tdk.com>



