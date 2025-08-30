Return-Path: <linux-iio+bounces-23492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9227DB3CEC4
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 20:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39AF189736D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF972DC353;
	Sat, 30 Aug 2025 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo263YhJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405492DBF6E;
	Sat, 30 Aug 2025 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579405; cv=none; b=Ex+aYD5Cyn5K9mvNcItryrToLy9gHMY/QJ+6pkZTxyoMYob60x9TcZicCeFvmTvG0VKU9fG4RPEDxwi1MoLLlgG6PzADbZ7dVKYn7hywfN1N+vmRl49ukycCPhMQ6xqshNuKzWwuUewrkTOatthwM7cJNl7qqvwpTcV+oXbn+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579405; c=relaxed/simple;
	bh=2BQki3rOQvZSSbICEdQ41lJZWBOC1qWNjLJixqk7BPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=myPELA/vE2W2bx9gmYVQToLil8VvcjJweUhA2onstxOAlCEFCfSbofmf3gbY3gOh4YBFCbZeQNbXZqQV3ne1N7K/WBUSNwYL306ktay8Vdq8XpTdbQVk/sSnb/tRVn4s6AH8eomyGUltPkwlbeVI/JCUnVc0vgpaYZKClRMBQ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bo263YhJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4df220483fso754384a12.2;
        Sat, 30 Aug 2025 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756579401; x=1757184201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYn8yD0BD7KBURI/1KwhOSv9mwPsTskduF2no0+ubVQ=;
        b=bo263YhJMjWNNpsggxzrcTTuHg06nwAilMlzm1gryBdoLcYv/Y2RFlTrYlJtbHeQRw
         v9awCAlICy1Gu0oE2TibOXkE2sEqmYbFNFxv2uEIVhFIcphMZ/8Ug9X0m0nTgB/3nc4d
         LWnRS9uglCLV7gGxHzN1qwLLDmLFd7kEv6gi3soG0DQJ9Ia82jkW7I6Uz79R+o1/nnmx
         7lvyp/EbWnRB96yQP0YVDFIonKQlvQWRe4EM8xEZlVchdeiAWI2E2wdD1L/x1gNUWlPI
         K8ryJ3F7osF2OoUnobaDu+Q8Q9ZwepJPMc48qdRudaJ3fFyAgXZa7DRJXTXAq8tHb8Ya
         01ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756579401; x=1757184201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYn8yD0BD7KBURI/1KwhOSv9mwPsTskduF2no0+ubVQ=;
        b=iNiQqL3UuVR+i/Zq6KoGsNWeJeMTFgqtFQLMrZ6EKvL1lU0D+Hl70dBcGAGsr2LMRe
         2uoH9TFE9Akm9bpUgp1PJ/Y/sLvVHqHaxfaXh0otDyWJl+HT2GDQs+X6kX5Corb8Au/B
         5gijmuelQSFevoByPGVwROXBJtqQMWm4cG+UhV8fd0PoG/6X12l5T3zaUH3/e5YI3TiO
         hiFfoki16EnoOnURbBm33dQgGDaedGzhChRxOWJ1HMnxcsoTEKo6iGnqrXvXspYQU8wY
         kutylXSPuw8oT1pIC4n6+zB7Rs/mQ4rzqWZBQSqMoNgkRjNFrgh0S1fzTblm0tow25wK
         vyxw==
X-Forwarded-Encrypted: i=1; AJvYcCWPqkzRAMe+0cSFKLlhkM8af4HyJqXp4Bzf+XJCNQDXnC2niQ1rRjZPaaAP9/n/HF1a8EjAReMAF5NAX6Yb@vger.kernel.org, AJvYcCXkQ1Fy/KDAYULH7s1jZ8AwbDlSgxgkJuBtXow9t/HxEktPrd3RgDQLHH1doJA6uG7tRQKwhaPCjDXX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5FWhP1xGuSwqlMfGDEMjEDdHqJhcFYT5nuiQLLH5SRQWzqu6P
	umOM9faEe3v6wuHiBolrIkeaXvqKoUoTTvh64gwOoDawM/0PqXOIx1fy
