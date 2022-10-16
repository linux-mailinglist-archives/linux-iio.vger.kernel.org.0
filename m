Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFFC60020D
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 19:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJPRKP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJPRKD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 13:10:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E86248F1
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 10:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13DF4B80D41
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 17:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E422BC433D6;
        Sun, 16 Oct 2022 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665940172;
        bh=oYhj+l2sg4gIFpJawaeeru5wkinVX/YuP3hnhwyO2tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTiHkApKX+XkdK86Wjp4rR/a9nhSF+3FHaSbtv7YqNNwdzg+qY3ZOG0D9zHrK6sSm
         WyjSUBML9jZ+rEoiQBSlWRFfGi1e8zWfx1r0rx3MIGJJq8VhksfaFLsvQUybqz32r+
         enJ1jOe9dgzZcZoL+nIuq4FHSuU8Zis9ZemfIBT267LphK7JF3K4iHOHGRQbMSsImI
         MMfuyZjguA2yo2IMTCdLju8ndos38d9Cuo5gTybALV0J9r0/7kLoTxdN1Ddm3qS1CN
         XtSjRbv47T13cMzQxDZuTLN63irSj4kpzim8MIQ2s4B9RCyrKGEDikBm1SVHBVIlB2
         LmPm2jJ1q5VmA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/5] iio: adc: cc10001: Use devm_clk_get_enabled() to avoid boilerplate.
Date:   Sun, 16 Oct 2022 18:09:48 +0100
Message-Id: <20221016170950.387751-4-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221016170950.387751-1-jic23@kernel.org>
References: <20221016170950.387751-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As this driver just enables clock in probe() and disables in remove()
we can use this new function to replace boilerplate and simplify
error paths.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/cc10001_adc.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index 4f42ceb40ded..332f0e06369f 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -352,23 +352,16 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(adc_dev->reg_base))
 		return PTR_ERR(adc_dev->reg_base);
 
-	adc_dev->adc_clk = devm_clk_get(dev, "adc");
+	adc_dev->adc_clk = devm_clk_get_enabled(dev, "adc");
 	if (IS_ERR(adc_dev->adc_clk)) {
 		dev_err(dev, "failed to get the clock\n");
 		return PTR_ERR(adc_dev->adc_clk);
 	}
 
-	ret = clk_prepare_enable(adc_dev->adc_clk);
-	if (ret) {
-		dev_err(dev, "failed to enable the clock\n");
-		return ret;
-	}
-
 	adc_clk_rate = clk_get_rate(adc_dev->adc_clk);
 	if (!adc_clk_rate) {
-		ret = -EINVAL;
 		dev_err(dev, "null clock rate!\n");
-		goto err_disable_clk;
+		return -EINVAL;
 	}
 
 	adc_dev->eoc_delay_ns = NSEC_PER_SEC / adc_clk_rate;
@@ -385,14 +378,14 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 	/* Setup the ADC channels available on the device */
 	ret = cc10001_adc_channel_init(indio_dev, channel_map);
 	if (ret < 0)
-		goto err_disable_clk;
+		return ret;
 
 	mutex_init(&adc_dev->lock);
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 					 &cc10001_adc_trigger_h, NULL);
 	if (ret < 0)
-		goto err_disable_clk;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
@@ -404,8 +397,6 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 
 err_cleanup_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
-err_disable_clk:
-	clk_disable_unprepare(adc_dev->adc_clk);
 	return ret;
 }
 
@@ -417,7 +408,6 @@ static int cc10001_adc_remove(struct platform_device *pdev)
 	cc10001_adc_power_down(adc_dev);
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	clk_disable_unprepare(adc_dev->adc_clk);
 
 	return 0;
 }
-- 
2.37.2

