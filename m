Return-Path: <linux-iio+bounces-24804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7005ABC07A9
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 09:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C1F3A584C
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 07:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D24B239E7E;
	Tue,  7 Oct 2025 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYpwAOeo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12321234966;
	Tue,  7 Oct 2025 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759821610; cv=none; b=t4ciQ/xw00Sbm6NXig2iHnX0eUCU85/nKAqocipnsAwuPlO4k7EzRV/rMO8TYKZh9KhnbbCs4NrMor3wYk8WGT+PEMVfNApTSYlUlp5v1raaBNn1n3uyEMOExGh6WjlXDZ0Jnm07grR40Mmln84bJmdOfx9MUoRaNciE1fj/URk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759821610; c=relaxed/simple;
	bh=5xYLeJ+Hw5xlJP+d3gvsOl1fSNetBPws217QUoEqg7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ugvsOnVFDcC9dokZx8p/MAm/+5hXj96JDVpxbKPSfl3Dlcf+oY2ROitNSmA5UGyTkYNSrfQRkziqPI6R9QV3vUfCFOVYC5d9SZWnrr6kso6hiQHSsBMh+tcGZnCQvfvMWyGCApOcdkrR5/Ko8bBZg3UT+xnLb7f5Uwlapv+eLYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYpwAOeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C91AAC19425;
	Tue,  7 Oct 2025 07:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759821609;
	bh=5xYLeJ+Hw5xlJP+d3gvsOl1fSNetBPws217QUoEqg7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sYpwAOeogrmueXWfjntZjkH5V/HkfPkkcyKXh73HCyQl9e2D2YSFXyZNswPivl2Nw
	 vi79f6djWpNwA/n1rJ9dSywbwlwzBApdPUHQxp04fy3gPhz3SO5I5FUBrcJHJQ+ykx
	 fiizZ9NvRIWXw1GL1mp/+yK66SPKluFo2SMARZ7W2b+heX2YWNZsA3Nl/73DhlBg/O
	 eninKe6a53dEw3/m4hn+rFs88KroZdKzqTsrBJ3tjOXiYR0ozbP8hvf+bvjHYwHYIa
	 bmYh7gqH9nhueoOqozKOjlPk3mHe63EWBUF9iYw6hIeh67fuHavpTKSZpVpYexH4Nm
	 7LDYqSsRhhC8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21A7CCD185;
	Tue,  7 Oct 2025 07:20:09 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Tue, 07 Oct 2025 07:20:08 +0000
Subject: [PATCH v7 7/9] iio: imu: inv_icm45600: add SPI driver for
 inv_icm45600 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-add_newport_driver-v7-7-137223a1f79e@tdk.com>
References: <20251007-add_newport_driver-v7-0-137223a1f79e@tdk.com>
In-Reply-To: <20251007-add_newport_driver-v7-0-137223a1f79e@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759821607; l=5379;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=j7TNix5ULGwE5X57onqEYH8kfE3Lmcq8sNg8KgQ8ysc=;
 b=6CO26tIVR78OberXB89Yqatxkslcrtw86oPwQGiYpb82924CB6nZljVc8oH9IsNOony6xcEUe
 PgikQavS7psDD0IdTxj4FkEMzmN+6EPp1rJh091fT6CP9xxl52Xgm6X
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
 drivers/iio/imu/inv_icm45600/Makefile           |   3 +
 drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c | 108 ++++++++++++++++++++++++
 3 files changed, 132 insertions(+)

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
index c43e5d6ad3a2ddbd666d77630015c440e740d969..3692636d393a109a0ad68e955e1cad59005e9128 100644
--- a/drivers/iio/imu/inv_icm45600/Makefile
+++ b/drivers/iio/imu/inv_icm45600/Makefile
@@ -8,3 +8,6 @@ inv-icm45600-y += inv_icm45600_accel.o
 
 obj-$(CONFIG_INV_ICM45600_I2C) += inv-icm45600-i2c.o
 inv-icm45600-i2c-y += inv_icm45600_i2c.o
+
+obj-$(CONFIG_INV_ICM45600_SPI) += inv-icm45600-spi.o
+inv-icm45600-spi-y += inv_icm45600_spi.o
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c
new file mode 100644
index 0000000000000000000000000000000000000000..6288113a6d7c4ac11788eb9539d604903f6bb8c7
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2025 InvenSense, Inc. */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+
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



