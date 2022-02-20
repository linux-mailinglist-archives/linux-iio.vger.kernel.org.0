Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D984BCFD8
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 17:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbiBTQ1D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 11:27:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiBTQ1D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 11:27:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273DB35857
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 08:26:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF88260C73
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 16:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF11AC340E8;
        Sun, 20 Feb 2022 16:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645374401;
        bh=mz5wJD19Vc07QihgMrZHiRnguZROHGLxGOxnhs5bS+A=;
        h=From:To:Cc:Subject:Date:From;
        b=J2sgNX/kzPzy5HyoQGLFSff1Z4vK710r2BfatKQiRdg1P4s32Cpi+BgTFrkwVHbNw
         +79SjVcj7nmslWk2/b36+Km4jOtPpYUw8dsMHYyTSUrxpUIqRN6dx48cW8Gns5M/CO
         Dc8u1i6ExZKZx1fsw31ke4BMHY9A5VSeB41/g9bhaJGO58SaRG0WzUmmX+jVu9lPap
         UaZFuiLvrveSaCEYoc1vqq/EoF7JbBsBTd7I+/skcKgiefOWKfgmTaJll113pVQsZJ
         81xCk/FkzLqXZ1tkwmjO72MtPmJbgU4F2w5txN0Nl01aYj7CZKe5YpG+cCeK9ggWkN
         8oRl3jW9L5fnA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio: core: drop iio_get_time_res()
Date:   Sun, 20 Feb 2022 16:33:27 +0000
Message-Id: <20220220163327.424696-1-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This function was introduced with the ability to pick a clock.
There are no upstream users so presumably it isn't as obviously useful
as it seemed at the time.  Hence drop it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c | 23 -----------------------
 include/linux/iio/iio.h         |  1 -
 2 files changed, 24 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e1ed44dec2ab..5d6c62d4a83d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -320,29 +320,6 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL(iio_get_time_ns);
 
-/**
- * iio_get_time_res() - utility function to get time stamp clock resolution in
- *                      nano seconds.
- * @indio_dev: device
- */
-unsigned int iio_get_time_res(const struct iio_dev *indio_dev)
-{
-	switch (iio_device_get_clock(indio_dev)) {
-	case CLOCK_REALTIME:
-	case CLOCK_MONOTONIC:
-	case CLOCK_MONOTONIC_RAW:
-	case CLOCK_BOOTTIME:
-	case CLOCK_TAI:
-		return hrtimer_resolution;
-	case CLOCK_REALTIME_COARSE:
-	case CLOCK_MONOTONIC_COARSE:
-		return LOW_RES_NSEC;
-	default:
-		BUG();
-	}
-}
-EXPORT_SYMBOL(iio_get_time_res);
-
 static int __init iio_init(void)
 {
 	int ret;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index faf00f2c0be6..13cd5f41b0de 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -313,7 +313,6 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
 }
 
 s64 iio_get_time_ns(const struct iio_dev *indio_dev);
-unsigned int iio_get_time_res(const struct iio_dev *indio_dev);
 
 /* Device operating modes */
 #define INDIO_DIRECT_MODE		0x01
-- 
2.35.1

