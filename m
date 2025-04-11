Return-Path: <linux-iio+bounces-17950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42374A85EF9
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908A94A44E0
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DE31DC198;
	Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB2z5jxh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936FB1C84BC;
	Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378122; cv=none; b=cx3MUmhgo0jZ1ezuBOnUEeb+150sRmIIwK7ipvHgJfWVnZumf8q5IWuWN7VtMpIFHq+5zG7xwYlAOqcVir9i8ghH/UTYzCK/k0I08K3a5J5xLtWdcG+NZAs6l3ZInRrcFasF4ar4rWnK+0b8H1zR1OAlaiWUcxZ2SNjpMxV/6pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378122; c=relaxed/simple;
	bh=06F3uWhubW/MmNs70dPjAwsBGFSu4UP7REe4gzXRvrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVIQFca2pNpp8oeJZvrN79sHeusTWC32A9vOb61Hif47Bi3cNHlVTP58kndnvJnN93pE73xPeA2/nfoIYFSkZ2VbhK31Ch7Bl8CiCf1gT1ymC92zHkF+9rpe7uE6+43Qx97lkfthFUAQfh1RnSEYNH9Mk0mQ7SOAP4V1Fej7ENI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB2z5jxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE666C4CEFB;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744378121;
	bh=06F3uWhubW/MmNs70dPjAwsBGFSu4UP7REe4gzXRvrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AB2z5jxhDYDnx+mAZAbLs6h67qSfstJEns1HckWAOu0+x9WZxhbQfF3PX7b45eefO
	 7I6PX643rGFMs3mCkrxZHHtfnLyAncPHtHdEdqB5q9VvbZ8W+/pBnWimMH2EKjzTpV
	 m8+oWCASG7ka1KDwFYdtcmbd7F+XowcQlxqC02sByGIq8EtDuSwYF9I5KMSUATfaOe
	 uB0FQPc7x/YzieldKM52juGBPsX088Xn7MbEAq3z3MHipMfvEOQdDwG8YCn+nK4qKn
	 oEOANgDCcRQQ4hESAQrElQ4JQHODH0R68t+VptyM+GyfKl/Lx7ha4VcDdR05o523wZ
	 Apu4bI7eqdhxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F6AC369B1;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Fri, 11 Apr 2025 13:28:38 +0000
Subject: [PATCH 6/8] iio: imu: add Kconfig and Makefile for inv_icm45600
 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-add_newport_driver-v1-6-15082160b019@tdk.com>
References: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
In-Reply-To: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744378119; l=4140;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=JKi2GN1rX4ptrduYYDNWdyAYIQv9H73qs4FmqmLloQw=;
 b=/TXZTOwq25RwAGuqKUwN+ZtntsPPAgi8phGEgNImREFZdnkwGsxs6M44j1HgXhFIVxc41u4Hc
 K+VDRjApQERBtMJkC2O9bT+vgPICtUnF+dcq5R1ht8xr2zyoB9jD58+
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Add 4 modules:
- inv-icm45600
- inv-icm45600-i2c
- inv-icm45600-spi
- inv-icm45600-i3c.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 drivers/iio/imu/Kconfig               |  1 +
 drivers/iio/imu/Makefile              |  1 +
 drivers/iio/imu/inv_icm45600/Kconfig  | 70 +++++++++++++++++++++++++++++++++++
 drivers/iio/imu/inv_icm45600/Makefile | 17 +++++++++
 4 files changed, 89 insertions(+)

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 15612f0f189b5114deb414ef840339678abdc562..9d732bed9fcdac12a13713dba3455c1fdf9f4a53 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -109,6 +109,7 @@ config KMX61
 	  be called kmx61.
 
 source "drivers/iio/imu/inv_icm42600/Kconfig"
