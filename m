Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C47600211
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 19:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJPRKk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 13:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJPRK3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 13:10:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F16637433
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 10:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1423B80D3F
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 17:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487BAC433C1;
        Sun, 16 Oct 2022 17:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665940171;
        bh=yMEU6m7C5v4zXwvzejTlF0IMyMCyY93HoJZmR5I5d18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pP6+wfAP/brj7h3y7DGpCgbIl6uoCoa5mO47wVNe6cyfFtB9TYaCDg9wrENm65w7i
         WErT7F3VRNMxg/rO5F9U2xCiEmmQ4gL+0KCJEGwai6lQG7PSt/pMXhu7JJzWxMFh7+
         udSVBv3APnhUkRpp4DXju3zr4uGC2YedRoLDzly/kKkfJB/xDh6p9KmZTrNSl3gDFq
         oGSHZ9hTHOdal9/7dLcRzckBdXJE36ghvo248HGptYFNTFwpz5oPD1PW/UCw7yYh9k
         RM1jotOy+by9ThXxvVEPlHUT/GRnAmCnhkCFdLkzwBMa/RW6HBA2JUxpxh7rPMSq/t
         UhbwevJYyoAcw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/5] iio: adc: cc10001: Add devm_add_action_or_reset() to disable regulator.
Date:   Sun, 16 Oct 2022 18:09:47 +0100
Message-Id: <20221016170950.387751-3-jic23@kernel.org>
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

As the voltage of this regulator is queried, we cannot use the
devm_regulator_get_enable() call and have to role our own disable.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/cc10001_adc.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index eeaea1362ed1..4f42ceb40ded 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -305,6 +305,11 @@ static int cc10001_adc_channel_init(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static void cc10001_reg_disable(void *priv)
+{
+	regulator_disable(priv);
+}
+
 static int cc10001_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -335,27 +340,28 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, cc10001_reg_disable, adc_dev->reg);
+	if (ret)
+		return ret;
+
 	indio_dev->name = dev_name(dev);
 	indio_dev->info = &cc10001_adc_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	adc_dev->reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(adc_dev->reg_base)) {
-		ret = PTR_ERR(adc_dev->reg_base);
-		goto err_disable_reg;
-	}
+	if (IS_ERR(adc_dev->reg_base))
+		return PTR_ERR(adc_dev->reg_base);
 
 	adc_dev->adc_clk = devm_clk_get(dev, "adc");
 	if (IS_ERR(adc_dev->adc_clk)) {
 		dev_err(dev, "failed to get the clock\n");
-		ret = PTR_ERR(adc_dev->adc_clk);
-		goto err_disable_reg;
+		return PTR_ERR(adc_dev->adc_clk);
 	}
 
 	ret = clk_prepare_enable(adc_dev->adc_clk);
 	if (ret) {
 		dev_err(dev, "failed to enable the clock\n");
-		goto err_disable_reg;
+		return ret;
 	}
 
 	adc_clk_rate = clk_get_rate(adc_dev->adc_clk);
@@ -400,8 +406,6 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 	iio_triggered_buffer_cleanup(indio_dev);
 err_disable_clk:
 	clk_disable_unprepare(adc_dev->adc_clk);
-err_disable_reg:
-	regulator_disable(adc_dev->reg);
 	return ret;
 }
 
@@ -414,7 +418,6 @@ static int cc10001_adc_remove(struct platform_device *pdev)
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	clk_disable_unprepare(adc_dev->adc_clk);
-	regulator_disable(adc_dev->reg);
 
 	return 0;
 }
-- 
2.37.2

