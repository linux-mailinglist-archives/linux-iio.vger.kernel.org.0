Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA3E2A2CDC
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 15:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgKBO0N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 09:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgKBOWh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 09:22:37 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A64C061A47
        for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2020 06:22:35 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 23so1148950wmg.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2020 06:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oc+CRyq0MP1rGPx6qu4fJIiuXgNVzq5WpNvySKjLu6M=;
        b=EcVmzz9jth/73LQEedUdNCEyD5xs5p5MrEHBHb5vnk+/Fhd6bkVFftxytaQ98ipoi2
         E7o8OHb6Yj9gmE5x5+rfThOvj9oZYoEpsZhKZDXRdJ5C7T4tzde8EdYcpT4DohOb/0OB
         QBIQIFx+0s4OJ0KSlHkLKm4zQbUyVL3yPrVzN8k9IMQ5pyfaqyyhRV9EROX94IGpZcW7
         nKaCjKX5gcLcDQBG9z07e0FrG0CD9kLjyMyiz6vGUnt5h2e6UNSqKH//ptHRGgLbY33z
         HGY7ZpNcovsFzKYMww8DIz6Q0V/t2wrYTpNpbgocFjaF+44Bjjnlp8fPlq616UdRR6KQ
         jNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oc+CRyq0MP1rGPx6qu4fJIiuXgNVzq5WpNvySKjLu6M=;
        b=pRHuEXgXVAt1QZVRFQXrIppcMyGh6eIl+94k+AL089NwPVcXi58xwJWJpbfNzNs9G1
         3A5CGaUdmD8KOl8RY++iB5MtaZuUHxV5ZLFuukE5qkE0zAwAYBSKT9mn2/R5d64WPAna
         /f8qaIBzeZgW+MfqSobH3aw7413wXTzZFZYLkDuMsLwCMjMjEWeLy2G5C+/AKrA6yze9
         2wHCKj0oFBy9qtB2yfXujMcMSJf06RCVNpq7R64nbDqod5yZtV9K2wgAPBbclRXEDojQ
         yGRzyKXMAqRdHgWtxgBpzPVWNwi0OxIAShhXfdMOtTa30ht795JkNmukdZiJwTcJe6m5
         VZqQ==
X-Gm-Message-State: AOAM533nqr1N/uG+klsx2+gagUcr9JKXKckF9CS4XJ+1vSf7QU+D3JGK
        d9CxQnR18HK/pCX6o1E/bqH5iA==
X-Google-Smtp-Source: ABdhPJy4aiDk0PjW2NDVFwcRQ7QvYaGh//Ek/ANQ8H+KnrDn3+7QwhU39uVvCEUSktsWeSUAcRlx5A==
X-Received: by 2002:a1c:6405:: with SMTP id y5mr7346371wmb.150.1604326954564;
        Mon, 02 Nov 2020 06:22:34 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id 3sm16182987wmd.19.2020.11.02.06.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:22:34 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/4] iio: adc: xilinx: use helper variable for &pdev->dev
Date:   Mon,  2 Nov 2020 15:22:26 +0100
Message-Id: <20201102142228.14949-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201102142228.14949-1-brgl@bgdev.pl>
References: <20201102142228.14949-1-brgl@bgdev.pl>
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

