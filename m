Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5D72E235C
	for <lists+linux-iio@lfdr.de>; Thu, 24 Dec 2020 02:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgLXBQx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Dec 2020 20:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgLXBQw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Dec 2020 20:16:52 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C84C06179C
        for <linux-iio@vger.kernel.org>; Wed, 23 Dec 2020 17:16:12 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id a12so1530155lfl.6
        for <linux-iio@vger.kernel.org>; Wed, 23 Dec 2020 17:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czptFay4sxNBxdeX/6m7zLzHRzM7f7t5O5r/8rNb9WY=;
        b=MOitgnklA9nPkbQDPPZWhF3Newd29xfvrKfIyeL3ceJwWHM9u9R4qREux9s6XUHTNo
         HWIRA5ttZjedSn4AAGtKxhcrpyat9BTyo0iz/lGnygYM3O/qabPBcFB5LgYzU5QaCyQh
         GvBMUuAqc5ulkso4GDL1bfSEUjnMrfSS4uPfLEPWGaszn8QE2CNqvZ6HiY3f/RYCeVXt
         ATWe4fCB7vSZdCncGFZpbQOL+CeFjwJXhAB8aJMd+PEgzNQ8uc2ZTF+0kZOcycOc0m0e
         01yGm2wxfWgtCrf1v2ko2TdGG8adJBD+kChssaXP7pybT/9lNVVhat1iifUVFm/dyM9i
         HlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czptFay4sxNBxdeX/6m7zLzHRzM7f7t5O5r/8rNb9WY=;
        b=VAvlJ67xbYE28fg7SZsFDrwA+8QD1OOViCFCFfLy9GGEgDH0lvcGphHQuu6U3pymz1
         ZN2xc4Y2i7MZAAtbuVN8O+rjI190JBkRCEu/v4Njx3u1CvY5Syci/ovdUVf0QsairvMt
         kfUSdpGDUChk60r04Z8mKODbBx7aT3VUySebUH7Lf4nGDlkgJAGcMzjpHcFakIOCaseW
         BjQgzvuXeUnru104CXYqBHpr1RlZ9oQv9hpY7VHZmvdAHN0T5Lgo6aw4xKymYgl2ywh+
         Xc/BO4ScWWGH1k5taZx6PzOvQdbWPM4fn4Exyzsscca3gc2CNulUasig9u/WqNz3yich
         JQsg==
X-Gm-Message-State: AOAM533p+ioMxgojCXo8Gftsk3EZiY1FQFqvMYX4lHsshOA1m1Y3UwJG
        LrrlbC6OI6oiB3p3fl+EW6tpdQ==
X-Google-Smtp-Source: ABdhPJyXNecBYFgx3Lc+NnQfjxozy15FNnezF3UuBFNN3Yscr2dukVi6HX35a7/f/F8czxE2M+K9nQ==
X-Received: by 2002:a05:651c:1027:: with SMTP id w7mr12338558ljm.297.1608772570839;
        Wed, 23 Dec 2020 17:16:10 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id v7sm3416210lfg.9.2020.12.23.17.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 17:16:10 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: [PATCH v2] hwmon: (ntc_thermistor): try reading processed
Date:   Thu, 24 Dec 2020 02:16:07 +0100
Message-Id: <20201224011607.1059534-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Before trying the custom method of reading the sensor
as raw and then converting, just use
iio_read_channel_processed() which first tries to
see if the ADC can provide a processed value directly,
else reads raw and applies scaling inside of IIO
using the scale attributes of the ADC. We need to
multiply the scaled value with 1000 to get to
microvolts from millivolts which is what processed
IIO channels returns.

Keep the code that assumes 12bit ADC around as a
fallback.

This gives correct readings on the AB8500 thermistor
inputs used in the Ux500 HREFP520 platform for reading
battery and board temperature.

Cc: Peter Rosin <peda@axentia.se>
Cc: Chris Lesiak <chris.lesiak@licor.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix the patch to multiply the processed value by
  1000 to get to microvolts from millivolts.
- Fix up the confusion in the commit message.
- Drop pointless comments about the code, we keep the
  original code path around if processed reads don't
  work, nothing bad with that.
---
 drivers/hwmon/ntc_thermistor.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 3aad62a0e661..c1c02cc454fc 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -326,18 +326,33 @@ struct ntc_data {
 static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
 {
 	struct iio_channel *channel = pdata->chan;
-	int raw, uv, ret;
+	int uv, ret;
 
-	ret = iio_read_channel_raw(channel, &raw);
+	ret = iio_read_channel_processed(channel, &uv);
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
+	} else {
+		/*
+		 * The processed channel is in millivolts, so scale this
+		 * to microvolts.
+		 */
+		uv *= 1000;
 	}
 
 	return uv;
-- 
2.29.2

