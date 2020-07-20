Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB8B225819
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 09:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgGTHDv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 03:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgGTHDv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 03:03:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C772C0619D2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2020 00:03:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mn17so9742138pjb.4
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2020 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCDSxGJaqCTGCHhKUyNTBRjUkC1aBRbMkiZdv2yCaVY=;
        b=ieNE+kVtIiKgTbFFyayjdWeGr6YQagiKdIMjWE4z0V2gPyYa2MKvltwPZH0JcZ9/nt
         hrR3OozjdR1qDMf+41PWUIANDmIu9VWFC2FcZ8DhC3yPQ2gXvAmt++Ns1JsTg2hJxf8v
         01+VCCef7UrZRfzoOrVP0x5oYh5lnj1nYCSWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCDSxGJaqCTGCHhKUyNTBRjUkC1aBRbMkiZdv2yCaVY=;
        b=ZbC00acpps/Uui4zM43gPg1XD97AyTlGMYUwUg3NTG+jNKkr7mPFIpknFIzAjVlr5z
         iz9vkD2YofNIwzmMBfXnNtBeTugfvdV9q3cWZ476UCJS7V7VEbvLUeCHFSNNf6yXW55n
         gHvQ0o72OXTd9oF3Zc6tfaVn5xSmnrUtY278HGuf7cbmVi8ZsN1noGm3RSIm4RbifqCl
         BkHwxSbDw37lW/YyZUf3ia/yglgzjPjS7ZX+18u+1ylSMCJnGPKilk9EdHCV76Uytuu4
         Bef5XoQBUfmpG2Gq3E2yWR8mNTlNhlJfGjTODb4V5OpB0sao5MOf3jBhgF7SsPIohM+r
         SIZg==
X-Gm-Message-State: AOAM530K95e8rQxgz+hDdt4rllssiIiEHcfDCe66Q8Mt7q/CPY5ggKfh
        D3OdGvoNRky6pdOrYrcXp1PJcv0MniU3Zg==
X-Google-Smtp-Source: ABdhPJzuAQDK5dynOp8MQ/bA726fns0+SKLLiOL460k/KAzc0wjay8nOpphiXZuk7AxtmT6wmzDE/w==
X-Received: by 2002:a17:902:b113:: with SMTP id q19mr16954272plr.170.1595228630598;
        Mon, 20 Jul 2020 00:03:50 -0700 (PDT)
Received: from ubuntu.Home (anon-62-111.vpn.ipredator.se. [46.246.62.111])
        by smtp.gmail.com with ESMTPSA id gn5sm10613862pjb.23.2020.07.20.00.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 00:03:50 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 3/3] iio: chemical: atlas-ezo-sensor: add support for O2 sensor
Date:   Mon, 20 Jul 2020 00:03:30 -0700
Message-Id: <20200720070330.259954-4-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720070330.259954-1-matt.ranostay@konsulko.com>
References: <20200720070330.259954-1-matt.ranostay@konsulko.com>
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
2.27.0

