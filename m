Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D7637F781
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 14:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhEMMKF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 08:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbhEMMJS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 08:09:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8F8C06174A
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v5so19615052edc.8
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XPGApaju6LMGXyrepb+ba3cN9cbtBiZnKqABRzBNdQ=;
        b=DEWo68MHe8XL0las/rhte0NwwiN0TNv3enDH7m7Np0e/fI3FznpZJGJ+iHvwBINjXP
         1yNsCrPtveMW+HenfvW+GHKE75M50BtGjQstRCZTY+HS4qlNcGaXEA5k8B7igZ4WUN/l
         F0TpJcPcxsrm1xqukr0BH3ZsgDdadt0jcP9mCDm6Ny7K/30seo55gEzvD+ijdSfHUnma
         JitT7Jajt4xrzfjN65ryKym51fXBalGfRFjcpGhzOp7vui1rU+45Pw+1/VbTBATK/5nh
         ZzQl0MPzV+I7BqUjOiCwMkqeVrAwC5m2d2CdAW/setauZZNfHJP1OPsLUw73oV9hrA7x
         nBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XPGApaju6LMGXyrepb+ba3cN9cbtBiZnKqABRzBNdQ=;
        b=UFBv14kX9k5vAqtTrmQa6yO4B0+P8C25Cyv3xxX4IzRE2qlEw559MYQ9m2DVfAGBTL
         Ly88Sujr3W6DVkKvjIwPqoNL695M+VxT1LtusbzyM7cQ6odWJwXra7Ai9jZz9aYU++wa
         0cAEZv5/i5fgjnbnDvr+CDXMsgXLxsXHIApNe23rQYUMLu/TNhOAKej3ldf9U96j0ZKN
         ueWnOw2HdY+EyKzTdhu4gAHpTBV7pLX7+i9xvrj5DuCiz3lmX/z8R4Mvb3ST7Y8CmwkW
         OslAbIEKQ03m1QRI+mMB8cQJMb43D+xbkEKRwBZaLwUISSNbOKQyL/k03QMijdD/eooj
         vOJg==
X-Gm-Message-State: AOAM533d3E2Nw7gmj9qkHSsSYkzobPp33oXxz/oFmGh9te3aupHlKvkF
        ELhd/Epi5filJWZVicqfGGaIxAvR/u+hWw==
X-Google-Smtp-Source: ABdhPJx5mSGbM1QDSs7ADF1kvgFSDEhhxx0lJwHv4AZHomv03iRPhxP7aiaQcyQTODMrAmhwXRzYzg==
X-Received: by 2002:a50:a446:: with SMTP id v6mr47242351edb.254.1620907685059;
        Thu, 13 May 2021 05:08:05 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:04 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 06/12] iio: adc: ad7793: convert to device-managed functions
Date:   Thu, 13 May 2021 15:07:46 +0300
Message-Id: <20210513120752.90074-7-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
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

