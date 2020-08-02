Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FF2235601
	for <lists+linux-iio@lfdr.de>; Sun,  2 Aug 2020 10:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgHBIfP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Aug 2020 04:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgHBIfH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2020 04:35:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE1AC061757
        for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2020 01:35:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so31445901wrh.10
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2020 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPQnmI/58kOYJX5JO2+CM6DvjdssZDc2jVBjt8SVn9Y=;
        b=iO2jRFEx59Eh2m1Om/5bJDJk6/MLr3z2OMyOsrMzSXjHTnYO2Yr0MJFnmUantExUSg
         Xsex/oX3W+VEglpLLMrC6wpt1jxfdDiWMc7IVzo2zWlxpeVRQgMfwmUv8gVmdGX89YKH
         /HI1+tYCx7tbOg7CvzYtnATitPyFEf8B41jGH4xE+awMJ0YdnPHpO/OvgIhfwXvExvFp
         oAU2wb6m44XZoZpVqs87WsGaHIUAfhC/GyOforarHWOxfupdWdDKtNs4usKA04nxmgw8
         kP6x54XgAV24encfK0kNboTawG1oMc5zlvZ+OQ0RsWbrjip2tQWY9lTkgM5gle6bVUWc
         Z1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPQnmI/58kOYJX5JO2+CM6DvjdssZDc2jVBjt8SVn9Y=;
        b=RWpqyPadlsVIb/dOXdf9CZCS77v+bENCYdcQV6fKqlUcUajpoHFzD0I8uyUDCmlJEP
         qBICHEHZUfeE/8F4J2mJyoLNFCdaD0ycC6zCz5OQttCyUBukWRNA74mgUG1kDdI5wNtK
         uxshWhp9gnm0ONXQRxHMDd4IRmwuJBlFxAJUgfpd92whY7tz1GUfL1+JGlxDcUot43Hf
         d75TWIObwBqggU9fK9EhIDVW8e5SuWN8iWAkD8FhOAWm5NIabn/GAB0RTN1rh6FB7R1q
         f6ffC7NvHg3Kf/+dF9egc6KybzUzVcC/sNprLMqFSRYMq85wBw7ORrlbal3e9j0SintI
         CaVw==
X-Gm-Message-State: AOAM532XDSEzDy3jgsVLaWkG9PQ2sMjZeZ/ODxLPisBGtGIlSiFTV4qv
        nCkYgTnWFMrpjMybykbpIlZr4g==
X-Google-Smtp-Source: ABdhPJy4rrs4Yd+dSBltlP9MU+WoUAnn2Nr859YwbSPgNkZJwkSvEt7W6+PVPE5XkvK5+KUEjAVJ9g==
X-Received: by 2002:a5d:6641:: with SMTP id f1mr10312582wrw.307.1596357306003;
        Sun, 02 Aug 2020 01:35:06 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id d14sm19281466wre.44.2020.08.02.01.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 01:35:05 -0700 (PDT)
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
Subject: [PATCH v6 3/3] iio: adc: xilinx-xadc: use devm_krealloc()
Date:   Sun,  2 Aug 2020 10:34:58 +0200
Message-Id: <20200802083458.24323-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200802083458.24323-1-brgl@bgdev.pl>
References: <20200802083458.24323-1-brgl@bgdev.pl>
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

