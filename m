Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79F741D541
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 10:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348911AbhI3IM0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 04:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348840AbhI3IM0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Sep 2021 04:12:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9FFC06161C;
        Thu, 30 Sep 2021 01:10:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h15so6974561wrc.3;
        Thu, 30 Sep 2021 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bTL7VlXohDK5+O76KzT0lApCN/YaGjWf++xGRwDyQdw=;
        b=PxFx++L/PGYJ2OU1htJBiL+Vr4X4yt4aJo3HpXXszC0syWTIUobDxqaU1i6in8gpbP
         ZlElgN5gzCQjGqhwm7ey4W5Vul9IGXxn7FjXuZhSNDyUjiEyyAn5MNGMRFWNuh1pQlRc
         go3tTISzQOChjoPqPb2WCSyzFIYr+yGWCrBN5Pm7MbTw5GXLGZO3oF7t9VUFU+A9aAB5
         ZycsJLoVmI3cEmyq6x3nl5Wu83pZX0H+Uvj6Ak3kdy93p9x+FeLSiImOTCrn5p9IC4MF
         Z6PG2FfRIHi4do6RVGzPZgvnXnaDNjb78iqRq4sF36QXvF/cr4jqGx5JOd/fNhknUC5E
         NMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bTL7VlXohDK5+O76KzT0lApCN/YaGjWf++xGRwDyQdw=;
        b=4gzXomVq6HKxm6C7S4sM951B2Bv1GBvT01h3+hs20UiXspStSAlOB5lIZMMvl21njB
         UoPeNZrWHTdSPvEtoNYvBektuimk26gD3KylcuNq79aUesnKvPhW5hNjCs/svD/WRp7h
         J+bHr+jsb6lfirlZSG8SI2psGpM0MehpgvCReKm82RhpjLlmHKLFzHKWFB6dTc9iheOB
         dQMMvnWSxy2c7oCjtQNZId5JBoBJY4pwxMQCUtZnogk/uWvVWh+XXUtHBkLtuPdcPU3r
         l+6RXDQXqIqqvCmg/KECFYyEqx42ec1ejHwhQfTis+7fv9lxRjBF7N7SKx/K9lWMKTkJ
         qbMQ==
X-Gm-Message-State: AOAM532R6ewlOQon6FJxvsa+AGXo5isua9sST0171dTrNcsPAvbuvTMu
        KgsZLRJA+5ki9fCpwPq4mU0=
X-Google-Smtp-Source: ABdhPJytSDWK8U12B/Lx7rN2rUFLDcU8R8sEYFE4EV5CqUZ84Y5BxlKyv6BHcg/rtDhkTqIq+fLpEw==
X-Received: by 2002:a05:6000:154f:: with SMTP id 15mr2169743wry.254.1632989442836;
        Thu, 30 Sep 2021 01:10:42 -0700 (PDT)
Received: from stewarton.broadband ([84.67.150.141])
        by smtp.googlemail.com with ESMTPSA id q9sm1517188wrx.4.2021.09.30.01.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 01:10:42 -0700 (PDT)
From:   Iain Hunter <drhunter95@gmail.com>
Cc:     lothar.felten@gmail.com, iain@hunterembedded.co.uk,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Zeng Tao <prime.zeng@hisilicon.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] workaround regression in ina2xx introduced by cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
Date:   Thu, 30 Sep 2021 09:10:02 +0100
Message-Id: <20210930081025.366039-1-drhunter95@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Iain Hunter <iain@hunterembedded.co.uk>

That change adds an error check to avoid saturation during multiplication
to calculate nano seconds in timespec64_to_ns().
In ina2xx_capture_thread() a timespec64 structure is used to calculate
the delta time until the next sample time. This delta can be negative if
the next sample time was in the past. In the -1 case timespec64_to_ns()
now clamps the -1 second value to KTIME_MAX. This essentially puts ina2xx
thread to sleep forever.
Proposed patch is to:
1 change from timespec64_XXX() to standard raw ktime_XXX() APIs to remove 
non-standard timespec64 calls.
2 split the functionality in the loop into two parts:
- do while loop only does the test to see if the next sample time is in the
future or in the past and so will be skipped and the sample time 
incremented until it is in the future. This test is done with a simple 
signed comparison as we are only interested in the sign being positive or 
negative.
- after do while loop we know that next is later than now and so delay is
positive and ksub_sub() can be used to get the delay which is positive.

Signed-off-by: Iain Hunter <iain@hunterembedded.co.uk>

Fixes: cb47755725da("time: Prevent undef$
---
 drivers/iio/adc/ina2xx-adc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index a4b2ff9e0..17f702772 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -775,7 +775,7 @@ static int ina2xx_capture_thread(void *data)
 	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
 	int sampling_us = SAMPLING_PERIOD(chip);
 	int ret;
-	struct timespec64 next, now, delta;
+	ktime_t next, now;
 	s64 delay_us;
 
 	/*
@@ -785,7 +785,7 @@ static int ina2xx_capture_thread(void *data)
 	if (!chip->allow_async_readout)
 		sampling_us -= 200;
 
-	ktime_get_ts64(&next);
+	next = ktime_get();
 
 	do {
 		while (!chip->allow_async_readout) {
@@ -798,7 +798,7 @@ static int ina2xx_capture_thread(void *data)
 			 * reset the reference timestamp.
 			 */
 			if (ret == 0)
-				ktime_get_ts64(&next);
+				next = ktime_get();
 			else
 				break;
 		}
@@ -807,7 +807,7 @@ static int ina2xx_capture_thread(void *data)
 		if (ret < 0)
 			return ret;
 
-		ktime_get_ts64(&now);
+		now = ktime_get();
 
 		/*
 		 * Advance the timestamp for the next poll by one sampling
@@ -816,11 +816,10 @@ static int ina2xx_capture_thread(void *data)
 		 * multiple times, i.e. samples are dropped.
 		 */
 		do {
-			timespec64_add_ns(&next, 1000 * sampling_us);
-			delta = timespec64_sub(next, now);
-			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
-		} while (delay_us <= 0);
+			next = ktime_add_us(next, sampling_us);
+		} while (next <= now);
 
+		delay_us = ktime_to_us(ktime_sub(next, now));
 		usleep_range(delay_us, (delay_us * 3) >> 1);
 
 	} while (!kthread_should_stop());
-- 
2.17.1

