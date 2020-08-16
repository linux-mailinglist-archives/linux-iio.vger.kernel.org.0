Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1734924566B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 09:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgHPHPt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 03:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730239AbgHPHPs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Aug 2020 03:15:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D9EC061786
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 00:15:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so11872041wrl.4
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 00:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VdBrImZhCHkUqboxlZgGFEiFgrjKM+U4WBippdJ1nq8=;
        b=SJZP6QwnDrBeTwM81UgFZqK4xHpLhO2Z2gyvN65P0/5XqQ4t6/DoY0dCcGcVObMZOi
         cbqNRVEBf60uaA5SC+sro4VaHz/tcRlKclpNhnUfROhIZSiOdIFoISlofZ0yPUA9Rnle
         0Ap+Vk83yKOsU9WP0GaJlSH/96Aoy8Rp4d4rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VdBrImZhCHkUqboxlZgGFEiFgrjKM+U4WBippdJ1nq8=;
        b=mKBVdK8GSXakv0YiDwnpmAcT2eY9+MCIVFZyIb/wIIOZAsjvnQm1iEmAcUDFuG83S6
         xaSbKrjVoseO8Tj7mdQ4QLStrAqfoQd6O9rJ+RQzEI4fnBqvlDWiIL2KxgRUhMqb4z0N
         mGZuX6QOKEEQW9RhGjYYMkFiPg1HYh8BM9cCEGnYELE97DZ+o34e036cfLsAkhHMn2AN
         kGwdyJqRVNiZXaqGPLhZ6edaWNe+FC7fx9vEHoHOPig+5UB/Qz0f4C5ydJ5KEQt+waPn
         VfUG0Q3GGHrNQg8UCY/h8jXSzJ7KJBgdbCL821cxbPmxDYPHkR+QT1ji/Fj/2HIaBN7F
         CYJg==
X-Gm-Message-State: AOAM532LMGiHBggOJSj/q3Ejk7Xq78HdvNMneiDcTf2f6og5NgtplJXB
        vSjf8h3qxc/bukk6w+Gj5KGohQ==
X-Google-Smtp-Source: ABdhPJxfgFbL3JuSlAzhU2SPrprE7DrdblM4gIU4tOTWPQX6yxcHi4RmFXQp2CeF0/VLKR45DUV9YQ==
X-Received: by 2002:adf:bc4a:: with SMTP id a10mr9591721wrh.346.1597562146782;
        Sun, 16 Aug 2020 00:15:46 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id d14sm26189487wre.44.2020.08.16.00.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 00:15:46 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 2/2] iio: chemical: atlas-ezo-sensor: add humidity sensor support
Date:   Sun, 16 Aug 2020 10:15:40 +0300
Message-Id: <20200816071540.31897-3-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200816071540.31897-1-matt.ranostay@konsulko.com>
References: <20200816071540.31897-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for atlas,hum-ezo / humidity sensor which with scaling
provides respective data in millipercent

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-ezo-sensor.c | 37 ++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index 60a0c752fbc5..bb9b36b12a86 100644
--- a/drivers/iio/chemical/atlas-ezo-sensor.c
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -17,10 +17,12 @@
 
 #define ATLAS_EZO_DRV_NAME		"atlas-ezo-sensor"
 #define ATLAS_INT_TIME_IN_MS		950
+#define ATLAS_INT_HUM_TIME_IN_MS	350
 
 enum {
 	ATLAS_CO2_EZO,
 	ATLAS_O2_EZO,
+	ATLAS_HUM_EZO,
 };
 
 struct atlas_ezo_device {
@@ -63,6 +65,21 @@ static const struct iio_chan_spec atlas_o2_ezo_channels[] = {
 	ATLAS_CONCENTRATION_CHANNEL(IIO_MOD_O2),
 };
 
+static const struct iio_chan_spec atlas_hum_ezo_channels[] = {
+	{
+		.type = IIO_CONCENTRATION,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type =  {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
+	},
+};
+
 static struct atlas_ezo_device atlas_ezo_devices[] = {
 	[ATLAS_CO2_EZO] = {
 		.channels = atlas_co2_ezo_channels,
@@ -73,7 +90,12 @@ static struct atlas_ezo_device atlas_ezo_devices[] = {
 		.channels = atlas_o2_ezo_channels,
 		.num_channels = 1,
 		.delay = ATLAS_INT_TIME_IN_MS,
-	}
+	},
+	[ATLAS_HUM_EZO] = {
+		.channels = atlas_hum_ezo_channels,
+		.num_channels = 1,
+		.delay = ATLAS_INT_HUM_TIME_IN_MS,
+	},
 };
 
 static void atlas_ezo_sanitize(char *buf)
@@ -131,6 +153,17 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
 		return ret ? ret : IIO_VAL_INT;
 	}
 	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			*val = 1000;
+			return IIO_VAL_INT;
+		case IIO_CONCENTRATION:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		/* IIO_CONCENTRATION modifiers */
 		switch (chan->channel2) {
 		case IIO_MOD_CO2:
 			*val = 0;
@@ -153,6 +186,7 @@ static const struct iio_info atlas_info = {
 static const struct i2c_device_id atlas_ezo_id[] = {
 	{ "atlas-co2-ezo", ATLAS_CO2_EZO },
 	{ "atlas-o2-ezo", ATLAS_O2_EZO },
+	{ "atlas-hum-ezo", ATLAS_HUM_EZO },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
@@ -160,6 +194,7 @@ MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
 static const struct of_device_id atlas_ezo_dt_ids[] = {
 	{ .compatible = "atlas,co2-ezo", .data = (void *)ATLAS_CO2_EZO, },
 	{ .compatible = "atlas,o2-ezo", .data = (void *)ATLAS_O2_EZO, },
+	{ .compatible = "atlas,hum-ezo", .data = (void *)ATLAS_HUM_EZO, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
-- 
2.27.0

