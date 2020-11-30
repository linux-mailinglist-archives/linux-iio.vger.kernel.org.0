Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD4F2C86C0
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 15:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgK3O3h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 09:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbgK3O3f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2020 09:29:35 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57563C061A48
        for <linux-iio@vger.kernel.org>; Mon, 30 Nov 2020 06:28:17 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so16484192wrc.8
        for <linux-iio@vger.kernel.org>; Mon, 30 Nov 2020 06:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fd5KSHFV1q6gI7RhU+8EyA1Y00uNAy6sSQ4khIZyfoY=;
        b=Y/FsBSx13T2X69Ibh+WGXrLtNSHOCS0mkQOzWNbmD7AlrNhtwbyTqNKGWlkepAFuf6
         RUXtBd8u+f1Ga2VLfjv6BhEuH2/YWfnFm3daMISKtiKFqTh9gDrXflarok+rt5k4vHjJ
         zxr9rDTy7R1JHELGJRQT+ohm7g+EL9VkZ94U7ZqsFkGXNe3YLCqVLi7gEIAZIekSJdxi
         otehCDUhDILWWg5porVQbsORVoLTlYDuSyvqGJ0wRjP/J5o9sIe9PhVCMFpt4OGfMwLk
         m2LB0ULbMNUkC6cbWskmxAIA6TERJ23AD2rAjPqkaUh+NZbqvzhQ+4LpuLn8hvH22ey6
         J4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fd5KSHFV1q6gI7RhU+8EyA1Y00uNAy6sSQ4khIZyfoY=;
        b=ERBfHS+dvRBLau/a15R8b+by04HkQnyWH922qdNarhF9gsePaaUZu6jydrc/Q+hx23
         fO6HxoXnb2UCJAn03TwYoSWMg2XTuEdgVN8PsL+5DeC+f6sw+VehaMFhKZGP1iSyPJp5
         V0bMex3Mrrasworb4yt9JD/coNmTweRRmoKCCo2C0I4uoJWmy7W7IPuLfyfvCYTcjO/i
         SSVBhY1qrrculodWwZjJUEZaf3X6cxYQooTBvu2DHGoTW+GIfz1tkhEifi/OZHzpMgDR
         tzhOK2vAaPrzLUtq+4quPV/nITZhVl/ePR0X2qE4lo4VFD/PWs5d/Qk8IVwAiYalEOCv
         3hNw==
X-Gm-Message-State: AOAM5336r0m7tMUq7XM1N8uZdgRim97A3+KGxabQJvVF/dSCKCMej8Z+
        4ymOnJqJohuc8wtnGe/X0YSGQg==
X-Google-Smtp-Source: ABdhPJwUBwMmMnDmNtjZehE/iYf6O8JGsKzXJqDnFrHekSCm1SZAad0ud6EP8+DimZFVTkznyqafZQ==
X-Received: by 2002:adf:dd43:: with SMTP id u3mr21671117wrm.358.1606746496042;
        Mon, 30 Nov 2020 06:28:16 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id p19sm29446044wrg.18.2020.11.30.06.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 06:28:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATH v3 3/3] iio: adc: xilinx: use more devres helpers and remove remove()
Date:   Mon, 30 Nov 2020 15:27:59 +0100
Message-Id: <20201130142759.28216-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201130142759.28216-1-brgl@bgdev.pl>
References: <20201130142759.28216-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

In order to simplify resource management and error paths in probe() and
entirely drop the remove() callback - use devres helpers wherever
possible. Define devm actions for cancelling the delayed work and
disabling the clock.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 129 +++++++++++++----------------
 1 file changed, 56 insertions(+), 73 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 6f89a97bb127..495b3422b266 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -713,11 +713,12 @@ static const struct iio_trigger_ops xadc_trigger_ops = {
 static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
 	const char *name)
 {
+	struct device *dev = indio_dev->dev.parent;
 	struct iio_trigger *trig;
 	int ret;
 
-	trig = iio_trigger_alloc("%s%d-%s", indio_dev->name,
-				indio_dev->id, name);
+	trig = devm_iio_trigger_alloc(dev, "%s%d-%s", indio_dev->name,
+				      indio_dev->id, name);
 	if (trig == NULL)
 		return ERR_PTR(-ENOMEM);
 
@@ -725,15 +726,11 @@ static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
 	trig->ops = &xadc_trigger_ops;
 	iio_trigger_set_drvdata(trig, iio_priv(indio_dev));
 
-	ret = iio_trigger_register(trig);
+	ret = devm_iio_trigger_register(dev, trig);
 	if (ret)
-		goto error_free_trig;
+		return ERR_PTR(ret);
 
 	return trig;
-
-error_free_trig:
-	iio_trigger_free(trig);
-	return ERR_PTR(ret);
 }
 
 static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
@@ -1192,6 +1189,20 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	return 0;
 }
 
