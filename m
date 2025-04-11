Return-Path: <linux-iio+bounces-17944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82194A85EFC
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251E43B0696
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537641A5BB0;
	Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nU9nF7lF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE3A19A28D;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378122; cv=none; b=XZEJYA0AxR9NwUejOvwFYbFlGM+HU3yz9MF4wNL2RPceFK5JU6Qms11fS5okOBqq+zAtjImebkOq2t3eaxElXIl9/ss1mqBgihyGCBoUOqs/waxG9dEmAP2awsmqhQ7IvGZUCrJJAR4osXBNZy20G1LPRmFQ/oemisEkAFP+VvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378122; c=relaxed/simple;
	bh=GQpDhvOw4vXgDuXyes+BHzlaE27xz0vtE396S51W9dU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OS9Yh+WfNE7rh+ve7fBexArn4Gw3JiA8EozjtY8AY/yAwVHXNrC0PU4vTdruGK3FSBM9nCuBW4xEQc3NdTeSGIORsuNQ8E04dME1OsdUqHPh/i1+XuzvAJiUMATfDresvGJaLaETmp8YceQ+qchGcajyn4LTw9/Cs6zAAunltiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nU9nF7lF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 869FFC4CEE8;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744378121;
	bh=GQpDhvOw4vXgDuXyes+BHzlaE27xz0vtE396S51W9dU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nU9nF7lFHLJ/MNqS6H1x3Y+PeDcLDHYBW+FaQTk88F/LuceJU7uM2U8Vnyk6fKiCR
	 OzDETRh1Zflzn4lNDnLZYx5egDQfNAq2c7QDzzEZP+tJuvSI3vGqavf5dhUj8FQAjF
	 S+emkRDwDrcl8AN6iyGjSCys5VXvOSoYecxr3bdd1QnqKSMx3nVsaRPPfBerQyjjbd
	 3QFo/ylM+/Iosx1j/HS1fAd0W4ctUuzlcHHCTifQcQukbDHNpkvwerPj4CREbFbz2h
	 aBMkt1HI6pnbiCFr0+osp/oYJxtngC45kWEL45RGaeGOoB3m/aKUgzXd474YKPZjMo
	 Xf7OmAzXlyIgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE0FC369A9;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Fri, 11 Apr 2025 13:28:34 +0000
Subject: [PATCH 2/8] iio: imu: inv_icm45600: add I2C driver for
 inv_icm45600 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-add_newport_driver-v1-2-15082160b019@tdk.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744378119; l=3387;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=zvnek+WzKcKPqMBcpGOllwv/2GulHHduPuhOxyb8B+A=;
 b=BcxzJbKACafNrxxo6i1IRkESitg/K8jcjxJBoVAyzwizlkSHE+F+Nnm8e11x55+uMPeOU4cjc
 x+JNcNKqJAiAZPT7kf1EqKRjUge6bh3vAljqJsMNeZxU/XKvCZ4eexW
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Add I2C driver for InvenSense ICM-456xxx devices.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c | 103 ++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
new file mode 100644
index 0000000000000000000000000000000000000000..93fa9e7570846b6dfc3cfb96a2d6c058da3cc746
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 InvenSense, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
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
+	const void *match;
+	enum inv_icm45600_chip chip;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
+		return -ENOTSUPP;
+
+	match = device_get_match_data(&client->dev);
+	if (!match)
+		return -EINVAL;
+	chip = (uintptr_t)match;
+
+	regmap = devm_regmap_init_i2c(client, &inv_icm45600_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return inv_icm45600_core_probe(regmap, chip, true, NULL);
+}
+
+/*
+ * device id table is used to identify what device can be
+ * supported by this driver
+ */
+static const struct i2c_device_id inv_icm45600_id[] = {
+	{ "icm45605", INV_CHIP_ICM45605 },
+	{ "icm45686", INV_CHIP_ICM45686 },
+	{ "icm45688p", INV_CHIP_ICM45688P },
+	{ "icm45608", INV_CHIP_ICM45608 },
+	{ "icm45634", INV_CHIP_ICM45634 },
+	{ "icm45689", INV_CHIP_ICM45689 },
+	{ "icm45606", INV_CHIP_ICM45606 },
+	{ "icm45687", INV_CHIP_ICM45687 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, inv_icm45600_id);
+
+static const struct of_device_id inv_icm45600_of_matches[] = {
+	{
+		.compatible = "invensense,icm45605",
+		.data = (void *)INV_CHIP_ICM45605,
+	}, {
+		.compatible = "invensense,icm45686",
+		.data = (void *)INV_CHIP_ICM45686,
+	}, {
+		.compatible = "invensense,icm45688p",
+		.data = (void *)INV_CHIP_ICM45688P,
+	}, {
+		.compatible = "invensense,icm45608",
+		.data = (void *)INV_CHIP_ICM45608,
+	}, {
+		.compatible = "invensense,icm45634",
+		.data = (void *)INV_CHIP_ICM45634,
+	}, {
+		.compatible = "invensense,icm45689",
+		.data = (void *)INV_CHIP_ICM45689,
+	}, {
+		.compatible = "invensense,icm45606",
+		.data = (void *)INV_CHIP_ICM45606,
+	}, {
+		.compatible = "invensense,icm45687",
+		.data = (void *)INV_CHIP_ICM45687,
+	},
+	{}
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



