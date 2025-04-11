Return-Path: <linux-iio+bounces-17947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21685A85EFF
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AD83B2039
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDDF1CD1E4;
	Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN1j2jzr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F971AAE17;
	Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378122; cv=none; b=GizfgGQRjaMyMwXaIuaD0WzOAc5yDyzeTK/mxaetBLjVguFrJVavEbIxI3Al0gubXoUSgvQ0hiGPJIBsHsjE1SxaT43vHC37DFjPjqnag+iDkbG4zjCDT8QgM+fe8fDt/5aEnSqhMrFWfpaquGdVCuBDwruCA8lZ3ETvT4YoQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378122; c=relaxed/simple;
	bh=zdCSDIXvp4S4/c3ewltB0IiwGxcP/fWw9CcKslvterA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EjOmePacKJvAwl+IE45PXYCenLG2tMluM1iij7LIzJDJ6xojpw1rlUMrmwPsa5Qs5gpKMs76V27wh2xkylcAi695d58xwXC1iyYILWtVFoeacHdszltbDXyGSU/8KJx5TMW8smbEPLpeJpYGg3TaKGBR9D4/eKvgHfNsFuzx/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN1j2jzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D15BC4CEEC;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744378121;
	bh=zdCSDIXvp4S4/c3ewltB0IiwGxcP/fWw9CcKslvterA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uN1j2jzr9d6xeoIxjv2yS/F9b/Bha+FVEhQbhhQ5Ds9XbIex62d0uxORn4zkBsY1L
	 4u1/Yl/dbSmXDMMtYJjkpGoWmZV41EGfZh4CKRWx5luaHEFDlmSU7sJ5gD8APnsavx
	 AZx9fmCOt8gL6C2M+xh+73FMaNgwQ5LwOv4Suc46Wj1F1S00Jr+LoOZcat7IKf7BOf
	 m6C0YgS6K3lQOMwrK30OgRf6bFnKkCiQjYFUqovXx9Z/Ue2horFRQJnWLQge4XeLwy
	 kACi2zAB2z/gW3uIidGWKVcOGVWKKFFOxn3d3frQoqYSpz+uMxGbA8Np0LWD9gU+ai
	 JJ7wydAj/KgEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADA2C36010;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Fri, 11 Apr 2025 13:28:35 +0000
Subject: [PATCH 3/8] iio: imu: inv_icm45600: add SPI driver for
 inv_icm45600 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-add_newport_driver-v1-3-15082160b019@tdk.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744378119; l=3615;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=kqX0rbDG6+UEQFF0zrY6sK4rRJYJeEFgrhZxCbw57Rw=;
 b=AP71d1UNFHiRuw1VvbmHLzAqFCdSRmI2MGJnQlK6npqHwBzB8nj8UZ3pviuLvPVUIW93GETU1
 n3Vp53wooyrCujcPNU9kKW7wjYIx923N5q9OsRaKY/g4bhcNk9/xjvU
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Add SPI driver for InvenSense ICM-456xxx devices.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c | 110 ++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c
new file mode 100644
index 0000000000000000000000000000000000000000..fba0953343aaf9a6009a740d3a6e6446b5bea53f
--- /dev/null
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 InvenSense, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
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
+	/* set slew rates for SPI */
+	return regmap_update_bits(st->map, INV_ICM45600_REG_DRIVE_CONFIG0,
+				INV_ICM45600_DRIVE_CONFIG0_SPI_MASK,
+				INV_ICM45600_SPI_SLEW_RATE_5NS);
+}
+
+static int inv_icm45600_probe(struct spi_device *spi)
+{
+	const void *match;
+	enum inv_icm45600_chip chip;
+	struct regmap *regmap;
+
+	match = device_get_match_data(&spi->dev);
+	if (!match)
+		return -EINVAL;
+	chip = (uintptr_t)match;
+
+	/* use SPI specific regmap */
+	regmap = devm_regmap_init_spi(spi, &inv_icm45600_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return inv_icm45600_core_probe(regmap, chip, true,
+				       inv_icm45600_spi_bus_setup);
+}
+
+/*
+ * device id table is used to identify what device can be
+ * supported by this driver
+ */
+static const struct spi_device_id inv_icm45600_id[] = {
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
+MODULE_DEVICE_TABLE(spi, inv_icm45600_id);
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



