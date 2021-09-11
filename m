Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A706407648
	for <lists+linux-iio@lfdr.de>; Sat, 11 Sep 2021 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhIKLiD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 07:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhIKLiD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Sep 2021 07:38:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C80C061574;
        Sat, 11 Sep 2021 04:36:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so3143563wmq.0;
        Sat, 11 Sep 2021 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0yvDQfJe0Tp73tQcpqCV/x6QPx5VUgyY/ghBBw/JXl4=;
        b=QkkNVwhk8ES7mIAYxQ/p9xu2di89bCsgfFnxsXtiXXyCoGiA7NYEDbuX+j9trrph6e
         cy3vpOEbqQ7tc1OxfH0OTZhN4DqEl7hxA+lzT2KdNzpZQ9qW5OA66PMI+yU4ULpacZ1y
         GqgygqroaC5pb9Wo5MT+t4yjHknwNDTmnaApU7b5/vIWbseBBdpWzQp4CHQxvmMzvtn+
         pEF1sPEihKq8axXWoW2y0CN6QI1bdHHMSvf5qwrVKsumBCCAEgDC+VwHetGmhgB4JnKx
         8GktyMXW/8QSO+I3DhzrFriPDKKUc5uM1Myt59hnvTPmpYoj97hXS9oPYdplLjhM/gef
         qKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0yvDQfJe0Tp73tQcpqCV/x6QPx5VUgyY/ghBBw/JXl4=;
        b=cMRxptPOaGteG1Zb9v58d4H88X3J6Mcqrc1O8sKTfWNmT70EhO2v/JH9DESUBIO7EM
         0nJqSregJJorCYFVFHva3Ue4is4byOqFnZT342W6AIUEvCuV67P+JCMCKSp08b+WNaW+
         HNfec67YtUkk0TidWIZkyeyJyBjTkh8sT0QEPNgJyjN580gZsQB+tvOVsRVi74E/OOLR
         3tE678jVM4kFM8sKZkRsyT64+LR9QurlW81HGVhtvqEbPSMAjLrLzdmQUAR+qBYI7kTm
         6LA4JSAzyPU17HE0fvCodZv0j5euwXiVXZ1xxrJ8kCnVFujNc/lDi7v9adWTq1qQMZIV
         kI8A==
X-Gm-Message-State: AOAM532HqtvZQLaB8dmS2PDGzon3u7bspY2n7mwbF5GJGVtRbF5UA2uj
        WBUezRqU1jdVV1kMEopvBXY=
X-Google-Smtp-Source: ABdhPJzBqoNgAuR+ISotUmdYRp3ifg40ubzwDx2OIVPArZLSnjiN6VdiVNUAyuju7w7nbuN0d83gkA==
X-Received: by 2002:a1c:9846:: with SMTP id a67mr2377602wme.148.1631360209060;
        Sat, 11 Sep 2021 04:36:49 -0700 (PDT)
Received: from stewarton.broadband ([84.67.150.141])
        by smtp.googlemail.com with ESMTPSA id z1sm1373317wmi.34.2021.09.11.04.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 04:36:48 -0700 (PDT)
From:   Iain Hunter <drhunter95@gmail.com>
Cc:     lothar.felten@gmail.com, iain@hunterembedded.co.uk,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] workaround regression in ina2xx introduced by cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
Date:   Sat, 11 Sep 2021 12:36:23 +0100
Message-Id: <20210911113645.2547272-1-drhunter95@gmail.com>
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
Proposed patch is to replace the call to timespec64_to_ns() with the
contents of that function without the overflow test introduced by the
commit (ie revert to pre kernel 5.4 behaviour)

Signed-off-by: Iain Hunter <iain@hunterembedded.co.uk>
---
 drivers/iio/adc/ina2xx-adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index a4b2ff9e0..ba3e98fde 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -777,6 +777,7 @@ static int ina2xx_capture_thread(void *data)
 	int ret;
 	struct timespec64 next, now, delta;
 	s64 delay_us;
+	s64 delta_ns;
 
 	/*
 	 * Poll a bit faster than the chip internal Fs, in case
@@ -818,7 +819,8 @@ static int ina2xx_capture_thread(void *data)
 		do {
 			timespec64_add_ns(&next, 1000 * sampling_us);
 			delta = timespec64_sub(next, now);
-			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
+			delta_ns = (((s64)delta.tv_sec) * NSEC_PER_SEC)+delta.tv_nsec;
+			delay_us = div_s64(delta_ns, 1000);
 		} while (delay_us <= 0);
 
 		usleep_range(delay_us, (delay_us * 3) >> 1);
-- 
2.17.1

