Return-Path: <linux-iio+bounces-21739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EA5B08E1E
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 15:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D221E1AA4391
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 13:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8692E543B;
	Thu, 17 Jul 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkUQ1Iur"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9748298CD7;
	Thu, 17 Jul 2025 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758765; cv=none; b=sjZhQkLxgngfjbGb47AIKpGXSbQqwrE1pQVrEnFPZsNxm61Vu2+K240hb71JlY2AnFZT2uVF0H022tOgAtexHpsVBV3YRDPbZpX2ImZ2xmMkGX+le4sZmnnmAGrsaC9JXGxjZcLFj7w0F14IEUAckFWbY0CEpINpDZY18KBctl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758765; c=relaxed/simple;
	bh=xiST/0tFbj3wkN1Bt6VeFoMC8jlzdI9atHh74hSqjyI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lT5xKBK5SBFUAi8sRp9W+UiL3w3FiiZQ9VlSAywb0n5NcxzZRZvD9Rtj5FOZ2YecG9tBQxpKsbx2KZn9Pbu0nvvOzo08bvn1Y/z0h5Ba43+bujdidhMyaMU4rrAs7lw8UlcTKVmvUbYzLlgxuNRFuUy7lTih89OlW/Wxl7EWi6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkUQ1Iur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70233C4CEE3;
	Thu, 17 Jul 2025 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752758764;
	bh=xiST/0tFbj3wkN1Bt6VeFoMC8jlzdI9atHh74hSqjyI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=KkUQ1IurRRnQghrrXd7j9oKJgr7P/WcADtbrFcUIysrMaSIaCyK9lFxM5drxUptfz
	 9m9r2fdSlQ/oJCjJ6V/vZ6oUuhnB8llT6NB3TSIN7VWDMkhazhvwZ15BJ8isyXDHyd
	 X30RWNVI6t/ANhbObsDkTz9gRFOKNnnl8En7TQ8g4Lr66YgtrOu1d50O7fl7RfEV2B
	 LN7GiQvxRveH8E9Kh9k1gdxvSzrhLu/fpLhorJMbtdGA8pl1STmey+qinmyeLvQjAo
	 HWIf3Ua1+jYsBZQvDDR/4jGC3ftiLUYqnIl1sKdyG8CYDSzb54REXfS4v5TwmFjJv4
	 NC92fKXSiIdxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDC6C83F34;
	Thu, 17 Jul 2025 13:26:04 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Subject: [PATCH v3 0/8] iio: imu: new inv_icm45600 driver
Date: Thu, 17 Jul 2025 13:25:52 +0000
Message-Id: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOD5eGgC/33NTQ6CMBCG4auQrq3pjJQfV97DGAJ0Ko2xJS2pG
 sLdLWzYGJfvl8wzMwvkDQV2zmbmKZpgnE1xOmSsH1p7J25UaoYCpcgBeKtUY+k1Oj81yptInku
 sey27EqitWDocPWnz3tDrLfVgwuT8Z/sRYV3/chG44CBFhVCITkB9mdTj2LsnW7GIO1CC+AlgA
 jpdFqqCHEnjDizL8gX3/66W8wAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752758762; l=4957;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=xiST/0tFbj3wkN1Bt6VeFoMC8jlzdI9atHh74hSqjyI=;
 b=rxRjbWuEQSYj6mo9BV1HiZv9ZPMsPV/44fOdtt9OacKRZavLJvt1TwU/LRVat8OSsq/wcV65H
 xw/0XrMgWJAD3Ai21zY21xrPkR0U+KiGl8VvseTdkS31CujLs280gXV
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
Remi Buisson (8):
      dt-bindings: iio: imu: Add inv_icm45600
      iio: imu: inv_icm45600: add new inv_icm45600 driver
      iio: imu: inv_icm45600: add buffer support in iio devices
      iio: imu: inv_icm45600: add IMU IIO devices
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
 drivers/iio/imu/inv_icm45600/inv_icm45600.h        | 379 ++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c  | 798 +++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 585 ++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h | 101 +++
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 994 +++++++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c   | 809 +++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c    |  98 ++
 drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c    |  82 ++
 drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c    | 106 +++
 15 files changed, 4145 insertions(+)
---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250411-add_newport_driver-529cf5b71ea8

Best regards,
-- 
Remi Buisson <remi.buisson@tdk.com>



