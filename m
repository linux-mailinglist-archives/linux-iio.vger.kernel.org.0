Return-Path: <linux-iio+bounces-27479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA03CF20C6
	for <lists+linux-iio@lfdr.de>; Mon, 05 Jan 2026 07:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B853D300E174
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jan 2026 06:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A0430CD87;
	Mon,  5 Jan 2026 06:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6iQB+9f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA9E23D7FC
	for <linux-iio@vger.kernel.org>; Mon,  5 Jan 2026 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767593418; cv=none; b=aIkKZ5afbdR0QbgsVyiIp0Ymf6REuWEJ0/tx0RFTik9jCf8Ts6NCggMeOeYVTSJSySzwQkFqVN+fNxNSrIKCgIc7RG3gsqcaMKyZ86VjmMvgfAh8I3eI/Z5zPRMTFKE5Gx4I1wXoWrFb1qjBKJ+0awYyzc/IP1ya2EiJob3whTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767593418; c=relaxed/simple;
	bh=qvpC/YF/l5FlzaXSoJKoDh6j5g0khuuj0Qt93m9t9PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WilXuKBjsA8QecdBX15EjS9C3vnTyXvhX2uHalQnRY0W5Maec5Cm47TvBLv+jW6aXBoRfIE12qNtVJZSTpEaj6FSsE1M7/mTPonSSOo2xzmtLfsZk3cbXYJ8LkbC+iNXR5iIgV4t6qBviV1qrgLwcAyL6+5AQz/UCrRnhpsxwJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6iQB+9f; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c0c24d0f4ceso7973050a12.1
        for <linux-iio@vger.kernel.org>; Sun, 04 Jan 2026 22:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767593416; x=1768198216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rHJtUQb0A/mhz54yzwiGHDmjdFo5KL8B7QpAOP5snJE=;
        b=b6iQB+9fBS0aCtKhWH6K9UA9DBPtFGU1KpUDHK5EGYga40VGzWyLnjW4rlSKvvBP2z
         7Vp3wuuhGRuJYDuyOSILfGrsFDsOaRiGKmN3Oo1lcTfY9xbCIxvbcDrszA33KNkm9MM7
         f39XAcMyancQJsJOSdbrFu3Q9ehMo680hUjjxRmCQK/ZEqI3hyA7/UnpRTtcv65rLp3L
         Deub2XRREch00ITALT8dDEFu55jIWvVB12qm8OvSQFkFqdAj0Mku2sQs7PR0WPXEgxVI
         hPSMfQa2xUkD65dGj+hUoz7sRxYXKJOHPE9JajOofiUWdBTwqkBtmnMCQIm3DpGee5bh
         FuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767593416; x=1768198216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHJtUQb0A/mhz54yzwiGHDmjdFo5KL8B7QpAOP5snJE=;
        b=H1TfAz6R4DRnZxWcrW0d4DGm9cgT1yoo+rKBAerNXkhb0vVqhq1Blwo7fklWL72qWz
         Xflm+xST3a0/bNx/gezL5bHn/0+H3DXSqn9WxB+m/i4XroXQReVuVioNNeSs0EmXm7KI
         spO942g1rxfwCftV7ZjdcwxB8DWZQHWXTPuvSRiqtb/Z+oL+kUqkGajBUQj3dj0NOtdH
         h7BuCerFQrajvYf5V/1YrhA4Hmrqn12HJGzUfKzpE0SS4pPM11ViY3hjbhZC2OHlG+4J
         PqVlTNo0rTBf9cDjATZ1N9AaTVvahpW8hNEYhi7QRHo7ZT3K5uPYx0tL9f6uAXeTZ+vz
         ufDw==
X-Forwarded-Encrypted: i=1; AJvYcCXMuoe/gUGPZLKLs+13oN4PGAwdbCs5mK6lEDfeogfo8RiwqS14dx/LQqzqBs9nQJaiERVuBSiXkqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHc62xMT1yh/80HSM15jM/OCEhZK78nGVviG+D/2I7C732CmBV
	U4XF9EaLdK/W9mJxoIf+WhEswNXuItw19ovErVMZCH1jF1v7UUkXr5gm
