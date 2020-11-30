Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60612C86B1
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 15:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgK3O26 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 09:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbgK3O26 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2020 09:28:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646BCC0613CF
        for <linux-iio@vger.kernel.org>; Mon, 30 Nov 2020 06:28:12 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id h21so25395849wmb.2
        for <linux-iio@vger.kernel.org>; Mon, 30 Nov 2020 06:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oc+CRyq0MP1rGPx6qu4fJIiuXgNVzq5WpNvySKjLu6M=;
        b=GxmJyFcfA3iyJchLIAdSSvI7E0OmfEYFUrK5pXEvNYV2KlltBpcpeUpM58TJ+pnt/Q
         qgLqKKXNkt0UdGY2HBZi2V34IhcYRLIzupD+6vbWa0YWE4aSGD9lx1RGkPulnFfjfEVf
         SGstAR+EY0GYQINJMGMwNIutwUL3HYTjiCZoLT7Y5PahWav4i3R1snqoi/FREkBfks7p
         rzYVnSyvEEwORgskQM4nqn4SF+Nlkf1z+iprB3iDJz9um1+Ap9MK8C2yCdoQuET5J94X
         ffsZQAL9/sIE//unQV6Sk5lkcRe2QvIhaBlI3PTtkX3isgFV9T3f3DPWb/9LSc7V+MIT
         HB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oc+CRyq0MP1rGPx6qu4fJIiuXgNVzq5WpNvySKjLu6M=;
        b=FMp+0NwU7ZVe10Gz1qR/4tVKs1sNDcun/pRldMa9Wl+1DW8hdPpRm3y75g15mwG3x6
         JRytPzJbPTpTb4+bzwXUyCowwCW3PHGetfjxqQe3qIhGaY6whyCjetCrv79n3pWG0lep
         5ML+F/aFqGBchXj/qpQfz0D1W4xwaNevvI+kIgT9YOABtw+ezDan26HxHcXCgj7Ah3sI
         BJxScwFdwhFzfwMPn3MQgsoKwXSEr1TI7H9fgoQen/axVJSmEMGPhfDokWfCqDltzSxH
         UIcevUnVR76WFkDgIOSePDWFiNdKKaDjEkXPzOYtqkm4+Dh9hf2jqUq5CHSPf+Ah8kH0
         XPzQ==
X-Gm-Message-State: AOAM530KjlAyFyi5LLmvP7Qz5pfpJ+tO5MHdObI2z8todHV47oel4Tu7
        5dbv7pbdDPk4rdq3ZWDmtiNHyQ==
X-Google-Smtp-Source: ABdhPJxD/5kmfsCYXfU9rpNA3rlWnUqI4oAwPgY2OTtUwo/7XPH2d5ATmi4f+MwHCpZoewNmRC/DsQ==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr23718597wmc.159.1606746491168;
        Mon, 30 Nov 2020 06:28:11 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id p19sm29446044wrg.18.2020.11.30.06.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 06:28:10 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATH v3 1/3] iio: adc: xilinx: use helper variable for &pdev->dev
Date:   Mon, 30 Nov 2020 15:27:57 +0100
Message-Id: <20201130142759.28216-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201130142759.28216-1-brgl@bgdev.pl>
References: <20201130142759.28216-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

It's more elegant to use a helper local variable to store the address
of the underlying struct device than to dereference pdev everywhere.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index f93c34fe5873..8494eb424b33 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1186,6 +1186,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 
 static int xadc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
 	struct iio_dev *indio_dev;
 	unsigned int bipolar_mask;
@@ -1195,10 +1196,10 @@ static int xadc_probe(struct platform_device *pdev)
 	int irq;
 	int i;
 
-	if (!pdev->dev.of_node)
+	if (!dev->of_node)
 		return -ENODEV;
 
-	id = of_match_node(xadc_of_match_table, pdev->dev.of_node);
+	id = of_match_node(xadc_of_match_table, dev->of_node);
 	if (!id)
 		return -EINVAL;
 
@@ -1206,7 +1207,7 @@ static int xadc_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		return -ENXIO;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*xadc));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*xadc));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1226,7 +1227,7 @@ static int xadc_probe(struct platform_device *pdev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &xadc_info;
 
-	ret = xadc_parse_dt(indio_dev, pdev->dev.of_node, &conf0);
+	ret = xadc_parse_dt(indio_dev, dev->of_node, &conf0);
 	if (ret)
 		return ret;
 
@@ -1250,7 +1251,7 @@ static int xadc_probe(struct platform_device *pdev)
 		}
 	}
 
-	xadc->clk = devm_clk_get(&pdev->dev, NULL);
+	xadc->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(xadc->clk)) {
 		ret = PTR_ERR(xadc->clk);
 		goto err_free_samplerate_trigger;
@@ -1276,7 +1277,7 @@ static int xadc_probe(struct platform_device *pdev)
 	}
 
 	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
-			dev_name(&pdev->dev), indio_dev);
+			  dev_name(dev), indio_dev);
 	if (ret)
 		goto err_clk_disable_unprepare;
 
-- 
2.29.1

