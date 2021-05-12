Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EF937D36E
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 20:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbhELSWG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 14:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350563AbhELRvU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 13:51:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1171C061346
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f1so5866203edt.4
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T22i+g53k1fhCLKh9tB02Omn3iL2iUzJbrWzhjCB28A=;
        b=tAF0dx62soQ3Hr07KE+4fu6mDVXedc1leoQ4lZm5LT0qABOkJkI/YMs6BmzidWJVuc
         jvHaNqN2hMGLYA+qynnoN1kbH9wCtwI+O10AIPGINml6V+EXzFJ88Mo8Z3YwEAWAXu4t
         AMN2Bels0YkMrcdTvaxjpd54fmkW+QXWl3mrk788mYjcpMQlJ1al0yYt7ZBwedUKRM7j
         ORmNH/ceAxITCaDa4N0LThC/v7/OK0gIL6sI0hLS0CY3NwksLxlzuOOXHl5opTxGze3p
         GU158zyamltw6HxCZvnx2pzglrLKG6mS30c5b0IH/HmFLv6GgXWi/EGF4Uek2JIjjsGj
         Qhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T22i+g53k1fhCLKh9tB02Omn3iL2iUzJbrWzhjCB28A=;
        b=WNQDeoK7Ch7M+1hBV88WFVLuiqDqMrqeKSN37CkqXAgDPXXAuqGY45A80rAu3QRkCs
         bIt8MXv+ACTE3rfP3k3StgDr1erBAeqqvrVnO7ShitJk4kW0+YJpUAVkj5B4NE6y3kvp
         Gy6RdQT1Sub4Qbi4dei8LqwubKKgE1RTuiAd7iJfy133BQ8nKTAsZ/4dTrajsjF/NCX4
         WCFn84Dl2SKGJYR3j4faCc/HuSIhsb3x0hjq+EkLKUi3t7my+N2I92gsLkYZRYsUgWdu
         EU59jfyJp1dlsjwEIUSR/bayTI41CeRycr53di6XHLnYLVK6/Nlyc7yv4y4wvbgycxq3
         dSfg==
X-Gm-Message-State: AOAM530K4XaBr6i90wr+bVwHG2du3gw77nSZHji6/Iyrckfe+wsgaBed
        cAbj3cPdNQTIX/TDZ6ruYCdV3OGalNuQ8Q==
X-Google-Smtp-Source: ABdhPJy/lJaBxi2X3NQ269eKCy1E36c09nNh9XhZs9AjxR9E1UcmCj/5UYQO2CygU1ZsJ4uhrXkkhw==
X-Received: by 2002:a05:6402:1b1e:: with SMTP id by30mr9936102edb.277.1620841801295;
        Wed, 12 May 2021 10:50:01 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:50:00 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 05/12] iio: adc: ad_sigma_delta: introduct devm_ad_sd_setup_buffer_and_trigger()
Date:   Wed, 12 May 2021 20:49:07 +0300
Message-Id: <20210512174914.10549-6-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a version of ad_sd_setup_buffer_and_trigger() with all underlying
functions (that are used) being replaced with their device-managed
variants.

One thing to take care here is with {devm_}iio_trigger_alloc(), where both
functions take a parent-device object as the first parameter.

To make sure nothing quirky is happening, the devm_ad_sd_probe_trigger()
function is checking that the provided 'dev' reference is the same as the
one stored on the 'struct ad_sigma_delta' driver data.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 60 ++++++++++++++++++++++++++
 include/linux/iio/adc/ad_sigma_delta.h |  3 ++
 2 files changed, 63 insertions(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 69b979331ccd..d5801a47be07 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -513,6 +513,46 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
 	return ret;
 }
 
+static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_dev)
+{
+	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	if (dev != &sigma_delta->spi->dev) {
+		dev_err(dev, "Trigger parent should be '%s', got '%s'\n",
+			dev_name(dev), dev_name(&sigma_delta->spi->dev));
+		return -EFAULT;
+	}
+
+	sigma_delta->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+						   iio_device_id(indio_dev));
+	if (sigma_delta->trig == NULL)
+		return -ENOMEM;
+
+	sigma_delta->trig->ops = &ad_sd_trigger_ops;
+	init_completion(&sigma_delta->completion);
+
+	sigma_delta->irq_dis = true;
+	ret = devm_request_irq(dev, sigma_delta->spi->irq,
+			       ad_sd_data_rdy_trig_poll,
+			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
+			       indio_dev->name,
+			       sigma_delta);
+	if (ret)
+		return ret;
+
+	iio_trigger_set_drvdata(sigma_delta->trig, sigma_delta);
+
+	ret = devm_iio_trigger_register(dev, sigma_delta->trig);
+	if (ret)
+		return ret;
+
+	/* select default trigger */
+	indio_dev->trig = iio_trigger_get(sigma_delta->trig);
+
+	return 0;
+}
+
 static void ad_sd_remove_trigger(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
@@ -556,6 +596,26 @@ void ad_sd_cleanup_buffer_and_trigger(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(ad_sd_cleanup_buffer_and_trigger);
 
+/**
+ * devm_ad_sd_setup_buffer_and_trigger() - Device-managed buffer & trigger setup
+ * @dev: Device object to which to bind the life-time of the resources attached
+ * @indio_dev: The IIO device
+ */
+int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indio_dev)
+{
+	int ret;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &ad_sd_trigger_handler,
+					      &ad_sd_buffer_setup_ops);
+	if (ret)
+		return ret;
+
+	return devm_ad_sd_probe_trigger(dev, indio_dev);
+}
+EXPORT_SYMBOL_GPL(devm_ad_sd_setup_buffer_and_trigger);
+
 /**
  * ad_sd_init() - Initializes a ad_sigma_delta struct
  * @sigma_delta: The ad_sigma_delta device
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 7199280d89ca..be81ad39fb7a 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -26,6 +26,7 @@ struct ad_sd_calib_data {
 };
 
 struct ad_sigma_delta;
+struct device;
 struct iio_dev;
 
 /**
@@ -135,6 +136,8 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 int ad_sd_setup_buffer_and_trigger(struct iio_dev *indio_dev);
 void ad_sd_cleanup_buffer_and_trigger(struct iio_dev *indio_dev);
 
+int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indio_dev);
+
 int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
 
 #endif
-- 
2.31.1

