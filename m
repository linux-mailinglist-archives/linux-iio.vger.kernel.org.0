Return-Path: <linux-iio+bounces-21516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D586CAFFD4A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 10:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0024E49B2
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F02294A17;
	Thu, 10 Jul 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4p+LRal"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7774B290D98;
	Thu, 10 Jul 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137883; cv=none; b=RRYwT0KVCzYTpLJEXNeM6r6+PcO975ovweb3pkYKH2DNcwk+hbbT0rY5TeoqvKQ9XpTIR1wT6EEA3JAsDk92neevYI6dhuAhi7e9uCOteMWvWrhoOPNVhKsCb8v3cdoQhNC08qejFUF/GLusj6/s/xtz3R1nnIfSKcGGcchasYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137883; c=relaxed/simple;
	bh=vsHjZJf51AfU8S+DT+3gZS1r3jeZjtw/LCAGqXyQnIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cIpE3yBh501NpItaZqv1AtmTQMP3YG0KzzTrRdgcDIavUTQkdWPRC1x8g+fRtRRBkjhfBU8PC9BBzNyBe2qcu9dXVhIM77i7qqUxJF3zT9iulvOC9jXYN6nxmRsNbQCiGyisceFE2RdqnFniFR3xDpbtu/fbfefraQRM9xs9kq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4p+LRal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35ECEC4AF0F;
	Thu, 10 Jul 2025 08:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752137883;
	bh=vsHjZJf51AfU8S+DT+3gZS1r3jeZjtw/LCAGqXyQnIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M4p+LRalgj3AeDRhEOYx13ukmHuwmdnNKbKvnhnQZOGN7d7pbeFY7/ab8hFlfIN/+
	 J/uyzdo8jkC7Db4x6pnX79ZPDfjM8tjQUJ2DRATh8hb2bQeVMgKXd9A1RU2tRHsNod
	 NxKHCqYlyT15O8lLHS6wpzfM5enk1KG7+KVi9kgxeHRd4iROUHui9LXLHReqmj0tB6
	 FAUKRbY8eEXHP6ktT3wibvjRj3LRhHhrKYs5zu++twyx86T1mcJ5e6D3F8tTmp3ApZ
	 LYWefuIZWNZ3YAAGzM7zlV+HgyJqgw5ZRLkOiOz9ann4yYJ3PtA7T9N74ncXPduGm8
	 Pbv18iB667hBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253E1C83F20;
	Thu, 10 Jul 2025 08:58:03 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Thu, 10 Jul 2025 08:58:02 +0000
Subject: [PATCH v2 7/8] iio: imu: inv_icm45600: add I3C driver for
 inv_icm45600 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-add_newport_driver-v2-7-bf76d8142ef2@tdk.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752137881; l=4456;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=4m9qBpGi25U3Cwi+7Mah1nGcPeoIUiDCyFwUUL17ZWI=;
 b=yYWecN4TqeFNQZ2Uy3aAt7gmjHgxNLAlomKLTC0aFl6Z4lnjDAVRhSTAPXNq2ZvTChTDIMpN0
 uScb77BPs7iAtOdfexHiwrCfRPLKwVHnFg1K+HZwEBBsReLkcnHfOQH
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Add I3C driver for InvenSense ICM-45600 devices.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 drivers/iio/imu/inv_icm45600/Kconfig            | 21 +++++++
 drivers/iio/imu/inv_icm45600/Makefile           |  3 +
 drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c | 82 +++++++++++++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/drivers/iio/imu/inv_icm45600/Kconfig b/drivers/iio/imu/inv_icm45600/Kconfig