X-Gm-Gg: AY/fxX65VssCiM7T2dinkKi6lnlKxMkpiP8YOAfwHnKx5euKBVazPgedTEnQkFvGSol
	XsT1X6GWOrO837zaJwKM+J+nNMzn54AO+0x8j+STq5UqwgGbpXT+k5rULVW7McROK6+FHqxHoGQ
	KiOxdGGdu4S+SH7MGzx4xZIVYnODfsY2Q9lIvUJW2BwRBUn4bWyvOyp8aB/dOznu03KvJScxcxG
	cCvvARW1ANsP72pxtf3bA2VHYqigzqZCKabcpd1XJsxiPQNB3IZD2LT1EKNyBXKJEoqZwc68Rx1
	lfFWtuJ2PgBBmdpgk1l0tkV62RvWIftCHhvavet2rxUhhXkM1yk8BFTQVJxfR2PHhEEj/jM/rfm
	6WS0+ahVJm5shb7o5N8Y/9Q1qn9Rj2d6Mf8MGVq+yjiJHtkl6auGFLhB+DPTmQ2hn3VTy8Kupgp
	Gd7GUs+YJLyrt53DjRFN/h
X-Google-Smtp-Source: AGHT+IFux037pYXSM/nK+a35vAhJ08w/hzv51KAjgsRlJkYOD8Cgj/aunwGxUmabj2FO5CXuYZMtCg==
X-Received: by 2002:a05:7022:6294:b0:11b:9b9f:427a with SMTP id a92af1059eb24-121722b4fdfmr46030833c88.21.1767593416335;
        Sun, 04 Jan 2026 22:10:16 -0800 (PST)
Received: from gyrocopter ([76.174.137.141])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm134338472c88.8.2026.01.04.22.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 22:10:15 -0800 (PST)
From: Michael Harris <michaelharriscode@gmail.com>
To: gregkh@linuxfoundation.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: iio: adt7316: modernize power management
Date: Sun,  4 Jan 2026 22:08:03 -0800
Message-ID: <20260105060803.2315274-1-michaelharriscode@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaced use of deprecated function SIMPLE_DEV_PM_OPS with
EXPORT_GPL_SIMPLE_DEV_PM_OPS.

Removed PM preprocessor conditions with usage of pm_sleep_ptr function.

Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
---
v2: Corrected staging list email address
---

 drivers/staging/iio/addac/adt7316-i2c.c | 2 +-
 drivers/staging/iio/addac/adt7316-spi.c | 2 +-
 drivers/staging/iio/addac/adt7316.c     | 6 ++----
 drivers/staging/iio/addac/adt7316.h     | 6 +-----
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index f45968ef94ea..3bdaee925dee 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -136,7 +136,7 @@ static struct i2c_driver adt7316_driver = {
 	.driver = {
 		.name = "adt7316",
 		.of_match_table = adt7316_of_match,
-		.pm = ADT7316_PM_OPS,
+		.pm = pm_sleep_ptr(&adt7316_pm_ops),
 	},
 	.probe = adt7316_i2c_probe,
 	.id_table = adt7316_i2c_id,
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index af513e003da7..f91325d11394 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -142,7 +142,7 @@ static struct spi_driver adt7316_driver = {
 	.driver = {
 		.name = "adt7316",
 		.of_match_table = adt7316_of_spi_match,
-		.pm = ADT7316_PM_OPS,
+		.pm = pm_sleep_ptr(&adt7316_pm_ops),
 	},
 	.probe = adt7316_spi_probe,
 	.id_table = adt7316_spi_id,
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 8a9a8262c2be..59fb3bd26bc1 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2082,7 +2082,6 @@ static const struct attribute_group adt7516_event_attribute_group = {
 	.name = "events",
 };
 
-#ifdef CONFIG_PM_SLEEP
 static int adt7316_disable(struct device *dev)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
@@ -2098,9 +2097,8 @@ static int adt7316_enable(struct device *dev)
 
 	return _adt7316_store_enabled(chip, 1);
 }
-EXPORT_SYMBOL_GPL(adt7316_pm_ops);
-SIMPLE_DEV_PM_OPS(adt7316_pm_ops, adt7316_disable, adt7316_enable);
-#endif
+
+EXPORT_GPL_SIMPLE_DEV_PM_OPS(adt7316_pm_ops, adt7316_disable, adt7316_enable);
 
 static const struct iio_info adt7316_info = {
 	.attrs = &adt7316_attribute_group,
diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
index 8c2a92ae7157..f208f0d3583a 100644
--- a/drivers/staging/iio/addac/adt7316.h
+++ b/drivers/staging/iio/addac/adt7316.h
@@ -22,12 +22,8 @@ struct adt7316_bus {
 	int (*multi_write)(void *client, u8 first_reg, u8 count, u8 *data);
 };
 
-#ifdef CONFIG_PM_SLEEP
 extern const struct dev_pm_ops adt7316_pm_ops;
-#define ADT7316_PM_OPS (&adt7316_pm_ops)
-#else
-#define ADT7316_PM_OPS NULL
-#endif
+
 int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 		  const char *name);
 
-- 
2.52.0


