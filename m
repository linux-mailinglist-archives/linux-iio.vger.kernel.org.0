Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67A561E67
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2019 14:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfGHMcn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jul 2019 08:32:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44780 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGHMcn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jul 2019 08:32:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so7535411pfe.11;
        Mon, 08 Jul 2019 05:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RxpMPcHTrGFGjqWq8f7HzjYVE09n8MPxeOpsNwbmg9k=;
        b=uDA+n1wSK/U5d0fPnWt6hjBiwZg6BHH1kVxd3zGI6SskDlhU3p/vRYyOuaP+lTphmp
         nWQFsEBWdFrDe9cmcZ2r1SCS72Z44qclUBtiI8wYpkaaY5hyjMdKe147rZEUgL0dypNB
         Rux9sy/0aB6nFmvqWQvVqN2PGhczXZa8nKBQbUVKIOXXqj6zTT6jdms1x0GQ6UIPgD70
         SPOx33Lr0mw7pd6x7mZjWahovDL4EukIy4FR4xzLyVMDqYFH7IVb3+vTwLyxkkhCh03h
         TfB0RXuFQeR2S6LKQ/5WIUf84XoxyqLwabbxmq6uS5iwUZjUMrFXrb+65MIRLLaN/HDp
         57Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RxpMPcHTrGFGjqWq8f7HzjYVE09n8MPxeOpsNwbmg9k=;
        b=BTCgFRsrdCspqXNfRAzHMogF2DqmYfqgzlTuf223lrplfq1uTbDZMfklKUY1sWgydg
         QUHmEuYoaE2vu7FUl6Cv7YxPJq20CC5HrvDN+IInROPZwzvThhEUARoXi55z8L4xVfm0
         t19Pr1vLCsr83iHLZryoQA2GQ59YW1V0BW7CcaFOrA9QcL/lPUzZe56/jhjFTXF0F8QC
         bx8KSDe7Awb1+HHLolR8u4ash2M40VtFqpemEk+R/NLpyVQBOpq7j1ruRUgusExGp1xN
         ZcE/LFO/KCRRVY/F6QiYx6dkEfwt82vAgRtCKmifLzMZ8BzKlhwobbLoGxfDadITQQQA
         BUhA==
X-Gm-Message-State: APjAAAWgWwsH7qRlfyyarPOO8zJE4WW9Qc7VIscd8HweyQaIv8Hjm0QF
        FiSDJQF/NrjtoibaQ1rjTsA=
X-Google-Smtp-Source: APXvYqw6bMGg8DJmMiXI2XCG7/UTSEzIlMrMTLiYGyYa7buh41RtB660m1E3FrMdiPP3rx02sqf19Q==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr23237667pgd.241.1562589162230;
        Mon, 08 Jul 2019 05:32:42 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id q1sm30813710pfn.178.2019.07.08.05.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 05:32:41 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 01/14] iio: adc: sc27xx: Introduce local variable 'struct device *dev'
Date:   Mon,  8 Jul 2019 20:32:21 +0800
Message-Id: <20190708123221.11658-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce local variable 'struct device *dev' and use it instead of
dereferencing it repeatly.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/iio/adc/sc27xx_adc.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index f7f7a18904b4..ec86f640e963 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -504,88 +504,89 @@ static void sc27xx_adc_free_hwlock(void *_data)
 
 static int sc27xx_adc_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct sc27xx_adc_data *sc27xx_data;
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*sc27xx_data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*sc27xx_data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	sc27xx_data = iio_priv(indio_dev);
 
-	sc27xx_data->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	sc27xx_data->regmap = dev_get_regmap(dev->parent, NULL);
 	if (!sc27xx_data->regmap) {
-		dev_err(&pdev->dev, "failed to get ADC regmap\n");
+		dev_err(dev, "failed to get ADC regmap\n");
 		return -ENODEV;
 	}
 
 	ret = of_property_read_u32(np, "reg", &sc27xx_data->base);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to get ADC base address\n");
+		dev_err(dev, "failed to get ADC base address\n");
 		return ret;
 	}
 
 	sc27xx_data->irq = platform_get_irq(pdev, 0);
 	if (sc27xx_data->irq < 0) {
-		dev_err(&pdev->dev, "failed to get ADC irq number\n");
+		dev_err(dev, "failed to get ADC irq number\n");
 		return sc27xx_data->irq;
 	}
 
 	ret = of_hwspin_lock_get_id(np, 0);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get hwspinlock id\n");
+		dev_err(dev, "failed to get hwspinlock id\n");
 		return ret;
 	}
 
 	sc27xx_data->hwlock = hwspin_lock_request_specific(ret);
 	if (!sc27xx_data->hwlock) {
-		dev_err(&pdev->dev, "failed to request hwspinlock\n");
+		dev_err(dev, "failed to request hwspinlock\n");
 		return -ENXIO;
 	}
 
-	ret = devm_add_action(&pdev->dev, sc27xx_adc_free_hwlock,
+	ret = devm_add_action(dev, sc27xx_adc_free_hwlock,
 			      sc27xx_data->hwlock);
 	if (ret) {
 		sc27xx_adc_free_hwlock(sc27xx_data->hwlock);
-		dev_err(&pdev->dev, "failed to add hwspinlock action\n");
+		dev_err(dev, "failed to add hwspinlock action\n");
 		return ret;
 	}
 
 	init_completion(&sc27xx_data->completion);
-	sc27xx_data->dev = &pdev->dev;
+	sc27xx_data->dev = dev;
 
 	ret = sc27xx_adc_enable(sc27xx_data);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to enable ADC module\n");
+		dev_err(dev, "failed to enable ADC module\n");
 		return ret;
 	}
 
-	ret = devm_add_action(&pdev->dev, sc27xx_adc_disable, sc27xx_data);
+	ret = devm_add_action(dev, sc27xx_adc_disable, sc27xx_data);
 	if (ret) {
 		sc27xx_adc_disable(sc27xx_data);
-		dev_err(&pdev->dev, "failed to add ADC disable action\n");
+		dev_err(dev, "failed to add ADC disable action\n");
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, sc27xx_data->irq, NULL,
+	ret = devm_request_threaded_irq(dev, sc27xx_data->irq, NULL,
 					sc27xx_adc_isr, IRQF_ONESHOT,
 					pdev->name, sc27xx_data);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to request ADC irq\n");
+		dev_err(dev, "failed to request ADC irq\n");
 		return ret;
 	}
 
-	indio_dev->dev.parent = &pdev->dev;
-	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->dev.parent = dev;
+	indio_dev->name = dev_name(dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &sc27xx_info;
 	indio_dev->channels = sc27xx_channels;
 	indio_dev->num_channels = ARRAY_SIZE(sc27xx_channels);
-	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
-		dev_err(&pdev->dev, "could not register iio (ADC)");
+		dev_err(dev, "could not register iio (ADC)");
 
 	return ret;
 }
-- 
2.11.0

