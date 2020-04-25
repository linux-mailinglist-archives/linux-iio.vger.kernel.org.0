Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622C21B842F
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 09:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgDYHZd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 03:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726097AbgDYHZb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Apr 2020 03:25:31 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8E3C09B049
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2020 00:25:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u15so12306733ljd.3
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2020 00:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1EvqB1CyHlv41G1Xc32epcgBQIAEREmOXv1dtCCZIzY=;
        b=MbEqDD2MXlMSFYXNIwZH7Ky633kVkBVAvp5LE9qaLa5bGENAz6VlL+mkPHOCop9omX
         g4z7+3CSNFZwdu+ExbPBl2zuldhcQnRSx+4dudGkd6WU31cR27+LOKO+I4dHBN5tnBK9
         ghiEDwWMK/cDWSCihtNjSM40/+puyVkohSd44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1EvqB1CyHlv41G1Xc32epcgBQIAEREmOXv1dtCCZIzY=;
        b=aDaYZyyvBq+1cPVW2+TIOdGQ6sUny6yBt4jmLCk5wlL91/DRHSn2yY30Z8f5ZiBvSe
         Yvb3tvNtoT/bc3oOJyovFr5Osc3G3COuuKU3+9k04pe3HZ1spU5GX+n52YiRtzq96oc1
         NSx58VezGYqnn0wngUvIPBqmJoSJO34T3S/h1vcUoT+aNXNFzKwOElUi+DNnJFXbvlZY
         B/pT4MGDmPzCLnZnTSJ6k0hAlDXERIACkR3Pg4VLL8sMbol3TIT9cgWV57JPvkC1nk3U
         +8LUcZA2UmXeEMGjEzLITs9A38+gSHWDl1PHFS/KMEQIcjC0HH9GzfnKGloJFQ2Qyqqq
         4f1A==
X-Gm-Message-State: AGi0PuZ0ZY/fObYyp1UmTBkHxnysjqNaSRgBL3g2/gmXsGWV48zh1EMO
        CT/nR4wJgeDH0y8mAhG6fCEneg==
X-Google-Smtp-Source: APiQypJqltiC1BLuN9sgPzPZTC+nUdbh8+HdlwGBhcPMj7tLBzortGzCwIcm8BWq6nBSAk2pXxcSsA==
X-Received: by 2002:a2e:140e:: with SMTP id u14mr8005197ljd.252.1587799529925;
        Sat, 25 Apr 2020 00:25:29 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id t8sm6382662lfe.31.2020.04.25.00.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 00:25:29 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v3 2/2] iio: chemical: atlas-sensor: add RTD-SM module support
Date:   Sat, 25 Apr 2020 10:25:20 +0300
Message-Id: <20200425072520.27776-3-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200425072520.27776-1-matt.ranostay@konsulko.com>
References: <20200425072520.27776-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Atlas Scientific RTD-SM OEM sensor reads temperaturee using
resistance temperature detector technology.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-sensor.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 82d470561ad3..4688cbe83d86 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -53,6 +53,8 @@
 #define ATLAS_REG_DO_CALIB_STATUS_PRESSURE	BIT(0)
 #define ATLAS_REG_DO_CALIB_STATUS_DO		BIT(1)
 
+#define ATLAS_REG_RTD_DATA		0x0e
+
 #define ATLAS_REG_PH_TEMP_DATA		0x0e
 #define ATLAS_REG_PH_DATA		0x16
 
@@ -72,12 +74,14 @@
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
+			.sign = 's',
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
@@ -478,6 +504,7 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
 	struct atlas_data *data = iio_priv(indio_dev);
 
 	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
 	case IIO_CHAN_INFO_RAW: {
 		int ret;
 		__be32 reg;
@@ -566,6 +593,7 @@ static const struct i2c_device_id atlas_id[] = {
 	{ "atlas-ec-sm", ATLAS_EC_SM},
 	{ "atlas-orp-sm", ATLAS_ORP_SM},
 	{ "atlas-do-sm", ATLAS_DO_SM},
+	{ "atlas-rtd-sm", ATLAS_RTD_SM},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, atlas_id);
@@ -575,6 +603,7 @@ static const struct of_device_id atlas_dt_ids[] = {
 	{ .compatible = "atlas,ec-sm", .data = (void *)ATLAS_EC_SM, },
 	{ .compatible = "atlas,orp-sm", .data = (void *)ATLAS_ORP_SM, },
 	{ .compatible = "atlas,do-sm", .data = (void *)ATLAS_DO_SM, },
+	{ .compatible = "atlas,rtd-sm", .data = (void *)ATLAS_RTD_SM, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, atlas_dt_ids);
-- 
2.20.1

