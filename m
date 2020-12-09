Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A410C2D4E50
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 23:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbgLIWr3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 17:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgLIWr3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 17:47:29 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE8FC0613CF
        for <linux-iio@vger.kernel.org>; Wed,  9 Dec 2020 14:46:49 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id c12so1821123pgm.4
        for <linux-iio@vger.kernel.org>; Wed, 09 Dec 2020 14:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qz6+DdMd5RNxX8TCnBI4nuok4jXoLSR1RsO27ukaupA=;
        b=QFPOM3J8PnHfVLppvTVqFEUCzCZLvfEdt31UY6uugbK1uVYSHvGRpLzk735BE55mRQ
         dFKAq1bJ1I0KK4Votrngn9+HH33ftMD93Ll8YK9mhaF3pXZ0VEEL+1zq6kf6kfh8NPyz
         c2d/xkHOL/K0bPId477mhd2jouGgoaiNvHEsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qz6+DdMd5RNxX8TCnBI4nuok4jXoLSR1RsO27ukaupA=;
        b=ktsNfhxeqnswNo6rfZH3rvGnO9plPsJHs2I8/bDj556Ji8qidYty4ZwtxxdyOQ3Y8K
         D1+f9WJFaAdZlWCZ4s14F5sDXNmHOnMD+xNcv4v15CtbOODzgEeGuyDSXyvP4nFtavBF
         Mo1MvXQqSKNnV7POv72VTCLeCnM5gLjrAe+wxu8iZrL+2ObfNRo/+ofJiRw0uz1cwDKa
         FvPAvsZeOxnjEGZlP887D1lRFrGYvsfV+YZ1SYmFW4HyeNv35nHO/fVQ3uRFzMc+95f2
         r9rbZESkulQNAvy42E9pjXphBgctMh0Gm6ma6fZzBsNVS0e60TLnkna0CGxTpQQRUNhk
         hSAA==
X-Gm-Message-State: AOAM533acTUQKIECd0UtF4z0K/h/C5jespOjMCLmgrV8iOo90DiCyHlT
        nGwcbBbOiaeHLfddNeKt1K3+NZ8/v8J2WQ==
X-Google-Smtp-Source: ABdhPJynKk2gkXrh/hgf5fN/SthXFeEeLgRQiFSpnNvOtBEqPajCZLDU5qOCL9W7nhpSAaHQe5nFFQ==
X-Received: by 2002:a65:6404:: with SMTP id a4mr3899644pgv.416.1607554008909;
        Wed, 09 Dec 2020 14:46:48 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id i37sm350627pgi.46.2020.12.09.14.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 14:46:48 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] iio: hrtimer: Allow sub Hz granularity
Date:   Wed,  9 Dec 2020 14:46:44 -0800
Message-Id: <20201209224644.185134-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
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
Changes since v1:
- Added documentation.

 Documentation/iio/iio_configfs.rst     |  1 +
 drivers/iio/trigger/iio-trig-hrtimer.c | 25 +++++++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/iio/iio_configfs.rst b/Documentation/iio/iio_configfs.rst
index ecbfdb3afef7e..428419f8732c4 100644
--- a/Documentation/iio/iio_configfs.rst
+++ b/Documentation/iio/iio_configfs.rst
@@ -99,3 +99,4 @@ Each trigger can have one or more attributes specific to the trigger type.
 
 "hrtimer" trigger type doesn't have any configurable attribute from /config dir.
 It does introduce the sampling_frequency attribute to trigger directory.
+That attribute sets the polling frequency in Hz, with mHz precision.
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index a5e670726717f..06acd6dc79a8c 100644
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
@@ -48,18 +50,21 @@ ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
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
+	info->period = NSEC_PER_SEC * 1000 / val;
 
 	return len;
 }
@@ -135,8 +140,8 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
 	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	trig_info->timer.function = iio_hrtimer_trig_handler;
 
-	trig_info->sampling_frequency = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
-	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency;
+	trig_info->sampling_frequency[0] = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;
+	trig_info->period = NSEC_PER_SEC / trig_info->sampling_frequency[0];
 
 	ret = iio_trigger_register(trig_info->swt.trigger);
 	if (ret)
-- 
2.29.2.576.ga3fc446d84-goog

