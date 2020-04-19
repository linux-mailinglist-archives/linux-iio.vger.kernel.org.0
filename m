Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D7C1AF766
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 07:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDSF7R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 01:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSF7R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2020 01:59:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00A6C061A0F
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2020 22:59:16 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j3so6352620ljg.8
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2020 22:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uf8geBzS9Y1Ieav6YI4XqkKO38PoBOqoEjtxo41FVQg=;
        b=UqbaVEZG0MhRw5G8JMHdYFxxjyh/qC9Jcv+4uqw279RAUN7VVhtJfWOMokljuRBo67
         8vPa9F6Xv4mX/EGp7zGc8nGvnejm8MBB2e9LVRSAYxYTkiZHysZEIYRIRQEKeFRo37h8
         p7R44b5medqbSs3iZwVu8+01GkgvNSfCMaQi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uf8geBzS9Y1Ieav6YI4XqkKO38PoBOqoEjtxo41FVQg=;
        b=JYvKH0tfYRUbzrVf2RfUMbxKXJm3hiddNe0wv3i71dlutUz8hJoa8DTXGS07Jtu+6f
         X+LJeqflb3Ft/yEGQUWF5QzCRgGQQAn455k/MbDcRhG+0AJKfiq5G0H+XBy2djKFDWXN
         g1/OG3VG1pJD1CbstOmp1iiShaSlSUP+zvyVH95yuzeYoWOOasiO42XGL4+GPXZ7rbt/
         u2QJD/7e22cnIDocvp3cLTCMHA4fiG4jfNnDJEPGyCsQ+q76bEz5wgIWNMah2xVes5MN
         7iJjBUz2noSYm8RyO2VAcYX43AEv9Iq1FeBu1DXHLJ0Zn2wA4y1ruiAlFECVU9GhNY6c
         Otnw==
X-Gm-Message-State: AGi0PuZlscAU2BCzV9aoSxUuXa3diy1YQGVpz5tu5FkPRhP7ZR8U0G2q
        6qsNk3HwFGrI7YLvxXnwN9R94Q==
X-Google-Smtp-Source: APiQypKRm9wJ8TSCXd0AQaPdkqAnvny9g6Sq33Z3cw8clf3pBvDl4a81zW6a58wuPZU8Jsy8uRC74Q==
X-Received: by 2002:a2e:164b:: with SMTP id 11mr6315971ljw.23.1587275955454;
        Sat, 18 Apr 2020 22:59:15 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 4sm12407715ljf.79.2020.04.18.22.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 22:59:14 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 2/2] iio: chemical: atlas-sensor: add RTD-SM module support
Date:   Sun, 19 Apr 2020 08:59:07 +0300
Message-Id: <20200419055907.23411-3-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419055907.23411-1-matt.ranostay@konsulko.com>
References: <20200419055907.23411-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Atlas Scientific RTD-SM OEM sensor reads temperate using
resistance temperature detector technology.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-sensor.c | 32 +++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 82d470561ad3..b58ef9759c08 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -68,16 +68,20 @@
 #define ATLAS_REG_DO_TEMP_DATA		0x12
 #define ATLAS_REG_DO_DATA		0x22
 
+#define ATLAS_REG_RTD_DATA		0x0e
+
 #define ATLAS_PH_INT_TIME_IN_MS		450
 #define ATLAS_EC_INT_TIME_IN_MS		650
 #define ATLAS_ORP_INT_TIME_IN_MS	450
 #define ATLAS_DO_INT_TIME_IN_MS		450
+#define ATLAS_RTD_INT_TIME_IN_MS	450
 
 enum {
 	ATLAS_PH_SM,
 	ATLAS_EC_SM,
 	ATLAS_ORP_SM,
 	ATLAS_DO_SM,
+	ATLAS_RTD_SM,
 };
 
 struct atlas_data {
@@ -199,13 +203,29 @@ static const struct iio_chan_spec atlas_do_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.address = ATLAS_REG_DO_TEMP_DATA,
-		.info_mask_separate =
-			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
 		.output = 1,
 		.scan_index = -1
 	},
 };
 
+static const struct iio_chan_spec atlas_rtd_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.address = ATLAS_REG_RTD_DATA,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_BE,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
 static int atlas_check_ph_calibration(struct atlas_data *data)
 {
 	struct device *dev = &data->client->dev;
@@ -350,6 +370,12 @@ static struct atlas_device atlas_devices[] = {
 				.calibration = &atlas_check_do_calibration,
 				.delay = ATLAS_DO_INT_TIME_IN_MS,
 	},
+	[ATLAS_RTD_SM] = {
+				.channels = atlas_rtd_channels,
+				.num_channels = 2,
+				.data_reg = ATLAS_REG_RTD_DATA,
+				.delay = ATLAS_RTD_INT_TIME_IN_MS,
+	},
 };
 
 static int atlas_set_powermode(struct atlas_data *data, int on)
@@ -566,6 +592,7 @@ static const struct i2c_device_id atlas_id[] = {
 	{ "atlas-ec-sm", ATLAS_EC_SM},
 	{ "atlas-orp-sm", ATLAS_ORP_SM},
 	{ "atlas-do-sm", ATLAS_DO_SM},
+	{ "atlas-rtd-sm", ATLAS_RTD_SM},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, atlas_id);
@@ -575,6 +602,7 @@ static const struct of_device_id atlas_dt_ids[] = {
 	{ .compatible = "atlas,ec-sm", .data = (void *)ATLAS_EC_SM, },
 	{ .compatible = "atlas,orp-sm", .data = (void *)ATLAS_ORP_SM, },
 	{ .compatible = "atlas,do-sm", .data = (void *)ATLAS_DO_SM, },
+	{ .compatible = "atlas,rtd-sm", .data = (void *)ATLAS_RTD_SM, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, atlas_dt_ids);
-- 
2.20.1

