Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC7430906A
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jan 2021 00:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhA2XDg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Jan 2021 18:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhA2XDf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jan 2021 18:03:35 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA62C061573
        for <linux-iio@vger.kernel.org>; Fri, 29 Jan 2021 15:02:54 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d2so1133937pjs.4
        for <linux-iio@vger.kernel.org>; Fri, 29 Jan 2021 15:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XHP0FZqfModTnj1b6V9hky1H+PtfYxfOvcBJQg+Xxe8=;
        b=H5SUDsgDFrnllQEO5jztJN81nvH0qxUt4e01v9juo+H0o3iJbjKn/ACB6aympaO32b
         eUzmniu21E8lBZTt9HKSsOLfwPRusO+Y+wkHbKAq7WZ1dznvgMP7v99wljAGnZIqpyO3
         1Hcsv3rMXJkQ7PlzG+o0baqIIYx0uS2VBotQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XHP0FZqfModTnj1b6V9hky1H+PtfYxfOvcBJQg+Xxe8=;
        b=I/RNs3490XXd12f/L1THHXrvbP5IYSZPEE3snAJXW4NA6NcH53/bzmIEU+AckX+ktY
         jPif6xztEQZJ7UsfhI8SvxP44Boe1m6qhZ+UPlul34HWKNgVTmHyJ73O682mK5wXpcsG
         qV8eReu/7E3wIoIHz30z9es4pRl9o6H2e11h8O74ZQA3sFtdG+HyYkJ0z1fePSHqSzk2
         sKG7is6CIQEjiyhgLD5F2Ox4+x7/jvjKuKj2+cuQeBRSR8m7TxgH86TLMrAiSJQJRskT
         vvpvTKVEC1sl4GUL6dLXC5c+k2SMNeS51hoI3K6RNzZ98ezOF6N3/14X83Wx4MEUmkE1
         13Sw==
X-Gm-Message-State: AOAM531FJoLDDZSGNp143zGgtjxKmQOAZtN4XnyRtLXXFAb1smJJHZPn
        bUzXHtHE7u5UZSLt8lTAq/9VJQ==
X-Google-Smtp-Source: ABdhPJw+vnkvYyzwBlFSnEgUrarcAjTuSPfiVs9CYcP7+qpdyqGenDkqMBOY5ZMPJ7t+c17YXfiHkw==
X-Received: by 2002:a17:902:8342:b029:e1:1465:4bf0 with SMTP id z2-20020a1709028342b02900e114654bf0mr6261499pln.76.1611961374474;
        Fri, 29 Jan 2021 15:02:54 -0800 (PST)
Received: from localhost ([2620:15c:202:201:6c61:23a5:b2b2:6216])
        by smtp.gmail.com with ESMTPSA id x125sm10016625pfd.17.2021.01.29.15.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 15:02:53 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v8] iio: hrtimer: Allow sub Hz granularity
Date:   Fri, 29 Jan 2021 15:02:49 -0800
Message-Id: <20210129230249.816268-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
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
Changes since v7:
- Check for sign properly, only allow positive frequencies.
- Return proper error code when input frequency is negative.

Changes since v6:
- Check for sign, only allow positive frequencies.

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
 drivers/iio/trigger/iio-trig-hrtimer.c | 30 +++++++++++++++++---------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/Documentation/iio/iio_configfs.rst b/Documentation/iio/iio_configfs.rst
index ecbfdb3afef7e..807589ef2bea0 100644
--- a/Documentation/iio/iio_configfs.rst
+++ b/Documentation/iio/iio_configfs.rst
@@ -99,3 +99,4 @@ Each trigger can have one or more attributes specific to the trigger type.
 
 "hrtimer" trigger type doesn't have any configurable attribute from /config dir.
 It does introduce the sampling_frequency attribute to trigger directory.
+That attribute sets the polling frequency in Hz, with mHz precision.
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index f59bf8d585866..69c2943583b36 100644
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
@@ -48,18 +50,26 @@ ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
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
+	if (integer < 0 || fract < 0)
+		return -ERANGE;
+
+	val = fract + 1000 * integer;
 
-	if (!val || val > NSEC_PER_SEC)
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
@@ -135,8 +145,8 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
 	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	trig_info->timer.function = iio_hrtimer_trig_handler;
 
-	trig_info->sampling_frequency = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
-	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency;
+	trig_info->sampling_frequency[0] = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
+	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency[0];
 
 	ret = iio_trigger_register(trig_info->swt.trigger);
 	if (ret)
-- 
2.30.0.365.g02bc693789-goog

