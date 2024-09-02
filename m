Return-Path: <linux-iio+bounces-8982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0687968640
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F141C21AA1
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524421849CB;
	Mon,  2 Sep 2024 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF89CnOZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC2195;
	Mon,  2 Sep 2024 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276689; cv=none; b=SAtzzxe9B/cvKPDSP08tRZWBWaOQ7qZaywLMn0+CbpXvvbvirUlWJy6g6TlM9FndBIm8+0X+hiFdEvyqCjU9cnaxmuILeMXU3MNJCebM5Ays+g7vSQUSTO2SL0ZVdIvH36Qhi/MZPJdwOXrdfvsG13L4rObFl5kHuG4ggHgIGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276689; c=relaxed/simple;
	bh=kaLu8QdTVTSYArpuwR9YQB+rqGwassSJXc79Q4yw5Ss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TgjlIWMWUt9F48CnTXgd0iMyt7VaEj5h+IHMfaue82W4lCYF/ewR+aAGV5Xpy5FWArpQOAf1wSPyxZxxEitipjmsmrFAYgsOclLkrjXhK/Xxg3knySvn8Y1YDQIhr9oKP5tipZM4Pt5aXF93HmFN0SbDADkg3oKLq8GVfY/yEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF89CnOZ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7cd9e634ea9so2705875a12.0;
        Mon, 02 Sep 2024 04:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725276686; x=1725881486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGJL/UfUCw42GI751ZmhsRYSPyBsQCICs+KScTxVAY8=;
        b=OF89CnOZRXqoaYk5j8HN2ZNOM1q3Dc7hyVuamXBWJlp4CjcLXfx1nsQSU3GV3yYKoO
         4VEOWlVGy3jjrp6g1OfgclqK7NIAgAR73ADcaXt1ZwEm0gndeYGq00KSwhMk9x78/e0R
         fkTUVU5hQ5taE2+uHpNvCOSpdDmAUmeEtPJf3X3CVG8dFCcDMJpevymARpNYQqC8cAVf
         apyvIfRJmfw628FdtML+jq/59SzWvfdsKZ8qPRnQ1cf/dzTipmrIe5L605KJI06cfh6n
         nqj95fv2ERbjgnm/wC4qqEmITCgSSGnCp4lpy6pJZ3/IVq0tw4+PL5HPGo8s4TBwzVWi
         fCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725276686; x=1725881486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGJL/UfUCw42GI751ZmhsRYSPyBsQCICs+KScTxVAY8=;
        b=K0gzNlhUuz1h7wfHJk69Pm8mXcJSXKWJL0wIrM9AxC/JDq3hFEk8ydpsx02OIYYwtU
         WsMI+hFkky7+g66ep1Kn1HIusLa3mIHMXQjoKsodiHOXrmUi8IuUjkk9toSOFBfFaroG
         BoAZg9sly0FZZsTABY8ka8bi5WmlIiiRsUPLW1zIDRRdTvj31XxIRlQ3SDJzanMkzY/w
         W1EYMxjQBawbPzr8kAblnHLH1AOqAHxGOVZkdmWTtrmJ7qPHHwM4xrOygDLKKfyyfJV4
         kJVW6IOTlXj+QfZfwV0rxz1LoFjkodtKqx8dn+DOdyyNcwacJ2/WSY/cfRZROK3U0Zf9
         tjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlzCI3mf9yepSYmX9hQdeW0Jc20EBh9Cf0Df2qXGg+LF5xMolEviUDXyVl3os15aHdPGSsQbymCHk29ucK@vger.kernel.org, AJvYcCXbQhm4ma49HNOTjMh13SFjmTcwJJc/GR60LMmqy00/IqPiiiwSGUlmKLaAFWsa24RK7iuA91nwLTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMvoNhN5spOw0s5vX5Uh9BC+LlVAKBL0Dr+8wcNIz4IfjYzXYs
	DSVQL9EfquhBaEM3lC8x/9QBWpe0CgkzzcvcRdoa55zvtpi2BiXC
