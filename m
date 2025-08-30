Return-Path: <linux-iio+bounces-23493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D97CAB3CEC7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 20:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1892D18978E0
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194122DCC1B;
	Sat, 30 Aug 2025 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0RmojyJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11DD2DCBE2;
	Sat, 30 Aug 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579409; cv=none; b=sggnzHSGx7xu+fJRe3RIwmGCkNdd4AqMxEAlTHD6sz6e4E+C8lMFKV3/CtYFGWipGhEmBahlYGQIU+vqHtH0mtD76QtaIxys5jwFKYi9+Hn1cO9aq4SVp6vgQmD60YMDm6NMrlIAgfug0dgpMA6UTeCbfLX5qHE0lUT5o7TnmN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579409; c=relaxed/simple;
	bh=K7rF2bt3HkEHRZ3fBUFmWsLziT5AfBMIgTUQVX8HyuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VyPBeiZ4J7CWvUBI4CZEmPnqcp/H6Lw65cNwklr9FSJ1hPAgyzjljyo7f1X1gVlWsL9jSgKHSTsC4X55rToDjbBoRSWQQnfhGAGGC1GDHwHpweRy1MooWP5ephiY4Y2RGO9Pz+HYMmqHOdFxcQYKrx8sytAnhdd4SRkQTAw9g7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0RmojyJ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so1068870a12.1;
        Sat, 30 Aug 2025 11:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756579407; x=1757184207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vj1yS9O+gUXgXX+X1gAHTGjRed1btcU//114VX10TmI=;
        b=A0RmojyJySPNQD09ClOeWzc4zdQ4LQJI9V+n6GkvfckbhJqrc0HdJ377nqj8Xh96Pw
         qO9d1lQJTXLgyBvffqCsEeyRT4e4RO6nYVCyrhJOMGpawaIBegj15oXky0qUTNXDH70G
         QRZLEgvrp9s0qyW/pZWzIqxwFEsfV1a/cg8EtwME/kiYlW8+PeqHPG4J1k4BrIYYLmTZ
         DhJwlbnc71WIxaXZxJ3cj0wnySwbNOJmobKwbRkz/ogvDKdFoQLmFheuEOgSZeNo36GC
         b5w5BjWhkugq0H3bMg1QT2WmrhkGK9YYlcsrfYbk8jh6u6zgLCJtmp1xb/myt/5wPXCu
         LZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756579407; x=1757184207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj1yS9O+gUXgXX+X1gAHTGjRed1btcU//114VX10TmI=;
        b=XUWNYnZDqVJlEoU2O5KKBvFhCIax7itveRAMP1WvQVcA9ltFhBMhSV7oVJI2qK1x1Z
         rJoZzf1s4Gh3PCWTKB3XAqRlwoh9jlmHIY+XMpqGdNjg+Gt/1uTAf7CnMmY2Eg1TjYzV
         s15esoDL7XPN9QthYGGWO3vWAbyTa0CV3dHGAYJRUIpNeYTvw7VLy53oC2/J4JgFgUav
         SlyNJKzUTH2wi0PCfd/avwD/cVfuvrwteXTbejzhcQQ2h/+aiPd9YBcwpRbSz3JHZNCx
         D+BpO7H6wznBKFkMDIpzdfOb0oZaKfqXUpEP55afwVQoL/ak936S9hQtiM/RXS4dgDpz
         yZfg==
X-Forwarded-Encrypted: i=1; AJvYcCWpk+IhZT29SXSMqOO72ypuBVJKqVjY+GBXOhhutloy7qjZunSk5tpnME8Tcypq8J8pj4sa+TrC8572LPO0@vger.kernel.org, AJvYcCXHulKOAELTgTvrW6q8H2j6tkVMTnvLHpijGFRkdk9Xzs2U+Tyg7RHoGTThalYWlSQW6RFJjsqdmy/E@vger.kernel.org
X-Gm-Message-State: AOJu0YwYFTJfOzzER8rUrxHZVVrjZpF/zKycuNOgri9jcDoDaL4w/LsE
	ZlHgf949TgHgE45Pm6+f1vNpfhuKesrsDMmT8xSsb2xqHBorYhSCU9JkT7tICzPu
