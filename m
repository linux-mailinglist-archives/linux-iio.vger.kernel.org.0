Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7D522A8FF
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 08:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGWG3w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 02:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGWG3v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 02:29:51 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D45C0619DC
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 23:29:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h28so3669482edz.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 23:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EAM1jyzJK3KL5nC2vaBWvf/2Lg8CovKQH+OxucJDd1E=;
        b=G8Aep+D366vJS9bC3UfYjWoHK4cM9v8OnLt2VETXqQCQoHB473aQD5gvj1PJTEmqls
         mpndymshI5fkX2qE7cvQyDuhJgUKrRI8sVjQ/x3gf7kSGu7qoywlrIVolJrIqwvTRwGP
         0/1YC3nzlt+Z5xGeazbwq7125tCCRtGMnBrR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAM1jyzJK3KL5nC2vaBWvf/2Lg8CovKQH+OxucJDd1E=;
        b=poosftYym5vVBNA7Jhx/IrvL3Ch7WT9NBsb2ioQMKWFsDhO9ok9pCkmn8SQVsydk+J
         CdiLl/cOhQY7TtooqVBPz0pPpylCk1DE0L0qQ/WgpjJdEupdPrvG6P11R3IYE8rNW79z
         92uMY3EzMPqd70eNGTWC77loNJqnEhbfj+o3h+6cDBc2Tr6m2T2E/aJssx3X8zdjjDAa
         AWgkaqRJE2xGp63Qn0xecE+FCAaIxubojAwUEuKLJ3NahEPXrJHj8srsOmYr5Tmw3aIA
         R5v1DxOVnaYvQG2ZkG8MWcuGsjO/a2H8PAj89U73EiRUo8sPvU8IBgfT+4wws7X5nxAC
         wvUw==
X-Gm-Message-State: AOAM532Owvl013K2VNtSEHSz3CaQnsrArgeHkNAqYkD1G4sv8suIYYcO
        0Yfa+OSII+7Xqajwq7da/rFHLA==
X-Google-Smtp-Source: ABdhPJwchTSfFsaShOZokdO+zLr1406BKGMWR3xnM6eJFmeITtZDGxpgeMTRnyqiV9ElhJu3IifjQw==
X-Received: by 2002:a50:ab52:: with SMTP id t18mr2793893edc.195.1595485790069;
        Wed, 22 Jul 2020 23:29:50 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id bq8sm1358866ejb.103.2020.07.22.23.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 23:29:49 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 2/2] iio: chemical: atlas-ezo-sensor: add support for O2 sensor
Date:   Thu, 23 Jul 2020 09:29:44 +0300
Message-Id: <20200723062944.11438-3-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200723062944.11438-1-matt.ranostay@konsulko.com>
References: <20200723062944.11438-1-matt.ranostay@konsulko.com>
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
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/atlas-ezo-sensor.c | 73 ++++++++++++++++++-------
 1 file changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index 8b72bb012363..60a0c752fbc5 100644
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
@@ -38,31 +39,53 @@ struct atlas_ezo_data {
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
+	memmove(ptr, ptr + 1, strlen(ptr));
+}
+
 static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan,
 			  int *val, int *val2, long mask)
@@ -96,6 +119,9 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
 			return -EBUSY;
 		}
 
+		/* removing floating point for fixed number representation */
+		atlas_ezo_sanitize(data->buffer + 2);
+
 		ret = kstrtol(data->buffer + 1, 10, &tmp);
 
 		*val = tmp;
@@ -105,9 +131,16 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
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
@@ -119,12 +152,14 @@ static const struct iio_info atlas_info = {
 
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
2.20.1

