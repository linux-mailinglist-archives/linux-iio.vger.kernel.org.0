Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E92632FDF9
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 00:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhCFXUV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 18:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhCFXUJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Mar 2021 18:20:09 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86764C06174A
        for <linux-iio@vger.kernel.org>; Sat,  6 Mar 2021 15:20:08 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id k12so9850952ljg.9
        for <linux-iio@vger.kernel.org>; Sat, 06 Mar 2021 15:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F189AKy36rkAyUhq6xOs3heAuW+B8SgtaLCtPHkhFmE=;
        b=XH28pMO3ZiH72pXpt8sEoQYpF31BKX++/NM182YjsWz6QU8ky2Sg2KqI5gWkWCeqef
         FE712P8cXNjiodzLsxWJ9cb4BmVw3Rzv1DdRpipaTnrlfNEOYvqX9PrcS3fHZrR5ifKP
         CpKTJJIm6VIFVkTE5nvAPIfx2mveD7yGgCUCear1e6v6z3E05TQMkKcx+8B32VUXyRjF
         zABLQIMyO7xxyZvYt8VIQ+cPiawDuKEB2Ck32gXpewzcBS1c61DNahXuRIFNw/vlgqiO
         eUBPnDy61hhw/09/a1zkhQ60K5FzsjgGSSA4MLgLpcnoUt1QjU4odzN9HLdycSxtGC4g
         nYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F189AKy36rkAyUhq6xOs3heAuW+B8SgtaLCtPHkhFmE=;
        b=SCKOJm1GPKuaemWDOxVwOb20jM7DSqzO/EpfHh8dE4Z1p2dnQrd7VUvGQZQ9jjEL3s
         SwoTCg+GRwicsd2wyMDzTZ5FOIzCG/5rbaW0lOFfiD3Um2fbVsVGoAxXTeceoayVyD8F
         2XUy7TTtZu8tcE4ZEEUk63zN4a2JIP3KUMw5xBIZVFoasyibxnkgnkibfS7PPl5rnLU3
         knueDmx7AYtH33Au9qK5R9UjrllT4vybOZ8FOAzzjRWoSEyLv7PjXdWye+DEADfd/GKU
         wFKqirTROzEqvKle+6wYzN9Ywgt5rj+86pog2Q3mfSaPMdEOW+MTMx0Qa99x06IcfGZJ
         5yMw==
X-Gm-Message-State: AOAM530BqaCXQR4kZNV5h2ueu6gxLzprDyWe1ZKHuTPeHARq3J1T/w1y
        k5oMoibVWrdScdFEXblvWwmVsg==
X-Google-Smtp-Source: ABdhPJxfmUXfTC/8UVxofvBnHz7OqqcHNuspn1rBruIby5AlpdoSJsnl9w5wZLodUYJkxlBlYFx4UA==
X-Received: by 2002:a2e:700a:: with SMTP id l10mr9490189ljc.368.1615072806800;
        Sat, 06 Mar 2021 15:20:06 -0800 (PST)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id c16sm797704lft.264.2021.03.06.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 15:20:06 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@cam.ac.uk>
Cc:     linux-hwmon@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH v3] hwmon: (ntc_thermistor): try reading processed
Date:   Sun,  7 Mar 2021 00:20:04 +0100
Message-Id: <20210306232004.2400379-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Before trying the custom method of reading the sensor
as raw and then converting, we want to use
iio_read_channel_processed() which first tries to
see if the ADC can provide a processed value directly,
else reads raw and applies scaling inside of IIO
using the scale attributes of the ADC. We need to
multiply the scaled value with 1000 to get to
microvolts from millivolts which is what processed
IIO channels returns.

Since the old iio_read_channel_processed() would
lose precision if we fall back to reading raw and
scaling, we introduce a new API that will pass in
the scale factor, iio_read_channel_processed_scale(),
as part of this patch.

Keep the code that assumes 12bit ADC around as a
fallback.

This gives correct readings on the AB8500 thermistor
inputs used in the Ux500 HREFP520 platform for reading
battery and board temperature.

Cc: Peter Rosin <peda@axentia.se>
Cc: Chris Lesiak <chris.lesiak@licor.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Link: https://lore.kernel.org/linux-iio/20201224011607.1059534-1-linus.walleij@linaro.org/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- After discussion about v2 we concludes that
  iio_read_channel_processed() could loose precision
  so we introduce a new API to read processed and
  scale.
