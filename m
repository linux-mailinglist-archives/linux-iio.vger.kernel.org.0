Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DDE37F787
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 14:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhEMMKO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 08:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhEMMJY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 08:09:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F301FC06174A
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k10so8299100ejj.8
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHJAupFk4VVa7z8ctgtedCHBJAEpOSwdi50lGjIjnM8=;
        b=rcr7BmNEIQVjj3pUZDq/B1tMKnn3iGdsbZuSj/giIshvWf/4JCiRGvshOVZogyJdRY
         ZiuAPEFaf0hJD3k/2c0Q37P8T3rfQ2SI9TW9LJLQHz6XcukWbuNFzLJUjS2hXlF+Ae6R
         G79+T/o+ZpuQWwXMzBsefokXpgdbg6YD8j3olInSGF05zvRCJR4wRPfmeFtyF+yzFiDC
         ObuMCG85XK0BBa9/4EOCKsD9Np4GBOchz54N2LjWPW3maAJYLsn7Z+LkDBwuXZ+t65tr
         GIRdwfXtDZNeZ9uDIbq1qwz6hYRtjcaPIh49i6SkN/z4IoLcErY3NV5Va88rMudfh5AN
         DIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHJAupFk4VVa7z8ctgtedCHBJAEpOSwdi50lGjIjnM8=;
        b=Wo3tz6uTPqJljQkkuLg8TELNbkBHJlQA6uYckJVPlkZ4EjVX87dNUIap1GE9bIOC41
         ykfeBlFHio7XmbfX8OH3kza4jyRXZKg2B+nM1/DO82+XUu5SOtpMMEUEw3g//RapfzZY
         Vlv0+ZEUv7VTrOsqtPdprIOTN9ONrxv1bA1RCipjCcDBlt3WMI1sinxBflcvpwKxVYuB
         sKbOQ+HnyVIfDS2tqcvv5a48qb4rCRLfgqtzwGlwiBeG3eeZG1uWLSZ60VLRQ0ONbew/
         NexmI0PKlOsDXhal63TI0gt+38w1UTf0xvuO+NFHuqZ5FR7faCtHRvrCjVT3wryE13p+
         Jzbw==
X-Gm-Message-State: AOAM533Rnp06y43j5/xhSQqGw3ac409hKd+QyMBokUrO2xMLnFcxzdRB
        5GjxJgbs06kIbtJlPoIIrOrjd1ThsL6SZA==
X-Google-Smtp-Source: ABdhPJyRZRmOkMHCYv12/pyUMesmQ4h4aqn5mfmbQZlU+FCDZUxW2HuNgdCuwrihezuF85CFoVbLCQ==
X-Received: by 2002:a17:906:81c4:: with SMTP id e4mr4926695ejx.27.1620907691447;
        Thu, 13 May 2021 05:08:11 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:11 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 12/12] iio: adc: ad_sigma_delta: remove ad_sd_{setup,cleanup}_buffer_and_trigger()
Date:   Thu, 13 May 2021 15:07:52 +0300
Message-Id: <20210513120752.90074-13-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
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