X-Google-Smtp-Source: AGHT+IF9pcoNxeIPlMERzSZyT+1QryN2d5h6mK1yRYcNGLBbDfqQrsqiICmIQrOwyCCeKgCxamd3oQ==
X-Received: by 2002:a17:902:e804:b0:205:3e68:7359 with SMTP id d9443c01a7336-20547c0cdccmr54910135ad.53.1725276685681;
        Mon, 02 Sep 2024 04:31:25 -0700 (PDT)
Received: from ubuntu.localdomain ([103.155.100.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205bda42b8dsm3768605ad.137.2024.09.02.04.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 04:31:25 -0700 (PDT)
From: Jason Liu <jasonliu10041728@gmail.com>
To: jmaneyrol@invensense.com
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jason Liu <jasonliu10041728@gmail.com>
Subject: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
Date: Mon,  2 Sep 2024 19:31:01 +0800
Message-Id: <20240902113101.3135-1-jasonliu10041728@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <FR3P281MB175720831E0817C23AD0B1BACE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <FR3P281MB175720831E0817C23AD0B1BACE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the id_table of inv_icm42600, so the device can probe correctly.

Signed-off-by: Jason Liu <jasonliu10041728@gmail.com>
---
V1->V2: fix up the formatting as requested
---
V2->V3: add icm42686 (INV_ICM_42686) and icm42688 (INV_ICM_42688)
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 17 +++++++++++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index ebb31b385881..9e65fef04c39 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -71,6 +71,22 @@ static int inv_icm42600_probe(struct i2c_client *client)
 				       inv_icm42600_i2c_bus_setup);
 }
 
+/*
+ * device id table is used to identify what device can be
+ * supported by this driver
+ */
+static const struct i2c_device_id inv_icm42600_id[] = {
+	{ "icm42600", INV_CHIP_ICM42600 },
+	{ "icm42602", INV_CHIP_ICM42602 },
+	{ "icm42605", INV_CHIP_ICM42605 },
+	{ "icm42686", INV_CHIP_ICM42686 },
+	{ "icm42622", INV_CHIP_ICM42622 },
+	{ "icm42688", INV_CHIP_ICM42688 },
+	{ "icm42631", INV_CHIP_ICM42631 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);
+
 static const struct of_device_id inv_icm42600_of_matches[] = {
 	{
 		.compatible = "invensense,icm42600",
@@ -104,6 +120,7 @@ static struct i2c_driver inv_icm42600_driver = {
 		.of_match_table = inv_icm42600_of_matches,
 		.pm = pm_ptr(&inv_icm42600_pm_ops),
 	},
+	.id_table = inv_icm42600_id,
 	.probe = inv_icm42600_probe,
 };
 module_i2c_driver(inv_icm42600_driver);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index eae5ff7a3cc1..75441b2be174 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -67,6 +67,22 @@ static int inv_icm42600_probe(struct spi_device *spi)
 				       inv_icm42600_spi_bus_setup);
 }
 
+/*
+ * device id table is used to identify what device can be
+ * supported by this driver
+ */
+static const struct spi_device_id inv_icm42600_id[] = {
+	{ "icm42600", INV_CHIP_ICM42600 },
+	{ "icm42602", INV_CHIP_ICM42602 },
+	{ "icm42605", INV_CHIP_ICM42605 },
+	{ "icm42686", INV_CHIP_ICM42686 },
+	{ "icm42622", INV_CHIP_ICM42622 },
+	{ "icm42688", INV_CHIP_ICM42688 },
+	{ "icm42631", INV_CHIP_ICM42631 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, inv_icm42600_id);
+
 static const struct of_device_id inv_icm42600_of_matches[] = {
 	{
 		.compatible = "invensense,icm42600",
@@ -100,6 +116,7 @@ static struct spi_driver inv_icm42600_driver = {
 		.of_match_table = inv_icm42600_of_matches,
 		.pm = pm_ptr(&inv_icm42600_pm_ops),
 	},
+	.id_table = inv_icm42600_id,
 	.probe = inv_icm42600_probe,
 };
 module_spi_driver(inv_icm42600_driver);
-- 
2.25.1