X-Gm-Gg: ASbGncsT6yj9ozMTCdmW4RXiXSW4/vtx8bndlVsFiikSyCiFr1c8p/XCMP3VPsXrux2
	HbCgbC8amw84np+kVn/b2zh3+ur8jEVxsnKOKkIIeVBWGSou+phcgBA+4ItrEoPpTANJUqtAIH+
	+k3N/e1t+5FpaMCofBhAwl4Smfe/uA6/pKnk1BQSA5cj8a2K3gESRdIXCim45aSKO4ehsJsG3Y+
	M7qu/zqKuH1OpMpPfZwy5xVyUckWkQre5Rtn5hk8G4GSZ7xWFmBwchNj+k5BQUBKwqcZLIjyJSr
	lVnHIW7DGR0pqSJkBQPL4+X5TxJiqT81s7md7NohVtGYIHUGdv8nERciJmnqsKw6FmSPRpufwX4
	JknagGVd9X05kazQqOIX6QXfULclZs3C/YwJkCQ==
X-Google-Smtp-Source: AGHT+IF2RiISKjH88j+9XDvLxOnJgFclY1F4bSMS27yUB5LyojfMcA1dqZ9K8n7Et/oH1Q+N6LP4XQ==
X-Received: by 2002:a17:902:f68f:b0:246:2e9:da9e with SMTP id d9443c01a7336-2494485bb9bmr42532885ad.6.1756579401386;
        Sat, 30 Aug 2025 11:43:21 -0700 (PDT)
