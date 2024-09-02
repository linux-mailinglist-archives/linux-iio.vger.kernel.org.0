Return-Path: <linux-iio+bounces-8952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A73A1967DFB
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 04:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41AB9B23FA2
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 02:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE8E38DF2;
	Mon,  2 Sep 2024 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH5TjgHU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BF82D613;
	Mon,  2 Sep 2024 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725245983; cv=none; b=imrYI5jjCH9NAVv9FFv8cFBJ0VwI6GpISpZzpF+1e/faoKslY35CpQdicUkk2Ba43vxobbxjAjRzFs1CpKbVsjw/LACpGs85xYC8ILCTVCNlYTTlZR/j/egO2qt3EomJUG5u/CieDKXisvKRRueueWK2gsRfYsDbQ8gTtZSOS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725245983; c=relaxed/simple;
	bh=PNRrouqrCqu1hgaCt4SeHOtWJ3yZrdBwkhasCBgQ1zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JN+BR3mfGwM+bYjeCMiYc2TT18MNoFl2PaCBOhwMO7Ua/3fbK5dPwQIssGzgp943FSI5RnngoJS+CNrCWiBO2+Cv+sOAas98X03IEHtw72V8pgPzp5PDYYYySfH52SVurMPhDNQq1tYcP8NUFHjLa30fwVYwEPGa8lbvQD3wU60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LH5TjgHU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d889ba25f7so1241128a91.0;
        Sun, 01 Sep 2024 19:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725245981; x=1725850781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AA0dytflfzhATYfkKstI1v6bdMzmDbQkOe16xp+1g4Q=;
        b=LH5TjgHUVi2xu+eGg6YnMKOUYlSHxQX+9z2xlJgrF5KdIpSYNhG563AF/CpWi7F7d/
         5hVm7AixGDpm7TZaZPs/Y5RopoAFk0EXOQz0wged4yhxxTtNL9GVJNPPIej5I+YcBTET
         JtbvEUXpvCxFUchmmxPNLqmAJQOB58+olz3qngZd2OeOFxmVZZ8yAhD4igezBA869xhi
         NvkY2Rfsnwu0ZIuu74KxmztdHpnTRtmrONW+WyioMdrtPYDTC3uD/z90bCqURiCDHVyd
         WrXl2cc7nHVgmqjEWAErD6FWo6yMxWZHrpAmU0OVPyjbLih7flnwIH8YJFqKxkE2vGrf
         vUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725245981; x=1725850781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AA0dytflfzhATYfkKstI1v6bdMzmDbQkOe16xp+1g4Q=;
        b=TtURTd8ENplWftE7CRBDR9Brroozwao67QtTbLvz+9L/rxrkdHaHjUbzUdIQHkX+nh
         l4mE3wE8Y5DbcHDJc7YRQS9o0JjrEUA2A8dNoKsna0qqapP+lbw9wWw+KfTDpYG4/Yyg
         lqVr3NmwSM+0zX0Zij9pxYC2fzbAxKh2lZq1cXuDSBNzGQyoiAzXUANZ8ogh3V+OZwhC
         /in7p/x+h2eNs432EhzTQZG8MpVrZAc8+Xh6f7jOnpnFOQw6R3P5mD57PpXkpbQy4uQ8
         IBWgJBXxkBG7uLkpRwohhd6LA3+lh7skDvv73yaPjTmSG8ViCbwiCuNIg77z+sbfJLY1
         DJAg==
X-Forwarded-Encrypted: i=1; AJvYcCVunPf/0uR+y85egrgvJiXs9imP0I7bDwjqYGK+0aW/HWDmSqRrIoMvsYyQNtlO0fPe0UeEseRewHg=@vger.kernel.org, AJvYcCX8ujX3u6Z4bv2Q+pRE4i5hZyimwrbjo31k/hp6B5nmUQdWv64yV4N0XmT1WpoyiZ1Zuf2VpyJk2lMnG9X5@vger.kernel.org
X-Gm-Message-State: AOJu0YxbKfknSQlsZ3KfifbfzQb1L7r5JejwQ8K6tCQ0XgBN07Q5+lfb
	hh5Ti6NgZlK57C+jUrWt2RSi+JMbiPYfI802SioEDmoznSp4mM9TfgbqEMjrTy6jVg==
X-Google-Smtp-Source: AGHT+IHGLP3N8gRCR4Ey6BOuU1BW75sQo28mn2wjvx/YSZzn+fI9+F0Mu6WJ3t80kMrCUh2NR7UXjA==
X-Received: by 2002:a17:90a:f2c2:b0:2d3:d68e:e8d8 with SMTP id 98e67ed59e1d1-2d8973c40e0mr3821797a91.40.1725245980989;
        Sun, 01 Sep 2024 19:59:40 -0700 (PDT)
Received: from ubuntu.localdomain ([103.155.100.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8c5d48a8esm1646134a91.35.2024.09.01.19.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 19:59:40 -0700 (PDT)
From: Jason Liu <jasonliu10041728@gmail.com>
To: jmaneyrol@invensense.com
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jason Liu <jasonliu10041728@gmail.com>
Subject: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
Date: Mon,  2 Sep 2024 10:58:48 +0800
Message-Id: <20240902025848.76573-1-jasonliu10041728@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <jic23@kernel.org>
References: <jic23@kernel.org>
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
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 15 +++++++++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index ebb31b385881..4e00eb130e9f 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -71,6 +71,20 @@ static int inv_icm42600_probe(struct i2c_client *client)
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
+	{ "icm42622", INV_CHIP_ICM42622 },
+	{ "icm42631", INV_CHIP_ICM42631 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);
+
 static const struct of_device_id inv_icm42600_of_matches[] = {
 	{
 		.compatible = "invensense,icm42600",
@@ -104,6 +118,7 @@ static struct i2c_driver inv_icm42600_driver = {
 		.of_match_table = inv_icm42600_of_matches,
 		.pm = pm_ptr(&inv_icm42600_pm_ops),
 	},
+	.id_table = inv_icm42600_id,
 	.probe = inv_icm42600_probe,
 };
 module_i2c_driver(inv_icm42600_driver);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index eae5ff7a3cc1..9efbe9b7674d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -67,6 +67,20 @@ static int inv_icm42600_probe(struct spi_device *spi)
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
+	{ "icm42622", INV_CHIP_ICM42622 },
+	{ "icm42631", INV_CHIP_ICM42631 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, inv_icm42600_id);
+
 static const struct of_device_id inv_icm42600_of_matches[] = {
 	{
 		.compatible = "invensense,icm42600",
@@ -100,6 +114,7 @@ static struct spi_driver inv_icm42600_driver = {
 		.of_match_table = inv_icm42600_of_matches,
 		.pm = pm_ptr(&inv_icm42600_pm_ops),
 	},
+	.id_table = inv_icm42600_id,
 	.probe = inv_icm42600_probe,
 };
 module_spi_driver(inv_icm42600_driver);
-- 
2.25.1