+static void xadc_clk_disable_unprepare(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+}
+
+static void xadc_cancel_delayed_work(void *data)
+{
+	struct delayed_work *work = data;
+
+	cancel_delayed_work_sync(work);
+}
+
 static int xadc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1240,34 +1251,35 @@ static int xadc_probe(struct platform_device *pdev)
 		return ret;
 
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
-		ret = iio_triggered_buffer_setup(indio_dev,
-			&iio_pollfunc_store_time, &xadc_trigger_handler,
-			&xadc_buffer_ops);
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      &iio_pollfunc_store_time,
+						      &xadc_trigger_handler,
+						      &xadc_buffer_ops);
 		if (ret)
 			return ret;
 
 		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
-		if (IS_ERR(xadc->convst_trigger)) {
-			ret = PTR_ERR(xadc->convst_trigger);
-			goto err_triggered_buffer_cleanup;
-		}
+		if (IS_ERR(xadc->convst_trigger))
+			return PTR_ERR(xadc->convst_trigger);
+
 		xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev,
 			"samplerate");
-		if (IS_ERR(xadc->samplerate_trigger)) {
-			ret = PTR_ERR(xadc->samplerate_trigger);
-			goto err_free_convst_trigger;
-		}
+		if (IS_ERR(xadc->samplerate_trigger))
+			return PTR_ERR(xadc->samplerate_trigger);
 	}
 
 	xadc->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(xadc->clk)) {
-		ret = PTR_ERR(xadc->clk);
-		goto err_free_samplerate_trigger;
-	}
+	if (IS_ERR(xadc->clk))
+		return PTR_ERR(xadc->clk);
 
 	ret = clk_prepare_enable(xadc->clk);
 	if (ret)
-		goto err_free_samplerate_trigger;
+		return ret;
+
+	ret = devm_add_action_or_reset(dev,
+				       xadc_clk_disable_unprepare, xadc->clk);
+	if (ret)
+		return ret;
 
 	/*
 	 * Make sure not to exceed the maximum samplerate since otherwise the
@@ -1276,22 +1288,28 @@ static int xadc_probe(struct platform_device *pdev)
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
 		ret = xadc_read_samplerate(xadc);
 		if (ret < 0)
-			goto err_free_samplerate_trigger;
+			return ret;
+
 		if (ret > XADC_MAX_SAMPLERATE) {
 			ret = xadc_write_samplerate(xadc, XADC_MAX_SAMPLERATE);
 			if (ret < 0)
-				goto err_free_samplerate_trigger;
+				return ret;
 		}
 	}
 
-	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
-			  dev_name(dev), indio_dev);
+	ret = devm_request_irq(dev, xadc->irq, xadc->ops->interrupt_handler, 0,
+			       dev_name(dev), indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
+				       &xadc->zynq_unmask_work);
 	if (ret)
-		goto err_clk_disable_unprepare;
+		return ret;
 
 	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
 	if (ret)
-		goto err_free_irq;
+		return ret;
 
 	for (i = 0; i < 16; i++)
 		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i),
@@ -1299,7 +1317,7 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = xadc_write_adc_reg(xadc, XADC_REG_CONF0, conf0);
 	if (ret)
-		goto err_free_irq;
+		return ret;
 
 	bipolar_mask = 0;
 	for (i = 0; i < indio_dev->num_channels; i++) {
@@ -1309,17 +1327,18 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(0), bipolar_mask);
 	if (ret)
-		goto err_free_irq;
+		return ret;
+
 	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1),
 		bipolar_mask >> 16);
 	if (ret)
-		goto err_free_irq;
+		return ret;
 
 	/* Disable all alarms */
 	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
 				  XADC_CONF1_ALARM_MASK);
 	if (ret)
-		goto err_free_irq;
+		return ret;
 
 	/* Set thresholds to min/max */
 	for (i = 0; i < 16; i++) {
@@ -1334,59 +1353,23 @@ static int xadc_probe(struct platform_device *pdev)
 		ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
 			xadc->threshold[i]);
 		if (ret)
-			goto err_free_irq;
+			return ret;
 	}
 
 	/* Go to non-buffered mode */
 	xadc_postdisable(indio_dev);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
-		goto err_free_irq;
+		return ret;
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	return 0;
-
-err_free_irq:
-	free_irq(xadc->irq, indio_dev);
-	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
-err_clk_disable_unprepare:
-	clk_disable_unprepare(xadc->clk);
-err_free_samplerate_trigger:
-	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
-		iio_trigger_free(xadc->samplerate_trigger);
-err_free_convst_trigger:
-	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
-		iio_trigger_free(xadc->convst_trigger);
-err_triggered_buffer_cleanup:
-	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
-		iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
-}
-
-static int xadc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct xadc *xadc = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
-		iio_trigger_free(xadc->samplerate_trigger);
-		iio_trigger_free(xadc->convst_trigger);
-		iio_triggered_buffer_cleanup(indio_dev);
-	}
-	free_irq(xadc->irq, indio_dev);
-	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
-	clk_disable_unprepare(xadc->clk);
-
 	return 0;
 }
 
 static struct platform_driver xadc_driver = {
 	.probe = xadc_probe,
-	.remove = xadc_remove,
 	.driver = {
 		.name = "xadc",
 		.of_match_table = xadc_of_match_table,
-- 
2.29.1

