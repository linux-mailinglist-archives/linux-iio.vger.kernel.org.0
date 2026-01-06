Return-Path: <linux-iio+bounces-27500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E57B5CF8E08
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 15:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56F71301A4C3
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA78330330;
	Tue,  6 Jan 2026 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5KesHQG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC4833345E
	for <linux-iio@vger.kernel.org>; Tue,  6 Jan 2026 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711102; cv=none; b=LEAna/zdIoezKh+AyulyDjwyIgIVCGrNrpRsjRVjpQ71dtoXHFW/6RAapm/3Lix5n3VzdB1kjk1hg15Rpen/qpjY09ppPaCsQEIqSfTrKoRLCOTzaYuzfDaxInm6cZNG1b2xpGC06+/XaGxDZHrJxrfShNiUKdZcFMk5yjy/YKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711102; c=relaxed/simple;
	bh=p8dq/dMEupUC2aQzzjPOIC1vFjm7cfadwEaa4zf6ba4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3WGPU5s9wbqnYdDcc2Voj49JpyCWBtgqGIgDueSkZX2W/wUrIxzJVJwzzN+1A2KsLIjiI9Aadl7p8XF/0Qb+Tv0Nt5BGLgx5KD4Ukqa8amSWH1+8EeUdTxEvk8JfmIh91kQhW5RitYtYCDaz061jnLI4igmlvVef0NO0ffRF4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5KesHQG; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11f3e3f0cacso337293c88.0
        for <linux-iio@vger.kernel.org>; Tue, 06 Jan 2026 06:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711100; x=1768315900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/hNvMMqkMl4qoxeO8kWiJinGTUcm34Ni+je0A+xask=;
        b=W5KesHQGLS+TD/TD+3ESrXw64mILRkaybhcCmEQmg1bkbiT+g+YokWm6ZSCsuVpnII
         wRM2yb8R4xqMjAyqhQLg6UFAz6/4FCvaSNoWlwpnNGUQDq1NS9WP6jnMHC/sToPP+sik
         Q+nStJn6jwdYaAsJ64riBc6rrVR4Qs6VkijpqlY4TTF3DVT5lnMb1Olxd9sNfGVXQMVQ
         F5uOczTetwHCb+Ma6MuK9gpNzltISpBPtaqggs3l42Zg/DAgWuaL651JfSQYSTe9Vjcr
         qIEcrdcTHn3JZBvxHhuU4vkj8Kmita0RcxIfT7szPQCD/yXP1/dJr3Oy27r1eK06hGYM
         6daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711100; x=1768315900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/hNvMMqkMl4qoxeO8kWiJinGTUcm34Ni+je0A+xask=;
        b=DLfuFcKPMiQDR7ckQaNI+CQj1kAfIp07A8CFrIVdFVh3fXsuQW97aosnM2hM0lrlHc
         GY9GPAWA9t6I9WFMNWyEqCkLB7QaYpJ5suz6eXAa+MOjMxNsju+R6ECBu6eC8ahmewFQ
         ReWvnrt0QWNOpQOBBEj8ltIXqQ+zHxkdCtFrduu/SJcaxmO8lYqLbmHXOu0wMHKo8oZ2
         FXQcaExWufD7S32W3P2b+1gvenXxTkyX10WkzqnQP7Tw/qnDPbxGDeai/qRcU0KM5Hq2
         GhrQ76b9H5GPsS+IRnd8/ltZssn4mZmK/3Szf1Bw9Dw0OnkrBXSUiQhg2mD8GsQ/dBrZ
         l7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWRWG6tQWY0kGMq4Z4SuTlTEGHm0YPfgaXcjpa3BIIdUPskDW5iGEHZDG5kaKxy7nXZr3fbhvMoE+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7afEMSos4As167If1/jTCLFnLwcd4qeYPgv50oRIqYCaZMYkb
	8b6qSBwgi/tuweDrS1a14vRWgJkXaUR6CxTFZj0jeJSlg/q8IRvCicnX
X-Gm-Gg: AY/fxX4jdbIPIqmhLoewVDs4NeNVwy/b9NI1PP4yJn5CwhcZiQ6uHYuv5jxIUYXkIhZ
	XBehUOA/+WuEjcEPehSfF6U09DXlcyK7QNJd3GZ2gUFCRxRdzhPkxZe/ZF37p8rnhmCj5QrM8Ld
	+LPqN1I3shk8PQ9rFFc1GH5TG4rLwhBUecJoB5LXYaErsq9kq1BAsRBqtI2K+rPEFFVsxsiVQi3
	zAgGeZ+hmCQYgLua2J14J4qUxWBGqnSu0W8KWqpx0SsydW/k+ujOwDwhpqGB9Wcj+YgNDZoZWsC
	fS5c37rrnLbrqNp74sES9ZjTVSfWzccTNk1y1a4JVUNBB1T7QkMCiX2ng/0LVc7Duo0BexGTLmB
	yIdZZ7POaWYyQTCELwkWcjX0Ow/i3ISKq6nmdPfadL0jXmK822WGqBtMantKTFSdTbNHJ82GeWP
	0dtvMgvqfUEOKsS+4Obz8GIyiJg4k8yZU=
X-Google-Smtp-Source: AGHT+IH7t7HjXLdeJ46ldbckFVJMidSGo03oodpDrxI0SKkKbyMpbQiE2Zdn26I5kWYcF3bBeMuCrQ==
X-Received: by 2002:a05:7023:b16:b0:119:e56b:91ea with SMTP id a92af1059eb24-121f18df9afmr2453038c88.27.1767711099732;
        Tue, 06 Jan 2026 06:51:39 -0800 (PST)
Received: from gyrocopter ([76.174.137.141])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f2434abesm5237003c88.4.2026.01.06.06.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 06:51:39 -0800 (PST)
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
Subject: [PATCH v3] staging: iio: adt7316: modernize power management
Date: Tue,  6 Jan 2026 06:50:55 -0800
Message-ID: <20260106145055.2557551-1-michaelharriscode@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaced use of deprecated function SIMPLE_DEV_PM_OPS() with
EXPORT_GPL_SIMPLE_DEV_PM_OPS().

Removed PM preprocessor conditions with usage of pm_sleep_ptr().

Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
---
v3: Fix commit message function/macro references
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


