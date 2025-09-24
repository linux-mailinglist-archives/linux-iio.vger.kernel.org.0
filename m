Return-Path: <linux-iio+bounces-24398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A820BB991A9
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 11:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DA517420D
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 09:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EF02D9789;
	Wed, 24 Sep 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLEmF1xp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37D2D8360;
	Wed, 24 Sep 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705848; cv=none; b=RAjzDNJoYthoL53WnSwXJ1CrZ/AGCp0hQTT/oW+W0u0RAoidHVtchAQGr3g/4dkAG6CLZ2CtqZXq02HHGg18HTuVSDHvZ1Abg2elnqqDPm4XQw7HvqBGa9gn89d+w9Y8N4MLpoCLQCIjD9EZqe0qYezfEU3ac3SENL8R7JdcMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705848; c=relaxed/simple;
	bh=iad621vV49d+wv02UCcQ9so9zAeVhfhnBdchvCJXOp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mxh8pYZHRUaNI0emzOdGRxQjz51kzomXwt67S8eRzvJIbvAgl9PWlYZe1w8zDSRjS8/lbpIc4tMOgapzEfFkUcNT2U6tZSSeFofYS9j+a1W06+PKIv+8D4GVBTynXVIt8RYZ+vv4uratq9K+M5Gjwl+k4M2qqz4LtDGIEJaliFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLEmF1xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2A02C2BCB5;
	Wed, 24 Sep 2025 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758705847;
	bh=iad621vV49d+wv02UCcQ9so9zAeVhfhnBdchvCJXOp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bLEmF1xpXH1oneWsSyM197L40z6Ll2QJT0rGIupVqPvUI2LFSXA+ytO6dOic5YFa2
	 rLFxQxyGKNiN40qyuMxrfR2/RguyQTqyKaumhzJBkfMKeIWa3qc5GOdB/DuJi89TcE
	 2vOf2lseODJsLSHl18DFv2IJsH/+/t2mwQtkSb102EVmVBXTJ7vhZ1LZ7p2L9GwluR
	 MdXppqDzMAzISRXCNntWZ4w/EfOsCqhTCIiKS0FUrmj8wFxI/r0Pi7xQS7/cccJD+Z
	 e4RWy/HVpLX3GhWsp39KA/S4c4KDlbMob3vLBZcZvWJzU0RPY4Q8/uZjHBF7H3ZUOU
	 HfdWr1rcq8njQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC5FCAC5A5;
	Wed, 24 Sep 2025 09:24:07 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Wed, 24 Sep 2025 09:23:59 +0000
Subject: [PATCH v6 6/9] iio: imu: inv_icm45600: add I2C driver for
 inv_icm45600 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-add_newport_driver-v6-6-76687b9d8a6e@tdk.com>
References: <20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com>
In-Reply-To: <20250924-add_newport_driver-v6-0-76687b9d8a6e@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758705845; l=5052;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=sBMP9Nob/m9bf7U1Inc9JV4s0JfRRB/2JECgb0ifR6Q=;
 b=9+bTZMv9su3csI7YoGJWLHRx/wPgemgLp0OO0KsSPxok3znaMTtLkwrtHhSg0xlTUSwY/WiFc
 uyb3rzM4L74A0793pUtSvzkQ6j1JdmmakmLnvo/FnHdXXJ1fpGZAjHx
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Add I2C driver for InvenSense ICM-456000 devices.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 drivers/iio/imu/inv_icm45600/Kconfig            | 21 ++++++
 drivers/iio/imu/inv_icm45600/Makefile           |  3 +
 drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c | 98 +++++++++++++++++++++++++
 3 files changed, 122 insertions(+)

diff --git a/drivers/iio/imu/inv_icm45600/Kconfig b/drivers/iio/imu/inv_icm45600/Kconfig
index ea0a8d20cba26549b74105fa6fdbca1ddb222633..5b044a954e952ffa8e44507eea42872e1f3161bc 100644
--- a/drivers/iio/imu/inv_icm45600/Kconfig
+++ b/drivers/iio/imu/inv_icm45600/Kconfig
@@ -5,3 +5,24 @@ config INV_ICM45600
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
 	select IIO_INV_SENSORS_TIMESTAMP
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
+	  - ICM-45606
+	  - ICM-45608
+	  - ICM-45634
+	  - ICM-45686
+	  - ICM-45687
+	  - ICM-45688-P
+	  - ICM-45689
+
+	  This driver can be built as a module. The module will be called
+	  inv-icm45600-i2c.
diff --git a/drivers/iio/imu/inv_icm45600/Makefile b/drivers/iio/imu/inv_icm45600/Makefile
index e34553d2b74dc46bb0f533d2bd0875655f91c781..c43e5d6ad3a2ddbd666d77630015c440e740d969 100644
--- a/drivers/iio/imu/inv_icm45600/Makefile
+++ b/drivers/iio/imu/inv_icm45600/Makefile
@@ -5,3 +5,6 @@ inv-icm45600-y += inv_icm45600_core.o
 inv-icm45600-y += inv_icm45600_buffer.o
 inv-icm45600-y += inv_icm45600_gyro.o
 inv-icm45600-y += inv_icm45600_accel.o
+
+obj-$(CONFIG_INV_ICM45600_I2C) += inv-icm45600-i2c.o
+inv-icm45600-i2c-y += inv_icm45600_i2c.o
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
new file mode 100644
index 0000000000000000000000000000000000000000..5ebc18121a11f8ad576efb4d4cf80091c13af31d
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2025 InvenSense, Inc. */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+
+#include "inv_icm45600.h"
+
+static const struct regmap_config inv_icm45600_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int inv_icm45600_probe(struct i2c_client *client)
+{
+	const struct inv_icm45600_chip_info *chip_info;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
+		return -ENODEV;
+
+	chip_info = device_get_match_data(&client->dev);
+	if (!chip_info)
+		return -ENODEV;
+
+	regmap = devm_regmap_init_i2c(client, &inv_icm45600_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return inv_icm45600_core_probe(regmap, chip_info, true, NULL);
+}
+
+/*
+ * The device id table is used to identify which device is
+ * supported by this driver.
+ */
+static const struct i2c_device_id inv_icm45600_id[] = {
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
+MODULE_DEVICE_TABLE(i2c, inv_icm45600_id);
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
+static struct i2c_driver inv_icm45600_driver = {
+	.driver = {
+		.name = "inv-icm45600-i2c",
+		.of_match_table = inv_icm45600_of_matches,
+		.pm = pm_ptr(&inv_icm45600_pm_ops),
+	},
+	.id_table = inv_icm45600_id,
+	.probe = inv_icm45600_probe,
+};
+module_i2c_driver(inv_icm45600_driver);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-456xx I2C driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_ICM45600");

-- 
2.34.1



