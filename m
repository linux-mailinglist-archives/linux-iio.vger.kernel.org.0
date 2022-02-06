Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412944AB17F
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244837AbiBFS5v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345264AbiBFS5u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:57:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE885C0401C3
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:57:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69D476122A
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF9EC340F1;
        Sun,  6 Feb 2022 18:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173868;
        bh=EIvzbIkN0kr30fcHhg52A7B3yqkuFc9SQLG2cQaW2oI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7d0BP1vVlHvpSibsvybw3u8RSLEwrTpLEsejyPHFU9c1HNl8dMgDU+23QWpoaYxQ
         8IVuTdEtegmZLaN4TMWN3xOCJggm63w+S3yTb5juWCo/kOLC1NZRnd4ezpSF04yF9q
         3k2ycV/b7ICiNZ0UHtMm9jRDSHdyKNtOPRXaUQn/2LMiANH09zk2L0n3MEQuXLOBy3
         /sWSHSZ5Z4mjkY6XQoOW0M2klo5XsrJgzlsoU9qmugTdn00FNj1PZPNH/BSmQzTWqD
         8SGbT1cmH8XwkAo0Aboggt7BTyZBECJKu81diGp0PHyelJ5hd3A53OVLLXw4p/DGWJ
         o7KQDLrVl4Edw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 13/20] staging:iio:adc:ad7280a: Use a local dev pointer to avoid &spi->dev
Date:   Sun,  6 Feb 2022 19:03:21 +0000
Message-Id: <20220206190328.333093-14-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206190328.333093-1-jic23@kernel.org>
References: <20220206190328.333093-1-jic23@kernel.org>
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

We use this a few times already and it is about to get worse, so
introduce a local variable to simplify things.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 8635a12f5f84..df4a03f42c7a 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -955,11 +955,12 @@ static const struct ad7280_platform_data ad7793_default_pdata = {
 static int ad7280_probe(struct spi_device *spi)
 {
 	const struct ad7280_platform_data *pdata = dev_get_platdata(&spi->dev);
+	struct device *dev = &spi->dev;
 	struct ad7280_state *st;
 	int ret;
 	struct iio_dev *indio_dev;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -991,7 +992,7 @@ static int ad7280_probe(struct spi_device *spi)
 	st->aux_threshhigh = 0xFF;
 	st->acquisition_time = pdata->acquisition_time;
 
-	ret = devm_add_action_or_reset(&spi->dev, ad7280_sw_power_down, st);
+	ret = devm_add_action_or_reset(dev, ad7280_sw_power_down, st);
 	if (ret)
 		return ret;
 
@@ -1020,7 +1021,7 @@ static int ad7280_probe(struct spi_device *spi)
 		if (ret)
 			return ret;
 
-		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
+		ret = devm_request_threaded_irq(dev, spi->irq,
 						NULL,
 						ad7280_event_handler,
 						IRQF_TRIGGER_FALLING |
@@ -1035,7 +1036,7 @@ static int ad7280_probe(struct spi_device *spi)
 		indio_dev->info = &ad7280_info_no_irq;
 	}
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id ad7280_id[] = {
-- 
2.35.1

