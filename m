Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9329942FB63
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 20:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241339AbhJOStZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 14:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238591AbhJOStZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 14:49:25 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5D8C061762
        for <linux-iio@vger.kernel.org>; Fri, 15 Oct 2021 11:47:18 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id r17so19880179uaf.8
        for <linux-iio@vger.kernel.org>; Fri, 15 Oct 2021 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=LPuZL7++oiK3AKTEYNGUGNnkKUKEOaVSI1la1HbR00o=;
        b=fka0ul0BUfdhnVcBo1ENmq87Cad2QyqOfAPSd1MhKesS67N7GYB5RP4RW7muabK00X
         EfKWc4Dz8dE9UCAk9i5cRKFIES59lAm+6HS/Kp/6werbFT1eEkjjAQtNCasprLrdE5zX
         bUrA40WoTf5Mcis8WZ1sXspWdWUtLspbEzmfyKuSDiktjWlvbhyyza/tYSbqwi1HhGrG
         Bx+DlqiPKTGUD4DNVq4BZ5xsoC2qXcDypsha9S9oi6KLmOWE0BvwGyfEAJ1uei27NOtp
         VRHDZ1BbhBvx0NS7ltYwRI2rBl8TMmMZUBl4e2ZFmjQimY56ipdBOEkXCT6jdR+X7gFP
         HPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=LPuZL7++oiK3AKTEYNGUGNnkKUKEOaVSI1la1HbR00o=;
        b=6kV0G3bqOjKSFoN2espC83B+bzQOfPcPjzrfMYNaM79/X8o1Vm1XYK8WuHxhmo+O/W
         QPee6futM//uxb4MizxIhZnKhyHflFv2EF70s4Y4Hmt3hyFn4zcN0h3kRH2YPuMfXB+0
         CrGpb5wEVAdJ50oJQsSnGwXMg0CA5mYGYnMowTtD6I3OcjDoqzR49lTxdiVyXsO77xAB
         98c9G/pSX7qIUGy+2oJP7eUpURWTZ3QSt8JiDaeNPYv/zJrVwkVNUotXB8j8/mV7Fnvw
         8jfnQGEbGilQD13DXzGHwmcCluQeh80U2cq2arg+xHXutFn2m1Z4+LkF1xSUmY5n2u8w
         4gbA==
X-Gm-Message-State: AOAM530owSvYDz7q1V4OjdjicN9JjSdBMToEYo0qTrnZZVqGcYIcno7/
        btSmZXHJB7tWIvQBLZFeqvVesQ==
X-Google-Smtp-Source: ABdhPJxkhdsZhhDUidLwL9QQSKDSaoYgaN82kqvwy+WU/pFWmZG+dpJDRpsnJunEco8maCH+Cat/nA==
X-Received: by 2002:a67:fc1a:: with SMTP id o26mr15817278vsq.23.1634323637365;
        Fri, 15 Oct 2021 11:47:17 -0700 (PDT)
Received: from Andryuu.br ([2804:431:c7fd:7238:7ee3:38a1:5467:1c06])
        by smtp.gmail.com with ESMTPSA id w27sm4256133vsi.25.2021.10.15.11.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 11:47:17 -0700 (PDT)
Date:   Fri, 15 Oct 2021 15:47:12 -0300
From:   =?iso-8859-1?Q?Andr=E9?= Gustavo Nakagomi Lopez <andregnl@usp.br>
To:     jic23@kernel.org, lars@metafoo.de, vz@mleia.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, andregnl@usp.br
Subject: [PATCH v2] iio: adc: lpc18xx_adc: Convert probe to device managed
 version
Message-ID: <YWnMsGlc/I35gYvy@Andryuu.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The remove function and the goto sections are not necessary if devm
functions are used.

Convert device register to devm version. Add hook functions to release
device resources, and use them inside probe with devm_add_action,
which will release resources on driver detach.

To maintain the order of which device resources were released/reseted,
register the hook functions as soon as resources are obtained/initialized.
Since devres actions are called on driver detach, the remove
function and the error-handling goto sections are no longer necessary.

Signed-off-by: André Gustavo Nakagomi Lopez <andregnl@usp.br>
---
Change log V1 -> V2:
       -Renamed lpc18xx_clk_disable_unprepare function
       -Removed platform_set_drvdata(pdev, indio_dev)
       -Renamed lpc18xx_writel to lpc18xx_clear_cr_reg
       -devm_iio_device_register now returns directly in the end of probe function
 drivers/iio/adc/lpc18xx_adc.c | 61 ++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
index 3566990ae87d..7d50107427ac 100644
--- a/drivers/iio/adc/lpc18xx_adc.c
+++ b/drivers/iio/adc/lpc18xx_adc.c
@@ -115,6 +115,23 @@ static const struct iio_info lpc18xx_adc_info = {
 	.read_raw = lpc18xx_adc_read_raw,
 };
 
+static void lpc18xx_clear_cr_reg(void *data)
+{
+	struct lpc18xx_adc *adc = data;
+
+	writel(0, adc->base + LPC18XX_ADC_CR);
+}
+
+static void lpc18xx_clk_disable(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
+static void lpc18xx_regulator_disable(void *vref)
+{
+	regulator_disable(vref);
+}
+
 static int lpc18xx_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -127,7 +144,6 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, indio_dev);
 	adc = iio_priv(indio_dev);
 	adc->dev = &pdev->dev;
 	mutex_init(&adc->lock);
@@ -163,44 +179,30 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&pdev->dev, lpc18xx_regulator_disable, adc->vref);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(adc->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to enable clock\n");
-		goto dis_reg;
+		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&pdev->dev, lpc18xx_clk_disable,
+				       adc->clk);
+	if (ret)
+		return ret;
+
 	adc->cr_reg = (clkdiv << LPC18XX_ADC_CR_CLKDIV_SHIFT) |
 			LPC18XX_ADC_CR_PDN;
 	writel(adc->cr_reg, adc->base + LPC18XX_ADC_CR);
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to register device\n");
-		goto dis_clk;
-	}
-
-	return 0;
-
-dis_clk:
-	writel(0, adc->base + LPC18XX_ADC_CR);
-	clk_disable_unprepare(adc->clk);
-dis_reg:
-	regulator_disable(adc->vref);
-	return ret;
-}
-
-static int lpc18xx_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct lpc18xx_adc *adc = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	writel(0, adc->base + LPC18XX_ADC_CR);
-	clk_disable_unprepare(adc->clk);
-	regulator_disable(adc->vref);
+	ret = devm_add_action_or_reset(&pdev->dev, lpc18xx_clear_cr_reg, adc);
+	if (ret)
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
 static const struct of_device_id lpc18xx_adc_match[] = {
@@ -211,7 +213,6 @@ MODULE_DEVICE_TABLE(of, lpc18xx_adc_match);
 
 static struct platform_driver lpc18xx_adc_driver = {
 	.probe	= lpc18xx_adc_probe,
-	.remove	= lpc18xx_adc_remove,
 	.driver	= {
 		.name = "lpc18xx-adc",
 		.of_match_table = lpc18xx_adc_match,
-- 
2.33.0

