Return-Path: <linux-iio+bounces-21743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD625B08E26
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 15:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BE8166409
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 13:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1CF2E5B23;
	Thu, 17 Jul 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMWfkXWN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541592E54AD;
	Thu, 17 Jul 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758765; cv=none; b=OQQFUNsASSUqCgQQZtPhXB61+cPS3aM28RmH5S9PVOOI2hnL9YKYJ5hYCssyN4FXWE0rYLMMgqdka41NFZxf7jpyoI+ml/Qzv919hBHJiuzTfxHe/P2C6eo7JsM8+xD9cP4n8Ucumtoo8BLS53ZpXeB4/FzysmI4I4zQCQmYr9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758765; c=relaxed/simple;
	bh=c2IX8PPIIZJzerT/aw+ykeihrxVRi5Gp/7XdkvR+5kY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H4RKxbffXvyaY3OddOZRpVS91Txgz9kosiF3lcxcTbb7AFxyPAKrOf2Qq97XwO+J1bmUeiSYP6UMlL4gA1TaaGTlc8dKmyauLsnWeS3TI7sRFG5ikwFWofT5zRCGkwuJQfmCz2cLFSWI2NRYv0wGTNYtob+RpgWgMyc8/NVCOdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMWfkXWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C62CDC113D0;
	Thu, 17 Jul 2025 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752758764;
	bh=c2IX8PPIIZJzerT/aw+ykeihrxVRi5Gp/7XdkvR+5kY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JMWfkXWNI1bZD34Wj9G6fn6d4vUkCJirllS3rCwf+eppBISWZsmohDLQRP/QKfR0D
	 gBW1lQvkDcA0wZYEKJN1oiR4L/WJu2PU9UJCNFLy2WUCZm+11vFiX00C4CGcNfJQBn
	 3fQ6i2GqnIB1tbmzAU2zAre8Pmq+9cXYnk5ttcxofiFoIU+H3WadqmA1PXR8cnuLKT
	 5/UhHPefK2RYhgWtTobG7Qee3H4Vyc8slu3R7JL5SVnyHG9pqphLKsuHzcVBMiktJx
	 xhzxPhL5QL51ZCkr4FjxGGX4oNpjvKNfvs3HD+GX6axLI5rab7exdMRhb8IpKXWGyY
	 x6YIfpL35uJsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA1DC83F1A;
	Thu, 17 Jul 2025 13:26:04 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Thu, 17 Jul 2025 13:25:58 +0000
Subject: [PATCH v3 6/8] iio: imu: inv_icm45600: add SPI driver for
 inv_icm45600 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-add_newport_driver-v3-6-c6099e02c562@tdk.com>
References: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
In-Reply-To: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752758762; l=5474;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=hnED/tFv/crwWZzbfKEjfj7vI38mqj6A3J7aBo72i3g=;
 b=5xwdtZLnl2BughHOJdnesAXNVMNT1D9ueZrfoBiRs9sdWVLxXXJ9W4wa1pt8LgcydiWy9mHjQ
 Ni0DoBBW21/C/bst1gmoBa/Q40kIKKAecJXZyNF6VWe7k7dabXKcGCO
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Add SPI driver for InvenSense ICM-456000 devices.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 drivers/iio/imu/inv_icm45600/Kconfig            |  21 +++++
 drivers/iio/imu/inv_icm45600/Makefile           |   5 +-
 drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c | 106 ++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm45600/Kconfig b/drivers/iio/imu/inv_icm45600/Kconfig
index 5b044a954e952ffa8e44507eea42872e1f3161bc..01399d136a7ea3aa92a3a18ea455c95c0a6578b3 100644
--- a/drivers/iio/imu/inv_icm45600/Kconfig
+++ b/drivers/iio/imu/inv_icm45600/Kconfig
@@ -26,3 +26,24 @@ config INV_ICM45600_I2C
 
 	  This driver can be built as a module. The module will be called
 	  inv-icm45600-i2c.
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
+	  - ICM-45606
+	  - ICM-45608
+	  - ICM-45634
+	  - ICM-45686
+	  - ICM-45687
+	  - ICM-45688-P
+	  - ICM-45689
+
+	  This driver can be built as a module. The module will be called
+	  inv-icm45600-spi.
diff --git a/drivers/iio/imu/inv_icm45600/Makefile b/drivers/iio/imu/inv_icm45600/Makefile
index 371585e29e92e78a30c7d40c1389548fa22a999a..244cc8aa1f79e3367ac6925504cfd9d5b918a0e6 100644
--- a/drivers/iio/imu/inv_icm45600/Makefile
+++ b/drivers/iio/imu/inv_icm45600/Makefile
@@ -7,4 +7,7 @@ inv-icm45600-y += inv_icm45600_accel.o
 inv-icm45600-y += inv_icm45600_gyro.o
 
 obj-$(CONFIG_INV_ICM45600_I2C) += inv-icm45600-i2c.o
