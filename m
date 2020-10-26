Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB65A298E1F
	for <lists+linux-iio@lfdr.de>; Mon, 26 Oct 2020 14:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780260AbgJZNgc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Oct 2020 09:36:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40631 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780250AbgJZNga (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Oct 2020 09:36:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id h5so12557434wrv.7
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2020 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k40eJc8Lhw98TUMyUtqdBZVrG65XsNSVzHSaCNt0jHc=;
        b=xULoTkoUGRbnpHi6ZghaIZ1Q5yiAkgzBSZomS+pZDERJpF71+9WHNz7PkKFZCppqnR
         E8TvUVRzJBWf61WOq6yMPk1rtsL/mjsrHd984WeDRag1X84yfn9JZ3/BUdFfpsyAhr9i
         r+3jGNJKjnN9NhccBQ3VVT/UqJwJoQO0rwTYfNAdIj3OK+AX71r8AOVUI8mt+ZO9CAjl
         crYeJmkgxX/876FoIJU0Li4C6oO8FT+cCgFCyan2kbT99hhNS3i2Q9r4i1ccDmqKiRT0
         mMHQBprSDMOBi94y3N82AbCwRWdMXNsHegunbPSFZH3U49aHEKpZXieoIckKWFPib/GG
         7/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k40eJc8Lhw98TUMyUtqdBZVrG65XsNSVzHSaCNt0jHc=;
        b=uWSDpPQIq8kv5HXV/smfqpZ7s5fA1eIbB/h/hiSP5G+5BcqH5mW4Mibv953KG7Z7jE
         oJoAXSfa2g0Y/FQX9HQIg1IKrq1Njxl2faPPgtOheeM9ICIraTrDalCYEI9BA4eFr9be
         j+ngBKe3rPsTX6DcUFlSbFAYOHgPLYDebX6uN7IgKFQGdQxyLoizXmjQLlgNYR8htDJk
         E0Vv1Puyq5skbXPEbVO+ZKuq1FkJWkcLzMpldWslRFrBNpuRBIvJ/VAT46YPwf3F57pm
         Gl9vIrVnxS2lmvoIddl7Ek/kPoQ1fXHZjJjWJt+vNe3vh0311GwTpabJytFSP70n3WCb
         qiRw==
X-Gm-Message-State: AOAM532XB3eRzwsIaekOvhF+/xDoSnI+IbAUI4wt648WTFVoEI8DKSFY
        MxTuC07H7zWJ49dKX069VNgeZg==
X-Google-Smtp-Source: ABdhPJya7i/8CLwnUaaOp1aYoYaQe7iJhVlKyGV0P8+acTJoTJqeMcxGCcPsHQ982b6i6Dwhqn+clQ==
X-Received: by 2002:a5d:5344:: with SMTP id t4mr17501589wrv.267.1603719387795;
        Mon, 26 Oct 2020 06:36:27 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id f7sm23688991wrx.64.2020.10.26.06.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:36:27 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 5/5] iio: adc: xilinx: use iio devres helpers
Date:   Mon, 26 Oct 2020 14:36:09 +0100
Message-Id: <20201026133609.24262-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201026133609.24262-1-brgl@bgdev.pl>
References: <20201026133609.24262-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Shrink the code by using devres variants of all iio routines. This allows
us to entirely drop the remove() callback as well as significantly
simplifies error paths in probe().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 97 ++++++++++--------------------
 1 file changed, 32 insertions(+), 65 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 4440b7a9bd36..c17705205456 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -706,11 +706,12 @@ static const struct iio_trigger_ops xadc_trigger_ops = {
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
 
@@ -718,15 +719,11 @@ static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
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
@@ -1247,39 +1244,35 @@ static int xadc_probe(struct platform_device *pdev)
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
 
 	ret = devm_add_action_or_reset(dev,
 				       xadc_clk_disable_unprepare, xadc->clk);
 	if (ret)
-		goto err_free_samplerate_trigger;
+		return ret;
 
 	/*
 	 * Make sure not to exceed the maximum samplerate since otherwise the
@@ -1288,27 +1281,28 @@ static int xadc_probe(struct platform_device *pdev)
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
 
 	ret = devm_request_irq(dev, xadc->irq, xadc->ops->interrupt_handler, 0,
 			       dev_name(dev), indio_dev);
 	if (ret)
-		goto err_free_samplerate_trigger;
+		return ret;
 
 	ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
 				       &xadc->zynq_unmask_work);
 	if (ret)
-		goto err_free_samplerate_trigger;
+		return ret;
 
 	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
 	if (ret)
-		goto err_free_samplerate_trigger;
+		return ret;
 
 	for (i = 0; i < 16; i++)
 		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i),
@@ -1316,7 +1310,7 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = xadc_write_adc_reg(xadc, XADC_REG_CONF0, conf0);
 	if (ret)
-		goto err_free_samplerate_trigger;
+		return ret;
 
 	bipolar_mask = 0;
 	for (i = 0; i < indio_dev->num_channels; i++) {
@@ -1326,17 +1320,18 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(0), bipolar_mask);
 	if (ret)
-		goto err_free_samplerate_trigger;
+		return ret;
+
 	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1),
 		bipolar_mask >> 16);
 	if (ret)
-		goto err_free_samplerate_trigger;
+		return ret;
 
 	/* Disable all alarms */
 	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
 				  XADC_CONF1_ALARM_MASK);
 	if (ret)
-		goto err_free_samplerate_trigger;
+		return ret;
 
 	/* Set thresholds to min/max */
 	for (i = 0; i < 16; i++) {
@@ -1351,51 +1346,23 @@ static int xadc_probe(struct platform_device *pdev)
 		ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
 			xadc->threshold[i]);
 		if (ret)
-			goto err_free_samplerate_trigger;
+			return ret;
 	}
 
 	/* Go to non-buffered mode */
 	xadc_postdisable(indio_dev);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
-		goto err_free_samplerate_trigger;
+		return ret;
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	return 0;
-
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

