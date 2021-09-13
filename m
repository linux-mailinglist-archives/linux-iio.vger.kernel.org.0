Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D489408A8B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Sep 2021 13:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbhIMLyD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Sep 2021 07:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbhIMLyD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Sep 2021 07:54:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FEAC061574
        for <linux-iio@vger.kernel.org>; Mon, 13 Sep 2021 04:52:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id e21so20364469ejz.12
        for <linux-iio@vger.kernel.org>; Mon, 13 Sep 2021 04:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/J5lGuOdmg4sjezTWBAUmB/SvM57bpTS6IPuRdmTEdw=;
        b=ugJ7JquctQRBWSspPBa4JnyXUL6+VmwZ3M13GGjYNeV7PK4EM2n9QQOf+DCWW7qu30
         BWdsw74/2Jdr3sE/Y42xvt4ciAci94s2aUDBp6rn0iIeIu68xMJy7hhVTB2K4UrXac44
         7+TFtouYOeYvZARZcEXzyMRuc/8cpZXlbO1hz6MUftsPHdSltpTx3waVPa9fhVGwFB27
         WW65NIsfxfARJFRQuzibeGITR+IsiL101o0HM8748F+qNrNsRHYrndIVg7LpKqxHcRPc
         miuAsTgvcRfqg/qI2MeVQ3Qpeu0bzB1Ux3sAvySyeR7xAmSkmgGDRGshkywOzqcPMUie
         Bb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/J5lGuOdmg4sjezTWBAUmB/SvM57bpTS6IPuRdmTEdw=;
        b=GztYcTN9myINQZ6Qce5v6pEeuA8hsmz+eIusVApivsZpBGgry6VpzMr2YretYdflfk
         ubb7UwdCGygdWvvVE2/9C0GL0Y/+EZ/KPC0HdYy15xGMl9o4savQNds1oiHAnZE+3ylo
         n12SXJieSFGXzhR4cuEh9fcMlJVF523PTfcR9R2WXW4K9gHwT9vBLnzpdQstGwR9VsRq
         Ec71DWMMhWPlnfj2bvvlM2UTy6AMU4JQhYtevoIB4k1dI0y1U2lmeyRpW2nKz2EjgIS/
         0khnvO+5Kw+Y5DYC3CutnsrbyXCT8L4wuI82wrRPDtwGoyC1AafnVhBngOakr+X7Mfwu
         JX3Q==
X-Gm-Message-State: AOAM533sKGjbfiMOEtHq/nK9B+Jb67LLYlIvVnKyZZ2judNhAy2AkN3b
        YWrO82xepVfB4wj2qA2f+wFKm6Yb1weW8w==
X-Google-Smtp-Source: ABdhPJz6naSAZa9AsBOEXyi42mrTNyjXM2OLbPoap9PqmtVNCglCDhIpGeXEBwEs6xwBDFPHE6Jldw==
X-Received: by 2002:a17:906:d287:: with SMTP id ay7mr11987086ejb.402.1631533965785;
        Mon, 13 Sep 2021 04:52:45 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id v8sm3372423ejy.79.2021.09.13.04.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:52:45 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: dac: ad5064: convert probe to full device-managed
Date:   Mon, 13 Sep 2021 14:52:37 +0300
Message-Id: <20210913115237.301310-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change converts the probe of the AD5064 driver to use only
device-managed functions.

The regulator_bulk_disable() is passed on a devm_add_action_or_reset() hook
and the devm_iio_device_register() can be used to register the IIO device.

The driver has both I2C and SPI hooks inside, so all these can be removed.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/dac/ad5064.c | 49 ++++++++++------------------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index dff623b65e4f..fd9cac4f6321 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -843,6 +843,13 @@ static int ad5064_request_vref(struct ad5064_state *st, struct device *dev)
 	return ret;
 }
 
+static void ad5064_bulk_reg_disable(void *data)
+{
+	struct ad5064_state *st = data;
+
+	regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
+}
+
 static int ad5064_probe(struct device *dev, enum ad5064_type type,
 			const char *name, ad5064_write_func write)
 {
@@ -858,7 +865,6 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
-	dev_set_drvdata(dev, indio_dev);
 
 	st->chip_info = &ad5064_chip_info_tbl[type];
 	st->dev = dev;
@@ -872,6 +878,10 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 		ret = regulator_bulk_enable(ad5064_num_vref(st), st->vref_reg);
 		if (ret)
 			return ret;
+
+		ret = devm_add_action_or_reset(dev, ad5064_bulk_reg_disable, st);
+		if (ret)
+			return ret;
 	}
 
 	indio_dev->name = name;
@@ -887,30 +897,7 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
 		st->dac_cache[i] = midscale;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
-	return 0;
-
-error_disable_reg:
-	if (!st->use_internal_vref)
-		regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
-
-	return ret;
-}
-
-static int ad5064_remove(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5064_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	if (!st->use_internal_vref)
-		regulator_bulk_disable(ad5064_num_vref(st), st->vref_reg);
-
-	return 0;
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 #if IS_ENABLED(CONFIG_SPI_MASTER)
@@ -932,11 +919,6 @@ static int ad5064_spi_probe(struct spi_device *spi)
 				ad5064_spi_write);
 }
 
-static int ad5064_spi_remove(struct spi_device *spi)
-{
-	return ad5064_remove(&spi->dev);
-}
-
 static const struct spi_device_id ad5064_spi_ids[] = {
 	{"ad5024", ID_AD5024},
 	{"ad5025", ID_AD5025},
@@ -963,7 +945,6 @@ static struct spi_driver ad5064_spi_driver = {
 		   .name = "ad5064",
 	},
 	.probe = ad5064_spi_probe,
-	.remove = ad5064_spi_remove,
 	.id_table = ad5064_spi_ids,
 };
 
@@ -1019,11 +1000,6 @@ static int ad5064_i2c_probe(struct i2c_client *i2c,
 						ad5064_i2c_write);
 }
 
-static int ad5064_i2c_remove(struct i2c_client *i2c)
-{
-	return ad5064_remove(&i2c->dev);
-}
-
 static const struct i2c_device_id ad5064_i2c_ids[] = {
 	{"ad5625", ID_AD5625 },
 	{"ad5625r-1v25", ID_AD5625R_1V25 },
@@ -1081,7 +1057,6 @@ static struct i2c_driver ad5064_i2c_driver = {
 		   .name = "ad5064",
 	},
 	.probe = ad5064_i2c_probe,
-	.remove = ad5064_i2c_remove,
 	.id_table = ad5064_i2c_ids,
 };
 
-- 
2.31.1

