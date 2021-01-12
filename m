Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9722F254C
	for <lists+linux-iio@lfdr.de>; Tue, 12 Jan 2021 02:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbhALBMl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jan 2021 20:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbhALBMk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2021 20:12:40 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F576C061575
        for <linux-iio@vger.kernel.org>; Mon, 11 Jan 2021 17:12:00 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id p12so580069pju.5
        for <linux-iio@vger.kernel.org>; Mon, 11 Jan 2021 17:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6R/cq6PIYbS6Bsrl+RHrnbHTzftJZnFEZon8G4ejAuw=;
        b=cUece+YuN0yDo7znegO5IPyFtlSL/NRE041LYGwoKyn0FRDsN5NtccbEe0tB4mzq0+
         A9Y0jZuBbisxTf6ow6I/HYe82ZZgLwCyxShU3NCBI6cyk6g6f5nR7eqg2jlf+E4NbPIx
         nxYzX0aVAJXyfgdblVIYJbq9SQHqTKflgRFwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6R/cq6PIYbS6Bsrl+RHrnbHTzftJZnFEZon8G4ejAuw=;
        b=gPGYPTSLXCCqtkAaw2Rb1InRoQibBx8XYIMDrV6RF0HRgXiXfavUaaX09ZrdDToUkA
         TFqUBz5kiILNAjI1RoCJuYob+6UtsE3GMwFWfDkX0CbfqDjV8dmgfgeMf22voQztsg9Q
         hx+Vg2IuVPGRF6w2bH7/9XATlncctShwF9RXSDbsuPXpu//BxiyK2BXzw+UVi0eQNEyM
         fkmhy3GlFd1hFb3YqhE8OzWxkR2uMfEwzq0dCJ6GVBOfxmHwOqsvNQYVlaxgy3t7b2hl
         maNca1nYz6inKZzm93gG+MPbyarL7R1MEKLYZiUKMFY2VHIQSfd2WX0tILC0LVAt2CO6
         tabQ==
X-Gm-Message-State: AOAM531XRsR9u0os36xO7SNmu6YyKbaPcc1H7kcC70rhNBEfuXr9dmpP
        Wv44ubi3WHMZ5BqWz88bNB/jxw==
X-Google-Smtp-Source: ABdhPJzId2XNSdFw1uWmosuVNyAADqDe42fpPX4zp3axmE85f9lg7Fq2Rvr4F91PGj45EKXmT09HlA==
X-Received: by 2002:a17:90a:4083:: with SMTP id l3mr1670827pjg.109.1610413919732;
        Mon, 11 Jan 2021 17:11:59 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id cl23sm678118pjb.23.2021.01.11.17.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 17:11:58 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4] iio: hrtimer: Allow sub Hz granularity
Date:   Mon, 11 Jan 2021 17:11:54 -0800
Message-Id: <20210112011154.2435035-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
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
Changes since v3:
- Fix rebasing issue. 

Changes since v2:
- Add do_div to allow divide by a u64 on 32bit machines.

Changes since v1:
- Added documentation.

 Documentation/iio/iio_configfs.rst     |  1 +
 drivers/iio/trigger/iio-trig-hrtimer.c | 26 ++++++++++++++++----------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/Documentation/iio/iio_configfs.rst b/Documentation/iio/iio_configfs.rst
index 3a5d76f9e2b9..09845fe525e8 100644
--- a/Documentation/iio/iio_configfs.rst
+++ b/Documentation/iio/iio_configfs.rst
@@ -99,3 +99,4 @@ Each trigger can have one or more attributes specific to the trigger type.
 
 "hrtimer" trigger type doesn't have any configurable attribute from /config dir.
 It does introduce the sampling_frequency attribute to trigger directory.
+That attribute sets the polling frequency in Hz, with mHz precision.
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index 410de837d041..aae12a245ece 100644
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
@@ -48,18 +50,22 @@ ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct iio_hrtimer_info *info = iio_trigger_get_drvdata(trig);
-	unsigned long val;
-	int ret;
+	unsigned long long val;
+	int integer, fract, ret;
 
-	ret = kstrtoul(buf, 10, &val);
+	ret = iio_str_to_fixpoint(buf, 100, &integer, &fract);
 	if (ret)
 		return ret;
 
-	if (!val || val > NSEC_PER_SEC)
+	val = fract + 1000 * integer;
+
+	if (!val || val > NSEC_PER_SEC * 1000)
 		return -EINVAL;
 
-	info->sampling_frequency = val;
-	info->period = NSEC_PER_SEC / val;
+	info->sampling_frequency[0] = integer;
+	info->sampling_frequency[1] = fract * 1000;
+	info->period = NSEC_PER_SEC * 1000;
+	info->period = do_div(info->period, val);
 
 	return len;
 }
@@ -135,8 +141,8 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
 	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	trig_info->timer.function = iio_hrtimer_trig_handler;
 
-	trig_info->sampling_frequency = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
-	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency;
+	trig_info->sampling_frequency[0] = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
+	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency[0];
 
 	ret = iio_trigger_register(trig_info->swt.trigger);
 	if (ret)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

