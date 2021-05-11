Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F40F37A0A7
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 09:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhEKHUL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 03:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhEKHT7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 03:19:59 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF9CC06134A
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c22so21614543edn.7
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OjyXmokyyEi4mYmoSxzJwRJFFFsatuf8PBQju296W0w=;
        b=RqZyvI4Ref0gaXFImbjvyEYHYYueIwC+5l3WQ5s6Ma8gtNeBRdTde2JfhfTyTgg0KO
         HdzF8qEscFr2XzjK+a+yFiKr/qngecyHYqzjTD2BGHUDa7G8hcvqKVaf31kgV5RFeCfy
         gnHL9SsLaAVGeIn1cDHqvHoAAfam1iNTiAijp+E6/ZNDw2QxFUuOvjfGG2JIw4nIP8Yc
         CzOoDcq/Ir68YnFrWd8671fqtoAWSmPGVTe20ZJsGg/UhOvgZnkxlr8rmNMq9M6+/5ML
         YGTiGKUoNxOfORG/LtSKlauRmL/zyATuTvUu9G0LsU8bBIhXh0e2H3HZN1r6wnqVSLuP
         G2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OjyXmokyyEi4mYmoSxzJwRJFFFsatuf8PBQju296W0w=;
        b=cHw3I9NF2pA5NubYBZquGdnzZLkTEZSsySwhYTRaqYNVG0ahuFjQWhTM4UxQodwbwO
         GilmSg2EQ4Hu7fDSbC5PbA65ZRKN8vChaomkWjNPQXu17zrOEKr4csGi5XCGG3mE97F0
         iHyUx67UQgRnSY62lH3+mN/xy2ukxFsjpgCRH3lnPWzFqcdKrWMTWl92J6qQ1a/puBfW
         v1cdERb36QMOXx0HFJRKh4Pp0TO4Sw6JG5m9dkj1xbL+43IlUVLtVc2ZDyT+b0eMUBML
         OpdfEtp2Jrw/xScGV3FdoijGN8jEzQ2iFuZLRXGAyrhXPOqfQXPMQFqPa+Ywgn54KSb5
         EoWg==
X-Gm-Message-State: AOAM531tLjU/oVJYVLPIqKibygP5iH9Avsdu713e96Z9mrAyECI7l771
        ykir8d5D09qbjnP2yOMzTWyV1z1RS60dHna3
X-Google-Smtp-Source: ABdhPJwen16A/yUfPkZAwST2ej+Wa8csmfGwlYKlau0yXL5+0GnwnMzdPYr7oXsnLKKSKhi1X5kadg==
X-Received: by 2002:aa7:d146:: with SMTP id r6mr34822500edo.344.1620717525130;
        Tue, 11 May 2021 00:18:45 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id i6sm13871558eds.83.2021.05.11.00.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:18:44 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 10/12] iio: adc: ad7192: convert to device-managed functions
Date:   Tue, 11 May 2021 10:18:29 +0300
Message-Id: <20210511071831.576145-11-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511071831.576145-1-aardelean@deviqon.com>
References: <20210511071831.576145-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With the devm_ad_sd_setup_buffer_and_trigger() helper, it's a bit easier
now to convert the probe of the AD7192 driver to use device-managed
functions.

The regulators and the mclk requires devm_add_action_or_reset() callbacks
though.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7192.c | 93 ++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 18e731f1471a..50696959c018 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -908,6 +908,16 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static void ad7192_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
+static void ad7192_clk_disable(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
 static int ad7192_probe(struct spi_device *spi)
 {
 	struct ad7192_state *st;
@@ -937,41 +947,44 @@ static int ad7192_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->avdd);
+	if (ret)
+		return ret;
+
 	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
-	if (IS_ERR(st->dvdd)) {
-		ret = PTR_ERR(st->dvdd);
-		goto error_disable_avdd;
-	}
+	if (IS_ERR(st->dvdd))
+		return PTR_ERR(st->dvdd);
 
 	ret = regulator_enable(st->dvdd);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to enable specified DVdd supply\n");
-		goto error_disable_avdd;
+		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->dvdd);
+	if (ret)
+		return ret;
+
 	voltage_uv = regulator_get_voltage(st->avdd);
 	if (voltage_uv == 0) {
-		ret = -EINVAL;
 		dev_err(&spi->dev, "Zero value provided for AVdd supply\n");
-		goto error_disable_avdd;
+		return -EINVAL;
 	}
 
 	if (voltage_uv > 0) {
 		st->int_vref_mv = voltage_uv / 1000;
 	} else {
-		ret = voltage_uv;
 		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
-		goto error_disable_avdd;
+		return voltage_uv;
 	}
 
-	spi_set_drvdata(spi, indio_dev);
 	st->chip_info = of_device_get_match_data(&spi->dev);
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = ad7192_channels_config(indio_dev);
 	if (ret < 0)
-		goto error_disable_dvdd;
+		return ret;
 
 	if (st->chip_info->chip_id == CHIPID_AD7195)
 		indio_dev->info = &ad7195_info;
@@ -980,17 +993,15 @@ static int ad7192_probe(struct spi_device *spi)
 
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
 
-	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
+	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
 	if (ret)
-		goto error_disable_dvdd;
+		return ret;
 
 	st->fclk = AD7192_INT_FREQ_MHZ;
 
 	st->mclk = devm_clk_get_optional(&spi->dev, "mclk");
-	if (IS_ERR(st->mclk)) {
-		ret = PTR_ERR(st->mclk);
-		goto error_remove_trigger;
-	}
+	if (IS_ERR(st->mclk))
+		return PTR_ERR(st->mclk);
 
 	st->clock_sel = ad7192_of_clock_select(st);
 
@@ -998,55 +1009,26 @@ static int ad7192_probe(struct spi_device *spi)
 	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
 		ret = clk_prepare_enable(st->mclk);
 		if (ret < 0)
-			goto error_remove_trigger;
+			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7192_clk_disable,
+					       st->mclk);
+		if (ret)
+			return ret;
 
 		st->fclk = clk_get_rate(st->mclk);
 		if (!ad7192_valid_external_frequency(st->fclk)) {
-			ret = -EINVAL;
 			dev_err(&spi->dev,
 				"External clock frequency out of bounds\n");
-			goto error_disable_clk;
+			return -EINVAL;
 		}
 	}
 
 	ret = ad7192_setup(st, spi->dev.of_node);
 	if (ret)
-		goto error_disable_clk;
-
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		goto error_disable_clk;
-	return 0;
-
-error_disable_clk:
-	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
-	    st->clock_sel == AD7192_CLK_EXT_MCLK2)
-		clk_disable_unprepare(st->mclk);
-error_remove_trigger:
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-error_disable_dvdd:
-	regulator_disable(st->dvdd);
-error_disable_avdd:
-	regulator_disable(st->avdd);
-
-	return ret;
-}
-
-static int ad7192_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7192_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
-	    st->clock_sel == AD7192_CLK_EXT_MCLK2)
-		clk_disable_unprepare(st->mclk);
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-
-	regulator_disable(st->dvdd);
-	regulator_disable(st->avdd);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id ad7192_of_match[] = {
@@ -1064,7 +1046,6 @@ static struct spi_driver ad7192_driver = {
 		.of_match_table = ad7192_of_match,
 	},
 	.probe		= ad7192_probe,
-	.remove		= ad7192_remove,
 };
 module_spi_driver(ad7192_driver);
 
-- 
2.31.1

