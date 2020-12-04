Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C122CF505
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 20:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgLDTs4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 14:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgLDTsz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Dec 2020 14:48:55 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D768BC0613D1
        for <linux-iio@vger.kernel.org>; Fri,  4 Dec 2020 11:48:09 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so4136679pgg.13
        for <linux-iio@vger.kernel.org>; Fri, 04 Dec 2020 11:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9oo71f7EepGEshdY1pgTF+2bORVq9UNwL8pNKUpVxNk=;
        b=hCshOgNhR96IaHP9+Gijq15cxp6rsGTMu7y6Vn9+8Ktt1WNEWa1z1KdHIBEOJ+9Zkv
         2z8q8CjkmT9/GsxhmYr0UYpuf2DCUEH6qV8cCk5+K04Kyx/jn3K0ZX0gByk9+635Jf/A
         nxeMo3UHkOc7c8K8UIW+4EFcvK+XJMlFdBI2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9oo71f7EepGEshdY1pgTF+2bORVq9UNwL8pNKUpVxNk=;
        b=LvPZ5s9Os510vAPWbnBTpM2CQ4Ow1R1D75YnI7hvasKzGk0xJBR9R27l2okWxLe5mq
         wjVsAlUBFojUBnxISsYKg15vW823Ncr74I5VnuZLzqZkBsWTyQQpeTv0D4FPQv3crOI9
         c7K61w8sVK+dowHz/3nvp7NIxxZZsJFwByNhI7GYCDTh1Z8O49nk+vz8fEc8ZzjGMAII
         xOrvLIQSh5bEtFHmunDbWRzWBn5UgSju+EKLjWmmGgfvgAn8HxapOVlC4A/cwofdAGh9
         0e5H6vuhuHOPV/OdHGhaxJ7F56K83kvirm434RlqXoTCyQEeieaMjqqG2Kun7/iCLaCE
         q6Bw==
X-Gm-Message-State: AOAM531864Rd3V3MzN2LPA7FH81URghcw1XURmNxaFD8DC5BXxMkBqOU
        FZ+BDFickyqYjmJpxaaEwqIywg==
X-Google-Smtp-Source: ABdhPJywKRKZ69wA3ai/Yl3jfHFVyuwJ1vlxLqfBew+C4JuHd48Cbmnfswe0UwNKqVlk0s4LPz7uOg==
X-Received: by 2002:a62:6494:0:b029:19d:b276:97e0 with SMTP id y142-20020a6264940000b029019db27697e0mr5286604pfb.41.1607111288824;
        Fri, 04 Dec 2020 11:48:08 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id z65sm6119557pfz.126.2020.12.04.11.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 11:48:07 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: hrtimer: Allow sub Hz granularity
Date:   Fri,  4 Dec 2020 11:48:03 -0800
Message-Id: <20201204194803.751866-1-gwendal@chromium.org>
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
 drivers/iio/trigger/iio-trig-hrtimer.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

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

