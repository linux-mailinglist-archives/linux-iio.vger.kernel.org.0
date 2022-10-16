Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5A9600212
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 19:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJPRKq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 13:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJPRKe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 13:10:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384833405
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 10:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9C61B80D26
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 17:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B17C433D6;
        Sun, 16 Oct 2022 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665940169;
        bh=OmjUXOg8l1mQVp6gTMJ2W/f4edV9ISlnMuDB+fBN1+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ke8ZlIGtmCn8dfhSaKEWzdUaJN4LUdgmm5qIE1cEpDXI1lIA5MQ3tT6Furh4EN1DV
         blyQrFNV3u5P1VR/57qjax/SZGkc9s6NAg0GJW/EFf9Bh4h50H4WrFBvqvScSpMXyM
         ZslhWaFqTjvwQsF+u++9pou+rWSq5JccRKuLyH2y7sfSHEgig6xTOEaetaFE3g8eBT
         OIjVX1gtsfVHNRyBRepBtnXiP85GNYvr+UCiYVtNKEJcdWcQapWNx3kjDj2greIZxO
         9+xwKX5N5f2JCpEF47FuRiFD/Sd/iNNRivrgVhAqszkQfPqAADbL79Nfz5qQH0EkRj
         QRe7WT+gjCssQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/5] iio: adc: cc10001: Add local struct device *dev variable to avoid repitition
Date:   Sun, 16 Oct 2022 18:09:46 +0100
Message-Id: <20221016170950.387751-2-jic23@kernel.org>
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

There are lots of uses of this in probe() and we are about to introduce
some more, so add a local variable to simplify this.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/cc10001_adc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index e16ac935693b..eeaea1362ed1 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -307,14 +307,15 @@ static int cc10001_adc_channel_init(struct iio_dev *indio_dev,
 
 static int cc10001_adc_probe(struct platform_device *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
 	struct cc10001_adc_device *adc_dev;
 	unsigned long adc_clk_rate;
 	struct iio_dev *indio_dev;
 	unsigned long channel_map;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc_dev));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -326,7 +327,7 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 		channel_map &= ~ret;
 	}
 
-	adc_dev->reg = devm_regulator_get(&pdev->dev, "vref");
+	adc_dev->reg = devm_regulator_get(dev, "vref");
 	if (IS_ERR(adc_dev->reg))
 		return PTR_ERR(adc_dev->reg);
 
@@ -334,7 +335,7 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->name = dev_name(dev);
 	indio_dev->info = &cc10001_adc_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
@@ -344,23 +345,23 @@ static int cc10001_adc_probe(struct platform_device *pdev)
 		goto err_disable_reg;
 	}
 
-	adc_dev->adc_clk = devm_clk_get(&pdev->dev, "adc");
+	adc_dev->adc_clk = devm_clk_get(dev, "adc");
 	if (IS_ERR(adc_dev->adc_clk)) {
-		dev_err(&pdev->dev, "failed to get the clock\n");
+		dev_err(dev, "failed to get the clock\n");
 		ret = PTR_ERR(adc_dev->adc_clk);
 		goto err_disable_reg;
 	}
 
 	ret = clk_prepare_enable(adc_dev->adc_clk);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to enable the clock\n");
+		dev_err(dev, "failed to enable the clock\n");
 		goto err_disable_reg;
 	}
 
 	adc_clk_rate = clk_get_rate(adc_dev->adc_clk);
 	if (!adc_clk_rate) {
 		ret = -EINVAL;
-		dev_err(&pdev->dev, "null clock rate!\n");
+		dev_err(dev, "null clock rate!\n");
 		goto err_disable_clk;
 	}
 
-- 
2.37.2

