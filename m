Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EF0378E51
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 15:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhEJNJA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 09:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351171AbhEJNDC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 09:03:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FA4C06135D
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:55:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l2so16517819wrm.9
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QF1dS6Jiuh+5NfJUW5uLOxaG+TUcbVDDHXnkhoAABbE=;
        b=lXLIoRfCBVaZLpupzEwQirKRMzJHB2eeQubMW+5riB5IlnoAETDDHi7k2fVGWsZHoV
         W0tr/QJBORHoV31sIW8qcrjtU16xK0gLr617bVoXP/ia+JhTIWg4SGxA+McgFRAW56WC
         ATnlqwAxbytAipWNK4Fg64BUfxQs/XbAIyFJyxd+fXBsjXOZEBH2qzFHxBlJVW484Jet
         fxY8yDHjcFJigX4zv/w+162rxWZ8G8zW2Q3dK6/Ed5B8/GxM/1hjcys7yysj5oukDxJn
         0OUj0jStHhvVOwCVDvrH58piIxOq66nyQ89cCy+7dkFKb3Jkl3UcoWWLJ5RWfHqz/owU
         CJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QF1dS6Jiuh+5NfJUW5uLOxaG+TUcbVDDHXnkhoAABbE=;
        b=YGxs0C+x79dunOAa1Fokq3dqRPoUG6Edw3WItOntugjZ/8Y2cIpwrkg/no83x24Y+A
         bNXTt3GFzBXebqBwZoGQEeiR1hTyjV0QZLLyXKihGMiIyO5nSxyYhkXuocdhl1RGOBch
         b5MDZT74tUj1SJcYKefVTk0l/0Je67GZtphbTF1IEsM6Wy0d2MyF2kpk3O/wUH9/QTl6
         XzH6b4bGbpzXvD+BAFCDvFXEntJ0NQos9SToR2xYTUFQ9SMpn3dc136KlPEAT2elvd/X
         RY9c0+jMrUDeFKI3Z2DDUpZmzbNu0osxD8oCJ3EsKgwQ/AhksIpnz9VQrE1yNI/YSkJV
         3mcA==
X-Gm-Message-State: AOAM532uU6+9SzX9JAcYu4gSlUnPU1Kdxbv/LnbuuiUDdJ0HQ5NJ72Yc
        mK3MsMs+Elzq3P+q5LPEoNG1qmQkxF+DBg==
X-Google-Smtp-Source: ABdhPJwgjz9v7MbJAa0qed7mncrflCAyPSgzDEeD/f75sOxYmuN9wz0FR+aRIzBdum5YzpgEG9FEMA==
X-Received: by 2002:a5d:694c:: with SMTP id r12mr30495791wrw.224.1620651357617;
        Mon, 10 May 2021 05:55:57 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n2sm23134329wmb.32.2021.05.10.05.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:55:57 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 07/11] iio: adc: ad7192: convert to device-managed functions
Date:   Mon, 10 May 2021 15:55:19 +0300
Message-Id: <20210510125523.1271237-8-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510125523.1271237-1-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
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
 drivers/iio/adc/ad7192.c | 90 ++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 5b3c46213bd4..b3fa1b5764e9 100644
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
@@ -937,36 +947,40 @@ static int ad7192_probe(struct spi_device *spi)
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
@@ -975,17 +989,15 @@ static int ad7192_probe(struct spi_device *spi)
 
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
 
@@ -993,55 +1005,26 @@ static int ad7192_probe(struct spi_device *spi)
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
@@ -1059,7 +1042,6 @@ static struct spi_driver ad7192_driver = {
 		.of_match_table = ad7192_of_match,
 	},
 	.probe		= ad7192_probe,
-	.remove		= ad7192_remove,
 };
 module_spi_driver(ad7192_driver);
 
-- 
2.31.1

