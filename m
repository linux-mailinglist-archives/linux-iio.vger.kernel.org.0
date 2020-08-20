Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0560724C5D8
	for <lists+linux-iio@lfdr.de>; Thu, 20 Aug 2020 20:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgHTSvk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Aug 2020 14:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgHTSv3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2020 14:51:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBEEC061343
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2020 11:51:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k20so2703419wmi.5
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2020 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPQnmI/58kOYJX5JO2+CM6DvjdssZDc2jVBjt8SVn9Y=;
        b=ds8FchHZgRuxGCcCkfqi5SN58L2+FMba1tz0losixTRhpXlqakfrOTqrbbVnokDN7f
         WheHwZbtxeZPlOV4zb65MCYoGXAMGE5xVq/Idi3wyXUyRrsLVO4rc/xo9Ni2Ap70Zrln
         ynhRFKQdeKG3/n3MpIXmtpXc8PiWpVShani05RJZfwaHRiM/mJlDf1/T1urQOTb7OF+n
         E3S2YOSoJBYv2fiaSbYSjMYeZFKmJYkr4SLL/TqZWgAUyusGabPyP7GqG5K2ZNsu2uZD
         qXOABGS19VmFHX3oLEuCVW74JDowihEpLnyDpBNKyfNtaK5PrnF6XWwOyQLeYHSci/CY
         eEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPQnmI/58kOYJX5JO2+CM6DvjdssZDc2jVBjt8SVn9Y=;
        b=nAT8U70hqETeAcKkf7nhA9ItHeobzu6RXrxNvqh3I4kKv7ZASboMufHIhvD/gAj/r5
         81GTEqZiK6EhE8jet/MT7W95cAt992yLKJc+hJTiiw8R0bsg+GXSDPpskgVgtfYSFGrS
         bGf1A/BgQn6sELGImgAcmdRDecjuLUM48En28BhZLZo95arP3Jd02IvXflPRRDSbayHj
         DmaLLRItdcgSnZpNpZBm8viezm5bbVMYHn6T4iaJh05mV5fIS4dJ50Z1sgKGNCt3EBk/
         Ta6NbCRmUTCRLb4qFXHyrMFu45ENYdvYK7Ls4+VuAaa0LyDpOc+KzTjUS6SB/ufiSbWD
         H9RA==
X-Gm-Message-State: AOAM532ymGU8i1UnH9AKwWn6ZAYXH3rpZZYHcukXwb20rM2e20n4i+Hu
        Au7rL0wRnVwPBV/D36y2uxKj5mOHhslL5w==
X-Google-Smtp-Source: ABdhPJyp/NWmznNP/KusvFX00GaOA7bor3jeE+T3/KSaaSpCfA6GXoWHo3uB2PcjIe/9X/tKfJQ0Pw==
X-Received: by 2002:a7b:cbcc:: with SMTP id n12mr38361wmi.105.1597949487036;
        Thu, 20 Aug 2020 11:51:27 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q2sm5694019wro.8.2020.08.20.11.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 11:51:26 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 3/3] iio: adc: xilinx-xadc: use devm_krealloc()
Date:   Thu, 20 Aug 2020 20:51:10 +0200
Message-Id: <20200820185110.17828-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200820185110.17828-1-brgl@bgdev.pl>
References: <20200820185110.17828-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the managed variant of krealloc() and shrink the code a bit.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index d0b7ef296afb..f93c34fe5873 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1092,6 +1092,7 @@ MODULE_DEVICE_TABLE(of, xadc_of_match_table);
 static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	unsigned int *conf)
 {
+	struct device *dev = indio_dev->dev.parent;
 	struct xadc *xadc = iio_priv(indio_dev);
 	struct iio_chan_spec *channels, *chan;
 	struct device_node *chan_node, *child;
@@ -1136,7 +1137,8 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 		*conf |= XADC_CONF0_MUX | XADC_CONF0_CHAN(ext_mux_chan);
 	}
 
-	channels = kmemdup(xadc_channels, sizeof(xadc_channels), GFP_KERNEL);
+	channels = devm_kmemdup(dev, xadc_channels,
+				sizeof(xadc_channels), GFP_KERNEL);
 	if (!channels)
 		return -ENOMEM;
 
@@ -1172,8 +1174,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	of_node_put(chan_node);
 
 	indio_dev->num_channels = num_channels;
-	indio_dev->channels = krealloc(channels, sizeof(*channels) *
-					num_channels, GFP_KERNEL);
+	indio_dev->channels = devm_krealloc(dev, channels,
+					    sizeof(*channels) * num_channels,
+					    GFP_KERNEL);
 	/* If we can't resize the channels array, just use the original */
 	if (!indio_dev->channels)
 		indio_dev->channels = channels;
@@ -1225,14 +1228,14 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = xadc_parse_dt(indio_dev, pdev->dev.of_node, &conf0);
 	if (ret)
-		goto err_device_free;
+		return ret;
 
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
 		ret = iio_triggered_buffer_setup(indio_dev,
 			&iio_pollfunc_store_time, &xadc_trigger_handler,
 			&xadc_buffer_ops);
 		if (ret)
-			goto err_device_free;
+			return ret;
 
 		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
 		if (IS_ERR(xadc->convst_trigger)) {
@@ -1350,8 +1353,6 @@ static int xadc_probe(struct platform_device *pdev)
 err_triggered_buffer_cleanup:
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
 		iio_triggered_buffer_cleanup(indio_dev);
-err_device_free:
-	kfree(indio_dev->channels);
 
 	return ret;
 }
@@ -1371,7 +1372,6 @@ static int xadc_remove(struct platform_device *pdev)
 	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 	clk_disable_unprepare(xadc->clk);
 	kfree(xadc->data);
-	kfree(indio_dev->channels);
 
 	return 0;
 }
-- 
2.26.1

