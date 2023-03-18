Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C696BFB79
	for <lists+linux-iio@lfdr.de>; Sat, 18 Mar 2023 17:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCRQPx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Mar 2023 12:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCRQPw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Mar 2023 12:15:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45A42D175
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2023 09:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B3CB60EC9
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2023 16:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19AFC433EF;
        Sat, 18 Mar 2023 16:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679156149;
        bh=DZNVe7U1+EpIpS+aGcyiw0CjbwrDOauszNFx3YY3Cko=;
        h=From:To:Cc:Subject:Date:From;
        b=cS56kIYIaObhm8gsKmCZmLKZcI7iGLmexcQo4t6ktyfm7Ossb3yLv9HXbKmbd0dhW
         cuppXCywZ4nCJzY2uuHQdoegVbp4dwwFioyw5wmVoeM/4soaJIKdrwYsp8WRUry2Bi
         wUaZG+E78M+tix+Dh5f6S54xuInuUK+nYRekLOss4RkEaVZM3XQIiFLQSoth0TeL9K
         KxF4t2tRP2B2m7AcIQQ1CrvdyfyCRY1EJsaq4HXXO/4pYGUkgKgibpFdiCDfnkkPq3
         3Tee7J8rUmGLZLZ0FlBzDpQ4Ma+FwC86+5j5x9wnrS1LaenuvDCpttThG3zNqx8W10
         bKidYdmC3R7HQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Signed-off-by=20=3A=20Patrik=20Dahlstr=C3=B6m?= 
        <risca@dalakolonin.se>
Subject: [PATCH] iio: adc: palmas: Take probe fully device managed.
Date:   Sat, 18 Mar 2023 16:30:39 +0000
Message-Id: <20230318163039.56115-1-jic23@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Review of a recent fix highlighted that this driver could be trivially
converted to be entirely devm managed.

That fix should be applied to resolve the fix in a fashion easy to back port
even though this change removes the relevant code.

[1] https://patchwork.kernel.org/project/linux-iio/patch/20230313205029.1881745-1-risca@dalakolonin.se/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Signed-off-by: Patrik Dahlström <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 110 +++++++++++++--------------------
 1 file changed, 42 insertions(+), 68 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 849a697a467e..2921186458e0 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -493,6 +493,11 @@ static int palmas_gpadc_get_adc_dt_data(struct platform_device *pdev,
 	return 0;
 }
 
+static void palmas_disable_wakeup(void *dev)
+{
+	device_wakeup_disable(dev);
+}
+
 static int palmas_gpadc_probe(struct platform_device *pdev)
 {
 	struct palmas_gpadc *adc;
@@ -532,36 +537,30 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 
 	adc->auto_conversion_period = gpadc_pdata->auto_conversion_period_ms;
 	adc->irq = palmas_irq_get_virq(adc->palmas, PALMAS_GPADC_EOC_SW_IRQ);
-	if (adc->irq < 0) {
-		dev_err(adc->dev,
-			"get virq failed: %d\n", adc->irq);
-		ret = adc->irq;
-		goto out;
-	}
-	ret = request_threaded_irq(adc->irq, NULL,
-		palmas_gpadc_irq,
-		IRQF_ONESHOT, dev_name(adc->dev),
-		adc);
-	if (ret < 0) {
-		dev_err(adc->dev,
-			"request irq %d failed: %d\n", adc->irq, ret);
-		goto out;
-	}
+	if (adc->irq < 0)
+		return dev_err_probe(adc->dev, adc->irq, "get virq failed\n");
+
+	ret = devm_request_threaded_irq(&pdev->dev, adc->irq, NULL,
+					palmas_gpadc_irq,
+					IRQF_ONESHOT, dev_name(adc->dev),
+					adc);
+	if (ret < 0)
+		return dev_err_probe(adc->dev, ret,
+				     "request irq %d failed\n", adc->irq);
 
 	if (gpadc_pdata->adc_wakeup1_data) {
 		memcpy(&adc->wakeup1_data, gpadc_pdata->adc_wakeup1_data,
 			sizeof(adc->wakeup1_data));
 		adc->wakeup1_enable = true;
 		adc->irq_auto_0 =  platform_get_irq(pdev, 1);
-		ret = request_threaded_irq(adc->irq_auto_0, NULL,
-				palmas_gpadc_irq_auto,
-				IRQF_ONESHOT,
-				"palmas-adc-auto-0", adc);
-		if (ret < 0) {
-			dev_err(adc->dev, "request auto0 irq %d failed: %d\n",
-				adc->irq_auto_0, ret);
-			goto out_irq_free;
-		}
+		ret = devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0,
+						NULL, palmas_gpadc_irq_auto,
+						IRQF_ONESHOT,
+						"palmas-adc-auto-0", adc);
+		if (ret < 0)
+			return dev_err_probe(adc->dev, ret,
+					     "request auto0 irq %d failed\n",
+					     adc->irq_auto_0);
 	}
 
 	if (gpadc_pdata->adc_wakeup2_data) {
@@ -569,15 +568,14 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 				sizeof(adc->wakeup2_data));
 		adc->wakeup2_enable = true;
 		adc->irq_auto_1 =  platform_get_irq(pdev, 2);
