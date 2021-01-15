Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C412F8948
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jan 2021 00:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbhAOXRJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jan 2021 18:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhAOXRI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jan 2021 18:17:08 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605F6C0613D3
        for <linux-iio@vger.kernel.org>; Fri, 15 Jan 2021 15:16:28 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id g15so6965976pgu.9
        for <linux-iio@vger.kernel.org>; Fri, 15 Jan 2021 15:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uSop28QKfbgeQS619poHgerSZ2oNr0NFuecw4kYHheU=;
        b=DUUR6mCOr8Voy04tI7XTnNK6SVyHdLElGmoxsezmPgliQ9nVeEs9c0RmKGcti+KnWq
         nXiWPPgJf0nNT1vhFuOGkt/dEx5zb4BGCgjUc4s+Qx97obddQzFh2lDAbqo+FeeIhmfC
         EejlMmha1hoSjr0oEUPIMHSvcREUXzzmyGbOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uSop28QKfbgeQS619poHgerSZ2oNr0NFuecw4kYHheU=;
        b=cwlJFMdyuavQqEQvI5lOLoNxJlS+McIxD1g7RGS73j0eoZ31ONgqgVi8RhhNVYjuNc
         RtYZ+PQPSqSX3xKLEYVN1kh1X9kb3xBRFrD+ZmX9HzdrbA/UcR9mS4kEOfN74542dEHN
         419EXsMfDb1KmhCBoKljumoKr08BqPXS4JMevdbjLGaIFQQawy4jQ87bDDrx5WBBJf8o
         1OXBnRJ1A5aDKq2ZUswAnepppCjiCSC25dL2pIk19qEhY+zw/GeCQB3rVhmMvnWydcnF
         M4SV6hlcqcx7IlD/D0s83db5CnVFIqeCinC5Xdtoa/WHL8FG4SWR/qAu2IGgp7iFOE7x
         MECw==
X-Gm-Message-State: AOAM533a8782a93II7oDU3OO+/vQgmQJEFT4Ew+n1gjuN6w+bPDyhWvL
        7PBvn5ZoCzv9QdRnIuedhphQhw==
X-Google-Smtp-Source: ABdhPJxMjgFYWTmJnjy9y6+S+fsKH0XHGnaYfD5709x0CMRi3UGcAWrsrfsq8bCnaG2otTScRtpMeQ==
X-Received: by 2002:aa7:9eda:0:b029:19d:ce86:f941 with SMTP id r26-20020aa79eda0000b029019dce86f941mr14830777pfq.57.1610752587775;
        Fri, 15 Jan 2021 15:16:27 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id o1sm8813965pgq.1.2021.01.15.15.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 15:16:26 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6] iio: hrtimer: Allow sub Hz granularity
Date:   Fri, 15 Jan 2021 15:16:13 -0800
Message-Id: <20210115231613.2878027-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Allow setting frequency below 1Hz or sub 1Hz precision.
Useful for slow sensors like ALS.

Test frequency is set properly:
modprobe iio-trig-hrtimer && \
mkdir /sys/kernel/config/iio/triggers/hrtimer/t1 && \
cd /sys/bus/iio/devices/triggerX ;
for i in 1 .1 .01 .001 ; do
  echo $i > sampling_frequency
  cat sampling_frequency
done

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v5:
- Properly support do_div on 32bit architecture: quotient must be u64, dividend
  u32.
- Use PSEC_PER_SEC from
  https://patchwork.kernel.org/project/linux-iio/patch/20210112153709.1074-1-andriy.shevchenko@linux.intel.com/

Changes since v4:
- Use do_div() properly.

Changes since v3:
- Fix rebasing issue.

Changes since v2:
- Add do_div to allow divide by a u64 on 32bit machines.

Changes since v1:
- Added documentation.

 Documentation/iio/iio_configfs.rst     |  1 +
 drivers/iio/trigger/iio-trig-hrtimer.c | 28 +++++++++++++++++---------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/Documentation/iio/iio_configfs.rst b/Documentation/iio/iio_configfs.rst
index ecbfdb3afef7e..807589ef2bea0 100644
--- a/Documentation/iio/iio_configfs.rst
+++ b/Documentation/iio/iio_configfs.rst
@@ -99,3 +99,4 @@ Each trigger can have one or more attributes specific to the trigger type.
 
 "hrtimer" trigger type doesn't have any configurable attribute from /config dir.
 It does introduce the sampling_frequency attribute to trigger directory.
+That attribute sets the polling frequency in Hz, with mHz precision.
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index 58c1c30d5612b..b560194b4f1f3 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -22,7 +22,7 @@
 struct iio_hrtimer_info {
 	struct iio_sw_trigger swt;
 	struct hrtimer timer;
-	unsigned long sampling_frequency;
+	int sampling_frequency[2];
 	ktime_t period;
 };
 
@@ -38,7 +38,9 @@ ssize_t iio_hrtimer_show_sampling_frequency(struct device *dev,
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct iio_hrtimer_info *info = iio_trigger_get_drvdata(trig);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", info->sampling_frequency);
+	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO,
+			ARRAY_SIZE(info->sampling_frequency),
+			info->sampling_frequency);
 }
 
 static
@@ -48,18 +50,24 @@ ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct iio_hrtimer_info *info = iio_trigger_get_drvdata(trig);
-	unsigned long val;
-	int ret;
+	unsigned long long val;
+	u64 period;
+	int integer, fract, ret;
 
-	ret = kstrtoul(buf, 10, &val);
+	ret = iio_str_to_fixpoint(buf, 100, &integer, &fract);
 	if (ret)
 		return ret;
 
-	if (!val || val > NSEC_PER_SEC)
+	val = fract + 1000 * integer;
+
+	if (!val || val > UINT_MAX)
 		return -EINVAL;
 
-	info->sampling_frequency = val;
-	info->period = NSEC_PER_SEC / val;
+	info->sampling_frequency[0] = integer;
+	info->sampling_frequency[1] = fract * 1000;
+	period = PSEC_PER_SEC;
+	do_div(period, val);
+	info->period = period;
 
 	return len;
 }
@@ -135,8 +143,8 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
 	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	trig_info->timer.function = iio_hrtimer_trig_handler;
 
-	trig_info->sampling_frequency = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
-	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency;
+	trig_info->sampling_frequency[0] = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
+	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency[0];
 
 	ret = iio_trigger_register(trig_info->swt.trigger);
 	if (ret)
-- 
2.30.0.296.g2bfb1c46d8-goog

