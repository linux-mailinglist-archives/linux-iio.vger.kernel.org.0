Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949C1418A4F
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 19:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhIZRSx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 13:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhIZRSx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Sep 2021 13:18:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F54C061570;
        Sun, 26 Sep 2021 10:17:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t18so44885457wrb.0;
        Sun, 26 Sep 2021 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vdoiudf+Qx0SLWKKUZwclGuUal9uTNufI3MRCJhiqfc=;
        b=oRppo0XmuSim3/r41OoTdCn6vxm+2tGYUkY6Tpi7TNISyj3we26F0Djp9s3W7t+lCb
         QuJp++BzSZqGK7PbflJr9Q02myGsbTnyd11VybnTNfEgk9TDifrYg69W/ty0blJzFqef
         JoaaMTcxRvgyZSydZ7vL4zdws8F+weCjsJKSdis+lPtvV8Hkl/073ATvJS44kmDLjYa5
         apdfePs85l4Sy+BvImyIqLkWJlQpCn+QNM1x6b7PqCV1s5zXij22GfnnTTFuS+chwH9K
         GNZfjzY/M478yP3Q1pkXlrkKJyaQCD48rwXWGsN0tMLUgmql9uI8dSquS3zfzTBAG5cX
         S02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vdoiudf+Qx0SLWKKUZwclGuUal9uTNufI3MRCJhiqfc=;
        b=QQCeMJzuVlcdNXOHLU+Btd4YqWBD2cmn5KFgfUpMlXo9cL6tIOFGR62F99St6F1YQT
         S+ite+jkOQ4m/WcFTxftrMktQYnQHlID765JbBJM1Ol8d6g8Ha31YdsxloxRGTIyfWqB
         rSv6Kgsna4Ecs94J/0xHBPF8Vp5/sN8Y2sUrZeSTkeAETYVbcapC+bGiJ2w621DcUqZY
         iyosMDVFd7Q4NoOSRdXSpmOgODGo5ARPQebD9DZqdh44uH0fzrSiXkfl/OzX7AAvtME0
         vV3K+OppCDod2NNpqmNrVldRXpq7Ad8swCRP6Rxk0oFBoO2Bnlblo35U+7XA1/khCtgw
         JX9A==
X-Gm-Message-State: AOAM533bXFNNYn1bTdGoNwiD+ZDBepW6ycnZvV+YolaPWNxrt6HNNPXr
        HPND/n/qH6OTWOW5l8cyj6E=
X-Google-Smtp-Source: ABdhPJwlFs1bs7Z9UfT1gZLxHhxzY/culXzOfOFlS3HFxOfOpZCOsoQBHCp1bSngCTcOzMVJ6k3diA==
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr13288454wrp.397.1632676634906;
        Sun, 26 Sep 2021 10:17:14 -0700 (PDT)
Received: from stewarton.broadband ([84.67.150.141])
        by smtp.googlemail.com with ESMTPSA id u6sm16839186wrp.0.2021.09.26.10.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 10:17:14 -0700 (PDT)
From:   Iain Hunter <drhunter95@gmail.com>
Cc:     lothar.felten@gmail.com, iain@hunterembedded.co.uk,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zeng Tao <prime.zeng@hisilicon.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] workaround regression in ina2xx introduced by cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
Date:   Sun, 26 Sep 2021 18:16:48 +0100
Message-Id: <20210926171711.194901-1-drhunter95@gmail.com>
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
Proposed patch is to split the functionality in the loop into two parts:
1 do while loop only does the test to see if the next sample time is in 
the future or in the past. If it is in the past it will be skipped
and the sample time incremented until it is in the future. This 
comparision can be done with timespec64_compare() as we are only 
interested in the sign being positive or negative.
2 after do while loop we know that next is later than now and so delta is
guaranteed to be positive. This means timespec64_to_ns() can be safely 
used.

Signed-off-by: Iain Hunter <iain@hunterembedded.co.uk>

Fixes: cb47755725da("time: Prevent undefined behaviour in timespec64_to_ns()")
---
 drivers/iio/adc/ina2xx-adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index a4b2ff9e0..661bcf707 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -817,10 +817,10 @@ static int ina2xx_capture_thread(void *data)
 		 */
 		do {
 			timespec64_add_ns(&next, 1000 * sampling_us);
-			delta = timespec64_sub(next, now);
-			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
-		} while (delay_us <= 0);
+		} while (timespec64_compare(&next, &now) < 0);
 
+		delta = timespec64_sub(next, now);
+		delay_us = div_s64(timespec64_to_ns(&delta), 1000);
 		usleep_range(delay_us, (delay_us * 3) >> 1);
 
 	} while (!kthread_should_stop());
-- 
2.17.1

