Return-Path: <linux-iio+bounces-24390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807CBB9917C
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 11:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9774C1C32
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC0F2D7DD2;
	Wed, 24 Sep 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjDd1RSB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55601990D9;
	Wed, 24 Sep 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705847; cv=none; b=lLy3nEitzqpEnXc4NklLfMJBGDGPDUE67j/rKW4hPBHIM0vwudyzuu3pqJy93fbpegioQ60c8OgcncUXU3LS6liExceCmiKUm42X10YPs769Hauv3sqfEOKcfTv4VIjhxcFXecRC72Fu3Y1cx9gczxUPf78XYa5p3dVpS53O7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705847; c=relaxed/simple;
	bh=AmVomRMWOKA07HoZeGaejlDATFCNyFNvT6ODgLF3w8U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u25Ubps2mbfFayq8adUhkxdpxErONpFI5OEqaVQKI/uJgeZaO+z4Fs4Aa4rBntd233g941vzFDfuIR/qKyrnxMnDc30lbWJPma9esT+EKwB/lsHR7ujKSh7kI9TE+WJvFt2KfleeiJij4nJmTY7THSoyfgBDxhPxEar173NF2jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjDd1RSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B13DC2BC87;
	Wed, 24 Sep 2025 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758705847;
	bh=AmVomRMWOKA07HoZeGaejlDATFCNyFNvT6ODgLF3w8U=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YjDd1RSBeej1vgm0HIpLlqOPWC5mo4mHcvk9Nlu1Y0V1QC/zPV+9T38cS8jI8FjC9
	 CR0rdA0qpuR2aULs/7ELEb2jxyKTeJkiU1tgIr+GsRJfYaFU8U92uqnFU24qFXGuBG
	 gjfgDtrqe/lFM+Mp39OtzNGbbJqIPdASwjdTjAl9L6jbVBviWUns8hN1JNB6nigRHH
	 CdnrRkrk5UUsawrUP1FUREH0sT4RVdi0iUvzuDBWRtIMkpK1oA6Tmfqdrm7eWQeFYC
	 uFI3C9TOxgMgVHuqd8vq6Qz6XntkFcKPUhlUERMK1FimjwqqYFIk0HXDAJ5YV7ZSnB
	 /tixm9z124COw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D28CAC5B0;
	Wed, 24 Sep 2025 09:24:07 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Subject: [PATCH v6 0/9] iio: imu: new inv_icm45600 driver
Date: Wed, 24 Sep 2025 09:23:53 +0000
Message-Id: <20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKm402gC/33PTWrDMBAF4KsErasyM9aPlVXvUUKwpVEjSu0gG
 6Ul+O5VsnEaTJfvwXyPuYqJc+JJ7HdXkbmkKY1DDeZlJ/ypGz5YplCzICANClF2IRwHvpzHPB9
 DToWz1OR81L1F7lpRD8+ZY/q+o++Hmk9pmsf8c98oeGv/5QpKkKihJTTQA7q3OXy++vFL3LBCK
 2ARNgGqQB+tCS0q4kh/geYRsJtAUwFvwDkG8to8AWoF6sAmoCqglFG9MQDOPgH6AaDtF3QFKHo
 XsQkhMK/Asiy//yTmY7YBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758705845; l=7060;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=AmVomRMWOKA07HoZeGaejlDATFCNyFNvT6ODgLF3w8U=;
 b=86P2nFjgQCl+1daKHRPCbB2Uoz+PiVQx0Sb5/6cCm0OO+aPJfwJ2Lsk39zGalF8FCCyjLKX5k
 kmS67pJMJjvCICRwL3bt/Aopd8450eM7NdkF1WvkTsPrHlIp8AvmLLm
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
different ODRs. Since there is only a single FIFO a specific value is used
to mark invalid data. To keep the device standard we are de-multiplexing
data from the FIFO to 2 IIO devices with 2 buffers, 1 for the accelerometer
and 1 for the gyroscope. This architecture also enables to easily turn each
sensor on/off without impacting the other. The device interrupt is used to
read the FIFO and launch parsing of accelerometer and gyroscope data.
This driver relies on the common Invensense timestamping mechanism to
handle correctly FIFO watermark and dynamic changes of settings.

The structure of the driver is quite similar to the inv_icm42600 driver,
however there are significant reasons for adding a different driver for
inv_icm45600, such as:
- A completely different register map.
- Different FIFO management, based on number of samples instead of bytes.
- Different indirect register access mechanism.

Note that regmap cache will be added in a dedicated patch set, to avoid
increasing too much this one.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
Changes in v6:
- Reviewed headers inclusion
- Formatting (line too short, ...)
- moving code to patch it belongs
- kernel doc fixes
- Comments reviewed and simplified
- removed dev_error_probe with ENOMEM
- fixed useless ssize_t to size_t
- removed useless pack attribute
- Fixed unclear or malformed if
- Removed useless fifo_is_data_valid wrapper
- Use available macros instead of hardcoded values
- Link to v5: https://lore.kernel.org/r/20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com

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
 drivers/iio/imu/inv_icm45600/inv_icm45600.h        | 385 ++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c  | 782 ++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 560 ++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h |  97 ++
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 990 +++++++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c   | 791 ++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c    |  98 ++
 drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c    |  78 ++
 drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c    | 107 +++
 15 files changed, 4074 insertions(+)
---
base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
change-id: 20250411-add_newport_driver-529cf5b71ea8

Best regards,
-- 
Remi Buisson <remi.buisson@tdk.com>