-		ret = request_threaded_irq(adc->irq_auto_1, NULL,
-				palmas_gpadc_irq_auto,
-				IRQF_ONESHOT,
-				"palmas-adc-auto-1", adc);
-		if (ret < 0) {
-			dev_err(adc->dev, "request auto1 irq %d failed: %d\n",
-				adc->irq_auto_1, ret);
-			goto out_irq_auto0_free;
-		}
+		ret = devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1,
+						NULL, palmas_gpadc_irq_auto,
+						IRQF_ONESHOT,
+						"palmas-adc-auto-1", adc);
+		if (ret < 0)
+			return dev_err_probe(adc->dev, ret,
+					     "request auto1 irq %d failed\n",
+					     adc->irq_auto_1);
 	}
 
 	/* set the current source 0 (value 0/5/15/20 uA => 0..3) */
@@ -608,11 +606,10 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 	indio_dev->channels = palmas_gpadc_iio_channel;
 	indio_dev->num_channels = ARRAY_SIZE(palmas_gpadc_iio_channel);
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(adc->dev, "iio_device_register() failed: %d\n", ret);
-		goto out_irq_auto1_free;
-	}
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret < 0)
+		return dev_err_probe(adc->dev, ret,
+				     "iio_device_register() failed\n");
 
 	device_set_wakeup_capable(&pdev->dev, 1);
 	for (i = 0; i < PALMAS_ADC_CH_MAX; i++) {
@@ -620,36 +617,14 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 			palmas_gpadc_calibrate(adc, i);
 	}
 
-	if (adc->wakeup1_enable || adc->wakeup2_enable)
+	if (adc->wakeup1_enable || adc->wakeup2_enable) {
 		device_wakeup_enable(&pdev->dev);
-
-	return 0;
-
-out_irq_auto1_free:
-	if (gpadc_pdata->adc_wakeup2_data)
-		free_irq(adc->irq_auto_1, adc);
-out_irq_auto0_free:
-	if (gpadc_pdata->adc_wakeup1_data)
-		free_irq(adc->irq_auto_0, adc);
-out_irq_free:
-	free_irq(adc->irq, adc);
-out:
-	return ret;
-}
-
-static int palmas_gpadc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(&pdev->dev);
-	struct palmas_gpadc *adc = iio_priv(indio_dev);
-
-	if (adc->wakeup1_enable || adc->wakeup2_enable)
-		device_wakeup_disable(&pdev->dev);
-	iio_device_unregister(indio_dev);
-	free_irq(adc->irq, adc);
-	if (adc->wakeup1_enable)
-		free_irq(adc->irq_auto_0, adc);
-	if (adc->wakeup2_enable)
-		free_irq(adc->irq_auto_1, adc);
+		ret = devm_add_action_or_reset(&pdev->dev,
+					       palmas_disable_wakeup,
+					       &pdev->dev);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -834,7 +809,6 @@ MODULE_DEVICE_TABLE(of, of_palmas_gpadc_match_tbl);
 
 static struct platform_driver palmas_gpadc_driver = {
 	.probe = palmas_gpadc_probe,
-	.remove = palmas_gpadc_remove,
 	.driver = {
 		.name = MOD_NAME,
 		.pm = pm_sleep_ptr(&palmas_pm_ops),
-- 
2.40.0

