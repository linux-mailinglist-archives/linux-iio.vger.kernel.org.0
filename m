Return-Path: <linux-iio+bounces-21515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AD3AFFD38
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 10:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D73847A145B
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 08:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07282951C6;
	Thu, 10 Jul 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfXbWXbt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776BD290D96;
	Thu, 10 Jul 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137883; cv=none; b=JaJkKI7q8KAIJ0j9Xp37n3b748J6+l2TR3kWnsnUWodWHn/5V/O+/liHLL3LqdoggBjT3S/0hGL9fb6O5vYup5rHzGuzNCzM0Dnx95iJZ7AItPRJGyR529fqwyT4V2hmP64YQzO1lYDJ64GimHzmnXqMeZkDkHyNL3It9L6/fXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137883; c=relaxed/simple;
	bh=OhptN+7B1XE2fgRUs9oHodmN33ZP4J2jyblze+ymoPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VEVbDt76GNQ1X13Eux8VsP8tM4qMFDWZ+mIwWxYdy8+DLpENmfJeSytx6MMtesXmUUV8dklmU907BfNESLCDU5nEGE+YWV4rPCNPqfyZZJSSMZERVS4g4fb+c1FOfQAjltys9dJR6BeiQN85Sb4eGRNVnQ5SdkoMO4DtX75KWt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfXbWXbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 111FAC4AF11;
	Thu, 10 Jul 2025 08:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752137883;
	bh=OhptN+7B1XE2fgRUs9oHodmN33ZP4J2jyblze+ymoPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cfXbWXbtHtLIy8+msInrHyby2cjAO+mbASADF6VLKksvpM52D/t2adWlGpt97Ocm0
	 b7EjZv0S1UPO9qmCjykdIYvPXCIkGaTf7ZWKGHQ33WllX+wFa2dUk9Z3Thu0OzL73y
	 SuEwF8Q5S+02U69fZwqoEFEXIGuDx1JPDU24oODRd473rqnIdz4h1t6lQt238CMmFj
	 oFcIUbOArgzECBan9ZJ7XfYMz5Ho86Rli1vcxfZ7iHg+W740ZgbD52OggTzfHU13X2
	 SF6sSeleE9TPSYRPXTeAtf7MnVb1wyGy1Cmy21Yrc92t/wInjGH//jVLlumDYJBUqs
	 Grseg09Im22Ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B7EC83F1A;
	Thu, 10 Jul 2025 08:58:03 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Thu, 10 Jul 2025 08:58:00 +0000
Subject: [PATCH v2 5/8] iio: imu: inv_icm45600: add I2C driver for
 inv_icm45600 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-add_newport_driver-v2-5-bf76d8142ef2@tdk.com>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
In-Reply-To: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752137881; l=5081;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=rm9K6Dx3nzkqESFb6IZ1u3aaGk1Q2lyM/F/KVpz+xTs=;
 b=X+czwMlFUgC3MdylQzq5lESszrJ66Z6jXTmZQbNo54ens+E7SmZmhDCHIsx/WeHPFXb5Hbn37
 dc77EGJk4kJAkSDgUSZ1i0RFr4rcquB3663YgCh7y21XB7/rfBaqvT6
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
index ced5e1d9f2c10400cfa4878146672d41f815c22a..371585e29e92e78a30c7d40c1389548fa22a999a 100644
--- a/drivers/iio/imu/inv_icm45600/Makefile
+++ b/drivers/iio/imu/inv_icm45600/Makefile
@@ -5,3 +5,6 @@ inv-icm45600-y += inv_icm45600_core.o
 inv-icm45600-y += inv_icm45600_buffer.o
 inv-icm45600-y += inv_icm45600_accel.o
 inv-icm45600-y += inv_icm45600_gyro.o
+
+obj-$(CONFIG_INV_ICM45600_I2C) += inv-icm45600-i2c.o
+inv-icm45600-i2c-y += inv_icm45600_i2c.o
\ No newline at end of file
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



