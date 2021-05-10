Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D50378E53
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 15:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241823AbhEJNJJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 09:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351211AbhEJNDI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 09:03:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DCDC061373
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:56:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n2so16578012wrm.0
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vz4kEJldu4GosjMrUcy5BaoWWF6Pgm+zPh1bcD8HAp8=;
        b=cVWwtM1xiuY+o3ca9K7oq8d7mjvL2+pcXQcYySUxsUkbFm0Hzr9tdphMsuzmfxjEvJ
         O7ALQGWABwg6LO+AST/Q2TMqXKg59kQMojvk0zP/wVmGtXi/7AhUeivMNlaVcoly39Gr
         LPFoV4M95RO74oomDsWafmMVUb88dhgxaOrsigPUTQmY2z+wqHbBftrCD+6SGqiWoLfi
         FYyDL1OM6Mpt3DbU4jTKAI3WZ+JdN0heq4/FLXGb718BDKN9hQa4UXimsOBTv6Njwlk0
         h6Q14Ws+OI504RoAgYmHpQeGRcV4ZYdNIQVhxkM7jYZTJqzQ+JaEsn47zvJBZeNII/5l
         pKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vz4kEJldu4GosjMrUcy5BaoWWF6Pgm+zPh1bcD8HAp8=;
        b=cIPVqLvEvv2EYCIjwgJm1spSggkrT7so3stI3nwyX4hWy7/T7V9XYZaoMsLWh1Ye2X
         wsNylTFqK7cE8K0Oib8/aqiMB/c2KF5V+PNFXttar5V3IxKzYPkRLb1qeyIzvLggyLfr
         IFbd0iKqEpGFRqdFWlf8/5h5IPgXRphQ9nnpkFSNtgCSTK2I+aV+VU/3A0zkRSy9FOv0
         fboRjmXO3JfyWcxeh/SlL/bRWEMvvz+kb1a1HH7CCeJ1pbrG0YAXnjt+3Me1Xd9t3Vzg
         Qd/0nIj3FGDJrf8IzwDKeiEF1gNQh6otEa9WsQqs6/8paY1fW+eY4GYzR2csNtHNf5oR
         zA3g==
X-Gm-Message-State: AOAM5311GhMjwYS0xxWOYY4qoac9zCTENBZ5ATSD5Ee4h6c/Mm9tadNK
        xkAQxQPrxdIiAqqdYZDM1SyJOVku73euJQ==
X-Google-Smtp-Source: ABdhPJykjSars3kw6uHkq5syFmwiSnMywB00SpgCG2BehvZcPFeEmcBk/PZkFsItwjpzQNT2XuRZzw==
X-Received: by 2002:a05:6000:180a:: with SMTP id m10mr30342135wrh.215.1620651360537;
        Mon, 10 May 2021 05:56:00 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n2sm23134329wmb.32.2021.05.10.05.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:56:00 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 10/11] iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop remove()
Date:   Mon, 10 May 2021 15:55:22 +0300
Message-Id: <20210510125523.1271237-11-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510125523.1271237-1-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As not many steps were not already devm_ managed, use
devm_add_action_or_reset() to handle the rest.

This also uses the new devm_ad_sd_setup_buffer_and_trigger() function.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
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