index 01399d136a7ea3aa92a3a18ea455c95c0a6578b3..dc133402f6d75f8c050100e8475404e00993818b 100644
--- a/drivers/iio/imu/inv_icm45600/Kconfig
+++ b/drivers/iio/imu/inv_icm45600/Kconfig
@@ -47,3 +47,24 @@ config INV_ICM45600_SPI
 
 	  This driver can be built as a module. The module will be called
 	  inv-icm45600-spi.
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
+	  - ICM-45606
+	  - ICM-45608
+	  - ICM-45634
+	  - ICM-45686
+	  - ICM-45687
+	  - ICM-45688-P
+	  - ICM-45689
+
+	  This driver can be built as a module. The module will be called
+	  inv-icm45600-i3c.
diff --git a/drivers/iio/imu/inv_icm45600/Makefile b/drivers/iio/imu/inv_icm45600/Makefile
index 244cc8aa1f79e3367ac6925504cfd9d5b918a0e6..fa646ea8339da3c41eab8aa16e14b484fd884843 100644
--- a/drivers/iio/imu/inv_icm45600/Makefile
+++ b/drivers/iio/imu/inv_icm45600/Makefile
@@ -11,3 +11,6 @@ inv-icm45600-i2c-y += inv_icm45600_i2c.o
 
 obj-$(CONFIG_INV_ICM45600_SPI) += inv-icm45600-spi.o
 inv-icm45600-spi-y += inv_icm45600_spi.o
+
+obj-$(CONFIG_INV_ICM45600_I3C) += inv-icm45600-i3c.o
+inv-icm45600-i3c-y += inv_icm45600_i3c.o
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
new file mode 100644
index 0000000000000000000000000000000000000000..9db249ca53ec3fecb0f85792a353d05463f52acb
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2025 InvenSense, Inc. */
+
+#include <linux/err.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "inv_icm45600.h"
+
+static const struct regmap_config inv_icm45600_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct i3c_device_id inv_icm45600_i3c_ids[] = {
+	I3C_DEVICE_EXTRA_INFO(0x0235, 0x0000, 0x0011, (void *)NULL),
+	I3C_DEVICE_EXTRA_INFO(0x0235, 0x0000, 0x0084, (void *)NULL),
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(i3c, inv_icm45600_i3c_ids);
+
+static const struct inv_icm45600_chip_info *i3c_chip_info[] = {
+	&inv_icm45605_chip_info,
+	&inv_icm45606_chip_info,
+	&inv_icm45608_chip_info,
+	&inv_icm45634_chip_info,
+	&inv_icm45686_chip_info,
+	&inv_icm45687_chip_info,
+	&inv_icm45688p_chip_info,
+	&inv_icm45689_chip_info,
+};
+
+static int inv_icm45600_i3c_probe(struct i3c_device *i3cdev)
+{
+	int ret;
+	unsigned int whoami;
+	struct regmap *regmap;
+	const int nb_chip = ARRAY_SIZE(i3c_chip_info);
+	int chip;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &inv_icm45600_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&i3cdev->dev, "Failed to register i3c regmap %ld\n", PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	ret = regmap_read(regmap, INV_ICM45600_REG_WHOAMI, &whoami);
+	if (ret) {
+		dev_err(&i3cdev->dev, "Failed to read part id %d\n", whoami);
+		return ret;
+	}
+
+	for (chip = 0; chip < nb_chip; chip++) {
+		if (whoami == i3c_chip_info[chip]->whoami)
+			break;
+	}
+
+	if (chip == nb_chip) {
+		dev_err(&i3cdev->dev, "Failed to match part id %d\n", whoami);
+		return -ENODEV;
+	}
+
+	return inv_icm45600_core_probe(regmap, i3c_chip_info[chip], false, NULL);
+}
+
+static struct i3c_driver inv_icm45600_driver = {
+	.driver = {
+		.name = "inv_icm45600_i3c",
+		.pm = pm_sleep_ptr(&inv_icm45600_pm_ops),
+	},
+	.probe = inv_icm45600_i3c_probe,
+	.id_table = inv_icm45600_i3c_ids,
+};
+module_i3c_driver(inv_icm45600_driver);
+
+MODULE_AUTHOR("Remi Buisson <remi.buisson@tdk.com>");
+MODULE_DESCRIPTION("InvenSense ICM-456xx i3c driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_ICM45600");

-- 
2.34.1



