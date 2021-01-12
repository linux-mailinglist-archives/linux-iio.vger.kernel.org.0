Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFB22F26E9
	for <lists+linux-iio@lfdr.de>; Tue, 12 Jan 2021 05:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbhALEKH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jan 2021 23:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbhALEKH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2021 23:10:07 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3824AC061575
        for <linux-iio@vger.kernel.org>; Mon, 11 Jan 2021 20:09:27 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id q4so689237plr.7
        for <linux-iio@vger.kernel.org>; Mon, 11 Jan 2021 20:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vyL9AEMjH5LWqpHoqXCBrwI8PaVFckxwxaCMSAC7ThY=;
        b=ZOf/vTcBl4KnJAcvvkHbLm87f22xj3oc+1RlAU80+//EA0fNeYcuh4WqHsT1eRYWUa
         eansoucBd08fvt5pk1cFlHgVMO20hvgxaiSMxqu8RH+fUpdmtQn4JWi6PCHVv75JLhLz
         CV1ShnHQyWWtGhaDRE66jzAS9QrWtcMDC2wnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vyL9AEMjH5LWqpHoqXCBrwI8PaVFckxwxaCMSAC7ThY=;
        b=StTz71I4R54GAPLo+0BxsR/BDCPmCRofCpFBTxaUoDUvBv4NNp3OLETS5Vrc/oSPLp
         VUMgWzQ6PcgRr4kJOakEyacAJWA4YPGqjWsQkreoOv9AOAYHqrdt5rPeCDROdCVMQn5t
         oKY9kOT71TXWRV9FaVq6PxQjCpJV6f8e7dX6XgD4mRgFLP/xIcUhN/2Pz6r4lfkCTtL0
         qhz0xm0XL+Sq2Xotv52SsStXLsiQkInbKTMHbijiOCzqJSmS/6r0pXJ4tbvG40iffc52
         x11k48PxE39ObORgwKCpyDs86kjVVurb0HEGgy++z1MZSRDTtloYL00wheIEtOfj145m
         +tCw==
X-Gm-Message-State: AOAM531A93DNNh8tyVcR2MYw2/7uAgiSIWhrTx489CjXQ2xg3LLm9OiM
        ZWIX0GSvJxu8pt0R1xvfc7rT6w==
X-Google-Smtp-Source: ABdhPJzFIqP2LNKixi3P/0AMIPo39l8CBKwVDcd7BYFwzXD7RI/0jA5Dwi7+LU8mWMVzYHBkvGSjww==
X-Received: by 2002:a17:902:a5cb:b029:dc:2706:4cc8 with SMTP id t11-20020a170902a5cbb02900dc27064cc8mr2765230plq.62.1610424566735;
        Mon, 11 Jan 2021 20:09:26 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id h10sm1120880pfn.213.2021.01.11.20.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 20:09:26 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5] iio: hrtimer: Allow sub Hz granularity
Date:   Mon, 11 Jan 2021 20:09:23 -0800
Message-Id: <20210112040923.2613711-1-gwendal@chromium.org>
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
Changes since v4:
- Use do_div() properly.

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
index ecbfdb3afef7e..807589ef2bea0 100644
--- a/Documentation/iio/iio_configfs.rst
+++ b/Documentation/iio/iio_configfs.rst
@@ -99,3 +99,4 @@ Each trigger can have one or more attributes specific to the trigger type.
 
 "hrtimer" trigger type doesn't have any configurable attribute from /config dir.
 It does introduce the sampling_frequency attribute to trigger directory.
+That attribute sets the polling frequency in Hz, with mHz precision.
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index 58c1c30d5612b..1effab04e00a8 100644
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
+	do_div(info->period, val);
 
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

