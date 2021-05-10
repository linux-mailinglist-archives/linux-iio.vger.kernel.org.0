Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2336378E4C
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 15:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241901AbhEJNIW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 09:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351134AbhEJNDA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 09:03:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836CBC061350
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:55:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o6-20020a05600c4fc6b029015ec06d5269so2440287wmq.0
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T22i+g53k1fhCLKh9tB02Omn3iL2iUzJbrWzhjCB28A=;
        b=eCtUxx+QoNkZtb/x+DkVSPqZKOadIhEMMlPASjY0l/1g2fFi8OVRvbxa1cF2ypMlad
         Cy5bx2x/k/plI+xFS7PNi3znFYwTD7Wpi2sWEJ/T0lbNvXorIFyFAkzz450CKuleSf+C
         gU2jWBcQ/3ILNxkS823GfeKdQ/GOhlpkLCdVDW4zVsbdKcBrRJckPits/sj9xHOXy+N+
         wjmQXMupfKXoLBd4QOLr1ord6ufgI4xlfjoYD2yoKDSvolyGTYtWtrRIGCsaiJ/NMyTJ
         fxSymlUL9EG6oNJTcQO4D0zZsX92771UIVWAt8mHt13/SMdZ3ckm5Tp0O9HTlsrnSwsC
         gjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T22i+g53k1fhCLKh9tB02Omn3iL2iUzJbrWzhjCB28A=;
        b=OSh2qL1Uq3bbObbZqtwZIkyZaowpzxt0GbVrpkN2GP09SiEC/HdZn9lntqe03+wtap
         wqSPdeGnrsALJMeDAchsVYxxnyt7pxJ+LmXiozaDjdP4u/T17ZnTeDzn958Wr7JDm6em
         A8q3CfCSiGrS721eZykD63f7PbzzBJW6R5Z717RcnVoKY26O3MJTdGI2yn/1FE80EYRn
         lFmgjU8XZr6yVwX6vjF5OhKJ+D6EYX4OaWVfSRWBDUSt4msEJg3XmMsQg0ZPe5GFhRUG
         m3s3W9gCto5M4EiFmYkdkttIIt0+XM95r3gPNmmXV0h9diRpS52+zQ2QPuWl7iwmM1sh
         rm/g==
X-Gm-Message-State: AOAM533Yr2r4e2PSUVWxH+Wei27E5VKKmbdF+c9YaxZWrKvQsy+Atm59
        /Z2XaH5L65MsJPWroWs+hDNiFZjHHGKcAg==
X-Google-Smtp-Source: ABdhPJz2vAtWMSvSZ13uvP3TVIYNGQLJ09O47U9p2Q6KI9rlJzds0loEMA+VGywRLQo2U1RX1UOH5g==
X-Received: by 2002:a05:600c:4304:: with SMTP id p4mr37384148wme.111.1620651352071;
        Mon, 10 May 2021 05:55:52 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n2sm23134329wmb.32.2021.05.10.05.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:55:51 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 01/11] iio: adc: ad_sigma_delta: introduct devm_ad_sd_setup_buffer_and_trigger()
Date:   Mon, 10 May 2021 15:55:13 +0300
Message-Id: <20210510125523.1271237-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510125523.1271237-1-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
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