- Include a link to the v2 discussion for reference.
- For ease of applying to the hwmon tree, keep it all
  in one patch.
- This needs Jonathans ACK to be merged through hwmon.
ChangeLog v1->v2:
- Fix the patch to multiply the processed value by
  1000 to get to microvolts from millivolts.
- Fix up the confusion in the commit message.
- Drop pointless comments about the code, we keep the
  original code path around if processed reads don't
  work, nothing bad with that.
---
 drivers/hwmon/ntc_thermistor.c | 27 ++++++++++++++++++---------
 drivers/iio/inkern.c           | 15 +++++++++++++--
 include/linux/iio/consumer.h   | 15 +++++++++++++++
 3 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 3aad62a0e661..8587189c7f15 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -326,18 +326,27 @@ struct ntc_data {
 static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
 {
 	struct iio_channel *channel = pdata->chan;
-	int raw, uv, ret;
+	int uv, ret;
 
-	ret = iio_read_channel_raw(channel, &raw);
+	ret = iio_read_channel_processed_scale(channel, &uv, 1000);
 	if (ret < 0) {
-		pr_err("read channel() error: %d\n", ret);
-		return ret;
-	}
+		int raw;
 
-	ret = iio_convert_raw_to_processed(channel, raw, &uv, 1000);
-	if (ret < 0) {
-		/* Assume 12 bit ADC with vref at pullup_uv */
-		uv = (pdata->pullup_uv * (s64)raw) >> 12;
+		/*
+		 * This fallback uses a raw read and then
+		 * assumes the ADC is 12 bits, scaling with
+		 * a factor 1000 to get to microvolts.
+		 */
+		ret = iio_read_channel_raw(channel, &raw);
+		if (ret < 0) {
+			pr_err("read channel() error: %d\n", ret);
+			return ret;
+		}
+		ret = iio_convert_raw_to_processed(channel, raw, &uv, 1000);
+		if (ret < 0) {
+			/* Assume 12 bit ADC with vref at pullup_uv */
+			uv = (pdata->pullup_uv * (s64)raw) >> 12;
+		}
 	}
 
 	return uv;
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index db77a2d4a56b..6a842c6b6705 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -688,7 +688,8 @@ int iio_read_channel_offset(struct iio_channel *chan, int *val, int *val2)
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_offset);
 
-int iio_read_channel_processed(struct iio_channel *chan, int *val)
+int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
+				     unsigned int scale)
 {
 	int ret;
 
@@ -701,11 +702,14 @@ int iio_read_channel_processed(struct iio_channel *chan, int *val)
 	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
 		ret = iio_channel_read(chan, val, NULL,
 				       IIO_CHAN_INFO_PROCESSED);
+		if (!ret)
+			*val *= scale;
 	} else {
 		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
 		if (ret < 0)
 			goto err_unlock;
-		ret = iio_convert_raw_to_processed_unlocked(chan, *val, val, 1);
+		ret = iio_convert_raw_to_processed_unlocked(chan, *val, val,
+							    scale);
 	}
 
 err_unlock:
@@ -713,6 +717,13 @@ int iio_read_channel_processed(struct iio_channel *chan, int *val)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iio_read_channel_processed_scale);
+
+int iio_read_channel_processed(struct iio_channel *chan, int *val)
+{
+	/* This is just a special case with scale factor 1 */
+	return iio_read_channel_processed_scale(chan, val, 1);
+}
 EXPORT_SYMBOL_GPL(iio_read_channel_processed);
 
 int iio_read_channel_scale(struct iio_channel *chan, int *val, int *val2)
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 0a90ba8fa1bb..5fa5957586cf 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -241,6 +241,21 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val);
  */
 int iio_read_channel_processed(struct iio_channel *chan, int *val);
 
+/**
+ * iio_read_channel_processed_scale() - read and scale a processed value
+ * @chan:		The channel being queried.
+ * @val:		Value read back.
+ * @scale:		Scale factor to apply during the conversion
+ *
+ * Returns an error code or 0.
+ *
+ * This function will read a processed value from a channel. This will work
+ * like @iio_read_channel_processed() but also scale with an additional
+ * scale factor while attempting to minimize any precision loss.
+ */
+int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
+				     unsigned int scale);
+
 /**
  * iio_write_channel_attribute() - Write values to the device attribute.
  * @chan:	The channel being queried.
-- 
2.29.2

