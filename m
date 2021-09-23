Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21474159FD
	for <lists+linux-iio@lfdr.de>; Thu, 23 Sep 2021 10:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbhIWIYz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Sep 2021 04:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhIWIYy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Sep 2021 04:24:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B8FC061757;
        Thu, 23 Sep 2021 01:23:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t8so14803942wrq.4;
        Thu, 23 Sep 2021 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNBIkdqrfBWoODl4rVjrpYZvK6+z3y3Yg3DlUkxU4pk=;
        b=ip7+kVR2I44Dogsy2DooLa4tAj9TEdElY2AlnrnTrzJbaImvVRkuTijeJT7LgtxrP5
         1T8RS35G3+00KZFlz4mYpL/xeaF3/ouRFpQUe4WagQogxCDBudx83Bc8RRd3OQ9pGgJT
         HCouyc9Gb6XEGcmzY2NGDdkYyVoR8VQyq2+2dLOVJTjHgbQoOvajQJCg5pIS87cDSZfV
         uS05DUv3grHCriBDumBy/yyop/xH9KXVliBNP7idO6tgbuiiEhnSY17Yz+rjLioEDsOX
         EwcKmfPDQYtLhzC+/sH7ycLTwn5YgF0Vl53AV9RQZXQyAJq3fFd9+1VXadqRu1nEF75D
         +vRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNBIkdqrfBWoODl4rVjrpYZvK6+z3y3Yg3DlUkxU4pk=;
        b=wgiwFowvu+iylNCgqHEO20dh5sePMzVEk2qMklCDqMfegjgCSN+MAEbMAnJ6MUM9DZ
         +DWPsAvlYsWKHPc39QBjgwdW8TSSPUgwQ5Hpc9cR8N5zmC7Hv1KVsCbZuNh4cothH738
         RmJDBLVRwbme1VSJ9o4eBmhwNu4/108GQldu3B2LYTXC0HjKdqEL54uCC/X8aLfIP/ON
         6Zb2VJF28wnbqxkKYYP+t95c97qCHJ7XF1tcInG+S9drUfcN7Fvhfh0SdAEDRVDMkCGE
         R+1XLGcYUNzKXX49nnXx7xLgEBP5XQiC8qlWKZODFNIPUqDe/kzESvAmwHAsaOb8Bvox
         qzzg==
X-Gm-Message-State: AOAM532WThzCeznyCYEZ8aLXBC+922dE/FYKV/4k+PnL/xXjkgnApYEd
        7YqJkM+B64g4KkogppgeobpoT7FqVi6vqQ==
X-Google-Smtp-Source: ABdhPJyx93y7q9O7DmtOlj6h338X1hPwSNvz3mUKnA5464/RDJ7MCEXpz8CTsjXPyIKLfu5Fz9UnPg==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr3611236wrz.337.1632385401956;
        Thu, 23 Sep 2021 01:23:21 -0700 (PDT)
Received: from stewarton.broadband ([84.67.150.141])
        by smtp.googlemail.com with ESMTPSA id r25sm4604999wra.76.2021.09.23.01.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 01:23:21 -0700 (PDT)
From:   Iain Hunter <drhunter95@gmail.com>
Cc:     lothar.felten@gmail.com, iain@hunterembedded.co.uk,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] workaround regression in ina2xx introduced by cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
Date:   Thu, 23 Sep 2021 09:23:16 +0100
Message-Id: <20210923082319.1510936-1-drhunter95@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Iain Hunter <iain@hunterembedded.co.uk>

That change adds an error check to avoid saturation during multiplication
to calculate nano seconds in timespec64_to_ns(). This function was changed
in kernel 5.4.
In ina2xx_capture_thread() a timespec64 structure is used to calculate
the delta time until the next sample time. This delta can be negative if
the next sample time was in the past. In the -1 case timespec64_to_ns()
now clamps the -1 second value to KTIME_MAX. This essentially puts ina2xx
thread to sleep forever.
Proposed patch is to split the functionality in the loop into two parts:
- do while loop only does the test to see if the next sample time is in 
the future or in the past and so will be skipped and the sample time 
incremented until it is in the future. This comparision can be done with 
timespec64_compare() as we are only interested in the sign being positive
or negative.
The variable skip_next_sample is only used for clarity.
- after do while loop we know that next is later than now and so delta is
guaranteed to be positive. This means timespec64_to_ns() can be safely
used.

Signed-off-by: Iain Hunter <iain@hunterembedded.co.uk>

Fixes: regression introduced by
 cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
---
 drivers/iio/adc/ina2xx-adc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index a4b2ff9e0..e30012d0d 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -777,6 +777,7 @@ static int ina2xx_capture_thread(void *data)
 	int ret;
 	struct timespec64 next, now, delta;
 	s64 delay_us;
+	int skip_next_sample;
 
 	/*
 	 * Poll a bit faster than the chip internal Fs, in case
@@ -817,10 +818,15 @@ static int ina2xx_capture_thread(void *data)
 		 */
 		do {
 			timespec64_add_ns(&next, 1000 * sampling_us);
-			delta = timespec64_sub(next, now);
-			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
-		} while (delay_us <= 0);
 
+			if (timespec64_compare(&next, &now) < 0)
+				skip_next_sample = 1;
+			else
+				skip_next_sample = 0;
+		} while (skip_next_sample);
+
+		delta = timespec64_sub(next, now);
+		delay_us = div_s64(timespec64_to_ns(&delta), 1000);
 		usleep_range(delay_us, (delay_us * 3) >> 1);
 
 	} while (!kthread_should_stop());
-- 
2.17.1

