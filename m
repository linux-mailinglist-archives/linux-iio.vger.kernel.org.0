Return-Path: <linux-iio+bounces-23057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DC4B2DF4A
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 16:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19741C20257
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0929276024;
	Wed, 20 Aug 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkzHMx6c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F8426FA5B;
	Wed, 20 Aug 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699885; cv=none; b=Q2p/IaUATwONqOQ5DZZbf4ytux/oB/3PmNoLdFCN/j+5/TDkRX//FEw/tWVUu0uz6iOAsjDS5cbFxKDteDjvcgvwLoNMuXwZaJ9508omqMGCJokT8f7Ce/1GccImBO04x6iFVP1rCYO7vZz90IPmfz6eKDcmKOGI6Hf7L02mdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699885; c=relaxed/simple;
	bh=FaJBnayLLeeHXIkZMFvhM3bi2xMW6chEyzv8fyYvAg8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=updku0G2KoLmh1Y+CHJWAuZgdU8sx2Fcu8zZ77MptsGg/zNarBTBf4hKyGqZuipBQw7EnT9Gng2Riiych7yzOsDHD5vPCo8ma9D/XMF36hBlBu1leUHyGtkGdtVW3IaINVJ/ocujv5+/9p3YqnQQgQ0xi44OFE4PKLRUBYmSpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkzHMx6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 432B3C4CEEB;
	Wed, 20 Aug 2025 14:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755699885;
	bh=FaJBnayLLeeHXIkZMFvhM3bi2xMW6chEyzv8fyYvAg8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gkzHMx6cFHuLRvblLm58t+avG3WRcHpshRCdxGdkKbS6fEANab1ESqzND3bdcC6nF
	 xzggHbCcVUCpbz22NMyZPzQmpyBNMzF05IyrR2iFT2DrFFXXpIniBCDfcMjqc7QsYg
	 KtROLFjq9l4xKC2Lr0Z5PZNLewVkW9LbSidWa0us/9wkCRNPVfs+d+86YJ8M6fj9ZS
	 If8x0Y6TxMpQQLnw5pnhmMRTxRvuPrZoqBMen90l9PaLVdseo5OuKCS0caGGLL9+M8
	 +8+8ifdFiLX7txBMNIRQ/wlkI6qytfqQDok2gNzkZyQRgNMHRVZX8bpf48xMca4VjZ
	 dA8YZr5hKn8sA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F9CCA0EED;
	Wed, 20 Aug 2025 14:24:45 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Subject: [PATCH v5 0/9] iio: imu: new inv_icm45600 driver
Date: Wed, 20 Aug 2025 14:24:18 +0000
Message-Id: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJLapWgC/33NTW7CMBCG4asgrzGaGfwTd9V7oAol9gQsRIKcy
 LRCuXudbIAq6vIdaZ7vIQZOkQfxsXmIxDkOse9K6O1G+HPdnVjGUFoQkAaFKOsQjh3fb30ajyH
 FzElqcr7VjUWuK1Eeb4nb+L2gh6/S5ziMffpZNjLO13+5jBIkaqgIDTSA7nMMl53vr2LGMj0Bi
 7AKUAGa1ppQoSJu6R3YvwJ2FdgXwBtwjoG8Nn8A9QTKwCqgCqCUUY0xAM6+ANM0/QK98Gj1dQE
 AAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755699883; l=6453;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=FaJBnayLLeeHXIkZMFvhM3bi2xMW6chEyzv8fyYvAg8=;
 b=R0vZ7Y3wJaWHzjP29xah7pfLZ6dcKw0HI4Ac2msXQYpB3/uNeqWGKENXA0npWdES4bG8QbWcp
 JaKg8GZsoVhAwgJkZoQ9gY/N7/Zgb0yHdm6pwtU5xhBkpFF19HKaMa7
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
Changes in v5:
- Simplified device tree, removed interrupts from mandatory param list
- Allocated regmap_bulk_read/write buffers to dma-capable memory (for indirect reg accesses)
- Use min/max to simplify code
- Reordered some code/include/prototypes to the patch they belong
- Updated to latest iio_push_to_buffers_with_ts API
- Fix build warning with clang 18.1.8
- Fixed some alignements
- Avoiding irq_type silly assignation
- Simplified fwnode_irq_get_byname error management
- Re-ordered suspend/resume process to match + comments
- Reverted VDDIO init to make it work without PM
- Avoid PM underflow on VDDIO when removing inv_icm456000 module, by checking suspend state
- Link to v4: https://lore.kernel.org/r/20250814-add_newport_driver-v4-0-4464b6600972@tdk.com

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

 .../bindings/iio/imu/invensense,icm45600.yaml      |  90 ++
 MAINTAINERS                                        |   8 +
 drivers/iio/imu/Kconfig                            |   1 +
 drivers/iio/imu/Makefile                           |   1 +
 drivers/iio/imu/inv_icm45600/Kconfig               |  70 ++
 drivers/iio/imu/inv_icm45600/Makefile              |  16 +
 drivers/iio/imu/inv_icm45600/inv_icm45600.h        | 380 ++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c  | 781 +++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 566 ++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h | 101 +++
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 969 +++++++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c   | 792 +++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c    |  98 +++
 drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c    |  77 ++
 drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c    | 106 +++
 15 files changed, 4056 insertions(+)
---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250411-add_newport_driver-529cf5b71ea8

Best regards,
-- 
Remi Buisson <remi.buisson@tdk.com>



