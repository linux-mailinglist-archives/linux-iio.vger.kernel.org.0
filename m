Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2D02208AD
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jul 2020 11:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbgGOJZh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jul 2020 05:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbgGOJZg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 05:25:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A973C08C5DB
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2020 02:25:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so1608691wrw.12
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2020 02:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9PXD4vP8fC6/t9fZb9g5coIXGjPw+6LiW/rcHcw4O0Y=;
        b=YhQHu/Py4gj0Gkn+iHVJwiDCL6stH/0kHXZZ8bdqixcEAHNXK07UhLcVpA8ipX7h5b
         h7rDsIFNoRUMqBWfqYgGccuaIHLUe//PjzxbTCyZ/TCJzmjVA2PdR+146fDH9dR3EpVP
         p7iD7iSS1YJ75kgrqRxJeayNsNtT7Wyrg6Iinpg2R2pFnSiPW4YOVuYtkB64CYKvjJYq
         ze67yTtpeM4t/jWtW6jptq2qMzho4+9e3b5YhJsi6oILD9vmC0RvmwCh+cMNK1oprhBq
         lA3WxcT/w7aCj2T4R3Cxo3V+xAA+EmOn3szMwzuw0BE74/Td5v24TXj3DYmATmNDSRra
         6utA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9PXD4vP8fC6/t9fZb9g5coIXGjPw+6LiW/rcHcw4O0Y=;
        b=ddno46kkR7Bs+zQE+vWkNniIU61R3jt6AEzEpLiOAaoYuiApGjQCkufXo2BUTL3nMy
         mPFRh/7I5KK7g5ryxiGm/vfHntiZqzxqyizeVC+8X+6plX5tlzm8ZtHPovatJuqU1MB1
         trWahYVEQmyevMtA8oCBZa+u8LRpn5OYgx2UBG9qS+l/vnaYF4OWdfA81IJaxt1ieNDQ
         QtgTVwRKupisTsayiEJNDwPxuxVp0jDAQDytpiDKIQLPSXWLAjaiNZW19HA4hOJk++s7
         3JIv8AcEzRPnTqaKMv1kWfMYCFhhYWA02pgawmTMqmXVrMzbLcRYm1FCtYseYhX33U2S
         ZR+Q==
X-Gm-Message-State: AOAM5335tkDRjdsg3/287FMB57VBjVgcEdEreY38ghN8uteGF3/iFKKG
        a++aNji63J0aGr4KxUl3OiZv2g==
X-Google-Smtp-Source: ABdhPJxAv8TS1L6Exp3BLcxEht3Ou3eTz+k4lGA82m7EZ3boprVK27BZQpRkRlPpwYfLU2cxMGfDkg==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr10480495wrp.96.1594805135021;
        Wed, 15 Jul 2020 02:25:35 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id v11sm12083419wmb.3.2020.07.15.02.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:25:34 -0700 (PDT)
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 3/3] iio: adc: xilinx-xadc: use devm_krealloc()
Date:   Wed, 15 Jul 2020 11:25:28 +0200
Message-Id: <20200715092528.8136-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200715092528.8136-1-brgl@bgdev.pl>
References: <20200715092528.8136-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the managed variant of krealloc() and shrink the code a bit.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index d7fecab9252e4..5bdbe502e983a 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1094,6 +1094,7 @@ MODULE_DEVICE_TABLE(of, xadc_of_match_table);
 static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	unsigned int *conf)
 {
+	struct device *dev = indio_dev->dev.parent;
 	struct xadc *xadc = iio_priv(indio_dev);
 	struct iio_chan_spec *channels, *chan;
 	struct device_node *chan_node, *child;
@@ -1138,7 +1139,8 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 		*conf |= XADC_CONF0_MUX | XADC_CONF0_CHAN(ext_mux_chan);
 	}
 
-	channels = kmemdup(xadc_channels, sizeof(xadc_channels), GFP_KERNEL);
+	channels = devm_kmemdup(dev, xadc_channels,
+				sizeof(xadc_channels), GFP_KERNEL);
 	if (!channels)
 		return -ENOMEM;
 
@@ -1174,8 +1176,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
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
@@ -1229,14 +1232,14 @@ static int xadc_probe(struct platform_device *pdev)
 
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
@@ -1354,8 +1357,6 @@ static int xadc_probe(struct platform_device *pdev)
 err_triggered_buffer_cleanup:
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
 		iio_triggered_buffer_cleanup(indio_dev);
-err_device_free:
-	kfree(indio_dev->channels);
 
 	return ret;
 }
@@ -1375,7 +1376,6 @@ static int xadc_remove(struct platform_device *pdev)
 	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 	clk_disable_unprepare(xadc->clk);
 	kfree(xadc->data);
-	kfree(indio_dev->channels);
 
 	return 0;
 }
-- 
2.26.1

