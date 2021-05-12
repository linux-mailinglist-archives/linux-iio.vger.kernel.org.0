Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99237D377
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbhELSWV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 14:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351072AbhELRxQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 13:53:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E34EC061359
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id c20so845979ejm.3
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3CIlvHXWAL8LnevCxF+tYL0znrNNdyr/u/1pI8y5A4=;
        b=qXCVU1pOC3NzaTJp9gtolMr27NxdPQPD44yJNa++uNdTnbUbh7ROvboXmUiRoIY863
         Pmj++blx5+aTL5eYpceb2RQqLPyFCX9Hxe+OSd1hdjIzo/6B+noo7zTyLZ6IANatMsUk
         o9KvvT0qdHCyKD7L9+c8BZXRUNOx5ukwp90c4N9oF6P01xGhqIt0VeKuKgBlJq931RsY
         CswmQnyuXgOMCzhTD8jISNOZOR0kyY4OsLzOj1P0cs0T3RTazIaOJmJA64yJ/N4C7jnk
         8yE9iHlGTz/PopQayK/trOQpSF70T/dK1UkqQ7M80FeA2hFD20qAEP1jBZPV5cmT45nK
         8czA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3CIlvHXWAL8LnevCxF+tYL0znrNNdyr/u/1pI8y5A4=;
        b=VGA7FRq3dMPpD4mrLTPZ2+/vX9IAI/IQoyYj4pHjE+385eOyGFaq6vm2VThsFl6dSe
         YiJgEzhxtP652CHzMqZAtdQMUkCQx9MNXi1cv+6807wV9UXITZw+6BuE/P7SitNAPisj
         DRRTZ/e5iqbCEJMAeBHDkdtrsZczIUF4Z5+jDzLHJF5msN0dBZ88i4bfMfVEUtgNP1VJ
         66xGs5RfjrYUubnJBH/i0VRhU6FXH+CvaW8uTysLwiloWosF0oCREauAv8YC2H5gI9yW
         tOs+i+K7aqed1/trUAhYycBNxWcSXZ3uybvdolYyYqyeSzaTAHi+5OnajP2TLaq5Ragz
         48tQ==
X-Gm-Message-State: AOAM532HNL//pCLHMGu0LtOpjEIoeUuqGJsL4/NcFIe0koYroFs7y0Id
        Pcgf5CikbBONygXePBJlzVcxtS1SVKYWJw==
X-Google-Smtp-Source: ABdhPJxRWOy3CH7rmQIcbkRp4vckxVLhFK/2r4beXIvZ6wPCagZSzLrH0C79YI4iqL1HRTFXCJ5ecA==
X-Received: by 2002:a17:906:29ce:: with SMTP id y14mr38621527eje.189.1620841808068;
        Wed, 12 May 2021 10:50:08 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:50:07 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 11/12] iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop remove()
Date:   Wed, 12 May 2021 20:49:13 +0300
Message-Id: <20210512174914.10549-12-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
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

