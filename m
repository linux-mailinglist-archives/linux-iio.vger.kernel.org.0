Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B5F37D374
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 20:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbhELSWS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 14:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351070AbhELRxQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 13:53:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD72C06135A
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id c22so8142146ejd.12
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHJAupFk4VVa7z8ctgtedCHBJAEpOSwdi50lGjIjnM8=;
        b=e10xmBpzys9TdMzE0pnZOOkSfhsx/x+C1dbrHUZpxwE97NttSHDWv5JMPPQzRHCKmf
         5q3wJ5nmq/nooxGb8mVQgNDjWMrYDglBaVpSrsIn1rcHqC7bLMzlUR1K9d0aSDaxANMN
         8MDIr7L9W2Ama2Do4uMchWdz1vBpNeascHyKnkr+5S7TktkVwvza3oJPN4QniW+C8qwR
         Wjp3K0jHkZj1hY/NMOCCNUhtWCUzcQbP79tBqyTCMXocF1iEwztNhOFlG8jKbQQwdcqP
         4+sEdxNOOqJsRF7tO+rQ/ykf2Fq0Xko9BUwyAfKDYTRVewT8XpjtFLoU9WjFDFSLyjo8
         aOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHJAupFk4VVa7z8ctgtedCHBJAEpOSwdi50lGjIjnM8=;
        b=iw0MHABBC4O7fooPotyDQVxz6G7+i8ALg/Hwvp+B6iDtcfTuMU9PvD3Uw22CPe3Bwh
         h3DIeZOlKgrs2oogn7q4C/NNRtwoE9FV+y17HnNK+kj9qbNNek3qIJ5CY1fND/lvSxUx
         hWyj/+IBrlAenNQBoGn1v6+kKSJLpH38hg8ChRMFAdOzc/6qROoQcyZifMZDnje7aj6z
         +KyGD4MycJa/52RT0lIyo7XWsNVz6rUhobDsfTILozQSUEZCwOeNL2PI9iupKzYoM6ue
         KFFXRC+u9VBYa8meHrpBiRuY4EnE9OHUTPJ/ImcbcTMLCypTyTm0xWz1EIzss48Ays/P
         9RQQ==
X-Gm-Message-State: AOAM530BIZ5900omFw23S/5j4oe/HwefMF/NVjTEpMM6fFKq6vfsIMHU
        7TB1JQkexY0NYd5+UAn7GJeSgy/5nO5rJA==
X-Google-Smtp-Source: ABdhPJz0FTn0J+EeturXDq+YOEJGN9aS96/Ktldul8oQ4CJTzbrcu1fjcrwMYKn+fa9fVKlSBehKIg==
X-Received: by 2002:a17:907:e89:: with SMTP id ho9mr37611483ejc.5.1620841809218;
        Wed, 12 May 2021 10:50:09 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:50:08 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 12/12] iio: adc: ad_sigma_delta: remove ad_sd_{setup,cleanup}_buffer_and_trigger()
Date:   Wed, 12 May 2021 20:49:14 +0300
Message-Id: <20210512174914.10549-13-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
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

