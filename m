Return-Path: <linux-iio+bounces-27478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6067CF2045
	for <lists+linux-iio@lfdr.de>; Mon, 05 Jan 2026 06:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CFA53003071
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jan 2026 05:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CEE27FD43;
	Mon,  5 Jan 2026 05:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU2tGxs/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022353A1E63
	for <linux-iio@vger.kernel.org>; Mon,  5 Jan 2026 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767591652; cv=none; b=tuunHlAefmoaHNT4R5xBXtQoSfbk2/+vJ3dirqnzRHSzmFFMkEPUJrz5LFb28JB1lQZc/NNw21SD85x503jvJ8f2wFVT2ww4TkLr4YxQ/4hvBgIsy9QVyr/9oUpeOphxFwQ8xBl5GZxceP4WauFfcWUcJY4m0Ifa0yOtcfZEP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767591652; c=relaxed/simple;
	bh=nVetKFiniY+pyq12INTLbvV4dQfJMGJUbDFjs3iD5N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIULa8GxBiG0vc3Wz2ghASZf4KKzhla0buDelamKN+IoT9fjN++p1UE8H7YK7OJ28K8Td6iOAM9QMVHHq9jERCaj2NtUA/gI6sZ0J+oZFjU/r+TBUUpIwUqt3sLzf/ARlk2ktAbvdtc/u9IFQq09nmn+sTXZQ+F/L1PDmpf8TFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU2tGxs/; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so1378396eec.0
        for <linux-iio@vger.kernel.org>; Sun, 04 Jan 2026 21:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767591650; x=1768196450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/siz1sGL+rHoPXRyi1dYN5AnuY0dRJ8z6Ho+34PBemY=;
        b=BU2tGxs/13A7j1S5uf59lAYb31FenTC0OlY+HIwYoZq2kYUC1zamx0ujZWpHCVLANN
         K/TQr9Hnsf/pcMhN9eHeBFwDbgernQfIr5xrQm7ihvsNyKgQwYTfymKgM8Fy3IFU71x9
         BKqU2h8V55xOrkIROAnHbI5ZPMqW57sqDXykvr18UH0Dhu8YzmnWSCugVRB0gAIlYAIf
         JX3qZc+NRgzpRtHOSI8uIVdeDlN0Bbs9epZfS0lcYpFu6kjTKO44jjH6hvof2RRgVkjj
         VbJ0Cvsu8pr/+mTo7lgct1HMzrs4Pi45RKdabyuDdpbUcU55Gd13bKNZWJj4jGg4qG0v
         Pc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767591650; x=1768196450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/siz1sGL+rHoPXRyi1dYN5AnuY0dRJ8z6Ho+34PBemY=;
        b=I3680tDKrOrnGRF0g2Zb59/HH4nRDNHrPucgdnPLH0AESzpuG3XJ9AhYKGdLAwU7QD
         g5zlOHWbSc+BqBZ/DuBWSIdx+U7fk2zr3b2C1dw3WUf8u6RSMHHOG/N8sqseHETZr8o4
         td5mVL1ccS/6isUOqPzJmT6zv7CQ9CviReyby8mRAJUaJ+Dh91OnuvODjxtUBVPvXGuZ
         +iNPHqbHRNwyDpUZ3IBx+sc8eni1zRv/y8GDTOGT0rdh7MPWrjXkpTrnX0986xF5JTTq
         f2FloR6sdJcxW/sq5g8xxWR/yW5MwHVg4x+Z7gGdRlpAEFqVT5673q+eb2mBEmFZaOXR
         tZSg==
X-Forwarded-Encrypted: i=1; AJvYcCXY1QHH0OARLVyLzP6GUPMeuLeIuq6o2RhTTzT2Gl3D7O396sKL0LJfqTvlZ6mmWRpdrHu+JAaoxZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo/2sdam9RvpAAVw6TopPauGPxQ99QXdaUiCYcNJUIPl9sNP5l
	XLgAvKJI30lRYlB3w9mNbYlntWNq8FxotWX4pXfc31QYwq+TDTzeT7qe
X-Gm-Gg: AY/fxX4fkfbr52nPOs0T4AhcIZoodDaGVWpACADQtjDibPVxA+asLLDHAz4k0Ta/MIP
	fjH3UL5w5pbgK9Wu7b5IqHH60P4iJ5mPKOmWnYQ7fT/huZet/kiE4qlzp58Hjzp+Ur6QiM3GAT4
	eP9SkQIeZbIpNu/N4r0gBpMddgCXy7fE303GxouYBx8YGrNd0hdkiEw8wmlvM5CErpSIkgCWGOD
	a2/LPsfYUQmblBHkCxzZjdN8NocmEo3CaC8CgUv54i2uErazOg4uSHjfpfYq6kaUwhUfKx9L3J6
	oG90HGvkgYdSeFodnD45FnsNP96MVjTH6jbDCKi7ptwOPEH09khlX0t3nJIG5e5vv3RDOxFk7tB
	5Cz+PTYn4pLBzl87JQHyUWp6ku4z2PCJWwcJdiP3EOKT5Ame25EPzdmpau6EId/f4r+F52xWllR
	yckPE7/KtD1eFkgCAMBdZq
X-Google-Smtp-Source: AGHT+IEr7tfKvJo3iR5Z+TSTQBlApJrCpEFHmGbDsuycc9iNrN3AroTuqC22ByNcEU9JrX+01Fia2w==
X-Received: by 2002:a05:7300:b586:b0:2a4:3593:ccb9 with SMTP id 5a478bee46e88-2b14335a1ccmr4300198eec.0.1767591649904;
        Sun, 04 Jan 2026 21:40:49 -0800 (PST)
Received: from gyrocopter ([76.174.137.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42eb9sm10349451eec.21.2026.01.04.21.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 21:40:49 -0800 (PST)
From: Michael Harris <michaelharriscode@gmail.com>
To: gregkh@linuxfoundation.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: adt7316: modernize power management
Date: Sun,  4 Jan 2026 21:40:40 -0800
Message-ID: <20260105054040.2309395-1-michaelharriscode@gmail.com>
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


