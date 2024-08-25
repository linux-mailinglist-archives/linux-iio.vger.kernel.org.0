Return-Path: <linux-iio+bounces-8770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3838F95E23C
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2024 08:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D801F21C72
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2024 06:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3457364BC;
	Sun, 25 Aug 2024 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDNCm3T7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CAC33CD2;
	Sun, 25 Aug 2024 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724567995; cv=none; b=FqSBTr2thBxdsFkBdJQO0+cPurhZPlQxIdxlZI2y6H9aObfsL9JrGpXtAj0lSOQWq5IXL/pC/tmUPhfML3gWATeP48cLmh75GKkX+1Bpu+zDfi0xLq9e8wVOQmMmzGzLqZ2AyweTLeIMl0ml0U34DjqBpka9xAd7aPiRfz3JC+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724567995; c=relaxed/simple;
	bh=JQIJZ9W4hwReB2dGt8776miSVWSoK17ppqWOzgA2yws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jfMP2Q7pJ0rwDk7IQI6raczIHS3eZEH7wpKTqO+HXJQQ/DlWCBUcMF9qIUm5DHheNBjdf4rP8FSuzt+ufKFJinG551j7PiKa5YXU/fPflefSHjdcrBLGl+HnX4Cn27GGccBtvg0imQVwK7KTZRFPJBl8jj/cvse2Cb5PONeGJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDNCm3T7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-714261089c1so2324218b3a.0;
        Sat, 24 Aug 2024 23:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724567993; x=1725172793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WLbaFB5rmDIezgtKS2Zs1TcyM+iMrDpMS8ff4zJFYRk=;
        b=eDNCm3T7BQLa0WzEg2iq7my8mNkQolIMSEjClib6ZXjDB33BzewNN0Gjh64918OmUG
         nbgI2k15bTaTub+nNyTDqhgT7vNpQsMVL7kroV27KNMpLUrlO6GvYHk4GnxZCFQP5N1X
         X6cEWxU67hyfKJDA47JxA07il2fzYJU+9aSH1acRzex7bVtn3Qbfm+jFCIxiFaR16fjl
         Qu2SO2Zie5Dgf9eOya0tTqhd9CORnh6/DDaXcd7MfHaSKdOtmomjzyha+1d7hXfJAGU+
         z79W7EilXJUYLETuDzldOyN5pO+XFUJBAvU2/wrmbwEit65iEt9BsldUqa/8dRvC9Smg
         B1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724567993; x=1725172793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLbaFB5rmDIezgtKS2Zs1TcyM+iMrDpMS8ff4zJFYRk=;
        b=dWBQ+FjPSpOFeBX7+wRaAUB5Rwk/5GILEePrXdlo7RjK83wPKWV1Z/hgfAx/dGeTQo
         Zmz08rwdVrur1nlW1jhnNBwruAm7oDAlyFvnxLBdfwI9zOoVTcQQiLCls5+/28qvEZEG
         EGMZOBv41CnQXjndN30TxzQ5A7WzRLmtRpST8zlbxZcoZqwAQlxn4bNe6CsRtTBU8Jlk
         gRzvBwkQxcI5mt4clZXuY38+4ZmoXbWmAdWUSrzynhj+IF2RF5pzK5SdaAQcFh/pTmix
         eBX0LMkCCf7CU8DhOCgpkq1I2ptdtHEOMJa4aiUq1joGDr4e1YipBCcqWNqVSBKy5oH8
         2L0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVu7KA6uV2jdwsWck5p9m/lgma+SB8fQlxVxiyCRHW/MAlAq66n5mATe5EmgwHiZw0MkxTi9ZmA25w=@vger.kernel.org, AJvYcCWQgGMIno3pyus3SGnCfteZT6YBK3voMArFbruzXLmnY3WV2MIqQiATF6q+CnX1nBI7r9gbRhCj3+VHo+G7@vger.kernel.org
X-Gm-Message-State: AOJu0YxmcUBatvEApDpEzu2BjX/aitlk7iYjOk5CiEeFQlV4OdwnvFIC
	MCF8lqPbUfpQh+88U6yY2MLRiH+eVrBGhPC0+RVf9JIKSh6M9xXl
X-Google-Smtp-Source: AGHT+IF/IJVnB0GoKyyqi4OGi6DC+tc34yfbW7zqGtd1D7dYOWgDoJOtmmBwSBEkQeHsfE61KH23Kg==
X-Received: by 2002:a05:6a00:8d46:b0:70e:cf99:adc7 with SMTP id d2e1a72fcca58-7143170e1d0mr17022170b3a.3.1724567993112;
        Sat, 24 Aug 2024 23:39:53 -0700 (PDT)
Received: from ubuntu.localdomain ([103.155.100.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434330425sm5278542b3a.190.2024.08.24.23.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 23:39:52 -0700 (PDT)
From: Jason Liu <jasonliu10041728@gmail.com>
To: jmaneyrol@invensense.com
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jason Liu <jasonliu10041728@gmail.com>
Subject: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
Date: Sun, 25 Aug 2024 14:39:38 +0800
Message-Id: <20240825063938.56319-1-jasonliu10041728@gmail.com>
X-Mailer: git-send-email 2.25.1
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
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 15 +++++++++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index ebb31b385881..8cc550b8cfc3 100644
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
+	{"icm42600", INV_CHIP_ICM42600},
+	{"icm42602", INV_CHIP_ICM42602},
+	{"icm42605", INV_CHIP_ICM42605},
+	{"icm42622", INV_CHIP_ICM42622},
+	{"icm42631", INV_CHIP_ICM42631},
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
index eae5ff7a3cc1..5fe078ddc8a1 100644
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
+	{"icm42600", INV_CHIP_ICM42600},
+	{"icm42602", INV_CHIP_ICM42602},
+	{"icm42605", INV_CHIP_ICM42605},
+	{"icm42622", INV_CHIP_ICM42622},
+	{"icm42631", INV_CHIP_ICM42631},
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


