Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996452DF204
	for <lists+linux-iio@lfdr.de>; Sat, 19 Dec 2020 23:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgLSWmd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Dec 2020 17:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgLSWmc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Dec 2020 17:42:32 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B524C0613CF
        for <linux-iio@vger.kernel.org>; Sat, 19 Dec 2020 14:41:50 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o19so14849976lfo.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Dec 2020 14:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82OS3pLNd8iUHESUMUxIhbTgIU37vSfj8yHnrTeu96Y=;
        b=TrSct3igLxzJi4/z97dqaidZkhkr01QcRXtp42P0HWxxErrIcM5M/1moUcA25uBMkf
         mNrdJVLAXqj09giY+T1ZqJwAIgjYCoDdPbDTKBT+4En2C9T3FbUMFEtF+9mTaMNwvxis
         NKO6Ff9CdJ2S54zCfljdp/ZcA5rMJaTMqwWBqmY7MzcBO6f3268Y8BN0b4KvOqnNYN1n
         j+eskQ8IFO79uiQ+xQqoezbn9PBNj3WA1cZU3kHwQp9OvRtgMXDDiDEdzGdeObQMMkD8
         GZ/hVFflAS+6iMYqXEohsluX5AWwUloKEbcol2w2fuJGSGInIrsUT126xjVzfuczoM6g
         WXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82OS3pLNd8iUHESUMUxIhbTgIU37vSfj8yHnrTeu96Y=;
        b=qSe75AlrgDU218nfZJ1bq9SA8i45o7Fjezu29xaQDjekzWES54xnujhTpE7EoP4y8K
         ZccpkI/Rnf72pYdyzQoUjmMvLY+bVlFwvnnnrJiuYto9N9dUpnxsGvrror6RC6b1Vz+e
         V/xU+CyisTelNlCUB/DmYmMsv+jU/KNRiIrN5qWmBhLGjXyP1OUaXr+PbAHtv+UPyR6u
         2+GyBUfxDfM+YN08lLhGuZrpTXxt/pmGGhWnBnYIqDZVLCy6XVPoGgeulI0T4gy88tTC
         Hg+ViL4XZ+6nxaUXxmIZyr/bQqwOM7ZMpYs5qa2zSrTwNX+XUO5mWeUTNG3yTn3eVqYt
         u/ZA==
X-Gm-Message-State: AOAM533+RzwnVjQIIGMRhZkf7oh2Da25ByNkCjSQbSCMsMMGtIGBTOll
        W2RoKO0W21+soR9Mejoc4vbxVA==
X-Google-Smtp-Source: ABdhPJyb4/OE6CfJu11wNoQYGVhclGqX8lAfSXe4t+nUc4gruT1BjchaAm8LF4hX0+js6jjOqSTVkw==
X-Received: by 2002:a2e:8045:: with SMTP id p5mr4553381ljg.289.1608417708792;
        Sat, 19 Dec 2020 14:41:48 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id 195sm1368982lfk.109.2020.12.19.14.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 14:41:48 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: [PATCH] hwmon: (ntc_thermistor): try reading processed
Date:   Sat, 19 Dec 2020 23:41:43 +0100
Message-Id: <20201219224143.686074-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Before trying the custom method of reading the sensor
as raw and then converting assuming 1000 scaling, just
use iio_read_channel_processed() which first tries to
see if the ADC can provide a processed value directly,
else reads raw and applies scaling inside of IIO
using the scale attributes of the ADC.

The code that hardcodes scaling to 1000 and assumes
a 12bit ADC is very dubious. I keep it around here
but I have a strong urge to just delete it.

This gives correct readings on the AB8500 thermistor
inputs used in the Ux500 HREFP520 platform for reading
battery and board temperature.

Cc: Peter Rosin <peda@axentia.se>
Cc: Chris Lesiak <chris.lesiak@licor.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/hwmon/ntc_thermistor.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 3aad62a0e661..ac0d80faddf6 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -326,18 +326,29 @@ struct ntc_data {
 static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
 {
 	struct iio_channel *channel = pdata->chan;
-	int raw, uv, ret;
+	int uv, ret;
 
-	ret = iio_read_channel_raw(channel, &raw);
+	/* A processed voltage channel will return microvolts */
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
+		 * FIXME: This fallback to using a raw read and then right
+		 * out assume the ADC is 12 bits and hard-coding scale
+		 * to 1000 seems a bit dangerous. Should it simply be
+		 * deleted?
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
-- 
2.29.2

