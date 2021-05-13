Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E092237F786
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 14:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhEMMKO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 08:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhEMMJW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 08:09:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB210C061760
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r11so6660427edt.13
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rhRTUXV6Mcvo5JAvjRouwEkZwkfKrcd+a9R2REGQoX4=;
        b=JwgzISSYyYFmKuZwR/Jq5Lpv2yD/qZF+dAh4k+StqRatLXN2lhM1TH++XXJFDT5BEo
         VHeZdNpGPp52MpcxCKjIGXEvt/nMo5EwXg7R3nkQPu/fP+oV+L0xNr0tiop82CuZu32V
         zl6jcqxV4nrvuLCByzxFh5NuzQdiLUJgcImbMr4LKGXbv8/ahfwPJ8ao+npeOdNU44rC
         C0Y8O44Cn+UWvjCfdQTpJ8uAajm6E7gJ+WTXPlevyp9Wev6eMlCr/cy9wKpGNPgzN8eP
         eEunDuYjtEMPYH2bpWekEzqc162VKq1kev08fkxQFbNUWcMEJmicbQAx6o/AJ/MIC7yZ
         xaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rhRTUXV6Mcvo5JAvjRouwEkZwkfKrcd+a9R2REGQoX4=;
        b=PUg2orvbMM8ePzBmSrLibcfkGFH+YIsTpk/7AJG9Fkmf3Ctqv+81q8ocSFI3SO8pBT
         z2sAs9RrW4MiCmFTtPeGLxWXT1cknfYRt5x3ruoeoDElMl2v75Us4GwciIN6qvqeHa8v
         koAZ+WldMXmkDHNCaI9ki6ekksza4IKLvLhqlLI3vc715kyggrYDOMEGdSQyX2GW+clJ
         JdO28zFeX1FIGzmAs+nYCuf+h2GI1uL0VfS+BPhhOEXufN525C/8aBqk3wmR+7kXI9QK
         vPJwpid1+zkXHAM9xNOrPdSR2i1dogXJSreLglEiHdKS83bMOmv1MLQ1J+1yKQ8wMQRU
         5ldg==
X-Gm-Message-State: AOAM531Q1zrZmS2GmhN+Mv1gxqM9XLeRNHhWmL4IboF3n2BcFirZDP/A
        CWAa7NqbQxV4jUK42EpZRz8tZIA8mbywjA==
X-Google-Smtp-Source: ABdhPJzi8Rj+/uBFzFljuLGd+TcsFnzreBj+ZSlPq1MU66gaO6tmJpJh8jh5c4lVObVT2y5E9gV7SQ==
X-Received: by 2002:aa7:d4d9:: with SMTP id t25mr42310289edr.377.1620907689370;
        Thu, 13 May 2021 05:08:09 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:08 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 10/12] iio: adc: ad7192: convert to device-managed functions
Date:   Thu, 13 May 2021 15:07:50 +0300
Message-Id: <20210513120752.90074-11-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
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
 drivers/iio/adc/ad7192.c | 89 ++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 53 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 523cf3bc955b..ee8ed9481025 100644
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
@@ -937,33 +947,38 @@ static int ad7192_probe(struct spi_device *spi)
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
 	ret = regulator_get_voltage(st->avdd);
 	if (ret < 0) {
 		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
-		goto error_disable_avdd;
+		return ret;
 	}
 	st->int_vref_mv = ret / 1000;
 
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
@@ -972,17 +987,15 @@ static int ad7192_probe(struct spi_device *spi)
 
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
 
@@ -990,55 +1003,26 @@ static int ad7192_probe(struct spi_device *spi)
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
@@ -1056,7 +1040,6 @@ static struct spi_driver ad7192_driver = {
 		.of_match_table = ad7192_of_match,
 	},
 	.probe		= ad7192_probe,
-	.remove		= ad7192_remove,
 };
 module_spi_driver(ad7192_driver);
 
-- 
2.31.1