-inv-icm45600-i2c-y += inv_icm45600_i2c.o
\ No newline at end of file
+inv-icm45600-i2c-y += inv_icm45600_i2c.o
+
+obj-$(CONFIG_INV_ICM45600_SPI) += inv-icm45600-spi.o
+inv-icm45600-spi-y += inv_icm45600_spi.o
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c
new file mode 100644
index 0000000000000000000000000000000000000000..2fd4ecce24bd60aa2112e1bcae3f7196504df637
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2025 InvenSense, Inc. */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "inv_icm45600.h"
+
+static const struct regmap_config inv_icm45600_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int inv_icm45600_spi_bus_setup(struct inv_icm45600_state *st)
+{
+	/* Set slew rates for SPI. */
+	return regmap_update_bits(st->map, INV_ICM45600_REG_DRIVE_CONFIG0,
+				INV_ICM45600_DRIVE_CONFIG0_SPI_MASK,
+				FIELD_PREP(INV_ICM45600_DRIVE_CONFIG0_SPI_MASK,
+					INV_ICM45600_SPI_SLEW_RATE_5NS));
+}
+
+static int inv_icm45600_probe(struct spi_device *spi)
+{
+	const struct inv_icm45600_chip_info *chip_info;
+	struct regmap *regmap;
+
+	chip_info = spi_get_device_match_data(spi);
+	if (!chip_info)
+		return -ENODEV;
+
+	/* Use SPI specific regmap. */
+	regmap = devm_regmap_init_spi(spi, &inv_icm45600_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return inv_icm45600_core_probe(regmap, chip_info, true,
+				       inv_icm45600_spi_bus_setup);
+}
+
+/*
+ * The device id table is used to identify which device is
+ * supported by this driver.
+ */
+static const struct spi_device_id inv_icm45600_id[] = {
+	{ "icm45605", (kernel_ulong_t)&inv_icm45605_chip_info },
+	{ "icm45606", (kernel_ulong_t)&inv_icm45606_chip_info },
+	{ "icm45608", (kernel_ulong_t)&inv_icm45608_chip_info },
+	{ "icm45634", (kernel_ulong_t)&inv_icm45634_chip_info },
+	{ "icm45686", (kernel_ulong_t)&inv_icm45686_chip_info },
+	{ "icm45687", (kernel_ulong_t)&inv_icm45687_chip_info },
+	{ "icm45688p", (kernel_ulong_t)&inv_icm45688p_chip_info },
+	{ "icm45689", (kernel_ulong_t)&inv_icm45689_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, inv_icm45600_id);
+
+static const struct of_device_id inv_icm45600_of_matches[] = {
+	{
+		.compatible = "invensense,icm45605",
+		.data = &inv_icm45605_chip_info,
+	}, {
+		.compatible = "invensense,icm45606",
+		.data = &inv_icm45606_chip_info,
+	}, {
+		.compatible = "invensense,icm45608",
+		.data = &inv_icm45608_chip_info,
+	}, {
+		.compatible = "invensense,icm45634",
+		.data = &inv_icm45634_chip_info,
+	}, {
+		.compatible = "invensense,icm45686",
+		.data = &inv_icm45686_chip_info,
+	}, {
+		.compatible = "invensense,icm45687",
+		.data = &inv_icm45687_chip_info,
+	}, {
+		.compatible = "invensense,icm45688p",
+		.data = &inv_icm45688p_chip_info,
+	}, {
+		.compatible = "invensense,icm45689",
+		.data = &inv_icm45689_chip_info,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, inv_icm45600_of_matches);
+
+static struct spi_driver inv_icm45600_driver = {
+	.driver = {
+		.name = "inv-icm45600-spi",
+		.of_match_table = inv_icm45600_of_matches,
+		.pm = pm_ptr(&inv_icm45600_pm_ops),
+	},
+	.id_table = inv_icm45600_id,
+	.probe = inv_icm45600_probe,
+};
+module_spi_driver(inv_icm45600_driver);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-456xx SPI driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_ICM45600");

-- 
2.34.1



