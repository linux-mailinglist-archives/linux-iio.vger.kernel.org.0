Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9975D245A5A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Aug 2020 02:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgHQAvD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 20:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgHQAvC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Aug 2020 20:51:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD256C061388
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 17:51:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id p20so13269393wrf.0
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 17:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mzmzyRGnWuW3bDVLpeu3gaxMtR7ORuE9EHMT3rtzUJ0=;
        b=CsLxm9xHxFyWtQ54wyb/JFammUNDuk04Spo+H8r2c/Jg6wlBIXx/wWYptRlhDcgIv5
         p4cZsnUKwgsGz/cDYuQEAbVPRClnABoNU0aEbztJXqEqmOen6cUjA+ez3G+fH91tdLDB
         s2q818gb6NyEjy+bXnOsBQwMtNJh2FSEOgiEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mzmzyRGnWuW3bDVLpeu3gaxMtR7ORuE9EHMT3rtzUJ0=;
        b=A7P+bfCHHJelzq6vcUfzJ7OD0iH+YdyZEgAa5vV7Q4v7n2Ttid/I8f2sd2PcwcVKRX
         dhndEB8brnlhbqMOSBeqoSOEHb94NoM7u/+gjGIO8+puWKsXVHlWtPMCLCISjMKNZsZT
         ZmJRYBUwzfH8TQvxKes2rFsZdTpYE7kxOp8DVAU4YPDvT095NYhAw26nxdfOry1qFTZ1
         17+ZbzZceMpDy96xl9JQPyaIxGaKRCpBlyMJ7vqFDLuGY9B2MmtimeD4ihz3pz7Uf6BT
         9ZxTWcqfhlo99LCVpDxNYEP7weOFtGqdF3m5+z5JsBfRbfg3LMC/C+ocQa+a38HuWIUD
         i+RA==
X-Gm-Message-State: AOAM530lf5joM7bGO7mGyHXZHWxlyR6X+gTwmMYs6d2fliFfcMBuscAZ
        Zl9H3H3ni6TnhMW7OOojiU5DXg==
X-Google-Smtp-Source: ABdhPJyZKgzh4JA9nlhTSxZy7V5oVnbEfQ9yQzom+sxRJJXQ+ucSsV6pmIfVwFt+vbwT5rKHO2kS+g==
X-Received: by 2002:a5d:514c:: with SMTP id u12mr13203509wrt.90.1597625460481;
        Sun, 16 Aug 2020 17:51:00 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id b139sm29892711wmd.19.2020.08.16.17.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 17:50:59 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 2/2] iio: chemical: atlas-ezo-sensor: add humidity sensor support
Date:   Mon, 17 Aug 2020 03:50:52 +0300
Message-Id: <20200817005052.11565-3-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200817005052.11565-1-matt.ranostay@konsulko.com>
References: <20200817005052.11565-1-matt.ranostay@konsulko.com>
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
index 60a0c752fbc5..b1bacfe3c3ce 100644
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
+		.type = IIO_HUMIDITYRELATIVE,
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
+			*val = 10;
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
2.20.1