Received: from [192.168.1.19] ([122.177.240.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490658999fsm56821665ad.112.2025.08.30.11.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 11:43:21 -0700 (PDT)
From: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Date: Sun, 31 Aug 2025 00:12:46 +0530
Subject: [PATCH 2/5] iio: imu: add inv_icm20948
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-icm20948-v1-2-1fe560a38de4@gmail.com>
References: <20250831-icm20948-v1-0-1fe560a38de4@gmail.com>
In-Reply-To: <20250831-icm20948-v1-0-1fe560a38de4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, shuah@kernel.org, 
 linux-kernel-mentees@lists.linux.dev, 
 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756579380; l=13258;
 i=bharadwaj.raju777@gmail.com; s=20250830; h=from:subject:message-id;
 bh=2BQki3rOQvZSSbICEdQ41lJZWBOC1qWNjLJixqk7BPY=;
 b=5MZZHCT9HMAIpD2HFFAgin3vhl3D6hSjQm+GOzEVg7V7Q5b5zWUcJJtHKhPIJT3n5FKT/6OxK
 vNiWqyvDf1dCpsTQZfJ9SXwSeH/UmnLcwazYtJ/Q7HNINDo2xs2YKD6
X-Developer-Key: i=bharadwaj.raju777@gmail.com; a=ed25519;
 pk=s+pP76EgUCC/7pyu4E6Q5AizWQ1T6hUf1jUWrQRl040=

Core parts of the new ICM20948 driver.

Add register definitions, probing, setup, and an IIO device for
reading the onboard temperature sensor.

Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
---
 drivers/iio/imu/Kconfig                          |   1 +
 drivers/iio/imu/Makefile                         |   1 +
 drivers/iio/imu/inv_icm20948/Kconfig             |  17 ++++
 drivers/iio/imu/inv_icm20948/Makefile            |   8 ++
 drivers/iio/imu/inv_icm20948/inv_icm20948.h      |  47 +++++++++
 drivers/iio/imu/inv_icm20948/inv_icm20948_core.c | 122 +++++++++++++++++++++++
 drivers/iio/imu/inv_icm20948/inv_icm20948_i2c.c  |  48 +++++++++
 drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c | 108 ++++++++++++++++++++
 8 files changed, 352 insertions(+)

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 15612f0f189b5114deb414ef840339678abdc562..d59e5b0087398cfbd2719ca914fd147ab067155f 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -109,6 +109,7 @@ config KMX61
 	  be called kmx61.
 
 source "drivers/iio/imu/inv_icm42600/Kconfig"
+source "drivers/iio/imu/inv_icm20948/Kconfig"
 source "drivers/iio/imu/inv_mpu6050/Kconfig"
 
 config SMI240
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index e901aea498d37e5897e8b71268356a19eac2cb59..79e49bae59038c1ca1d54a64cf49b6ca5f57cb0b 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_FXOS8700_I2C) += fxos8700_i2c.o
 obj-$(CONFIG_FXOS8700_SPI) += fxos8700_spi.o
 
 obj-y += inv_icm42600/
+obj-y += inv_icm20948/
 obj-y += inv_mpu6050/
 
 obj-$(CONFIG_KMX61) += kmx61.o
diff --git a/drivers/iio/imu/inv_icm20948/Kconfig b/drivers/iio/imu/inv_icm20948/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..79ffbe273e71f27ec33fffa0286eafd7dd11aa29
--- /dev/null
+++ b/drivers/iio/imu/inv_icm20948/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config INV_ICM20948
+	tristate
+
+config INV_ICM20948_I2C
+	tristate "InvenSense ICM-20948 I2C driver"
+	depends on I2C
+	select INV_ICM20948
+	select REGMAP_I2C
+	help
+	  This driver supports the InvenSense ICM-20948 motion tracking
+	  device over I2C.
+
+	  This driver can be built as a module. The module will be called
+	  inv-icm20948-i2c.
+
diff --git a/drivers/iio/imu/inv_icm20948/Makefile b/drivers/iio/imu/inv_icm20948/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..c508c2dc3eee2c32be20067e3e0868a203d8aa1a
--- /dev/null
+++ b/drivers/iio/imu/inv_icm20948/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-$(CONFIG_INV_ICM20948) += inv-icm20948.o
+inv-icm20948-y += inv_icm20948_core.o
+inv-icm20948-y += inv_icm20948_temp.o
+
+obj-$(CONFIG_INV_ICM20948_I2C) += inv-icm20948-i2c.o
+inv-icm20948-i2c-y += inv_icm20948_i2c.o
diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948.h b/drivers/iio/imu/inv_icm20948/inv_icm20948.h
new file mode 100644
index 0000000000000000000000000000000000000000..f9830645fbe96fd02eef7c54d1e5908647d5a0fe
--- /dev/null
+++ b/drivers/iio/imu/inv_icm20948/inv_icm20948.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
+ */
+
+#ifndef INV_ICM20948_H_
+#define INV_ICM20948_H_
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/err.h>
+
+/* accel takes 20ms, gyro takes 35ms to wake from full-chip sleep */
+#define INV_ICM20948_SLEEP_WAKEUP_MS 35
+
+#define INV_ICM20948_REG_BANK_SEL 0x7F
+#define INV_ICM20948_BANK_SEL_MASK GENMASK(5, 4)
+
+#define INV_ICM20948_REG_WHOAMI 0x0000
+#define INV_ICM20948_WHOAMI 0xEA
+
+#define INV_ICM20948_REG_FIFO_RW 0x0072
+
+#define INV_ICM20948_REG_PWR_MGMT_1 0x0006
+#define INV_ICM20948_PWR_MGMT_1_DEV_RESET BIT(7)
+#define INV_ICM20948_PWR_MGMT_1_SLEEP BIT(6)
+
+#define INV_ICM20948_REG_TEMP_DATA 0x0039
+
+extern const struct regmap_config inv_icm20948_regmap_config;
+
+struct inv_icm20948_state {
+	struct device *dev;
+	struct regmap *regmap;
+	struct iio_dev *temp_dev;
+	struct mutex lock;
+};
+
+extern int inv_icm20948_core_probe(struct regmap *regmap);
+
+struct iio_dev *inv_icm20948_temp_init(struct inv_icm20948_state *state);
+
+#endif
diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
new file mode 100644
index 0000000000000000000000000000000000000000..ee9e4159cffa261f0326b146a4b3df2cbfbd7697
--- /dev/null
+++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
+ */
+
+#include "inv_icm20948.h"
+
+static const struct regmap_range_cfg inv_icm20948_regmap_ranges[] = {
+	{
+		.name = "user banks",
+		.range_min = 0x0000,
+		.range_max = 0x3FFF,
+		.selector_reg = INV_ICM20948_REG_BANK_SEL,
+		.selector_mask = INV_ICM20948_BANK_SEL_MASK,
+		.window_start = 0,
+		.window_len = 0x1000,
+	},
+};
+
+static const struct regmap_range inv_icm20948_regmap_volatile_yes_ranges[] = {
+	/* WHOAMI */
+	regmap_reg_range(0x0000, 0x0000),
+	/* PWR_MGMT_1 */
+	regmap_reg_range(0x0006, 0x0006),
+	/* I2C and INT status */
+	regmap_reg_range(0x0017, 0x001C),
+	/* Sensor readouts */
+	regmap_reg_range(0x0028, 0x0052),
+	/* FIFO count and data */
+	regmap_reg_range(0x0070, 0x0072),
+	/* Data ready status */
+	regmap_reg_range(0x0074, 0x0074),
+	/* GYRO_CONFIG_1 */
+	regmap_reg_range(0x2001, 0x2001),
+	/* I2C SLV4 data in */
+	regmap_reg_range(0x307F, 0x307F),
+};
+
+static const struct regmap_access_table inv_icm20948_regmap_volatile_accesses = {
+	.yes_ranges = inv_icm20948_regmap_volatile_yes_ranges,
+	.n_yes_ranges = ARRAY_SIZE(inv_icm20948_regmap_volatile_yes_ranges),
+};
+
+static const struct regmap_range inv_icm20948_rd_noinc_no_ranges[] = {
+	regmap_reg_range(0x0000, INV_ICM20948_REG_FIFO_RW - 1),
+	regmap_reg_range(INV_ICM20948_REG_FIFO_RW + 1, 0x3FFF),
+};
+
+static const struct regmap_access_table inv_icm20948_regmap_rd_noinc_table = {
+	.no_ranges = inv_icm20948_rd_noinc_no_ranges,
+	.n_no_ranges = ARRAY_SIZE(inv_icm20948_rd_noinc_no_ranges),
+};
+
+const struct regmap_config inv_icm20948_regmap_config = {
+	.name = "inv_icm20948",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x3FFF,
+	.ranges = inv_icm20948_regmap_ranges,
+	.num_ranges = ARRAY_SIZE(inv_icm20948_regmap_ranges),
+	.volatile_table = &inv_icm20948_regmap_volatile_accesses,
+	.rd_noinc_table = &inv_icm20948_regmap_rd_noinc_table,
+	.cache_type = REGCACHE_MAPLE,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm20948_regmap_config, "IIO_ICM20948");
+
+static int inv_icm20948_setup(struct inv_icm20948_state *state)
+{
+	guard(mutex)(&state->lock);
+
+	int reported_whoami;
+	int ret = regmap_read(state->regmap, INV_ICM20948_REG_WHOAMI,
+			      &reported_whoami);
+	if (ret)
+		return ret;
+	if (reported_whoami != INV_ICM20948_WHOAMI) {
+		dev_err(state->dev, "invalid whoami %d, expected %d\n",
+			reported_whoami, INV_ICM20948_WHOAMI);
+		return -ENODEV;
+	}
+
+	ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
+				INV_ICM20948_PWR_MGMT_1_DEV_RESET,
+				INV_ICM20948_PWR_MGMT_1_DEV_RESET);
+	if (ret)
+		return ret;
+	msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
+
+	ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
+				INV_ICM20948_PWR_MGMT_1_SLEEP, 0);
+	if (ret)
+		return ret;
+	msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
+
+	state->temp_dev = inv_icm20948_temp_init(state);
+	if (IS_ERR(state->temp_dev))
+		return PTR_ERR(state->temp_dev);
+
+	return 0;
+}
+
+int inv_icm20948_core_probe(struct regmap *regmap)
+{
+	struct device *dev = regmap_get_device(regmap);
+
+	struct inv_icm20948_state *state;
+
+	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	state->regmap = regmap;
+	state->dev = dev;
+
+	mutex_init(&state->lock);
+
+	return inv_icm20948_setup(state);
+}
+
+MODULE_AUTHOR("Bharadwaj Raju <bharadwaj.raju777@gmail.com>");
+MODULE_DESCRIPTION("InvenSense ICM-20948 device driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_i2c.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_i2c.c
new file mode 100644
index 0000000000000000000000000000000000000000..cf04d82e014a2497592c9a15bbde6e36f431dd56
--- /dev/null
+++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_i2c.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/property.h>
+
+#include "inv_icm20948.h"
+
+static int inv_icm20948_probe(struct i2c_client *client)
+{
+	struct regmap *regmap =
+		devm_regmap_init_i2c(client, &inv_icm20948_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return inv_icm20948_core_probe(regmap);
+}
+
+static const struct i2c_device_id inv_icm20948_id[] = { { "icm20948" }, {} };
+MODULE_DEVICE_TABLE(i2c, inv_icm20948_id);
+
+static const struct of_device_id inv_icm20948_of_matches[] = {
+	{ .compatible = "invensense,icm20948" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, inv_icm20948_of_matches);
+
+static struct i2c_driver inv_icm20948_driver = {
+	.driver = {
+		.name = "icm20948",
+		.of_match_table = inv_icm20948_of_matches,
+	},
+	.probe = inv_icm20948_probe,
+	.id_table = inv_icm20948_id,
+};
+module_i2c_driver(inv_icm20948_driver);
+
+MODULE_AUTHOR("Bharadwaj Raju <bharadwaj.raju777@gmail.com>");
+MODULE_DESCRIPTION("InvenSense ICM-20948 device driver (I2C)");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_ICM20948");
diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c
new file mode 100644
index 0000000000000000000000000000000000000000..916053740cc5acda0316c76504d4086eff5ec7f0
--- /dev/null
+++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
+ */
+
+#include <linux/bits.h>
+
+#include <linux/iio/iio.h>
+
+#include "inv_icm20948.h"
+
+static const struct iio_chan_spec
+	inv_icm20948_temp_chan = { .type = IIO_TEMP,
+				   .info_mask_separate =
+					   BIT(IIO_CHAN_INFO_RAW) |
+					   BIT(IIO_CHAN_INFO_OFFSET) |
+					   BIT(IIO_CHAN_INFO_SCALE),
+				   .scan_index = 0,
+				   .scan_type = {
+					   .sign = 's',
+					   .realbits = 16,
+				   } };
+
+static int inv_icm20948_temp_read_sensor(struct inv_icm20948_state *state,
+					 s16 *temp)
+{
+	guard(mutex)(&state->lock);
+
+	__be16 raw;
+	int ret = regmap_bulk_read(state->regmap, INV_ICM20948_REG_TEMP_DATA,
+				   &raw, sizeof(raw));
+	if (ret)
+		return ret;
+
+	*temp = __be16_to_cpu(raw);
+
+	return 0;
+}
+
+static int inv_icm20948_temp_read_raw(struct iio_dev *temp_dev,
+				      struct iio_chan_spec const *chan,
+				      int *val, int *val2, long mask)
+{
+	struct inv_icm20948_state *state = iio_device_get_drvdata(temp_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(temp_dev))
+			return -EBUSY;
+		s16 temp;
+		int ret = inv_icm20948_temp_read_sensor(state, &temp);
+
+		if (ret)
+			return ret;
+		iio_device_release_direct(temp_dev);
+		*val = temp;
+		return IIO_VAL_INT;
+	/*
+	 * Sensitivity = 333.87
+	 * RoomTempOff = 21
+	 * T_degC = ((T_raw - RoomTempOff) / Sensitivity) + RoomTempOff
+	 * T_degC = ((T_raw - 21) / 333.87) + 21
+	 * T_milliDegC = 1000 * (((T_raw - 21) / 333.87) + 21)
+	 * T_milliDegC = (1000 / 333.87) * (T_raw - 21 + (21 * 333.87))
+	 * T_milliDegC = (T_raw + 6990.27) * 2.995177
+
+	 * scale = 2.995177
+	 * offset = 6990.27
+	 */
+	case IIO_CHAN_INFO_SCALE:
+		*val = 2;
+		*val2 = 995177;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 6990;
+		*val2 = 270000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info inv_icm20948_temp_info = {
+	.read_raw = inv_icm20948_temp_read_raw,
+};
+
+struct iio_dev *inv_icm20948_temp_init(struct inv_icm20948_state *state)
+{
+	struct iio_dev *temp_dev = devm_iio_device_alloc(state->dev, 0);
+
+	if (!temp_dev)
+		return ERR_PTR(-ENOMEM);
+
+	iio_device_set_drvdata(temp_dev, state);
+
+	temp_dev->name = "icm20948-temp";
+	temp_dev->info = &inv_icm20948_temp_info;
+	temp_dev->modes = INDIO_DIRECT_MODE;
+	temp_dev->channels = &inv_icm20948_temp_chan;
+	temp_dev->num_channels = 1;
+
+	int ret = devm_iio_device_register(state->dev, temp_dev);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	return temp_dev;
+}

-- 
2.51.0


