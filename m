Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF8B1AF780
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 08:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDSGGE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 02:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSGGD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2020 02:06:03 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD47C061A0F
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2020 23:06:02 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u10so5210601lfo.8
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2020 23:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hzGCJW6yBCbOxsB9B/8agb40s1husqLSK8c0gXR5MJQ=;
        b=sCD0UZXnJag9DMtG2EeWYOJ5sB96JNGDcpuKxkQ9ehvptVfOoLf8a/Kyq/TpXMdMzh
         oQWwAhhivzj/wgi62lz6yLQlslvCHqR/LqCHv7jUaKXNdt1QWbLOam7ltSNwUZK+WPED
         AeOaZv55wdlpWWz6iG4KA8wvzVn7GZkWxeSYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hzGCJW6yBCbOxsB9B/8agb40s1husqLSK8c0gXR5MJQ=;
        b=qqYrnDdwTaTsIhbVj2VISud9X+ApqdYePjwOwA1tuaIbxepaA3oKO0VdJQatvbn0bI
         0bL4HA4UvlEzioAb2KZMl2GIAd+rYcDfjFLcePMPueekHCfBVRRbEC8LEZEYkgbBsn5j
         xX9CQyUNcnX4scFxcZnGAmEfXpqnYtUkUZCmI8HyxL89Cnip2GfXP5tU2hR/a8dIfdqr
         mqyG9/8UDPiGdz+ZsM2UHW7XRjE/EXp0XJTGoWt1k3FrD6/RFpNxvhrQIhkLD1+3SvUj
         Kaf/45gG3pqBxybJHO3UOXturlR4LBS9fRjSVJ6RKevC9tlq2bcPw1gwCeqiaKEeedxe
         f49A==
X-Gm-Message-State: AGi0PuYDuO8A5nuxrDww3GUs2dX0tbFpCmELki9tjcnghPkWacCntzop
        ov9nfF76U7jH7uyPkARA0t7Q9KeFysAjNA==
X-Google-Smtp-Source: APiQypLEd5BNcOl3IrZknwejTRCJxsX9uHuMIeTzheaUtO5wQ6TFd0SMdozldWkNaEnhpAjhKf6YnQ==
X-Received: by 2002:ac2:58cb:: with SMTP id u11mr6687977lfo.185.1587276360819;
        Sat, 18 Apr 2020 23:06:00 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id o22sm3695002ljj.100.2020.04.18.23.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 23:06:00 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 2/2] iio: chemical: atlas-sensor: add RTD-SM module support
Date:   Sun, 19 Apr 2020 09:05:55 +0300
Message-Id: <20200419060555.14433-3-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419060555.14433-1-matt.ranostay@konsulko.com>
References: <20200419060555.14433-1-matt.ranostay@konsulko.com>
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
 drivers/iio/chemical/atlas-sensor.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 82d470561ad3..c7ed9004cf82 100644
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
@@ -206,6 +210,22 @@ static const struct iio_chan_spec atlas_do_channels[] = {
 	},
 };
 
+static const struct iio_chan_spec atlas_rtd_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.address = ATLAS_REG_RTD_DATA,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
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