+source "drivers/iio/imu/inv_icm45600/Kconfig"
 source "drivers/iio/imu/inv_mpu6050/Kconfig"
 
 config SMI240
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index e901aea498d37e5897e8b71268356a19eac2cb59..2ae6344f84699b2f85fff1c8077cb412f6ae2658 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_FXOS8700_I2C) += fxos8700_i2c.o
 obj-$(CONFIG_FXOS8700_SPI) += fxos8700_spi.o
 
 obj-y += inv_icm42600/
+obj-y += inv_icm45600/
 obj-y += inv_mpu6050/
 
 obj-$(CONFIG_KMX61) += kmx61.o
diff --git a/drivers/iio/imu/inv_icm45600/Kconfig b/drivers/iio/imu/inv_icm45600/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..4fade8852a0dcf54df2bbd67b9269ed2c59f8699
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/Kconfig
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config INV_ICM45600
+	tristate
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
+	select IIO_INV_SENSORS_TIMESTAMP
+
+config INV_ICM45600_I2C
+	tristate "InvenSense ICM-456xx I2C driver"
+	depends on I2C
+	select INV_ICM45600
+	select REGMAP_I2C
+	help
+	  This driver supports the InvenSense ICM-456xx motion tracking
+	  devices over I2C.
+	  Supported devices:
+	  - ICM-45605
+	  - ICM-45686
+	  - ICM-45688-P
+	  - ICM-45608
+	  - ICM-45634
+	  - ICM-45689
+	  - ICM-45606
+	  - ICM-45687
+
+	  This driver can be built as a module. The module will be called
+	  inv-icm45600-i2c.
+
+config INV_ICM45600_SPI
+	tristate "InvenSense ICM-456xx SPI driver"
+	depends on SPI_MASTER
+	select INV_ICM45600
+	select REGMAP_SPI
+	help
+	  This driver supports the InvenSense ICM-456xx motion tracking
+	  devices over SPI.
+	  Supported devices:
+	  - ICM-45605
+	  - ICM-45686
+	  - ICM-45688-P
+	  - ICM-45608
+	  - ICM-45634
+	  - ICM-45689
+	  - ICM-45606
+	  - ICM-45687
+
+	  This driver can be built as a module. The module will be called
+	  inv-icm45600-spi.
+
+config INV_ICM45600_I3C
+	tristate "InvenSense ICM-456xx I3C driver"
+	depends on I3C
+	select INV_ICM45600
+	select REGMAP_I3C
+	help
+	  This driver supports the InvenSense ICM-456xx motion tracking
+	  devices over I3C.
+	  Supported devices:
+	  - ICM-45605
+	  - ICM-45686
+	  - ICM-45688-P
+	  - ICM-45608
+	  - ICM-45634
+	  - ICM-45689
+	  - ICM-45606
+	  - ICM-45687
+
+	  This driver can be built as a module. The module will be called
+	  inv-icm45600-i3c.
diff --git a/drivers/iio/imu/inv_icm45600/Makefile b/drivers/iio/imu/inv_icm45600/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..0fd6fbce0286f24504dbfe71925f9c35e717c446
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-$(CONFIG_INV_ICM45600) += inv-icm45600.o
+inv-icm45600-y += inv_icm45600_core.o
+inv-icm45600-y += inv_icm45600_gyro.o
+inv-icm45600-y += inv_icm45600_accel.o
+inv-icm45600-y += inv_icm45600_temp.o
+inv-icm45600-y += inv_icm45600_buffer.o
+
+obj-$(CONFIG_INV_ICM45600_I2C) += inv-icm45600-i2c.o
+inv-icm45600-i2c-y += inv_icm45600_i2c.o
+
+obj-$(CONFIG_INV_ICM45600_SPI) += inv-icm45600-spi.o
+inv-icm45600-spi-y += inv_icm45600_spi.o
+
+obj-$(CONFIG_INV_ICM45600_I3C) += inv-icm45600-i3c.o
+inv-icm45600-i3c-y += inv_icm45600_i3c.o

-- 
2.34.1



