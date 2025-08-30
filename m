Return-Path: <linux-iio+bounces-23495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC202B3CECE
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 20:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C26B1899A8D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673692D9EF8;
	Sat, 30 Aug 2025 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5OItFOn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751CF2DCBE2;
	Sat, 30 Aug 2025 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579419; cv=none; b=RyzwJliwzVQYkFw2/K/0ItFqIfljvKAqSLWxwYcD0ZPpzYNomFH5YTFJCJBbCr43h57R/sZ9KgcZDMFP+LIErwdjP6pDHkDJlmvFU9Z5p3PxINDfTNnrEbPEcN1MZbEs3ZuKWPkmO7/AR3QYRrnIAYlf1Ie1PTVUb+zzVPGC118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579419; c=relaxed/simple;
	bh=YtIGNLXaQcmkc4Bi2x5bHdVSJylHl4+GAVTUbZPrAjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rSmxxkcKvzH4i4o9WlaBFwR6x8L1NJzLWPRlS64y9Cm8mgcfJRIJ3vnNMma7+a+K5iNDsg24FDsRl7Z6rGlj03vgSnlYOxwNh0wKawU96TsAv5VxtAMAzR/H+PXCdZhtBhozySbBvl0TjU1WUrvAE1+yFDCnu2uR1uA+Qle0xAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5OItFOn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-248c7f955a2so28199715ad.2;
        Sat, 30 Aug 2025 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756579417; x=1757184217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPo8Q3Bu4jk8j+Uw+RLNhPXNNzhpQ7JonMOG41K09VA=;
        b=I5OItFOng0mL1Vb/IePpYM+3PBjnK/JxtwOVLEYMKrj9CQXUk8oQOEfVD9mIYwU0hJ
         HABNatyGQcWZZnmuZCde7dfY63+JILHZ5hXJfg9MGpsFsM3wPOI15VQzilqhT7xEILhw
         t51dxwcnG0ysgdAZlJf1gLR2MlXoNzHg2ad+Eoe6ghMwfMHlhoPpr/9Hp6GVCS9Ly4Rx
         cPvFLuN9JYQFMGUl7uPQV2WerpaE1XmjwnA1qpIkSABSXGMJ8urFhcRAmIVcs80ZNT3E
         qlGjtn2iVuziv1PwN1D8yXgqYkVSywnIAyc6am/9ZjS+Ckf3ESqOU1MV5UsFZ02pVLMA
         lEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756579417; x=1757184217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPo8Q3Bu4jk8j+Uw+RLNhPXNNzhpQ7JonMOG41K09VA=;
        b=LYPYfpz9O8inNEj1O21MaY53k3YOafUu7X9cn8UnYG3x4HVmZn/WcU8zgsDPdKq40E
         P6S8i///YFHR+z8SB87/qKL0uCgkW+sZrtBk/riMjjnBU9mmfhnHipeqpm0tLian4HrP
         wdVRSh3lF1DeYSuuw6N5BYm9ORNFn1KrpJww4ySUiRX7oBu8K1F4YE4NbK9jqCxkWGfR
         RSyn5cJNtIWFaF3JlkHn57ToTOaKH9a2pDAlJiBwESpqG1SSIF4Y1z6eTfog5BDCv/0k
         6B/CTcK1g86Kd1G2J/KDyiHp/DIGxH/8beiSZztuXldswOT8IX3A1UUNSfr2RIv6GuHv
         f3xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh7QYJ0hZfVXHZq1gohYjbbLu4HVBwRePpoRj5CDbtoCcqM2tPPxeyi4UlnpRPn88xr/dFC+LDO3p8hQNW@vger.kernel.org, AJvYcCVtgQh0nnfs706cXr5D88gXFGu6/m4yJLwUnU4ozr6EVY31h/OIi43B3H+RChr9hJ48Kb5n8ql3cfuV@vger.kernel.org
X-Gm-Message-State: AOJu0YzevKM7tvLZjz592+mqHNDjKxPYYBqqqrXN55YeILMCvHZ5B942
	W9Wey3VGH4jw/7GK/1qGiAE/07B3ARai3BWusc/U+kTlGAeP37h1/Te8
