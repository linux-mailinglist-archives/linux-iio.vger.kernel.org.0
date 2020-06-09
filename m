Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F601F4745
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jun 2020 21:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389295AbgFITlx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Jun 2020 15:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389390AbgFITlr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jun 2020 15:41:47 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942EBC05BD1E
        for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2020 12:41:47 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n23so10713116pgb.12
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2020 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8eunt1wTSxU0bEfA0XN6C1T6L3rOZuiLFejw2nwip4=;
        b=ruE4hjz3pLJMLbbrNhyGM2wmjtv/yEAX7RQ65VLEKsUNDxPUB7dkXqr3f5ACcCXhcn
         aRlKnTen0k6bBDFNeGhLz6lrMVD5rno/q+JtAUqN8fAQ8nOJcA/u931gCeYNBl7L/ljP
         fIWDxh/S+Mm7fz0EoQsIto9LGE+eU6I2xLd2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8eunt1wTSxU0bEfA0XN6C1T6L3rOZuiLFejw2nwip4=;
        b=t38rnH2y0CkJqWFWZaWFu1yc91O15juo5Xy1ExtC0OckAh8VJjKFv8wugdHNJHXpgm
         dbhiaa0pf0Xjfzbtp+J5s9k65Ii2hWv3EyCN8/4Zq40fxqwwxI8SDFik0JY6Kav3cavy
         MXHsGr1rsMWYf8OgMFZJ17zG1Qd+ql6yL0HT0HtdQ13smchcW1UMQdWDIwD4gtltH7PW
         +NmVFrT6aGeQZ9rC4Pt9XE5+HwynBDzldN36vTlsoSieuzzofXRQ3QKiGMATotIOTraU
         B19I+jQodeOF4k3joI+7tMzNQQpGiGMhV+QbxLL97M09MxtFXaXa3tNYCfvUDaibFCEQ
         Zwkg==
X-Gm-Message-State: AOAM532XmF8UB3NzIguuflMeIKEGh42mTd8TxODZCq8iagertfYqdBMR
        8pItRCfuOMFvHrGNjIHsMAeDuQ==
X-Google-Smtp-Source: ABdhPJznRrSlwdqBVG3fkzMQO1tulZGBggqtnCHGpEjS+L2AKETok6W3sMkMGTE19HEhCq3x4GgwkQ==
X-Received: by 2002:a62:7b41:: with SMTP id w62mr25571818pfc.142.1591731707117;
        Tue, 09 Jun 2020 12:41:47 -0700 (PDT)
Received: from ubuntu.Home (anon-42-81.vpn.ipredator.se. [46.246.42.81])
        by smtp.gmail.com with ESMTPSA id z85sm10563627pfc.66.2020.06.09.12.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:41:46 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 3/3] iio: chemical: atlas-ezo-sensor: add support for O2 sensor
Date:   Tue,  9 Jun 2020 12:41:17 -0700
Message-Id: <20200609194117.5837-4-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609194117.5837-1-matt.ranostay@konsulko.com>
References: <20200609194117.5837-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for the Atlas EZO O2 chemical sensor which required
some refactoring of the driver and parsing of i2c transfer.

Sensor data is converted by the scaling value from percent to
IIO_CONCENTRATION.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-ezo-sensor.c | 74 ++++++++++++++++++-------
 1 file changed, 55 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index a94eb8a6bf32..94188c84e65f 100644
--- a/drivers/iio/chemical/atlas-ezo-sensor.c
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -16,10 +16,11 @@
 #include <linux/iio/iio.h>
 
 #define ATLAS_EZO_DRV_NAME		"atlas-ezo-sensor"
-#define ATLAS_CO2_INT_TIME_IN_MS	950
+#define ATLAS_INT_TIME_IN_MS		950
 
 enum {
 	ATLAS_CO2_EZO,
+	ATLAS_O2_EZO,
 };
 
 struct atlas_ezo_device {
@@ -38,31 +39,54 @@ struct atlas_ezo_data {
 	u8 buffer[8];
 };
 
+#define ATLAS_CONCENTRATION_CHANNEL(_modifier) \
+	{ \
+		.type = IIO_CONCENTRATION, \
+		.modified = 1,\
+		.channel2 = _modifier, \
+		.info_mask_separate = \
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE), \
+		.scan_index = 0, \
+		.scan_type =  { \
+			.sign = 'u', \
+			.realbits = 32, \
+			.storagebits = 32, \
+			.endianness = IIO_CPU, \
+		}, \
+	}
+
 static const struct iio_chan_spec atlas_co2_ezo_channels[] = {
-	{
-		.type = IIO_CONCENTRATION,
-		.modified = 1,
-		.channel2 = IIO_MOD_CO2,
-		.info_mask_separate =
-			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
-		.scan_index = 0,
-		.scan_type = {
-			.sign = 'u',
-			.realbits = 32,
-			.storagebits = 32,
-			.endianness = IIO_CPU,
-		},
-	},
+	ATLAS_CONCENTRATION_CHANNEL(IIO_MOD_CO2),
+};
+
+static const struct iio_chan_spec atlas_o2_ezo_channels[] = {
+	ATLAS_CONCENTRATION_CHANNEL(IIO_MOD_O2),
 };
 
 static struct atlas_ezo_device atlas_ezo_devices[] = {
 	[ATLAS_CO2_EZO] = {
 		.channels = atlas_co2_ezo_channels,
 		.num_channels = 1,
-		.delay = ATLAS_CO2_INT_TIME_IN_MS,
+		.delay = ATLAS_INT_TIME_IN_MS,
 	},
+	[ATLAS_O2_EZO] = {
+		.channels = atlas_o2_ezo_channels,
+		.num_channels = 1,
+		.delay = ATLAS_INT_TIME_IN_MS,
+	}
 };
 
+static void atlas_ezo_sanitize(char *buf)
+{
+	char *ptr = strchr(buf, '.');
+
+	if (!ptr)
+		return;
+
+	for (; *ptr; ptr++)
+		*ptr = *(ptr + 1);
+}
+
 static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan,
 			  int *val, int *val2, long mask)
@@ -96,6 +120,9 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
 			return -EBUSY;
 		}
 
+		/* removing floating point for fixed number representation */
+		atlas_ezo_sanitize(data->buffer + 2);
+
 		ret = kstrtol(data->buffer + 1, 10, &tmp);
 
 		*val = tmp;
@@ -105,9 +132,16 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
 		return ret ? ret : IIO_VAL_INT;
 	}
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		*val2 = 100; /* 0.0001 */
-		return IIO_VAL_INT_PLUS_MICRO;
+		switch (chan->channel2) {
+		case IIO_MOD_CO2:
+			*val = 0;
+			*val2 = 100; /* 0.0001 */
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_MOD_O2:
+			*val = 100;
+			return IIO_VAL_INT;
+		}
+		return -EINVAL;
 	}
 
 	return 0;
@@ -119,12 +153,14 @@ static const struct iio_info atlas_info = {
 
 static const struct i2c_device_id atlas_ezo_id[] = {
 	{ "atlas-co2-ezo", ATLAS_CO2_EZO },
+	{ "atlas-o2-ezo", ATLAS_O2_EZO },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
 
 static const struct of_device_id atlas_ezo_dt_ids[] = {
 	{ .compatible = "atlas,co2-ezo", .data = (void *)ATLAS_CO2_EZO, },
+	{ .compatible = "atlas,o2-ezo", .data = (void *)ATLAS_O2_EZO, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
-- 
2.25.1

