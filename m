Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640AC2F2515
	for <lists+linux-iio@lfdr.de>; Tue, 12 Jan 2021 02:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbhALArP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jan 2021 19:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731868AbhALArD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2021 19:47:03 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC9EC061575
        for <linux-iio@vger.kernel.org>; Mon, 11 Jan 2021 16:46:23 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i5so302204pgo.1
        for <linux-iio@vger.kernel.org>; Mon, 11 Jan 2021 16:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BFSAmenJoGpDLR5Jd0Z+pzCgvWKTXPzWQPtDSg8JcU0=;
        b=VE2YKCe/C92UEBhhyJJoeP24tB9ikVQDqd/zqZbBN2DkJM4eq9Fl4E5yYrHlRlh9HY
         zwh6MYi0JWVUI40ggP4v7bHUxdSsh/3vd0FwMf+7bcyYyH9n0jK5npqG/4J2U2KT58nN
         CCWtz/3gluSQ64tmoDhcPuSSjGwE87yuW1rOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BFSAmenJoGpDLR5Jd0Z+pzCgvWKTXPzWQPtDSg8JcU0=;
        b=erIP7CeV8p4fPnD4P3rjl3+ntvUN47QUxpX2n1IkYwZYm/gfptNGdieB2As8V46VFs
         zm80nqfCXMNikpDTOvUfSWzSg2Oeh6y5I7vfWaoY67Du0ePE3/5yr1k9BkCCNhp2+4Lb
         0YfX/3+L1f76/zCi1z4Op6WJmYQw4t5ijHQEyqq3KxE/3aFR8DQeR5Lu44iJrsE/IxlG
         31Le4WbCWmFPYtD0TyaJdLBytnP/cZoyLgd1bWkpifJYF2X03C78UK84SSv3/wqXj3e8
         +9cd/HMsbCGOiZjMx35M7b6REgcQBPDvTIgPtZoBY9skdBQasCqegU2aChqwyfkhGNUN
         PI+w==
X-Gm-Message-State: AOAM530i2tjF4HhvGMcwzn5p2GNd3VluY+Fe8s1nYtkb46ADfh5qMo1x
        SKvW5gz3GGhvuZH+f0NGR4iWdry4nhcPGg==
X-Google-Smtp-Source: ABdhPJxUcN1yV0bDYbGUfugjVqknKxPy/Y69Rclj/D/5d4rtS57UGvb+x4dIsikImygKIQrdrtJy9w==
X-Received: by 2002:a63:e246:: with SMTP id y6mr2015962pgj.412.1610412382837;
        Mon, 11 Jan 2021 16:46:22 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id m3sm795507pfa.134.2021.01.11.16.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 16:46:21 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3] iio: hrtimer: Allow sub Hz granularity
Date:   Mon, 11 Jan 2021 16:46:11 -0800
Message-Id: <20210112004611.2426181-1-gwendal@chromium.org>
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
index a5e670726717f..ac2c3be164ac6 100644
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
 	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	trig_info->timer.function = iio_hrtimer_trig_handler;
 
-	trig_info->sampling_frequency = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
-	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency;
+	trig_info->sampling_frequency[0] = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
+	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency[0];
 
 	ret = iio_trigger_register(trig_info->swt.trigger);
 	if (ret)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