X-Gm-Gg: ASbGncuUMilKnV1e5rv1mGROeMtuJ8cdIpYObOwRFBb8rsVB/sIc9LLt7oixm+kD7A5
	DbLsApkWSxP11oac2ulvQj5EFE/YOKaOK7ZBugA5Az0j8LcP4mUwQm8cqoGvvcxAl0E36mxTzJt
	6R1toqvBA2BZNzFfZkAXYm6L1FWaAvDnqSIQOD7QOJxUJHgeIzGhfml6m/YfTSZ2RwcF4MEGq5N
	PEC6Kr+YL0x68uUO0ovI+WvgdCHFATBa1Ejd0bwUeAzwty65bKnFUMsqz9nOx/StKLfNx2ANpUy
	Qm6sK5P+7GZ2Vhv/BqeU2iJovAftsLgALFRbU0Pf/yihPyyUKL6fFs3hjJSwBHlbnaaOEDIc+lu
	3DjcVYtMDMsJZ34hthN0TMQ35k3x1IMMBgQiLrgOiFV0oFECFokupUsBxEhU=
X-Google-Smtp-Source: AGHT+IGatw6wqMSc9flLFH26sU9wlID4+2HyjBNw0BsJSxIrSeTya3p2EMyW+F3Cs0eWgDVkPaYYkg==
X-Received: by 2002:a17:903:380f:b0:246:de71:1839 with SMTP id d9443c01a7336-24944b64760mr36733385ad.50.1756579416680;
        Sat, 30 Aug 2025 11:43:36 -0700 (PDT)
