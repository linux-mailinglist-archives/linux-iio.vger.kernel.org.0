Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890BC378E4B
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 15:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbhEJNIT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 09:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351125AbhEJNC7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 09:02:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAFAC061352
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:55:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i128so9113106wma.5
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XPGApaju6LMGXyrepb+ba3cN9cbtBiZnKqABRzBNdQ=;
        b=NgPgdNaRR89izT+ZilXkhdNmMCfCDwY9ZnQFZb/YitvdWfcQP2dt+yDMQDz2fXcbUf
         RXp0uXHoVzmmohvPKACGnUKTAxocsdviAfErO/9dOQOMB+kATRPx4SCXEs6v9UThFAcp
         wm8cMQX0rUwYBgv+M+xaozDs2ZgmgiABiUSjnPcrAtBzYodp/0srwtJW5MK91mczHD7L
         JwpiMM0E6vhExd6B2RRMsnrxp+olFebkoVyDQY6vC7L/QN/G4tNhvyh4G4Q0DMoNGT9i
         r5bJfLHyC5OvNg6mu77ySP7BtkisA+Ys3oGcjK3UtiVekCPJ88C+1YQW6hW1avNYayid
         xoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XPGApaju6LMGXyrepb+ba3cN9cbtBiZnKqABRzBNdQ=;
        b=uCvuTESHfUCdEryycc46YfO/TiNSbEaGcXvLwigS3su+OLODlI+esjVo7fJ6lpTdD4
         lnG1pT3KXEdjamS+Daq5FvXFGOBPRyhjCgF2WF38FX92FyR8QsKdyFfZsxoK3AwR9OEn
         N0wbTpvrq8AX2kYWL9MT3LDorG8vYAldTLgTTuK7fLmAYFYGj9Lo1ddYyPYU8mzNLm2Q
         WHl2laHVOxFv8zRiV6iU7uUuNWA0/DO6dpYfy1Celr1exxvZd1uS2JJVioFGP/1KflDG
         9bzcJ9pBoxfIhnPA1fNpYmtmLLF+O17Na/+E9GmhytxCQ2XJ9xicSiKBBGNh095Tmlw0
         jjag==
X-Gm-Message-State: AOAM533/GW4JzICWds5enMMbxojhcVQn01hIz7TTN2v9ltvrqN7KVEy1
        QztSnw31yd0cUoloNih/rOvAC8iT4wP0FQ==
X-Google-Smtp-Source: ABdhPJwDHt95VYhDz7PVBAzUcpeA/ZBk9kegmc9eNnCKRzRilX1VQvUbYBKFBmxen98ZTRv9atCAGw==
X-Received: by 2002:a7b:cc83:: with SMTP id p3mr25727363wma.170.1620651352974;
        Mon, 10 May 2021 05:55:52 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n2sm23134329wmb.32.2021.05.10.05.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:55:52 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 02/11] iio: adc: ad7793: convert to device-managed functions
Date:   Mon, 10 May 2021 15:55:14 +0300
Message-Id: <20210510125523.1271237-3-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510125523.1271237-1-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
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

