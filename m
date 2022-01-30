Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF034A388A
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355892AbiA3TZ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355901AbiA3TZ5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:25:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C6C06173B
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:25:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ACCD612EE
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923FAC340E4;
        Sun, 30 Jan 2022 19:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570756;
        bh=LLTptr8Ra4Qhw9pD26Xkf1RSeLZiqm/etlpre9Lkblc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lj0V6XFqrB2friXp6retlPNz4CN9DaIS17gVr5xPxdURiEf/VBbAiKd8rXo7kBvfr
         RRoKin3R5KhvSoaqxrRumBGf03NK5ufzkiIsT5knGcsKkdraLRKnIecrD7j7FopInJ
         o13/nMWjun0dS9CLkRT1/2WVuNBvOsfjj7idcSMEXFctyDLlYUTGYvd+YPGVjIIxzr
         L8RApvbBSXazrMyCpZkdqQh8ahtjPINeqMI2lKhaFqL4Zhp2Tl5uXS66uG1vv9fHY1
         3EIHZ+4qq8Qdfx5B2tPpRbCHsG4WKL6NvuKkrSOPE3slUP8KJOuJ99jMAh+aqYtJBW
         D5f3+/JpHs7Fw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v3 10/50] iio:adc:at91-adc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:07 +0000
Message-Id: <20220130193147.279148-11-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130193147.279148-1-jic23@kernel.org>
References: <20220130193147.279148-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/iio/adc/at91_adc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 5a7d3a3a5fa8..532daaa6f943 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1234,7 +1234,6 @@ static int at91_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int at91_adc_suspend(struct device *dev)
 {
 	struct iio_dev *idev = dev_get_drvdata(dev);
@@ -1256,9 +1255,9 @@ static int at91_adc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend,
+				at91_adc_resume);
 
 static const struct at91_adc_trigger at91sam9260_triggers[] = {
 	{ .name = "timer-counter-0", .value = 0x1 },
@@ -1386,7 +1385,7 @@ static struct platform_driver at91_adc_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = at91_adc_dt_ids,
-		   .pm = &at91_adc_pm_ops,
+		   .pm = pm_sleep_ptr(&at91_adc_pm_ops),
 	},
 };
 
-- 
2.35.1