Received: from [192.168.1.19] ([122.177.240.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490658999fsm56821665ad.112.2025.08.30.11.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 11:43:36 -0700 (PDT)
From: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Date: Sun, 31 Aug 2025 00:12:49 +0530
Subject: [PATCH 5/5] iio: imu: icm20948: add runtime power management
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-icm20948-v1-5-1fe560a38de4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756579380; l=9361;
 i=bharadwaj.raju777@gmail.com; s=20250830; h=from:subject:message-id;
 bh=YtIGNLXaQcmkc4Bi2x5bHdVSJylHl4+GAVTUbZPrAjo=;
 b=yj+v3a5GPXh26ZZOPJo4IfImx0oV3vCZhKBkPDgy5xpF0Plr/GhZS5aIqV+ZZKLqyYJX4fxKW
 eIrvJwehusNCpooAon7s0K1Ky2slKs4/K9XoxSmWZJBacQ5iOCXG3b7
X-Developer-Key: i=bharadwaj.raju777@gmail.com; a=ed25519;
 pk=s+pP76EgUCC/7pyu4E6Q5AizWQ1T6hUf1jUWrQRl040=

Implement runtime power management support for the ICM20948
sensor. The device autosuspends after 2 seconds of idle time.

Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
---
 drivers/iio/imu/inv_icm20948/Makefile             |  1 +
 drivers/iio/imu/inv_icm20948/inv_icm20948.h       |  7 +++
 drivers/iio/imu/inv_icm20948/inv_icm20948_core.c  |  3 +-
 drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c  | 28 ++++++---
 drivers/iio/imu/inv_icm20948/inv_icm20948_power.c | 73 +++++++++++++++++++++++
 drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c  | 15 +++--
 6 files changed, 114 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/inv_icm20948/Makefile b/drivers/iio/imu/inv_icm20948/Makefile
index 88a37be159e1d6f575da1c070c84ac94cd963020..0a17ad1c003e6a93f3431f7a998e56cdf975d245 100644
--- a/drivers/iio/imu/inv_icm20948/Makefile
+++ b/drivers/iio/imu/inv_icm20948/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_INV_ICM20948) += inv-icm20948.o
 inv-icm20948-y += inv_icm20948_core.o
 inv-icm20948-y += inv_icm20948_temp.o
 inv-icm20948-y += inv_icm20948_gyro.o
+inv-icm20948-y += inv_icm20948_power.o
 
 obj-$(CONFIG_INV_ICM20948_I2C) += inv-icm20948-i2c.o
 inv-icm20948-i2c-y += inv_icm20948_i2c.o
diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948.h b/drivers/iio/imu/inv_icm20948/inv_icm20948.h
index ca2513114378cdcba5bc315fc94cd61f930b4dfa..194dcccabc2162334779b285320187c7ff1f5236 100644
--- a/drivers/iio/imu/inv_icm20948/inv_icm20948.h
+++ b/drivers/iio/imu/inv_icm20948/inv_icm20948.h
@@ -13,10 +13,13 @@
  #include <linux/i2c.h>
  #include <linux/iio/iio.h>
  #include <linux/err.h>
+ #include <linux/pm_runtime.h>
 
 /* accel takes 20ms, gyro takes 35ms to wake from full-chip sleep */
  #define INV_ICM20948_SLEEP_WAKEUP_MS 35
 
+ #define INV_ICM20948_SUSPEND_DELAY_MS 2000
+
  #define INV_ICM20948_REG_BANK_SEL 0x7F
  #define INV_ICM20948_BANK_SEL_MASK GENMASK(5, 4)
 
@@ -46,6 +49,8 @@
 
 extern const struct regmap_config inv_icm20948_regmap_config;
 
+extern const struct dev_pm_ops inv_icm20948_pm_ops;
+
 enum inv_icm20948_gyro_fs {
 	INV_ICM20948_GYRO_FS_250 = 0,
 	INV_ICM20948_GYRO_FS_500 = 1,
@@ -82,4 +87,6 @@ extern int inv_icm20948_core_probe(struct regmap *regmap);
 struct iio_dev *inv_icm20948_temp_init(struct inv_icm20948_state *state);
 struct iio_dev *inv_icm20948_gyro_init(struct inv_icm20948_state *state);
 
+int inv_icm20948_pm_setup(struct inv_icm20948_state *state);
+
  #endif
diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
index eb4f940de7013bf4ddeb69b6380a60fbde49964a..e6e670d96e40c3663e55d1545b52f609603a02ed 100644
--- a/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
+++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_core.c
@@ -101,7 +101,7 @@ static int inv_icm20948_setup(struct inv_icm20948_state *state)
 	if (IS_ERR(state->gyro_dev))
 		return PTR_ERR(state->gyro_dev);
 
-	return 0;
+	return inv_icm20948_pm_setup(state);
 }
 
 int inv_icm20948_core_probe(struct regmap *regmap)
@@ -113,6 +113,7 @@ int inv_icm20948_core_probe(struct regmap *regmap)
 	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
 	if (!state)
 		return -ENOMEM;
+	dev_set_drvdata(dev, state);
 
 	state->regmap = regmap;
 	state->dev = dev;
diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c
index 2d4d598eb21c8ce98d4ee3c72504554ab49ea596..9cefb47a46b1a323202aa84f0de647d7b7b89728 100644
--- a/drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c
+++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c
@@ -73,10 +73,14 @@ static const struct iio_chan_spec inv_icm20948_gyro_channels[] = {
 static int inv_icm20948_gyro_apply_config(struct inv_icm20948_state *state)
 {
 	guard(mutex)(&state->lock);
+	pm_runtime_get_sync(state->dev);
 
-	return regmap_write_bits(state->regmap, INV_ICM20948_REG_GYRO_CONFIG_1,
+	int ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_GYRO_CONFIG_1,
 				 INV_ICM20948_GYRO_CONFIG_FULLSCALE,
 				 state->gyro_conf->fsr << 1);
+
+	pm_runtime_put_autosuspend(state->dev);
+	return ret;
 }
 
 static int inv_icm20948_gyro_read_sensor(struct inv_icm20948_state *state,
@@ -99,23 +103,25 @@ static int inv_icm20948_gyro_read_sensor(struct inv_icm20948_state *state,
 		return -EINVAL;
 	}
 
+	pm_runtime_get_sync(state->dev);
+
 	__be16 raw;
 	int ret = regmap_bulk_read(state->regmap, reg, &raw, sizeof(raw));
 
 	if (ret)
-		return ret;
+		goto out;
 
 	*val = (s16)be16_to_cpu(raw);
 
-	return 0;
+out:
+	pm_runtime_put_autosuspend(state->dev);
+	return ret;
 }
 
 static int inv_icm20948_gyro_read_calibbias(struct inv_icm20948_state *state,
 					    struct iio_chan_spec const *chan,
 					    int *val, int *val2)
 {
-	guard(mutex)(&state->lock);
-
 	unsigned int reg;
 
 	switch (chan->channel2) {
@@ -133,8 +139,11 @@ static int inv_icm20948_gyro_read_calibbias(struct inv_icm20948_state *state,
 	}
 
 	__be16 offset_raw;
+
+	pm_runtime_get_sync(state->dev);
 	int ret = regmap_bulk_read(state->regmap, reg, &offset_raw,
 				   sizeof(offset_raw));
+	pm_runtime_put_autosuspend(state->dev);
 
 	if (ret)
 		return ret;
@@ -216,8 +225,6 @@ static int inv_icm20948_write_calibbias(struct inv_icm20948_state *state,
 					struct iio_chan_spec const *chan,
 					int val, int val2)
 {
-	guard(mutex)(&state->lock);
-
 	unsigned int reg;
 
 	switch (chan->channel2) {
@@ -246,8 +253,13 @@ static int inv_icm20948_write_calibbias(struct inv_icm20948_state *state,
 	s16 offset = clamp(offset64, (s64)S16_MIN, (s64)S16_MAX);
 	__be16 offset_write = cpu_to_be16(offset);
 
-	return regmap_bulk_write(state->regmap, reg, &offset_write,
+	pm_runtime_get_sync(state->dev);
+	mutex_lock(&state->lock);
+	int ret = regmap_bulk_write(state->regmap, reg, &offset_write,
 				 sizeof(offset_write));
+	mutex_unlock(&state->lock);
+	pm_runtime_put_autosuspend(state->dev);
+	return ret;
 }
 
 static int inv_icm20948_gyro_write_raw(struct iio_dev *gyro_dev,
diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_power.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_power.c
new file mode 100644
index 0000000000000000000000000000000000000000..1281a5e5acb539cd3f91ca8ed8d52371f330b60a
--- /dev/null
+++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_power.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
+ */
+
+#include "inv_icm20948.h"
+
+static int inv_icm20948_suspend(struct device *dev)
+{
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	struct inv_icm20948_state *state = dev_get_drvdata(dev);
+
+	guard(mutex)(&state->lock);
+
+	return regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
+				 INV_ICM20948_PWR_MGMT_1_SLEEP,
+				 INV_ICM20948_PWR_MGMT_1_SLEEP);
+}
+
+static int inv_icm20948_resume(struct device *dev)
+{
+	struct inv_icm20948_state *state = dev_get_drvdata(dev);
+
+	guard(mutex)(&state->lock);
+
+	pm_runtime_disable(state->dev);
+	pm_runtime_set_active(state->dev);
+	pm_runtime_enable(state->dev);
+
+	int ret = regmap_write_bits(state->regmap, INV_ICM20948_REG_PWR_MGMT_1,
+				    INV_ICM20948_PWR_MGMT_1_SLEEP, 0);
+	if (ret)
+		return ret;
+
+	msleep(INV_ICM20948_SLEEP_WAKEUP_MS);
+
+	return 0;
+}
+
+static void inv_icm20948_pm_disable(void *data)
+{
+	struct device *dev = data;
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+}
+
+int inv_icm20948_pm_setup(struct inv_icm20948_state *state)
+{
+	struct device *dev = state->dev;
+
+	guard(mutex)(&state->lock);
+
+	int ret;
+
+	ret = pm_runtime_set_active(dev);
+	if (ret)
+		return ret;
+	pm_runtime_get_noresume(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, INV_ICM20948_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_put(dev);
+
+	return devm_add_action_or_reset(dev, inv_icm20948_pm_disable, dev);
+}
+
+EXPORT_NS_GPL_DEV_PM_OPS(inv_icm20948_pm_ops, IIO_ICM20948) = {
+	SYSTEM_SLEEP_PM_OPS(inv_icm20948_suspend, inv_icm20948_resume)
+	RUNTIME_PM_OPS(inv_icm20948_suspend, inv_icm20948_resume, NULL)
+};
diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c b/drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c
index 916053740cc5acda0316c76504d4086eff5ec7f0..6e17b3719301d6d7f005d545587f558fcadd2f40 100644
--- a/drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c
+++ b/drivers/iio/imu/inv_icm20948/inv_icm20948_temp.c
@@ -24,17 +24,24 @@ static const struct iio_chan_spec
 static int inv_icm20948_temp_read_sensor(struct inv_icm20948_state *state,
 					 s16 *temp)
 {
-	guard(mutex)(&state->lock);
+	int ret;
+
+	pm_runtime_get_sync(state->dev);
+	mutex_lock(&state->lock);
 
 	__be16 raw;
-	int ret = regmap_bulk_read(state->regmap, INV_ICM20948_REG_TEMP_DATA,
+	ret = regmap_bulk_read(state->regmap, INV_ICM20948_REG_TEMP_DATA,
 				   &raw, sizeof(raw));
 	if (ret)
-		return ret;
+		goto out;
 
 	*temp = __be16_to_cpu(raw);
+	ret = 0;
 
-	return 0;
+out:
+	mutex_unlock(&state->lock);
+	pm_runtime_put_autosuspend(state->dev);
+	return ret;
 }
 
 static int inv_icm20948_temp_read_raw(struct iio_dev *temp_dev,

-- 
2.51.0


