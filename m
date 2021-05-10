Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821ED378E56
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 15:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241977AbhEJNJd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 09:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351230AbhEJNDK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 09:03:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E601CC061375
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:56:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x5so16504584wrv.13
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHJAupFk4VVa7z8ctgtedCHBJAEpOSwdi50lGjIjnM8=;
        b=Lw9aPEnGCjsbM32sKxySIMXcTdcULo0+Rg/tmyTIBhvIl6sQfMY+I65XAY9r3OZiWZ
         poPiVstp8gUSAwkb54qwecMB+bKCsTFvoAJMcmN7rsPF+mY7pafWUCIZuMk1ONG0YxUi
         HAilK03xSi6c3gvsFcGUU+6dY7ZXsooCIZ/wZo5yVrr0GCcjfgkYnhzqDCfUUaQ/oCki
         zcecNbKfH+zVB+aUfZYrpy0YwJwDFlXtO165XBEnH2E5EUMLVznbnlxyMcLF6ZPku8kq
         7pBva4YRiosJct5/VIZNIFqH9iHY1bPnEV0nee1yAlqcwSRsJgguculoE8tENd5OjlWd
         sl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHJAupFk4VVa7z8ctgtedCHBJAEpOSwdi50lGjIjnM8=;
        b=PdNuNIDkdVS6juG2FEVDqkKes5iLVFtrMlRtlZp5ffmd/zFsqMPmjjsz0m6emxcaUZ
         FDw0s1QOxRrICoy0tSeMx7iqGZOimt4w4hIQWigfApNd+j6UlQN+8ofdphqWC9DARSc7
         seyp4Gx/ZePRcb+wB3AV1jQCxOvQV61kJYKZbqIgSm/Oc517DaKkLISdh/HaE6JUVA+4
         e8sr1q2xmrh0NbGug82FAnXlvvk8/c8A+BSWKefHG51xpgAMt5hd3FxdPLixo340jc6o
         8sJIM4eB2BkGa7nCP+LT1hHHcCZQZJwxhX4HQLkQPF0UkzyiismOnY8mSi9CPBIqEZwd
         ENuw==
X-Gm-Message-State: AOAM532m3M4gbFkGkhooUV97PO10XKUapMr/qKeWXdrdHV6jRWXmPKQb
        CNNu8Rj9uUsG1kY9yzApqj8bvZbdCt34Ug==
X-Google-Smtp-Source: ABdhPJwBLRLlpmibnMuPeJQJOER41JHLTwSUHgTz5UUARVCV5UjsabjfuRTjaY1dKjxEod7ANUx8Tw==
X-Received: by 2002:a05:6000:1846:: with SMTP id c6mr29885828wri.129.1620651361440;
        Mon, 10 May 2021 05:56:01 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n2sm23134329wmb.32.2021.05.10.05.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:56:01 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 11/11] iio: adc: ad_sigma_delta: remove ad_sd_{setup,cleanup}_buffer_and_trigger()
Date:   Mon, 10 May 2021 15:55:23 +0300
Message-Id: <20210510125523.1271237-12-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510125523.1271237-1-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since all AD Sigma-Delta drivers now use the
devm_ad_sd_setup_buffer_and_trigger() function, we can remove the old
ad_sd_{setup,cleanup}_buffer_and_trigger() functions.

This way we can discourage new drivers that use the ad_sigma_delta
lib-driver to use these (older functions).

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 86 --------------------------
 include/linux/iio/adc/ad_sigma_delta.h |  3 -
 2 files changed, 89 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d5801a47be07..1d652d9b2f5c 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -470,49 +470,6 @@ EXPORT_SYMBOL_GPL(ad_sd_validate_trigger);
 static const struct iio_trigger_ops ad_sd_trigger_ops = {
 };
 
-static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
-{
-	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
-	int ret;
-
-	sigma_delta->trig = iio_trigger_alloc(&sigma_delta->spi->dev,
-					      "%s-dev%d", indio_dev->name,
-					      iio_device_id(indio_dev));
-	if (sigma_delta->trig == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	sigma_delta->trig->ops = &ad_sd_trigger_ops;
-	init_completion(&sigma_delta->completion);
-
-	sigma_delta->irq_dis = true;
-	ret = request_irq(sigma_delta->spi->irq,
-			  ad_sd_data_rdy_trig_poll,
-			  sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
-			  indio_dev->name,
-			  sigma_delta);
-	if (ret)
-		goto error_free_trig;
-
-	iio_trigger_set_drvdata(sigma_delta->trig, sigma_delta);
-
-	ret = iio_trigger_register(sigma_delta->trig);
-	if (ret)
-		goto error_free_irq;
-
-	/* select default trigger */
-	indio_dev->trig = iio_trigger_get(sigma_delta->trig);
-
-	return 0;
-
-error_free_irq:
-	free_irq(sigma_delta->spi->irq, sigma_delta);
-error_free_trig:
-	iio_trigger_free(sigma_delta->trig);
-error_ret:
-	return ret;
-}
-
 static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
@@ -553,49 +510,6 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
 	return 0;
 }
 
-static void ad_sd_remove_trigger(struct iio_dev *indio_dev)
-{
-	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
-
-	iio_trigger_unregister(sigma_delta->trig);
-	free_irq(sigma_delta->spi->irq, sigma_delta);
-	iio_trigger_free(sigma_delta->trig);
-}
-
-/**
- * ad_sd_setup_buffer_and_trigger() -
- * @indio_dev: The IIO device
- */
-int ad_sd_setup_buffer_and_trigger(struct iio_dev *indio_dev)
-{
-	int ret;
-
-	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-			&ad_sd_trigger_handler, &ad_sd_buffer_setup_ops);
-	if (ret)
-		return ret;
-
-	ret = ad_sd_probe_trigger(indio_dev);
-	if (ret) {
-		iio_triggered_buffer_cleanup(indio_dev);
-		return ret;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ad_sd_setup_buffer_and_trigger);
-
-/**
- * ad_sd_cleanup_buffer_and_trigger() -
- * @indio_dev: The IIO device
- */
-void ad_sd_cleanup_buffer_and_trigger(struct iio_dev *indio_dev)
-{
-	ad_sd_remove_trigger(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-}
-EXPORT_SYMBOL_GPL(ad_sd_cleanup_buffer_and_trigger);
-
 /**
  * devm_ad_sd_setup_buffer_and_trigger() - Device-managed buffer & trigger setup
  * @dev: Device object to which to bind the life-time of the resources attached
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index be81ad39fb7a..c525fd51652f 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -133,9 +133,6 @@ int ad_sd_calibrate_all(struct ad_sigma_delta *sigma_delta,
 int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 	struct spi_device *spi, const struct ad_sigma_delta_info *info);
 
-int ad_sd_setup_buffer_and_trigger(struct iio_dev *indio_dev);
-void ad_sd_cleanup_buffer_and_trigger(struct iio_dev *indio_dev);
-
 int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indio_dev);
 
 int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
-- 
2.31.1

