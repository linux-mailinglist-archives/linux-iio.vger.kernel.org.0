Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC02221BA9B
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jul 2020 18:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgGJQPg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jul 2020 12:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbgGJQPa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jul 2020 12:15:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2573C08C5CE
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2020 09:15:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so6735875wmj.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2020 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A58ALUumjjt05j/+gyv9/npKtqLpw2CKDOBqng8A+3w=;
        b=QuZR81fNhSUrP+8tEzSRhwiB/EBjSn8c4nKW3rzK26q91ROb63GYpHfCv8OIOr3Iye
         vgJv3D5760cJMIigdjaZPmqlMqcEWrmpvDFWtGjmhgsmKUCLuUnOgc6mnQBc4614vIle
         0MjYT4bo/cC8bN8n4xbG+0IiNjRpGrJzdY/tb4u4oIWLbLNkdLQco2HxIJOvW2r1ieAb
         c6yjBsk4td8ScIrB85WUlivHVrN6yr64idhd8Kx/0YaG7zCpK8+Sskbszg9j5anS10VM
         /IhcpCKxO+Hg8GFw1f+PXyjRHhr2Anum/aez6NC/F3zwYHCpfVt6vHTW3tefl3+T6KRU
         c49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A58ALUumjjt05j/+gyv9/npKtqLpw2CKDOBqng8A+3w=;
        b=ioOqavI9Ua2VvVQcNRDSLsulw1fZ9lkZfxWn+KtRC2FpAO6sOqCWU36VkJi1shnPts
         XlLlNnNE9FYY+mKu/R3O5d7Lquv04UU9iVRM/PrUVRw2tddI4oGWSI+Uacgze0SlWMi4
         v/N378TlWNLpIXscoAsxkQkfYu22q+fvu2c1WQXQ+QnM57pJAKkeqWvfEr/8jBQR6mp7
         A2lfl7YpfP42qwgP3iB42ygF/P0DZPQercKTm9nUlTJ6RE/Qp4Cf5LvMqt+6gxO+QSkH
         qLmnKzRLTOtpIJcZcHncd3jlaJPHOXAud2nbYh+MhZ6ac5NcWuJKOO2xcJyDqOxI7i3O
         ylew==
X-Gm-Message-State: AOAM532YaVZ4xogDiN55gkcgtvv0B9rqXI+nHT1vH1qEsY1B39BgbJw1
        pLjBSYTY3GnW0XmHJCHY56CtaY5cvQs=
X-Google-Smtp-Source: ABdhPJwH+VJhu7xGq6cwXoneM1srOvV259fXHjx+PcqNcKEtcuecBaDo5y3b2FSMlJnpTTjKY51fbA==
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr5701020wmi.19.1594397727814;
        Fri, 10 Jul 2020 09:15:27 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id e8sm11179359wrp.26.2020.07.10.09.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:15:27 -0700 (PDT)
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
Subject: [PATCH v3 3/3] iio: adc: xilinx-xadc: use devm_krealloc()
Date:   Fri, 10 Jul 2020 18:15:16 +0200
Message-Id: <20200710161516.11625-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200710161516.11625-1-brgl@bgdev.pl>
References: <20200710161516.11625-1-brgl@bgdev.pl>
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

