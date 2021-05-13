Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5357C37F785
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 14:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhEMMKI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 08:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhEMMJW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 08:09:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E506BC061761
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id di13so30710769edb.2
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3CIlvHXWAL8LnevCxF+tYL0znrNNdyr/u/1pI8y5A4=;
        b=REgarnqFmNOJkjjpAZ51MHtU49AG1Me/3Ao2f3aBlYXjhPqINOios+jWutMI2TcWD9
         PmY/9n8CZkcSVfB5kVjzJFcG2yfdIhzN39Icv6yx0N8JvVNIsXF3PZskg8d+udQtQld9
         THCc7wiN4Vh8cTT7y6oGusXmXqTNa0AXjopkodBQ2IffTgIQnm3Pmo6zBPXuK+P/Tmub
         50V6MZcT/dWJjcSF0N85SNPhHKUHiBxeQU6/FctlLEHAlFLKaQS33p7KmMgXtU40JpRE
         mFgiYXnNDnwBsoVco0D4VlvjwFbzF/AsjoAEdLWOaOWCrgjOU0nN0/f0zQLelkBIMaeU
         kTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3CIlvHXWAL8LnevCxF+tYL0znrNNdyr/u/1pI8y5A4=;
        b=GOzESJBFR565mAzfW9s/ioNQ85GdyFU+My8Kfp3axxtaEF0tDcHEG65UAoX6E3auMv
         Vu1kzLyaZjahN0rZe5RK98BXO3PGo5wfqsrocY/tRjWmVM6LhwVqd1oCoOBEqgCsQaJz
         WXio54QDh7a7D9M0ttq9lO21y6vlnUdWisE+T1APp0LUFi6xuHTRBrPpPSjddquilUP7
         RcoaKi8nbDglllUva/Xh1WWuAySH+ONNkp8fYAN8UPwpdgdRXAxNchVrit40ZjezAS+H
         fwNqqRUklYbjh/EvDkE1cqDfUicmONIefSNnOFFVpPAxqsI6Q1tqCM5GBEWiiUTzd3BN
         pEyA==
X-Gm-Message-State: AOAM532Re7WGsSZ1Mfmx1pKOJvO1eLodt36+rLjEGAEa60doCZCzFd1U
        LWySssye9dum5wE+cGgORcB10PQQ8up3Jg==
X-Google-Smtp-Source: ABdhPJw85cD2bGxAr0P6FGs4liRKBxzCMfYc5MP/0qAwyYu8oo4a9BppF0FMutXSwXk3E8Rmvid5bg==
X-Received: by 2002:a50:f385:: with SMTP id g5mr12500007edm.222.1620907690414;
        Thu, 13 May 2021 05:08:10 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:10 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 11/12] iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop remove()
Date:   Thu, 13 May 2021 15:07:51 +0300
Message-Id: <20210513120752.90074-12-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As not many steps were not already devm_ managed, use
devm_add_action_or_reset() to handle the rest.

This also uses the new devm_ad_sd_setup_buffer_and_trigger() function.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7124.c | 48 +++++++++++++---------------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index a27db78ea13e..e45c600fccc0 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -862,6 +862,11 @@ static void ad7124_reg_disable(void *r)
 	regulator_disable(r);
 }
 
+static void ad7124_clk_disable(void *c)
+{
+	clk_disable_unprepare(c);
+}
+
 static int ad7124_probe(struct spi_device *spi)
 {
 	const struct ad7124_chip_info *info;
@@ -883,8 +888,6 @@ static int ad7124_probe(struct spi_device *spi)
 
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
 
-	spi_set_drvdata(spi, indio_dev);
-
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7124_info;
@@ -922,48 +925,28 @@ static int ad7124_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
+	ret = devm_add_action_or_reset(&spi->dev, ad7124_clk_disable, st->mclk);
+	if (ret)
+		return ret;
+
 	ret = ad7124_soft_reset(st);
 	if (ret < 0)
-		goto error_clk_disable_unprepare;
+		return ret;
 
 	ret = ad7124_check_chip_id(st);
 	if (ret)
-		goto error_clk_disable_unprepare;
+		return ret;
 
 	ret = ad7124_setup(st);
 	if (ret < 0)
-		goto error_clk_disable_unprepare;
+		return ret;
 
-	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
+	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
 	if (ret < 0)
-		goto error_clk_disable_unprepare;
-
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Failed to register iio device\n");
-		goto error_remove_trigger;
-	}
-
-	return 0;
-
-error_remove_trigger:
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-error_clk_disable_unprepare:
-	clk_disable_unprepare(st->mclk);
-
-	return ret;
-}
-
-static int ad7124_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7124_state *st = iio_priv(indio_dev);
+		return ret;
 
-	iio_device_unregister(indio_dev);
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-	clk_disable_unprepare(st->mclk);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 
-	return 0;
 }
 
 static const struct of_device_id ad7124_of_match[] = {
@@ -981,7 +964,6 @@ static struct spi_driver ad71124_driver = {
 		.of_match_table = ad7124_of_match,
 	},
 	.probe = ad7124_probe,
-	.remove	= ad7124_remove,
 };
 module_spi_driver(ad71124_driver);
 
-- 
2.31.1

