Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA4F325B60
	for <lists+linux-iio@lfdr.de>; Fri, 26 Feb 2021 02:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhBZBsV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Feb 2021 20:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBZBsV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Feb 2021 20:48:21 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0400EC061574
        for <linux-iio@vger.kernel.org>; Thu, 25 Feb 2021 17:47:40 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id e9so5162232pjj.0
        for <linux-iio@vger.kernel.org>; Thu, 25 Feb 2021 17:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIcD1B1LxoaKsY+eEVtZxACUjmvKqFVGILl0I8NPioY=;
        b=nYTxe1s99y9kSsg7kQ8zOZEEmHbfNwsbe/NLgLp0t6X5UiSFiHy945RArMCQUxu2KJ
         het+YPPrsLB9bCYS/RiosfH81I/bD3CNhWgeY94XG7JLSUNzrx9bHWJYaIRcF+TbnKlj
         gBZ43eCNKE2L7sBHUns0g7y3brRWRz6ANwt34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIcD1B1LxoaKsY+eEVtZxACUjmvKqFVGILl0I8NPioY=;
        b=OwNcDATXi7Fm8N4uI19cHsA1pjr3RWgGGu8qW/nXpSFf1evVEdYpaOvjczh71F9xNn
         1WRL/Km0blVclANSBTf9KzBDdkpprhgOhKjEgVQCQuP6kJIoFLuiBuXbh4Jz9iuJTSK1
         7b3Ea40YKB1LGYufYu727NIm9RWN3b4aAM8+gWLany8+hZGOso8VUDcE3BFYrfgqmjGF
         S1t9gXpW2BXtEHODmU6jMXv9cRjzcV98CmUfPoZE9Ky2fqliWWTP49+0jt4oKtVPreGO
         yP0qmAcBNscZ5hQVEPQ3mz28p9yZio0xXwU6wzs05upi6s6WqHZd61mXqNb8xSXBB19Z
         KQnQ==
X-Gm-Message-State: AOAM530aa1tNUn8zISrlI1ZbNCxBrTzs01xkAPXBR1HTNfJRjLoAC6et
        VymPAqi8igFjdqS73c960QJPAA==
X-Google-Smtp-Source: ABdhPJy0XhSakYhXjoiWMzrZaaaTpTj0loSqQ4odW5ktpLpVF7YN+u8P8Tai8zu7VIwrkoce4wkVag==
X-Received: by 2002:a17:90a:e603:: with SMTP id j3mr820614pjy.161.1614304060359;
        Thu, 25 Feb 2021 17:47:40 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b0a4:446e:a265:bffe])
        by smtp.gmail.com with UTF8SMTPSA id d124sm7394503pfa.149.2021.02.25.17.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 17:47:39 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        groeck@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v9] iio: hrtimer: Allow sub Hz granularity
Date:   Thu, 25 Feb 2021 17:47:33 -0800
Message-Id: <20210226014733.2108544-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
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
Changes since v8:
- Define PSEC_PER_SEC locally to avoid dependency
- Add units of expressions in comment.

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
 drivers/iio/trigger/iio-trig-hrtimer.c | 33 ++++++++++++++++++--------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/Documentation/iio/iio_configfs.rst b/Documentation/iio/iio_configfs.rst
index 3a5d76f9e2b97..09845fe525e84 100644
--- a/Documentation/iio/iio_configfs.rst
+++ b/Documentation/iio/iio_configfs.rst
@@ -99,3 +99,4 @@ Each trigger can have one or more attributes specific to the trigger type.
 
 "hrtimer" trigger type doesn't have any configurable attribute from /config dir.
 It does introduce the sampling_frequency attribute to trigger directory.
+That attribute sets the polling frequency in Hz, with mHz precision.
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index 410de837d0417..aa8cc7391a60d 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -16,13 +16,16 @@
 #include <linux/iio/trigger.h>
 #include <linux/iio/sw_trigger.h>
 
+/* Defined locally, not in time64.h yet. */
+#define PSEC_PER_SEC   1000000000000LL
+
 /* default sampling frequency - 100Hz */
 #define HRTIMER_DEFAULT_SAMPLING_FREQUENCY 100
 
 struct iio_hrtimer_info {
 	struct iio_sw_trigger swt;
 	struct hrtimer timer;
-	unsigned long sampling_frequency;
+	int sampling_frequency[2];
 	ktime_t period;
 };
 
@@ -38,7 +41,9 @@ ssize_t iio_hrtimer_show_sampling_frequency(struct device *dev,
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct iio_hrtimer_info *info = iio_trigger_get_drvdata(trig);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", info->sampling_frequency);
+	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO,
+			ARRAY_SIZE(info->sampling_frequency),
+			info->sampling_frequency);
 }
 
 static
@@ -48,18 +53,26 @@ ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
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
+	val = fract + 1000 * integer;  /* mHz */
 
-	if (!val || val > NSEC_PER_SEC)
+	if (!val || val > UINT_MAX)
 		return -EINVAL;
 
-	info->sampling_frequency = val;
-	info->period = NSEC_PER_SEC / val;
+	info->sampling_frequency[0] = integer;  /* Hz */
+	info->sampling_frequency[1] = fract * 1000;  /* uHz */
+	period = PSEC_PER_SEC;
+	do_div(period, val);
+	info->period = period;  /* nS */
 
 	return len;
 }
@@ -135,8 +148,8 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
 	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	trig_info->timer.function = iio_hrtimer_trig_handler;
 
-	trig_info->sampling_frequency = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
-	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency;
+	trig_info->sampling_frequency[0] = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
+	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency[0];
 
 	ret = iio_trigger_register(trig_info->swt.trigger);
 	if (ret)
-- 
2.30.1.766.gb4fecdf3b7-goog

