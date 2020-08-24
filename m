Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E75B2506AD
	for <lists+linux-iio@lfdr.de>; Mon, 24 Aug 2020 19:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHXRjN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Aug 2020 13:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgHXRjJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Aug 2020 13:39:09 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73398C061574
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2020 10:39:08 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u18so9284512wmc.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2020 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPQnmI/58kOYJX5JO2+CM6DvjdssZDc2jVBjt8SVn9Y=;
        b=clz/C0FZ1UbxXtnPwybhuWgiHNBL5Brwo6D97RcHtz/jpSGZzUyPdyThZfVpsuUPhy
         BLLt2igu/mDIt1K0CqFa2yQD9w2oVsQK/9Iqi7QetOpl9d/mWUlr8Mn3/cu3Vf9m/QWa
         mOtxZs3N/KmsPcr/EpW5ESCgbWZkeB6WRu4AKdJ1gZtRX/JdmE/Q30YbfWKEIb7mLWKZ
         2R00AVRzPMCqeANspr2UiyCqGTLKTmTfU2iRv0AXULWhbniUFAtjwt6XAQI8wBfuf+MA
         opHnb1m8Um2FEht+6vz1mkxnLQA4+m9qen3QuxTtiWVoJ7SSP1XU8QfKb1FULd7s0z/L
         juGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPQnmI/58kOYJX5JO2+CM6DvjdssZDc2jVBjt8SVn9Y=;
        b=kpVkBZzYtI6Lf1io6sAsUG1u9a0poit9MyvMj9tgGAiM9iz3oQ0dM3ijLJtgSs5mXj
         s+UylPHOE4jgfNrnuNemnbD5Q5bUU5osZs/UALHtGNgCd/TG1HW5GTwOrrMoLIafmAll
         dHqoXxJUdv8Bn/I+iAjMnupH9QjNtvExG5F/OVzWRpEXuqJ57DvL/pjwnmeyCZM3Ph8G
         wui7H1xv/2Z7IWBs+JE7nIDyCiHl/wp5vg977B5ovmol7ScIQWlwnac0PDfFfd1JXwtP
         U0iOugceR1rTksXwjHmw+MehoHxeTqQUzxb818XanYtEZAViCK2Jp44mEujl82SZzhZB
         0RLw==
X-Gm-Message-State: AOAM532kT0D1QS+Gk91gClVyxbtvs7fhsRicWN7Na5rkt7+k2BORYRjg
        mBnPtuwkL7uo9Jhv7uROz5WLTQ==
X-Google-Smtp-Source: ABdhPJyON3K1mqtMD/inQXwsjxZaY9mFHqzEoTnd6F5b28j0NPRKH/zMGFn1ARwYjsrjlG6pFSUHow==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr390305wmm.100.1598290747126;
        Mon, 24 Aug 2020 10:39:07 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y24sm471977wmi.17.2020.08.24.10.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:39:06 -0700 (PDT)
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
Subject: [PATCH v9 3/3] iio: adc: xilinx-xadc: use devm_krealloc()
Date:   Mon, 24 Aug 2020 19:38:59 +0200
Message-Id: <20200824173859.4910-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200824173859.4910-1-brgl@bgdev.pl>
References: <20200824173859.4910-1-brgl@bgdev.pl>
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