X-Gm-Gg: ASbGncu3YX+H1ADiFjn+yiMSnPDUDyvxKKyWiVfFnc9AFJrXEPRQDpbboMPI0nIO0kb
	ermp6sCI/bdF6ZWMtWROpLQvqB5lXC08+0TkfJPbov/cbzAq5Jg4hvbU9qNXURGWrx1DDZtS/sM
	L92U/xn4P6SEW8s42BFT/Z23ix/PR+GpX9mn9zuM1oJVk4fJv4v/8svunZ09AZCnmrRQ5bSd2oh
	5danVA4zXUFDNR1u0pX6ho7iSF7J58x4ik78nfV52+lxgeG8AyYEvoodqTc0KdkYOhYYXRJ/Okz
	h9FWvd+i3UydYVIEr1nII5R8d16DDA7Zo2ZGCkKEuxKulayTWZxwJQHJeK9bd+CpJLn+My3y+87
	ukGNA5djltzVNRaVlgHhBpGj+wMqcwuVcJe7Qfw==
X-Google-Smtp-Source: AGHT+IF3nKo2sqdBFb1VHTQ9UzNuttzGo/loyuiI3iilXsdQTk+0+TVLZktGEQ0//Aw9xC6ceTlNmQ==
X-Received: by 2002:a17:902:f549:b0:249:19b0:d3d4 with SMTP id d9443c01a7336-24944b63e3amr41398435ad.52.1756579407179;
        Sat, 30 Aug 2025 11:43:27 -0700 (PDT)
