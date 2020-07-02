Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C153B21294A
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jul 2020 18:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgGBQZR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Jul 2020 12:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgGBQZR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jul 2020 12:25:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5A7C08C5C1
        for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2020 09:25:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so27651797wmj.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2020 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7AvexTnflQTx+HPLZVCvwg7Wb7VYLoxDJot1+g9yUDc=;
        b=kPgariWQ1He9Btx0hrJy3AppzHXfqTkj15F3Qsuo8IWxk8m6yiKbqO8elL/FsOszcJ
         A4acPaHcp9u7XtZlLpr4OnGnj6majx9m7L23go8BKcWrq8xmiGjAFcdjJgKtOaQ0AQN7
         wZJeLz+fcaGmCTPqlgAFEyVkqjYHN3aI+p3/GnWLZh6NWLQi4suVrqeyFOy76dO8u/E+
         wLeXCOcM4Sziet7tPPAkMZTWGQIUiez7YJScOmXog1s3DPRxJi0o7gBYJ7UD2ZKSWbPg
         b9+3lmqZkKso7p7g1B3cXtdtn7ICVqOV0FtV7EjIH1DTSQWuXztVqyby6Hwsh7XXWxw+
         JzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7AvexTnflQTx+HPLZVCvwg7Wb7VYLoxDJot1+g9yUDc=;
        b=FIB8+fk3FnZa9t0BHHbj7IVtyrb9G+0TvEcSFc2b7z0nut6987GZ61Uc6brhUyG2Sz
         cCpMnOA+v0l4Sfywv0vV9KYJ9r2mm0k3YyNlt+KEmo50dQLEyofzsHKcYPrFKiwqeOKz
         k0gszFwHCG0I1hha2RLljuLRYQLt3tvP/OG9bdr3UvzOZgdf4IxfsRv6phhgmipcu71+
         LPaaDGZA6rnXZRFUG2jmHLhYRqtqXCZA3+9NAhgeZF9K9AmQKDBYL4pEewx7hZ401QEy
         kkkdNvqGxFxFxN92EIkP4GUMV7XnSU1twV1/CMb8sYbG9QTSkA551Qg6ftnE7CCaBwx/
         iV+Q==
X-Gm-Message-State: AOAM532EQFXAzTpVJeBYb+grlqeAla4P0ziBqQQk7ZezJz5Vp804ENV+
        ynCuxPdzk/QTO9QmsyhLdktSsKu0Qk8=
X-Google-Smtp-Source: ABdhPJzm9+NQZ1kati+9qc7RUkch8SPFB0vQJEmu3uSKR9jiTNVW/G/QZ8yYF+/SqdYJzZDF+Ylv+A==
X-Received: by 2002:a05:600c:2249:: with SMTP id a9mr31061773wmm.163.1593707115947;
        Thu, 02 Jul 2020 09:25:15 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id z25sm10428001wmk.28.2020.07.02.09.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 09:25:15 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH RFT] iio: adc: xilinx-xadc: use devm_krealloc()
Date:   Thu,  2 Jul 2020 18:25:09 +0200
Message-Id: <20200702162509.11254-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
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
NOTE: this patch depends on the series adding devm_krealloc() which is
not yet accepted.

Greg,

here's just a quick example of a second user of devm_krealloc(). This time
we're reallocing memory allocated with devm_kmemdup(). Hopefully this is
enough to prove this helper is useful enough to merge it.

I can't test it due to lack of HW though.

 drivers/iio/adc/xilinx-xadc-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index d7fecab9252e..5bdbe502e983 100644
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

