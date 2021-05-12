Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9637D370
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 20:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbhELSWL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 14:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350645AbhELRvc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 13:51:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BD1C061349
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id m12so36286702eja.2
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQxvMGRCpOgSDyhSi99qzEO+Zt/+Ct8uEX5NstuSgr8=;
        b=hhn1x2vQQ6eb4bVEjNiOxg3lkBu6xYzPHiUdMvVo5Y/ADD9heZCbeyv80YoxoQI+ap
         xdhFGIHj2gZ4bBbUrehpEcuOZN/pkyKItAxgzagS2SsJimPbjPu8iHeIK46zLIk9cYAO
         Zuzcmvxr/jHeEHNfVpJoOe3JSiV38DkXgAULzUDESqBVMGUGd6l19UIRwTJYvjwESlQW
         QAj7ORydlkU6jQxG/ZYMwu350RWGvCyCfruNabAlYzfMSZz5iN/JuJXVx4jyg93RbKzC
         r8RJT0QTeaz6Hk52NNbaudYGbJlbglVrv5Xc06b5TptX+9A4oZcAvadQHt7kBge4zMKo
         MHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQxvMGRCpOgSDyhSi99qzEO+Zt/+Ct8uEX5NstuSgr8=;
        b=op3WYV8lnAFde1BAJU+smLSK3NnLlluUDEtraAjcCl3jBZ+JiAt8vqhxOJG/9NYzDF
         +oQ5IjEFB1aW7vcpxEyjmKgVpnVfUs8QamKHMrjxBIPd3/L8qgRxJHsMO3XP2Wch6Ct3
         Fz8T1djEmwMS2w2j/gKAP+0Lg9H3kFRRp8HgXNrwEzUakf4xS3Blbi4EpwdK0wovwFLO
         kCAsRMIUhcDATWyvb4DyJwbSDRWNIvg6GJxfVbnsx+eLpEAC9Y39glU0P5evr2wilALq
         W91KsNFJIQyMii9BsD2LLOSVAiJj1KAbTV311UM8RdTetoJfk87zpiXbVzEU125/198B
         Mi8Q==
X-Gm-Message-State: AOAM530yM4SZn5Qo75h4A+JTnDWm25Snl7fEZtCuPaLQSsPgueJ03VHX
        JogUFIP9rXoFY7Y4xEpCQFYoL9Iu9YwQRg==
X-Google-Smtp-Source: ABdhPJwq9q5Iy3AdiO/bj8e11TxUZpVFfHepeUMmr9TRTfrbZmPqFQS4cwQWCM56t2MFqztHGwYBdw==
X-Received: by 2002:a17:906:fa19:: with SMTP id lo25mr38246636ejb.394.1620841803592;
        Wed, 12 May 2021 10:50:03 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:50:03 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 07/12] iio: adc: ad7791: convert to device-managed functions
Date:   Wed, 12 May 2021 20:49:09 +0300
Message-Id: <20210512174914.10549-8-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With the devm_ad_sd_setup_buffer_and_trigger() helper, it's a bit easier
now to convert the probe of the AD7791 driver to use device-managed
functions.

Only the regulator disable requires a devm_add_action_or_reset() callback.

This change does that, cleaning up the driver a bit.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7791.c | 44 ++++++++++++----------------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index d57ad966e17c..cb579aa89f39 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -394,6 +394,11 @@ static int ad7791_setup(struct ad7791_state *st,
 		st->mode);
 }
 
+static void ad7791_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ad7791_probe(struct spi_device *spi)
 {
 	struct ad7791_platform_data *pdata = spi->dev.platform_data;
@@ -420,11 +425,13 @@ static int ad7791_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(&spi->dev, ad7791_reg_disable, st->reg);
+	if (ret)
+		return ret;
+
 	st->info = &ad7791_chip_infos[spi_get_device_id(spi)->driver_data];
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7791_sigma_delta_info);
 
-	spi_set_drvdata(spi, indio_dev);
-
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->info->channels;
@@ -434,39 +441,15 @@ static int ad7791_probe(struct spi_device *spi)
 	else
 		indio_dev->info = &ad7791_no_filter_info;
 
-	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
+	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
 	if (ret)
-		goto error_disable_reg;
+		return ret;
 
 	ret = ad7791_setup(st, pdata);
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
-	regulator_disable(st->reg);
-
-	return ret;
-}
-
-static int ad7791_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7791_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-
-	regulator_disable(st->reg);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad7791_spi_ids[] = {
@@ -484,7 +467,6 @@ static struct spi_driver ad7791_driver = {
 		.name	= "ad7791",
 	},
 	.probe		= ad7791_probe,
-	.remove		= ad7791_remove,
 	.id_table	= ad7791_spi_ids,
 };
 module_spi_driver(ad7791_driver);
-- 
2.31.1

