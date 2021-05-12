Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611B337D36F
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 20:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbhELSWH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 14:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350644AbhELRvc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 13:51:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA031C061348
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k10so5029305ejj.8
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XPGApaju6LMGXyrepb+ba3cN9cbtBiZnKqABRzBNdQ=;
        b=TIuDBj9+Wl3PBpUhmQceJSzOzKrL/yVfsJliiz8NkMiRJudbmV2ZeuG44Wrj45LkVA
         b0NCwfxKEXI1EE4bb+NGLreQLAs9SN85fwzrwyTXKOwlYTeMfuObbUjIjvjhX7ibi73n
         pUqrHiY20bVeXJt49/R2fEOOvSLc3KnfdXrWonnkk77Hf4pt9b82OxKbAmwog99ZJUJY
         8xGU7Yf3/kfE20MiQ68dT5w6NKZEyIyB0qglQ73Lh2o79fib2kqwpVlHfnOleFQGEIEx
         OIcn4u+Krev0dBw3p7EB+PVIVJAlBgSxgKPF0al+UOq1ZC4QWJZy3K9S1Xwg6/dWiGWW
         AY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XPGApaju6LMGXyrepb+ba3cN9cbtBiZnKqABRzBNdQ=;
        b=IJp7MlIHII93GLie4ae5g59PoRsPZtvfiNKVyECOdWCHyhcI6SK7W5LT/SBYkctfss
         KGZB9oJT62YoXZheKFs0/vjtvDWS3TONCmkeMZ4YB+vUXLBHiThJ7/57jh7pXDuQ5clo
         0IACO5NSECQJjC6BMEz7lOlNUezT/8AOT4RXoOwF8yi5cHdIlDeGjE6KsixWZQDGFj7h
         cqc4aupO6QaXthtqZJ5Hjiczhuv2jaXqOa2jvGuzFLtJCKyVGNeDNiSs7ec8IWRkW7v5
         7BZuhwOtgzITgNx1JZIabsu5cZC/1MZCQoH/nLYEZahNq9LoktGDDURT5i4LQEe+rqr8
         NEeQ==
X-Gm-Message-State: AOAM530H84leoXBeWmIj94QrYZljOo/QqB2X9B9WHu5NBpXhfEZGGipZ
        15N05rvmgorbUJ+gKOdeD5Lfv7MW/gd/Yw==
X-Google-Smtp-Source: ABdhPJxi4Ns2UuaZ8/IGW8hNLNe8K5WE5m2440Ubsgt/9+wNDOKDqoyUynbgEwY8SZIdm9JVH1Zxrw==
X-Received: by 2002:a17:906:d9c1:: with SMTP id qk1mr33965044ejb.412.1620841802461;
        Wed, 12 May 2021 10:50:02 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:50:02 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 06/12] iio: adc: ad7793: convert to device-managed functions
Date:   Wed, 12 May 2021 20:49:08 +0300
Message-Id: <20210512174914.10549-7-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With the devm_ad_sd_setup_buffer_and_trigger() helper, it's a bit easier
now to convert the probe of the AD7793 driver to use device-managed
functions.

Only the regulator disable requires a devm_add_action_or_reset() callback.

This change does that, cleaning up the driver a bit.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7793.c | 53 ++++++++++++----------------------------
 1 file changed, 15 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 5e980a06258e..5dab2e5b5bac 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -768,6 +768,11 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 	},
 };
 
+static void ad7793_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ad7793_probe(struct spi_device *spi)
 {
 	const struct ad7793_platform_data *pdata = spi->dev.platform_data;
@@ -802,11 +807,13 @@ static int ad7793_probe(struct spi_device *spi)
 		if (ret)
 			return ret;
 
+		ret = devm_add_action_or_reset(&spi->dev, ad7793_reg_disable, st->reg);
+		if (ret)
+			return ret;
+
 		vref_mv = regulator_get_voltage(st->reg);
-		if (vref_mv < 0) {
-			ret = vref_mv;
-			goto error_disable_reg;
-		}
+		if (vref_mv < 0)
+			return vref_mv;
 
 		vref_mv /= 1000;
 	} else {
@@ -816,50 +823,21 @@ static int ad7793_probe(struct spi_device *spi)
 	st->chip_info =
 		&ad7793_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	spi_set_drvdata(spi, indio_dev);
-
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->info = st->chip_info->iio_info;
 
-	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
+	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
 	if (ret)
-		goto error_disable_reg;
+		return ret;
 
 	ret = ad7793_setup(indio_dev, pdata, vref_mv);
 	if (ret)
-		goto error_remove_trigger;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_remove_trigger;
-
-	return 0;
-
-error_remove_trigger:
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-error_disable_reg:
-	if (pdata->refsel != AD7793_REFSEL_INTERNAL)
-		regulator_disable(st->reg);
-
-	return ret;
-}
-
-static int ad7793_remove(struct spi_device *spi)
-{
-	const struct ad7793_platform_data *pdata = spi->dev.platform_data;
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7793_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-
-	if (pdata->refsel != AD7793_REFSEL_INTERNAL)
-		regulator_disable(st->reg);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad7793_id[] = {
@@ -881,7 +859,6 @@ static struct spi_driver ad7793_driver = {
 		.name	= "ad7793",
 	},
 	.probe		= ad7793_probe,
-	.remove		= ad7793_remove,
 	.id_table	= ad7793_id,
 };
 module_spi_driver(ad7793_driver);
-- 
2.31.1

