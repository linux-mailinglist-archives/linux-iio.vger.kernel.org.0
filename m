Return-Path: <linux-iio+bounces-8953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371DA967E16
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 05:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B30281E91
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 03:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44F43BB22;
	Mon,  2 Sep 2024 03:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfaPMxXn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299579C0;
	Mon,  2 Sep 2024 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725246732; cv=none; b=hmKaHY9jXn0BvGd7bvLLcJElUAFSYFV/7/VyYsjU/26pHQcRf5riQwZk85nEUjAtatDuiuK9rUaYdYDfSttvG+OgI9PTGaxSpIcpsgN5pa7j9UxeHV/Bl7ReCJD5XqXqtxvtj3e6oKGjDxZn3e/0BqshXuDMQZROXGaJ4MO80Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725246732; c=relaxed/simple;
	bh=PNRrouqrCqu1hgaCt4SeHOtWJ3yZrdBwkhasCBgQ1zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cbW7hWoXZaU+NsgWt1ainAWa/aUjqUc0hdtuTqwmyU4tnl2n0deJlfWoAqo4FKaJBxogpjNrdykYc5fwwPCNt/j/uXnVTW8Y+OMNB3riKooDcv0K+hZDeWv7vRzBTDisT2/9qF53XpdbZISnPTHDUx4hgNtiZQ/vuZ1OxE2GWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfaPMxXn; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70f794cd0e3so831805a34.2;
        Sun, 01 Sep 2024 20:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725246730; x=1725851530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AA0dytflfzhATYfkKstI1v6bdMzmDbQkOe16xp+1g4Q=;
        b=WfaPMxXn29JRd7Yxk/usMzBp+ddBLjmahWLAijuQ7ya0kXyejSc67rw1y5lztuoNcu
         yw/28Cp5ZWUmmw+I0mxYwA6Lw5md9HalvfqawtJYS2viSinjHdNCeBHkLeEzFbeU16wF
         qxIH7V7KFTBqwb0D7UMjtXHBgOAMSsZM5bWu7GT7G1A5gSQ3qM1M0vHMx5SZ28n+f11R
         EzSGBagpTjtR27v0skm6ubnpPSewH0mzGagcwMQ78Dwa8ni8+lQM6gneTZyfUAgWYdty
         leZjjktrIyy+xwx6TaTplzd/zwsdejPAhsS7OKHaZCTTwG5NxAp9wnhV4SM5snAqGujl
         mFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725246730; x=1725851530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AA0dytflfzhATYfkKstI1v6bdMzmDbQkOe16xp+1g4Q=;
        b=mWLQgwC7AhiC8EmwiL8sMOoDK4hEsGByaD4foYyjdI71UAintPTQNgjJ7BoNB7Yim1
         A+QvMub7lc6RrL4/jil8AqEih/CanYwZsORaNTEkH5KvZ9jw0Drdzl1ZwVRTIz1y455C
         jX4NAzRk1xvZIm/t9l0hXMjZG0qc7NVvWIVy0d+BMq/IuE8iXhoU2QR9OPXQQ2nUY1I5
         sut/I6X8Cz2cVt5ivRWdjfZxgzpCAelme8TcTpT0uKAQw0oggzo7eiKcCCQiT4ySBMTi
         Tu6fZlmlDNTAR1AA/2Zjs+0qYPQjHvpijpeIrXDYpm4qZDGPDk6NUna+F/sOQHPCUQ4s
         pJiA==
X-Forwarded-Encrypted: i=1; AJvYcCVLjmfyhgXFNWsKIPeM2j1wBA9IIHMWFPw9SJds9kVxioJZUUWa73x1X4tRPicxrLv9lNb3VWS5pU+XGIRX@vger.kernel.org, AJvYcCWefJowm48qlYsEnbnc6G3xw00jut4yMgy1hDCOl1mnGNcDfI67DLStKrltqZ8QkjOB1qJhZT/F40I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5Mkk91sE3UZ7Nd0ePEWneLIxEe8m4tU8Vw2wQTn5pVACj0rQ
	c2ChfZefuvde0L2sFharjVFc5bHGuOPO2CMz7M5eftMVbdgUVnnT
X-Google-Smtp-Source: AGHT+IG9FoQu8ozhJDcdpO79x+C7ivq88riXv1t8DrOijE0RxsEPtdK8I70UEYmUBHEe+0n3J8gljg==
X-Received: by 2002:a05:6830:630e:b0:703:b0e9:d951 with SMTP id 46e09a7af769-70f70fdfe42mr8547781a34.6.1725246730021;
        Sun, 01 Sep 2024 20:12:10 -0700 (PDT)
Received: from ubuntu.localdomain ([103.155.100.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e575c4a0sm5886920b3a.201.2024.09.01.20.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 20:12:09 -0700 (PDT)
From: Jason Liu <jasonliu10041728@gmail.com>
To: jmaneyrol@invensense.com
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jason Liu <jasonliu10041728@gmail.com>
Subject: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
Date: Mon,  2 Sep 2024 11:11:45 +0800
Message-Id: <20240902031145.76829-1-jasonliu10041728@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240901152346.45b096c3@jic23-huawei>
References: <20240901152346.45b096c3@jic23-huawei>
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