Received: from [192.168.1.19] ([122.177.240.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490658999fsm56821665ad.112.2025.08.30.11.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 11:43:26 -0700 (PDT)
From: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Date: Sun, 31 Aug 2025 00:12:47 +0530
Subject: [PATCH 3/5] iio: imu: icm20948: add support for gyroscope
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-icm20948-v1-3-1fe560a38de4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756579380; l=16670;
 i=bharadwaj.raju777@gmail.com; s=20250830; h=from:subject:message-id;
 bh=K7rF2bt3HkEHRZ3fBUFmWsLziT5AfBMIgTUQVX8HyuY=;
 b=A8nODpJCVi3yyJfBagvDCloX0wUl4046Av67JL5Is8u/vwO+wsVwSXRTFNZzCAAKNgmyh99MH
 IvMyrMHW68NB+EZjHVqZhzYcjnPJdkQKfL+5nV38MPtyzX1X+7wLZd8
X-Developer-Key: i=bharadwaj.raju777@gmail.com; a=ed25519;
 pk=s+pP76EgUCC/7pyu4E6Q5AizWQ1T6hUf1jUWrQRl040=

Add support for reading the gyroscope, which is exposed as another IIO
device under the icm20948 driver.

For now, the only configuration supported is changing the full-scale
range.

Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
---
 drivers/iio/imu/inv_icm20948/Makefile            |   1 +
 drivers/iio/imu/inv_icm20948/inv_icm20948.h      |  78 ++++--
 drivers/iio/imu/inv_icm20948/inv_icm20948_core.c |  55 ++--
 drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c | 343 +++++++++++++++++++++++
 4 files changed, 432 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/imu/inv_icm20948/Makefile b/drivers/iio/imu/inv_icm20948/Makefile
index c508c2dc3eee2c32be20067e3e0868a203d8aa1a..88a37be159e1d6f575da1c070c84ac94cd963020 100644
--- a/drivers/iio/imu/inv_icm20948/Makefile
+++ b/drivers/iio/imu/inv_icm20948/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_INV_ICM20948) += inv-icm20948.o
 inv-icm20948-y += inv_icm20948_core.o
 inv-icm20948-y += inv_icm20948_temp.o
+inv-icm20948-y += inv_icm20948_gyro.o
 
 obj-$(CONFIG_INV_ICM20948_I2C) += inv-icm20948-i2c.o
 inv-icm20948-i2c-y += inv_icm20948_i2c.o
diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948.h b/drivers/iio/imu/inv_icm20948/inv_icm20948.h
index f9830645fbe96fd02eef7c54d1e5908647d5a0fe..ca2513114378cdcba5bc315fc94cd61f930b4dfa 100644
--- a/drivers/iio/imu/inv_icm20948/inv_icm20948.h
+++ b/drivers/iio/imu/inv_icm20948/inv_icm20948.h
@@ -3,45 +3,83 @@
  * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
  */
 
-#ifndef INV_ICM20948_H_
-#define INV_ICM20948_H_
+ #ifndef INV_ICM20948_H_
+ #define INV_ICM20948_H_
 
-#include <linux/bits.h>
-#include <linux/bitfield.h>
-#include <linux/mutex.h>
-#include <linux/regmap.h>
-#include <linux/i2c.h>
-#include <linux/iio/iio.h>
-#include <linux/err.h>
+ #include <linux/bits.h>
+ #include <linux/bitfield.h>
+ #include <linux/mutex.h>
+ #include <linux/regmap.h>
+ #include <linux/i2c.h>
+ #include <linux/iio/iio.h>
+ #include <linux/err.h>
 
 /* accel takes 20ms, gyro takes 35ms to wake from full-chip sleep */
-#define INV_ICM20948_SLEEP_WAKEUP_MS 35
+ #define INV_ICM20948_SLEEP_WAKEUP_MS 35
 
-#define INV_ICM20948_REG_BANK_SEL 0x7F
-#define INV_ICM20948_BANK_SEL_MASK GENMASK(5, 4)
+ #define INV_ICM20948_REG_BANK_SEL 0x7F
+ #define INV_ICM20948_BANK_SEL_MASK GENMASK(5, 4)
 
-#define INV_ICM20948_REG_WHOAMI 0x0000
-#define INV_ICM20948_WHOAMI 0xEA
+ #define INV_ICM20948_REG_WHOAMI 0x0000
+ #define INV_ICM20948_WHOAMI 0xEA
 
-#define INV_ICM20948_REG_FIFO_RW 0x0072
+ #define INV_ICM20948_REG_FIFO_RW 0x0072
 
-#define INV_ICM20948_REG_PWR_MGMT_1 0x0006
-#define INV_ICM20948_PWR_MGMT_1_DEV_RESET BIT(7)
-#define INV_ICM20948_PWR_MGMT_1_SLEEP BIT(6)
+ #define INV_ICM20948_REG_PWR_MGMT_1 0x0006
+ #define INV_ICM20948_PWR_MGMT_1_DEV_RESET BIT(7)
+ #define INV_ICM20948_PWR_MGMT_1_SLEEP BIT(6)
 
-#define INV_ICM20948_REG_TEMP_DATA 0x0039
+ #define INV_ICM20948_REG_TEMP_DATA 0x0039
+
+ #define INV_ICM20948_REG_GYRO_DATA_X 0x0033
+ #define INV_ICM20948_REG_GYRO_DATA_Y 0x0035
+ #define INV_ICM20948_REG_GYRO_DATA_Z 0x0037
+
+ #define INV_ICM20948_REG_GYRO_CONFIG_1 0x2001
+ #define INV_ICM20948_GYRO_CONFIG_ENABLE_DLPF BIT(0)
+ #define INV_ICM20948_GYRO_CONFIG_FULLSCALE GENMASK(2, 1)
+ #define INV_ICM20948_GYRO_CONFIG_DLP_CONFIG GENMASK(5, 3)
+
+ #define INV_ICM20948_REG_GYRO_USER_OFFSET_X 0x2003
+ #define INV_ICM20948_REG_GYRO_USER_OFFSET_Y 0x2005
+ #define INV_ICM20948_REG_GYRO_USER_OFFSET_Z 0x2007
 
 extern const struct regmap_config inv_icm20948_regmap_config;
 
+enum inv_icm20948_gyro_fs {
+	INV_ICM20948_GYRO_FS_250 = 0,
+	INV_ICM20948_GYRO_FS_500 = 1,
+	INV_ICM20948_GYRO_FS_1000 = 2,
+	INV_ICM20948_GYRO_FS_2000 = 3,
+};
+
+enum inv_icm20948_gyro_avg {
+	INV_ICM20948_GYRO_AVG_1X = 0,
+	INV_ICM20948_GYRO_AVG_2X = 1,
+	INV_ICM20948_GYRO_AVG_4X = 2,
+	INV_ICM20948_GYRO_AVG_8X = 3,
+	INV_ICM20948_GYRO_AVG_16X = 4,
+	INV_ICM20948_GYRO_AVG_32X = 5,
+	INV_ICM20948_GYRO_AVG_64X = 6,
+	INV_ICM20948_GYRO_AVG_128X = 7,
+};
+
+struct inv_icm20948_gyro_config {
+	int fsr;
+};
+
 struct inv_icm20948_state {
 	struct device *dev;
 	struct regmap *regmap;
 	struct iio_dev *temp_dev;
+	struct iio_dev *gyro_dev;
+	struct inv_icm20948_gyro_config *gyro_conf;
 	struct mutex lock;
 };
 
 extern int inv_icm20948_core_probe(struct regmap *regmap);
 
 struct iio_dev *inv_icm20948_temp_init(struct inv_icm20948_state *state);
+struct iio_dev *inv_icm20948_gyro_init(struct inv_icm20948_state *state);
 
-#endif
+ #endif
diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
index ee9e4159cffa261f0326b146a4b3df2cbfbd7697..eb4f940de7013bf4ddeb69b6380a60fbde49964a 100644
--- a/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
+++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
  */
 
-#include "inv_icm20948.h"
+ #include "inv_icm20948.h"
 
 static const struct regmap_range_cfg inv_icm20948_regmap_ranges[] = {
 	{
@@ -66,36 +66,41 @@ EXPORT_SYMBOL_NS_GPL(inv_icm20948_regmap_config, "IIO_ICM20948");
 
 static int inv_icm20948_setup(struct inv_icm20948_state *state)
 {
-	guard(mutex)(&state->lock);
-
-	int reported_whoami;
-	int ret = regmap_read(state->regmap, INV_ICM20948_REG_WHOAMI,
-			      &reported_whoami);
-	if (ret)
-		return ret;
-	if (reported_whoami != INV_ICM20948_WHOAMI) {
-		dev_err(state->dev, "invalid whoami %d, expected %d\n",
-			reported_whoami, INV_ICM20948_WHOAMI);
-		return -ENODEV;
+	scoped_guard(mutex, &state->lock) {
+		int reported_whoami;
+		int ret = regmap_read(state->regmap, INV_ICM20948_REG_WHOAMI,
+				      &reported_whoami);
+		if (ret)
+			return ret;
+		if (reported_whoami != INV_ICM20948_WHOAMI) {
+			dev_err(state->dev, "invalid whoami %d, expected %d\n",
+				reported_whoami, INV_ICM20948_WHOAMI);
+			return -ENODEV;
+		}
+
+		ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
+					INV_ICM20948_PWR_MGMT_1_DEV_RESET,
+					INV_ICM20948_PWR_MGMT_1_DEV_RESET);
+		if (ret)
+			return ret;
+		msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
+
+		ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
+					INV_ICM20948_PWR_MGMT_1_SLEEP, 0);
+		if (ret)
+			return ret;
+
+		msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
 	}
 
-	ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
-				INV_ICM20948_PWR_MGMT_1_DEV_RESET,
-				INV_ICM20948_PWR_MGMT_1_DEV_RESET);
-	if (ret)
-		return ret;
-	msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
-
-	ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
-				INV_ICM20948_PWR_MGMT_1_SLEEP, 0);
-	if (ret)
-		return ret;
-	msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
-
 	state->temp_dev = inv_icm20948_temp_init(state);
 	if (IS_ERR(state->temp_dev))
 		return PTR_ERR(state->temp_dev);
 
+	state->gyro_dev = inv_icm20948_gyro_init(state);
+	if (IS_ERR(state->gyro_dev))
+		return PTR_ERR(state->gyro_dev);
+
 	return 0;
 }
 
diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c
new file mode 100644
index 0000000000000000000000000000000000000000..2d4d598eb21c8ce98d4ee3c72504554ab49ea596
--- /dev/null
+++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c
@@ -0,0 +1,343 @@
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
+/* IIO int + nano format */
+static const int inv_icm20948_gyro_scale[] = {
+	/* 250 dps == 0.000133158 rad/s per LSB */
+	[2 * INV_ICM20948_GYRO_FS_250] = 0,
+	[2 * INV_ICM20948_GYRO_FS_250 + 1] = 133158,
+	/* 500 dps == 0.000266316 rad/s per LSB */
+	[2 * INV_ICM20948_GYRO_FS_500] = 0,
+	[2 * INV_ICM20948_GYRO_FS_500 + 1] = 266316,
+	/* 1000 dps == 0.000532632 rad/s per LSB */
+	[2 * INV_ICM20948_GYRO_FS_1000] = 0,
+	[2 * INV_ICM20948_GYRO_FS_1000 + 1] = 532632,
+	/* 2000 dps == 0.001065264 rad/s per LSB */
+	[2 * INV_ICM20948_GYRO_FS_1000] = 0,
+	[2 * INV_ICM20948_GYRO_FS_1000 + 1] = 1065264,
+};
+
+/* Calibration bias, IIO range format int + nano */
+/* raw value -2**15 to +2**15, 0.0305 dps per LSB step */
+static const int inv_icm20948_gyro_calibbias_range[] = {
+	-17, 443239423, /* min */
+	0,   532325, /* step */
+	+17, 443239423, /* max */
+};
+
+#define INV_ICM20948_GYRO_CHAN(_dir) \
+	{		\
+		.type = IIO_ANGL_VEL,		\
+		.modified = 1,		\
+		.channel2 = IIO_MOD_##_dir,		\
+		.info_mask_separate =		\
+		  BIT(IIO_CHAN_INFO_RAW) |		\
+		  BIT(IIO_CHAN_INFO_CALIBBIAS),		\
+		.info_mask_shared_by_type =		\
+		  BIT(IIO_CHAN_INFO_SCALE),		\
+		.info_mask_shared_by_type_available =		\
+		  BIT(IIO_CHAN_INFO_SCALE) |		\
+		  BIT(IIO_CHAN_INFO_CALIBBIAS),		\
+		.info_mask_shared_by_all =		\
+		  BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+		.info_mask_shared_by_all_available =		\
+		  BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+		.scan_index = INV_ICM20948_GYRO_SCAN_##_dir,		\
+		.scan_type = {		\
+			.sign = 's',		\
+			.realbits = 16,		\
+			.endianness = IIO_BE,		\
+		},		\
+	}
+
+enum inv_icm20948_gyro_scan {
+	INV_ICM20948_GYRO_SCAN_X,
+	INV_ICM20948_GYRO_SCAN_Y,
+	INV_ICM20948_GYRO_SCAN_Z,
+};
+
+static const struct iio_chan_spec inv_icm20948_gyro_channels[] = {
+	INV_ICM20948_GYRO_CHAN(X),
+	INV_ICM20948_GYRO_CHAN(Y),
+	INV_ICM20948_GYRO_CHAN(Z),
+};
+
+static int inv_icm20948_gyro_apply_config(struct inv_icm20948_state *state)
+{
+	guard(mutex)(&state->lock);
+
+	return regmap_write_bits(state->regmap, INV_ICM20948_REG_GYRO_CONFIG_1,
+				 INV_ICM20948_GYRO_CONFIG_FULLSCALE,
+				 state->gyro_conf->fsr << 1);
+}
+
+static int inv_icm20948_gyro_read_sensor(struct inv_icm20948_state *state,
+					 struct iio_chan_spec const *chan,
+					 s16 *val)
+{
+	unsigned int reg;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM20948_REG_GYRO_DATA_X;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM20948_REG_GYRO_DATA_Y;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM20948_REG_GYRO_DATA_Z;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	__be16 raw;
+	int ret = regmap_bulk_read(state->regmap, reg, &raw, sizeof(raw));
+
+	if (ret)
+		return ret;
+
+	*val = (s16)be16_to_cpu(raw);
+
+	return 0;
+}
+
+static int inv_icm20948_gyro_read_calibbias(struct inv_icm20948_state *state,
+					    struct iio_chan_spec const *chan,
+					    int *val, int *val2)
+{
+	guard(mutex)(&state->lock);
+
+	unsigned int reg;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM20948_REG_GYRO_USER_OFFSET_X;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM20948_REG_GYRO_USER_OFFSET_Y;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM20948_REG_GYRO_USER_OFFSET_Z;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	__be16 offset_raw;
+	int ret = regmap_bulk_read(state->regmap, reg, &offset_raw,
+				   sizeof(offset_raw));
+
+	if (ret)
+		return ret;
+	int offset = be16_to_cpu(offset_raw);
+
+	/* step size = 0.0305 dps/LSB => +/- 999.24 dps over 16-bit range */
+	/* offset * 0.0305 * Pi * 10**9 (for nano) / 180 */
+	/* offset * 95818575.93448868 / 180 */
+	/* offset * 95818576 / 180 */
+	s64 val64 = (s64)offset * 95818576;
+	/* for rounding, add or subtract divisor/2 */
+	if (val64 >= 0)
+		val64 += 180 / 2;
+	else
+		val64 -= 180 / 2;
+
+	s64 bias = div_s64(val64, 180);
+
+	*val = bias / 1000000000L;
+	*val2 = bias % 1000000000L;
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int inv_icm20948_gyro_read_raw(struct iio_dev *gyro_dev,
+				      struct iio_chan_spec const *chan,
+				      int *val, int *val2, long mask)
+{
+	struct inv_icm20948_state *state = iio_device_get_drvdata(gyro_dev);
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(gyro_dev))
+			return -EBUSY;
+		s16 raw;
+		int ret = inv_icm20948_gyro_read_sensor(state, chan, &raw);
+
+		iio_device_release_direct(gyro_dev);
+		if (ret)
+			return ret;
+		*val = raw;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = inv_icm20948_gyro_scale[2 * state->gyro_conf->fsr + 1];
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm20948_gyro_read_calibbias(state, chan, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm20948_gyro_write_scale(struct inv_icm20948_state *state,
+					 int val, int val2)
+{
+	/* all supported scales are < 1.0 and > 0.0 */
+	if (val != 0)
+		return -EINVAL;
+
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm20948_gyro_scale); idx += 2) {
+		if (val2 == inv_icm20948_gyro_scale[idx + 1])
+			break;
+	}
+
+	if (idx >= ARRAY_SIZE(inv_icm20948_gyro_scale))
+		return -EINVAL;
+
+	state->gyro_conf->fsr = idx / 2;
+	return inv_icm20948_gyro_apply_config(state);
+}
+
+static int inv_icm20948_write_calibbias(struct inv_icm20948_state *state,
+					struct iio_chan_spec const *chan,
+					int val, int val2)
+{
+	guard(mutex)(&state->lock);
+
+	unsigned int reg;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM20948_REG_GYRO_USER_OFFSET_X;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM20948_REG_GYRO_USER_OFFSET_Y;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM20948_REG_GYRO_USER_OFFSET_Z;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	s64 bias = (s64)val * 100000000L + val2;
+	s64 val64 = bias * 180;
+
+	if (val64 >= 0)
+		val64 -= 180 / 2;
+	else
+		val64 += 180 / 2;
+
+	s64 offset64 = div_s64(val64, 95818576L);
+	s16 offset = clamp(offset64, (s64)S16_MIN, (s64)S16_MAX);
+	__be16 offset_write = cpu_to_be16(offset);
+
+	return regmap_bulk_write(state->regmap, reg, &offset_write,
+				 sizeof(offset_write));
+}
+
+static int inv_icm20948_gyro_write_raw(struct iio_dev *gyro_dev,
+				       struct iio_chan_spec const *chan,
+				       int val, int val2, long mask)
+{
+	struct inv_icm20948_state *state = iio_device_get_drvdata(gyro_dev);
+
+	int ret;
+
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (!iio_device_claim_direct(gyro_dev))
+			return -EBUSY;
+		ret = inv_icm20948_gyro_write_scale(state, val, val2);
+		iio_device_release_direct(gyro_dev);
+		return ret;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (!iio_device_claim_direct(gyro_dev))
+			return -EBUSY;
+		ret = inv_icm20948_write_calibbias(state, chan, val, val2);
+		iio_device_release_direct(gyro_dev);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm20948_gyro_read_avail(struct iio_dev *gyro_dev,
+					struct iio_chan_spec const *chan,
+					const int **vals, int *type,
+					int *length, long mask)
+{
+	if (chan->type != IIO_ANGL_VEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = inv_icm20948_gyro_scale;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(inv_icm20948_gyro_scale);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = inv_icm20948_gyro_calibbias_range;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(inv_icm20948_gyro_calibbias_range);
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info inv_icm20948_gyro_info = {
+	.read_raw = inv_icm20948_gyro_read_raw,
+	.write_raw = inv_icm20948_gyro_write_raw,
+	.read_avail = inv_icm20948_gyro_read_avail,
+};
+
+struct iio_dev *inv_icm20948_gyro_init(struct inv_icm20948_state *state)
+{
+	struct iio_dev *gyro_dev = devm_iio_device_alloc(state->dev, 0);
+
+	if (!gyro_dev)
+		return ERR_PTR(-ENOMEM);
+
+	iio_device_set_drvdata(gyro_dev, state);
+
+	gyro_dev->name = "icm20948-gyro";
+	gyro_dev->info = &inv_icm20948_gyro_info;
+	gyro_dev->modes = INDIO_DIRECT_MODE;
+	gyro_dev->channels = inv_icm20948_gyro_channels;
+	gyro_dev->num_channels = ARRAY_SIZE(inv_icm20948_gyro_channels);
+
+	int ret = devm_iio_device_register(state->dev, gyro_dev);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	state->gyro_conf =
+		devm_kzalloc(state->dev, sizeof(*state->gyro_conf), GFP_KERNEL);
+	if (!state->gyro_conf)
+		return ERR_PTR(-ENOMEM);
+
+	state->gyro_conf->fsr = INV_ICM20948_GYRO_FS_250;
+	ret = inv_icm20948_gyro_apply_config(state);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return gyro_dev;
+}

-- 
2.51.0


