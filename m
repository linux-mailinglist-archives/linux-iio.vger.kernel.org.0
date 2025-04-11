Return-Path: <linux-iio+bounces-17948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB360A85F01
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CA63B2DCE
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AAA1D7E57;
	Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJcieiro"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B61B3F3D;
	Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378122; cv=none; b=rCLA0LbqiK/DxodTejARRzr9znTaRbSGOl6sy6BmHOLPE7wN+MoJiF4I6yEdcOCEX9l2y8IBketWAUnuLXq54oxaetIESwLuVjAw1ynrsmuRFLKqinKtaLBJ8qWfGmIuRW/9o9illW5vn8gc6af8HSzZm1m7Ux3gZ1a+10RB8Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378122; c=relaxed/simple;
	bh=Hns3lEJU2PrajODTTCnU56xq9Xnx68YLhhUSEVwSqIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQSoaT45vt72SPMeI7TWshBn+9Pw16EgT/pSzCwDY1o35jDJITkvGZF7KoEByyDC1lfBA2+ss5Q3S4d1DMErDhwot4006rM6XAHsTvyF1bztT8YsLcUQFHfTyVTxS4OYRJMQDBSfwCoJpaPlOyiazqPirWDhIMLAcJVEXjHcfVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJcieiro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA16CC4CEF3;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744378121;
	bh=Hns3lEJU2PrajODTTCnU56xq9Xnx68YLhhUSEVwSqIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dJcieiroiyGs2+dcWAinR2TXgzTG3fw3hHf51eXtiuHkbT411V78zj2CWFqVwFNy9
	 YMDgtTaW3Jr5Rqkyx5ik/5UAgaOM2VzObaMXIz4iUGvCqFdOMimA0oJvejXuC2mzNI
	 +Rh7q1jM84ymY5RLxOiXNyXeyytgEWQusLIVNUqvxAv20hcVJXoB6/GH9kMcGz3Vbl
	 F5RRQxjvpB8r020FHaify2HMiyzRUlPzDiNR88MAm+LTvZm09stgRPxB084FbAGgYJ
	 pkfXyKeN+6P7j6iqjI7U87of6yJ9qg3xB4kIbMMfQT7fgfr5+OkukLM7PGA3fxzHDq
	 zGsMB8wZlk1Ig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC80C369AF;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Fri, 11 Apr 2025 13:28:36 +0000
Subject: [PATCH 4/8] iio: imu: inv_icm45600: add I3C driver for
 inv_icm45600 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-add_newport_driver-v1-4-15082160b019@tdk.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744378119; l=3115;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=AAAjeWu8beshqeqWWoKXRzNOSHP5dILEmgEVvq21vZs=;
 b=r+DS/JcwPXMldmQvkfrQqwevn33FPPQWPoCJ9dxNeZC4oh0TXQdbl6GSrNwftU362KezarD96
 389/OVBFAghCZCTmFEG3knzFzmwyYg/vkwzuoWCF7gtVTyyUxwGZTkC
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Add I3C driver for InvenSense ICM-456xxx devices.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c | 84 +++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
new file mode 100644
index 0000000000000000000000000000000000000000..da939a5da5da88cbbb4a41edd90deae950cb9760
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 InvenSense, Inc.
+ */
+
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
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
+static const uint8_t inv_icm45600_i3c_code[INV_CHIP_NB] = {
+	[INV_CHIP_ICM45605] = INV_ICM45600_WHOAMI_ICM45605,
+	[INV_CHIP_ICM45686] = INV_ICM45600_WHOAMI_ICM45686,
+	[INV_CHIP_ICM45688P] = INV_ICM45600_WHOAMI_ICM45688P,
+	[INV_CHIP_ICM45608] = INV_ICM45600_WHOAMI_ICM45608,
+	[INV_CHIP_ICM45634] = INV_ICM45600_WHOAMI_ICM45634,
+	[INV_CHIP_ICM45689] = INV_ICM45600_WHOAMI_ICM45689,
+	[INV_CHIP_ICM45606] = INV_ICM45600_WHOAMI_ICM45606,
+	[INV_CHIP_ICM45687] = INV_ICM45600_WHOAMI_ICM45687
+};
+
+static int inv_icm45600_i3c_probe(struct i3c_device *i3cdev)
+{
+	int ret;
+	unsigned int whoami;
+	enum inv_icm45600_chip chip;
+	struct regmap *regmap;
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
+	for (chip = INV_CHIP_ICM45605; chip < INV_CHIP_NB; chip++) {
+		if (whoami == inv_icm45600_i3c_code[chip])
+			break;
+	}
+
+	if (chip == INV_CHIP_NB) {
+		dev_err(&i3cdev->dev, "Failed to match part id %d\n", whoami);
+		return -ENODEV;
+	}
+
+	return inv_icm45600_core_probe(regmap, chip, false, NULL);
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



