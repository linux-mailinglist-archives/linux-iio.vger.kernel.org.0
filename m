Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DBE37A0AA
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 09:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhEKHUN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 03:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhEKHUA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 03:20:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936D0C06134C
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b25so28196178eju.5
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHJAupFk4VVa7z8ctgtedCHBJAEpOSwdi50lGjIjnM8=;
        b=bTvYTEb2K77cls873u2IXLpinsxfp5BKbdvPHfvZpBd/42WCGy9rj1yWQP4m9ICcHi
         oHZS1jrg1Kj9A3sMjavCtXrGDl3tMQFBLrMULkUBRSuYAugbephewj2Y35hObGWGI/IG
         Ey5tjMbqQezTgnEcDZzvpBPillnJfDX+SEPmakcLrwN+zgX/Ney0xycu/aTq/OIKxHiW
         p2hx0dH3AZzB59ACnTvSpxl0Lcgq1DGxsIyvm3dDo18SasDGxRMgSnNDekXd3HfTc96O
         CHwZ1s1SqvyhVb1zGm583BYcr7VYwFbSJ04iNsqskfzvq/57NdfLjXStEWfpv9FLVJIR
         8vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHJAupFk4VVa7z8ctgtedCHBJAEpOSwdi50lGjIjnM8=;
        b=JGfTQn5vMxUSrQ1ZDsQz2Osi8Eic4ghJ27y0a50CG8c9OgMg0XN7cxyqiIioF/auDe
         A+HmBter/GtlqnSbymYbx/HpXX4wa2OdvEkSkLwQ/jlN+FYUUdYQtP1SzEsLRSBQlPoB
         Z25FbAHrwGyWUOrGXebNKiIe2OiHKtERA6Kdj5yEMjT/4lXzapWCmeUP1eyMBROzc6NG
         4zE+nCznvw0oODIqdSvYe3hU0VChKUeEEcLbRqqii5ujFIOb2zS0BwyPe9tzQtHe0M6k
         WXGASPADklOXsTErLUZqAoRavFBqjExLlrgLEd9r0foBxZDP9ZnF9vO3tA/nmm04lhn2
         X21g==
X-Gm-Message-State: AOAM530cmLdk36Nty/89hcaOzg7uxeM7SeteNcSYXwLOKVSd4JBTSVMk
        QJFRwzzuzHve5xA0Gr6BgJRV0YAeFTyeMBV6
X-Google-Smtp-Source: ABdhPJxygVxUK46NgvIsEGDJHQrrsQdBrEMNOhzgin1vAaLwUSQjU522mKyN7SLxXS6kwpYQ4/YMWg==
X-Received: by 2002:a17:906:91d3:: with SMTP id b19mr30172072ejx.242.1620717527122;
        Tue, 11 May 2021 00:18:47 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id i6sm13871558eds.83.2021.05.11.00.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:18:46 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 12/12] iio: adc: ad_sigma_delta: remove ad_sd_{setup,cleanup}_buffer_and_trigger()
Date:   Tue, 11 May 2021 10:18:31 +0300
Message-Id: <20210511071831.576145-13-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511071831.576145-1-aardelean@deviqon.com>
References: <20210511071831.576145-1-aardelean@deviqon.com>
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

